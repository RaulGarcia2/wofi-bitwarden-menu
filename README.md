# wofi-bitwarden-menu
Menu hecho en wofi para acceder a los datos guardados en Bitwarden.
Se trata de un script hecho en python, el cual consulta en bitwarden y crea los menús correspondientes en wofi

## Requisitos
Es necesario tener instalado en el equipo los siguientes programas:
- wofi
- wl-clipboard
- libnotify-bin
- servidor con bw: es necesario disponer en algún equipo de la red local de un servidor que tenga instalado bw para acceder al servidor de Bitwarden donde estén los datos

## Configuración

La aplicación lee su configuración de `${HOME}/.config/bwmenu.conf`. Si el archivo no existe, usa valores por defecto (localhost:9090).

Ejemplo de contenido para `bwmenu.conf`:
```ini
HOST=host-bw-serve
PORT=9090
WOFI_CFG=~/.config/wofi/dracula/style.css
LOCK_TIMEOUT=10
```

*   **HOST**: Dirección del servidor donde corre `bw serve`.
*   **PORT**: Puerto del servidor.
*   **WOFI_CFG**: Ruta al archivo CSS de estilo para wofi.
*   **LOCK_TIMEOUT**: Tiempo en minutos para el bloqueo automático del cofre.

Se creará un acceso de teclado con el que iniciar el script desde donde estemos para poder copiar y pegar datos de usuario.

Por ejemplo, si tenemos _sway_ podemos incluir en el fichero de configuración correspondiente una linea con:
```
bindsym $mod+Control+b exec /home/usuario/.local/bin/bwmenu
```
Deberemos tener en la red local o en el propio equipo un cliente para Bitwarden llamado bw, deberemos acceder desde ese cliente al servidor de Bitwarden donde tengamos los datos, una vez que estemos autenticados en el servidor iniciaremos un servicio con un comando similar a:
```
bw serve --hostname host-bw-server --port 9090
```
En el ejemplo hay configurado un equipo llamado *rpi5c* y el puerto *9090*. En el script que ejecuta nuestra aplicación habrá que confiturar la variable HOST para que haga referencia a este equipo y este puerto.

El script de la aplicación tiene configurado un estilo y una configuración que puede ser modificada al gusto del usuario.

## Instalación
### Debian
Descargar el archivo de instalación de [bwmenu](https://github.com/RaulGarcia2/wofi-bitwarden-menu/releases) y ejecutarlo e instalar con el gestor de paquetes:
```
sudo apt install wofi-bitwarden-menu.deb
```
### Otras distribuciones
Copiar el script python *bwmenu* y los scripts bash *wofi-bitwarden-mata* y *wofi-bitwarden-bloquea* en la carpeta _$HOME/.local/bin_ , o en una carpeta incluida dentro de la variable de entorno PATH.
