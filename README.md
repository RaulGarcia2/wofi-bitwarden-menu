# wofi-bitwarden-menu
Menu hecho en wofi para acceder a los datos guardados en Bitwarden.
Se trata de un script hecho en bash, el cual consulta en bitwarden y crea los menús correspondientes en wofi

## Requisitos
Es necesario tener instalado en el equipo los siguientes programas:
- jq
- wofi
- curl
- wl-clipboard
- libnotify-bin
- servidor con bw: es necesario disponer en algún equipo de la red local de un servidor que tenga instalado bw para acceder al servidor de Bitwarden donde estén los datos

## Instalación
Copiar el script bash wofi-bitwarden-menu.sh en la carpeta _$HOME/.local/bin_ , o en una carpeta incluida dentro de la variable de entorno PATH.

Se creará un acceso de teclado con el que iniciar el script desde donde estemos para poder copiar y pegar datos de usuario.

Por ejemplo, si tenemos _sway_ podemos incluir en el fichero de configuración correspondiente una linea con:
```
bindsym $mod+Control+b exec /home/usuario/.local/bin/wofi-bitwarden-menu.sh
```
