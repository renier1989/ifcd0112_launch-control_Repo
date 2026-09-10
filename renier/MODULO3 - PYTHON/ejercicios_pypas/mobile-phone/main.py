class MobilePhone:
    def __init__(self, manufacturer:str, screen_size:float, num_cores:int):
        print('Running the __INIT__')
        self.manufacturer= manufacturer
        self. screen_size = screen_size
        self. num_cores = num_cores
        self.status= False
        self.apps=[]
    
    def power_on(self):
        print('Enciende el Movil')
        self.status= True

    def power_off(self):
        print('Apaga el Movil')
        self.status = False
    
    def install_app(self, *apps: str):
        print('Instalar aplicacion(es)')
        for app in apps:
            if app not in self.apps:
                self.apps.append(app)
                print(f'Aplicacion Instalada: {app}')
        print(self.apps)
    
    def uninstall_app(self, *apps: str):
        print('Desinstalar aplicacion(es)')
        for app in apps:
            if app in self.apps:
                self.apps.remove(app)
                print(f'Aplicacion desinstalada: {app}')
        print(self.apps)


samsung = MobilePhone(manufacturer='samsumg', screen_size=15.2, num_cores=8)
samsung.power_on()
samsung.power_off()
samsung.install_app('Google Store,Telegram,Calendar')
samsung.install_app('Whatsapp')
samsung.uninstall_app('Whatsapp')
print("""------ Informacion ------""")
print(samsung.manufacturer)
print(samsung.screen_size)
print(samsung.num_cores)
print(samsung.status)
print(samsung.apps)

