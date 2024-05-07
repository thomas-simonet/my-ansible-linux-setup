- Config zsh / dotfiles
    - https://github.com/olivomarco/dotfiles/tree/master

- Role SSH (Interdire la connexion par mdp etc.)

- Centraliser les logs
    - https://www.commandprompt.com/blog/docker-logging-with-rsyslog/
    - https://www.back-slash.net/enregistrer-ses-logs-rsyslog-sur-graylog/

- Ajouter les fichiers docker-compose :
    - Network : (app)
        - Portainer
        - Backup
        - Graylog / Grafana Loki
        - Check les updates
        - Nginx proxy manager / Traefik
        - Freshrss
        - Readeack
        - Photoprism
        - Maelie

    - Network (dev) :
        - Coder
        - Cloudflared

- Semaphore UI
    - https://semui.co/

- Backup
    - https://www.backblaze.com/cloud-storage
    - Backup via hetzner

- Créer les dossiers /mnt/docker-volumes/xxx pour chaque docker compose

- Test live

- Remplacer Nginx Proxy Manager par Traefik (et config auto via label) ?
    - https://hub.docker.com/_/traefik
- Quid de ufw ?
- Comment acceder aux bases de données dans coder ?
- Module Ansible / Terraform pour les dns Cloudflare ?