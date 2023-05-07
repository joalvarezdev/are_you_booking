#!/bin/bash


install_dependencies() {
    if [[ ! -d "bin" ]]; then
        python -m venv .
    fi

    source bin/activate
    pip install -r requirements.txt
    deactivate
}


verify_pip() {
    echo $(pip3 --version)
}


is_installed() {
    if [[ ! $1 == *"pip"*"/usr/lib/python"* ]]; then
        return 1
    fi
}


install_packages_debian() {
    is_installed "$(verify_pip)"

    if [[ $? -eq 1 ]]; then
        sudo apt install python3-pip
    fi
}


install_packages_redhat() {
    result=$(verify_pip)

    if [[ ! $result == *"pip"*"/usr/lib/python"* ]]; then
        sudo dnf install python3-pip
    fi
}


install_packages_arch() {
    is_installed "$(verify_pip)"

    if [[ $? -eq 1 ]]; then
        sudo pacman -S python-pip
    fi
    
    install_dependencies
}


if [[ ! -f "config.ini" ]]; then
    echo "A continuacion le pediremos los valores para configurar en el archivo .ini"

    read -p "Ingrese ID: " id
    read -p "Ingrese numero de Legajo: " legajo
    read -p "Ingrese numero de PIN (DOC): " pin

    cat << EOF > config.ini
    [CREDENTIALS]
    SENSOR_MANUAL=$id
    PIN=$legajo
    LEGAJO=$pin

    [DEFAULT]
    SCREEN=True

EOF
fi

distro=$(cat /etc/os-release | grep -E '^ID_LIKE=' | cut -d'=' -f2 | tr -d '"')

case "$distro" in
    debian|ubuntu)
        echo "Instalacion en UBUNTU"
        ;;
    fedora|redhat)
        echo "Instalacion en fedora"
        ;;
    arch)
        install_packages_arch
        ;;
esac



