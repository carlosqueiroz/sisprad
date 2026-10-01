#!/usr/bin/env bash
# Sobe o ambiente Docker do sisprad (MariaDB + app PHP) e a aplicação Laravel.
#
# Uso:
#   ./up.sh              -> sobe containers, instala deps se necessário, serve em http://localhost:8088
#   ./up.sh --reset-db   -> recria o volume do banco e reimporta o backup.sql
#   ./up.sh --down       -> derruba os containers (preserva o volume)
#   ./up.sh --logs       -> acompanha os logs dos containers
#   ./up.sh --shell      -> abre um bash no container da aplicação

set -euo pipefail

cd "$(dirname "$0")"

COMPOSE_FILE="docker-compose.yml"
APP_CONTAINER="sisprad-app"
DB_CONTAINER="sisprad-mariadb"
DB_NAME="default"
DB_USER="root"
DB_PASS="root"
DB_VOLUME="sisprad_sisprad-db"
APP_PORT="8088"

# Detecta docker compose v2 vs docker-compose v1
if docker compose version >/dev/null 2>&1; then
    DC="docker compose"
elif command -v docker-compose >/dev/null 2>&1; then
    DC="docker-compose"
else
    echo "ERRO: Docker Compose não encontrado. Instale o Docker Desktop ou o plugin docker-compose." >&2
    exit 1
fi

log()  { printf '\033[1;34m[+]\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[!]\033[0m %s\n' "$*"; }
err()  { printf '\033[1;31m[x]\033[0m %s\n' "$*" >&2; }

wait_for_db() {
    log "Aguardando MariaDB ficar saudável..."
    local tries=60
    while (( tries-- > 0 )); do
        if docker exec "$DB_CONTAINER" healthcheck.sh --connect --innodb_initialized >/dev/null 2>&1; then
            log "MariaDB pronto."
            return 0
        fi
        sleep 2
    done
    err "Timeout aguardando MariaDB."
    return 1
}

db_is_empty() {
    local count
    count=$(docker exec "$DB_CONTAINER" mariadb -u"$DB_USER" -p"$DB_PASS" -N -B -e \
        "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='$DB_NAME';" 2>/dev/null || echo 0)
    [[ "$count" == "0" ]]
}

import_backup() {
    if [[ ! -f backup.sql ]]; then
        warn "backup.sql não encontrado — pulando importação."
        return 0
    fi
    log "Importando backup.sql no banco '$DB_NAME'..."
    docker exec -i "$DB_CONTAINER" mariadb -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" < backup.sql
    log "Backup importado."
}

ensure_app_ready() {
    log "Garantindo dependências do Laravel dentro do container..."
    # Aguarda o entrypoint do container instalar pacotes e composer
    local tries=60
    while (( tries-- > 0 )); do
        if docker exec "$APP_CONTAINER" bash -c 'command -v composer >/dev/null 2>&1'; then
            break
        fi
        sleep 3
    done

    if ! docker exec "$APP_CONTAINER" bash -c 'command -v composer >/dev/null 2>&1'; then
        err "Composer ainda não está disponível no container — verifique 'docker logs $APP_CONTAINER'."
        return 1
    fi

    if [[ ! -d vendor ]] || [[ ! -f vendor/autoload.php ]]; then
        log "Rodando composer install..."
        docker exec "$APP_CONTAINER" bash -lc 'composer install --no-interaction --prefer-dist'
    fi

    if [[ ! -f .env ]]; then
        log "Copiando .env.example -> .env"
        cp .env.example .env
        docker exec "$APP_CONTAINER" bash -lc 'php artisan key:generate'
    fi

    log "Limpando caches do Laravel..."
    docker exec "$APP_CONTAINER" bash -lc 'php artisan config:clear && php artisan cache:clear' || true
}

start_server() {
    log "Iniciando 'php artisan serve' em 0.0.0.0:8000 (exposto em http://localhost:$APP_PORT) ..."
    docker exec -d "$APP_CONTAINER" bash -lc \
        'pkill -f "artisan serve" >/dev/null 2>&1 || true; nohup php artisan serve --host=0.0.0.0 --port=8000 >/tmp/artisan.log 2>&1 &'
    sleep 2
    log "App disponível em: http://localhost:$APP_PORT"
}

cmd_up() {
    log "Subindo containers..."
    $DC up -d
    wait_for_db
    if db_is_empty; then
        import_backup
    else
        log "Banco já populado — pulando importação. (use --reset-db para recriar)"
    fi
    ensure_app_ready
    start_server
    log "Pronto! Acompanhe os logs com: ./up.sh --logs"
}

cmd_reset_db() {
    warn "Isso vai apagar o volume do banco ($DB_VOLUME) e reimportar backup.sql."
    read -rp "Confirmar? [s/N] " ans
    [[ "${ans,,}" == "s" ]] || { log "Abortado."; exit 0; }
    $DC down
    docker volume rm "$DB_VOLUME" 2>/dev/null || true
    cmd_up
}

cmd_down()  { log "Derrubando containers..."; $DC down; }
cmd_logs()  { $DC logs -f --tail=100; }
cmd_shell() { docker exec -it "$APP_CONTAINER" bash; }

case "${1:-up}" in
    up|"")       cmd_up ;;
    --reset-db)  cmd_reset_db ;;
    --down)      cmd_down ;;
    --logs)      cmd_logs ;;
    --shell)     cmd_shell ;;
    -h|--help)
        sed -n '2,11p' "$0" | sed 's/^# \{0,1\}//'
        ;;
    *)
        err "Opção desconhecida: $1"
        sed -n '2,11p' "$0" | sed 's/^# \{0,1\}//'
        exit 1
        ;;
esac
