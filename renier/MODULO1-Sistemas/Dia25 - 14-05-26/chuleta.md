Aquí tienes una **chuleta mega comprimida** con la esencia teórica y todos los comandos clave listos para copiar y pegar.

---

## 📌 DATOS CLAVE

* **IP Profesor:** `10.0.140.8` (Puerto `9999`)
* **IPs Propias:** Desktop (`192.168.56.10`) | Artemis (`192.168.56.20`)
* **Redes:** Aula (`10.0.140.0/24`) | Cluster (`192.168.56.0/24`)
* **Clave Privada:** `~/.ssh/id_ed25519` (Firma, **NUNCA** se comparte)
* **Clave Pública:** `~/.ssh/id_ed25519.pub` (Candado, se comparte)

---

## 💻 COMANDOS DE CONFIGURACIÓN (PASO A PASO)

### 0bis. Levantar Red Aula (Bridge)

Si la interfaz del aula (ej. `enp0s9`) está *DOWN* o no tiene IP:

```bash
sudo ip link set enp0s9 up && sudo dhclient enp0s9

```

Persistencia en Netplan (`sudo tee /etc/netplan/95-bridge-aula.yaml`):

```yaml
network:
  version: 2
  ethernets:
    enp0s9:
      dhcp4: yes

```

```bash
sudo chmod 600 /etc/netplan/95-bridge-aula.yaml && sudo netplan apply

```

### 1 y 2. Cambiar Hostname

```bash
sudo hostnamectl set-hostname agente-<tu-nombre>
# Cierra y abre la terminal para aplicar

```

### 3. Generar Claves SSH (ED25519)

```bash
mkdir -p ~/.ssh && chmod 700 ~/.ssh
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N "" -C "agente-<tu-nombre>"

```

### 4. Enviar tu Pública al Profesor

```bash
curl -F "file=@$HOME/.ssh/id_ed25519.pub;filename=<tu-nombre>.pub" http://10.0.140.8:9999/upload

```

### 5. Autorizar la Pública del Profesor

```bash
touch ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys
PUB_PROF=$(curl -s http://10.0.140.8:9999/pubkey_profesor)
grep -qF "$PUB_PROF" ~/.ssh/authorized_keys || printf '\n%s\n' "$PUB_PROF" >> ~/.ssh/authorized_keys

```

### 6. Fijar IP Host-Only (`192.168.56.10`)

Modificar/crear archivo (`sudo tee /etc/netplan/99-hostonly.yaml`):

```yaml
network:
  version: 2
  ethernets:
    enp0s8: # Cambiar por tu interfaz host-only si es otra
      dhcp4: no
      addresses: [192.168.56.10/24]

```

```bash
sudo chmod 600 /etc/netplan/99-hostonly.yaml && sudo netplan apply

```

### 7. Configurar Firewall (UFW)

```bash
# Solo si UFW está activo:
sudo ufw allow from 10.0.140.0/24 to any port 22

```

### 8. Notificar "Listo" al Centro de Mando

```bash
IP_AULA=$(ip -4 -br addr show | awk '/10\.0\.140\./{split($3,a,"/"); print a[1]; exit}')
curl -X POST -d "ip=${IP_AULA}&hostname=$(hostname)&user=$(whoami)" http://10.0.140.8:9999/ready/<tu-nombre>

```

---

## ⚡ ATAJO EXPLOSIVO (Todo en 1 comando)

```bash
curl -s http://10.0.140.8:9999/scripts/bootstrap_alumno.sh | bash

```

---

## 🏁 VERIFICACIÓN FINAL (El "Aprobado")

Copia y pega este bloque para testear todo tu entorno de golpe:

```bash
echo "=== 1. Hostname ===" && hostname
echo "=== 2. Claves ===" && ls -la ~/.ssh/id_ed25519*
echo "=== 3. Profesor ===" && grep -c jefe@master ~/.ssh/authorized_keys
echo "=== 4. Host-Only ===" && ip -4 addr show | grep "inet 192.168.56"
echo "=== 5. Red Aula ===" && ip -4 addr show | grep "10\.0\.140" | head -1

```

---

## 🚨 REGLAS DE ORO (Lo que NO debes hacer)

* ❌ **NUNCA** compartas ni subas a GitHub tu clave privada (`id_ed25519`).
* ❌ No uses `sshpass` ni pases contraseñas en texto plano por comando.
* ⚠️ **Permisos rotos:** Si falla la conexión, repara permisos con: `chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys`.
* ⚠️ **Cambio de huella:** Si te da error *Host key verification failed*, limpia la IP con: `ssh-keygen -R <IP>`.