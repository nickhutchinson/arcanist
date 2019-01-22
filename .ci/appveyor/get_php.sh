#!/bin/bash
set -euo pipefail

case "$OSTYPE" in
    linux*)
        sudo apt-get install -y --no-install-recommends \
            php-cli \
            php-curl \
            php-mbstring \
            php-xml
        ;;

    msys*)
        curl -o php7.zip -fssL https://windows.php.net/downloads/releases/archives/php-7.3.1-nts-Win32-VC15-x64.zip || \
            curl -o php7.zip -fssL https://windows.php.net/downloads/releases/php-7.3.1-nts-Win32-VC15-x64.zip
        7z x php7.zip -ophp-7
        sed -E \
            -e 's/; *extension=(curl|mbstring|openssl)/extension=\1/g' \
            -e 's/; *extension_dir = "ext"/extension_dir = "ext"/g' \
            php-7/php.ini-production > php-7/php.ini
        ;;
esac
