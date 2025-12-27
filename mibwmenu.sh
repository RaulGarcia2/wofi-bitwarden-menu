#!/usr/bin/env bash

wofi_config="-W 400 -s ${HOME}/.config/wofi/wildberries/style.css -c ${HOME}/.config/wofi/wildberries/config"
HOST="rpi5c:9090"

estado() {
    x=$( curl http://${HOST}/status | jq -r " .data.template.status " )
    echo $x
}

lock() {
    curl -X POST http://${HOST}/lock
}

unlock() {
    contra=$( wofi ${wofi_config} --dmenu --password --prompt "Contrase desbloquear" )
    res=$(curl -X POST http://${HOST}/unlock -H "Content-Type: application/json"  -d "{\"password\": \"${contra}\"}")
    echo $res
    unset contra
}

listaNombres() {
    ( curl http://${HOST}/list/object/items 2>/dev/null )
}

# Verificamos si se está ejecutando el proceso bw serve
if [ "$(estado)" != "unlocked" ]; then
    echo "El proceso no está en ejecución."
    if [ "$(unlock | jq -r " .data.title ")"  != "Your vault is now unlocked!" ]; then
        notify-send -a "Bitwarden" -u critical "❌ Error al desbloquear el servidor ${HOST}"
        exit 1
    fi
fi

if ! x=$( listaNombres ); then
    echo "Error listar nombres de Bitwarden " >&2
    exit 1
fi

seleccion=$( echo ${x} | jq -r " .data.data | .[] | select(has(\"login\")) | .name " | uniq | sort| wofi ${wofi_config} --dmenu --prompt "Teclea sitio")

if [ "" != "${seleccion}" ]; then
    read -r  id username password topt <<< $(echo "${x}" | jq  -r " .data.data | .[]  | select(.name == \"${seleccion}\") | \"\\(.id) \\(.login.username) \\(.login.password) \\(.totp) \"")

    if [ "-null" = "-${totp}" ]; then
        stotp=""
    else
        stotp="
    TOTP:"
    fi
    comm=$( echo "DATOS DE: ${seleccion}
    Username: ${username} 
    Contraseña:${stotp}" | wofi ${wofi_config} -d | xargs )
    if [ "Contraseña:" = "${comm}" ]; then
        if wl-copy "${password}"; then
            notify-send -a "Bitwarden" -t 3000 "Bitwarden" "<b>🔒Contraseña copiada</b>"
        else
            notify-send -a "Bitwarden" -u critical "❌ Error al copiar contraseña "
        fi
    elif [ "TOTP:" = "${comm}" ]; then
        if wl-copy $( curl http://${HOST}/object/totp/${id}  | jq -r " .data.data "  ); then
            notify-send -a "Bitwarden" -t 3000 "Bitwarden" "<b>⏱️ TOTP copiado</b>"
        else
            notify-send -a "Bitwarden" -u critical "❌ Error al copiar TOTP"
        fi
    elif [ "Username: ${username}" = "${comm}" ]; then
        wl-copy "${username}"
        notify-send -a "Bitwarden" -t 3000 "Bitwarden" "<b>👤 Username copiado</b>"
    fi
    unset password
    unset dddd
fi
unset x
