#!/bin/bash


if [ ! -x "$(which certbot)" ]; then
   echo You have to install certbot
   exit 1
fi

CERTBOT_ARGS=()

# New function to prompt for EAB credentials
function prompt_for_eab_credentials() {
    read -p "Enter EAB KID: " _EAB_KID
    read -p "Enter EAB HMAC Key: " _EAB_HMAC_KEY
    CERTBOT_ARGS+=(--eab-kid "${_EAB_KID:?}" --eab-hmac-key "${_EAB_HMAC_KEY:?}" --server "https://emea.acme.atlas.globalsign.com/directory")
}

while [ "$#" -gt 0 ]; do
    case "$1" in
        --tz-api-key=*)
            _API_KEY=${1#*=}
        ;;
        --tz-api-key|-z)
           _API_KEY=$2
           shift
        ;;
        --tz-email=*)
            _EMAIL=${1#*=}
        ;;
        --email|--tz-email|-m)
           _EMAIL=$2
           CERTBOT_ARGS+=(-m "$2")
           shift
        ;;
        *) CERTBOT_ARGS+=("$1") ;;
    esac
    shift
done

set -- "${CERTBOT_ARGS[@]}"

# Instead of fetching credentials via an API, prompt the user for them.
if [[ -n $_API_KEY ]] || [[ -n $_EMAIL ]]; then
    prompt_for_eab_credentials
fi

printf '%s ' certbot "${CERTBOT_ARGS[@]}"; echo
certbot "${CERTBOT_ARGS[@]}"
