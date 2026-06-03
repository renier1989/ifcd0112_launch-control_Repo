Si no deja crear el bridge en virtualbox probar esto:

 1. Diagnóstico — ¿VirtualBox ve interfaces para bridge?

  & "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" list bridgedifs
  - Si sale vacío o solo cabeceras → VirtualBox no detecta ninguna NIC para bridge. Es lo que esperamos
   si no le deja crearlo.
  - Si lista interfaces → el problema no es de drivers, es otra cosa (VM en estado Saved, ver paso 5).
 
  2. Ver el estado del driver bridge en sus adaptadores

  Get-NetAdapter | Where-Object Status -eq 'Up' | ForEach-Object {
      $name = $_.Name
      Get-NetAdapterBinding -Name $name |
          Where-Object DisplayName -like "*VirtualBox*" |
          Select-Object @{n='Adapter';e={$name}}, DisplayName, Enabled
  }
  - Tiene que aparecer "VirtualBox NDIS6 Bridged Networking Driver" y Enabled = True sobre el adaptador
   que usa para internet (Wi-Fi o Ethernet).
   
  3. Si aparece pero deshabilitado → habilitarlo

  # Cambia "Wi-Fi" por el nombre real del adaptador (lo da Get-NetAdapter)
  Enable-NetAdapterBinding -Name "Wi-Fi" -ComponentID "VBoxNetLwf"

  4. Si NO aparece el driver → reinstalar VirtualBox en modo Repair

  No hay forma limpia desde PowerShell de re-enganchar el filtro NDIS si falta el componente; lo
  correcto es:
  - Ejecutar el instalador de VirtualBox → Repair.
  - O un ciclo rápido sin reinstalar: cerrar todo VirtualBox y reiniciar servicios:
  Get-Process VBox*, VirtualBox* -ErrorAction SilentlyContinue | Stop-Process -Force Restart-Service VBoxSDS -ErrorAction SilentlyContinue & "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" list bridgedifs

  5. Si la VM está en estado "Guardada" (no apagada)

  & "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" list vms
  # ver el estado:
  & "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" showvminfo "NombreDeLaVM" --machinereadable |
  Select-String "VMState="
  # si dice "saved": descartar
  & "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" discardstate "NombreDeLaVM"
  Tras discardstate la VM queda poweroff de verdad y ya deja editar el bridge.
 
  Atajo todo-en-uno (copiar/pegar en PowerShell del alumno)

  $vb = "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
  Write-Host "`n== Interfaces que ve VirtualBox para bridge ==" -ForegroundColor Cyan
  & $vb list bridgedifs | Select-String "^Name:|^Status:"
  Write-Host "`n== Drivers VirtualBox en NICs activas ==" -ForegroundColor Cyan
  Get-NetAdapter | ? Status -eq 'Up' | % {
    $n=$_.Name
    Get-NetAdapterBinding -Name $n | ? DisplayName -like "*VirtualBox*" |
      Select @{n='Adapter';e={$n}}, DisplayName, Enabled
  } | Format-Table -AutoSize
  Write-Host "`n== VMs y estado ==" -ForegroundColor Cyan
  & $vb list vms
  Con la salida de eso sabemos al instante qué falla. Si me la pasas, te digo el siguiente paso exacto.