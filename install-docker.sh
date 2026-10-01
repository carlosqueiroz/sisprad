#!/usr/bin/env bash
# Instala Docker Engine + Docker Compose v2 do zero em WSL/Ubuntu/Debian.
# Remove instalações antigas (incluindo snap quebrado) e usa o repositório oficial.
#
# Uso:
#   ./install-docker.sh

set -euo pipefail

log()  { printf '\033[1;34m[+]\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[!]\033[0m %s\n' "$*"; }
err()  { printf '\033[1;31m[x]\033[0m %s\n' "$*" >&2; }

require_sudo() {
    if [[ $EUID -ne 0 ]]; then
        if ! command -v sudo >/dev/null 2>&1; then
            err "Este script precisa de root ou sudo."
            exit 1
        fi
        SUDO="sudo"
    else
        SUDO=""
    fi
}

detect_distro() {
    if [[ ! -f /etc/os-release ]]; then
        err "Não foi possível detectar a distribuição (/etc/os-release ausente)."
        exit 1
    fi
    # shellcheck disable=SC1091
    . /etc/os-release
    DISTRO_ID="${ID:-}"
    DISTRO_CODENAME="${VERSION_CODENAME:-}"
    # Algumas variantes (ex.: Linux Mint) usam UBUNTU_CODENAME
    if [[ -z "$DISTRO_CODENAME" && -n "${UBUNTU_CODENAME:-}" ]]; then
        DISTRO_CODENAME="$UBUNTU_CODENAME"
        DISTRO_ID="ubuntu"
    fi

    case "$DISTRO_ID" in
        ubuntu|debian) ;;
        linuxmint)     DISTRO_ID="ubuntu" ;;
        *)
            err "Distribuição não suportada por este script: $DISTRO_ID"
            err "Suportadas: ubuntu, debian."
            exit 1
            ;;
    esac
    log "Distribuição detectada: $DISTRO_ID ($DISTRO_CODENAME)"
}

remove_old() {
    log "Removendo instalações antigas (apt e snap)..."

    if command -v snap >/dev/null 2>&1; then
        if snap list docker >/dev/null 2>&1; then
            warn "Removendo snap docker..."
            $SUDO snap remove --purge docker || {
                warn "snap remove falhou; tentando limpeza forçada"
                $SUDO rm -rf /snap/docker /var/snap/docker || true
                $SUDO snap remove docker || true
            }
        fi
    fi

    $SUDO apt-get remove -y \
        docker docker-engine docker.io containerd runc \
        docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
        2>/dev/null || true
}

install_docker() {
    log "Instalando pré-requisitos..."
    $SUDO apt-get update -qq
    $SUDO apt-get install -y -qq ca-certificates curl gnupg lsb-release

    log "Adicionando chave GPG oficial do Docker..."
    $SUDO install -m 0755 -d /etc/apt/keyrings
    $SUDO rm -f /etc/apt/keyrings/docker.gpg
    curl -fsSL "https://download.docker.com/linux/${DISTRO_ID}/gpg" \
        | $SUDO gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    $SUDO chmod a+r /etc/apt/keyrings/docker.gpg

    log "Adicionando repositório APT do Docker..."
    local arch
    arch=$(dpkg --print-architecture)
    echo "deb [arch=${arch} signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/${DISTRO_ID} ${DISTRO_CODENAME} stable" \
        | $SUDO tee /etc/apt/sources.list.d/docker.list >/dev/null

    log "Instalando Docker Engine + Compose v2..."
    $SUDO apt-get update -qq
    $SUDO apt-get install -y -qq \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-buildx-plugin \
        docker-compose-plugin
}

post_install() {
    log "Adicionando usuário '$USER' ao grupo docker..."
    $SUDO groupadd -f docker
    $SUDO usermod -aG docker "$USER"

    if grep -qi microsoft /proc/version 2>/dev/null; then
        log "Detectado WSL — iniciando daemon via 'service' (sem systemd)..."
        $SUDO service docker start || warn "Falha ao iniciar via service; tente Docker Desktop com WSL integration."
    else
        if command -v systemctl >/dev/null 2>&1; then
            log "Habilitando e iniciando docker.service via systemd..."
            $SUDO systemctl enable --now docker || true
        else
            $SUDO service docker start || true
        fi
    fi
}

verify() {
    log "Verificando instalação..."
    docker --version || { err "docker não encontrado no PATH."; return 1; }
    docker compose version || { err "docker compose plugin não encontrado."; return 1; }

    log "Testando com 'hello-world' (pode pedir sudo se você ainda não saiu/entrou da sessão)..."
    if ! docker run --rm hello-world >/dev/null 2>&1; then
        warn "docker run falhou sem sudo. Faça logout/login no WSL (ou rode 'newgrp docker') e tente de novo."
        warn "Teste imediato: sudo docker run --rm hello-world"
    else
        log "Docker funcionando sem sudo."
    fi
}

main() {
    require_sudo
    detect_distro
    remove_old
    install_docker
    post_install
    verify

    echo
    log "Instalação concluída."
    log "Versão:        $(docker --version 2>/dev/null || echo '?')"
    log "Compose:       $(docker compose version 2>/dev/null || echo '?')"
    echo
    warn "IMPORTANTE: feche este terminal WSL e abra de novo (ou rode 'newgrp docker')"
    warn "para que o grupo 'docker' valha sem precisar de sudo."
    echo
    log "Em seguida, no projeto sisprad:"
    echo "    cd /home/rt/scripts/sisprad && ./up.sh"
}

main "$@"
