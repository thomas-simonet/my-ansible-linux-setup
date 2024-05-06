- Config zsh / dotfiles
    - https://github.com/olivomarco/dotfiles/tree/master

- Role SSH (Interdire la connexion par mdp etc.)

- Centraliser les logs
    - https://www.commandprompt.com/blog/docker-logging-with-rsyslog/
    - https://www.back-slash.net/enregistrer-ses-logs-rsyslog-sur-graylog/

- Ajouter les fichiers docker-compose :

    - Network : (app)
        - portainer
        - backup
        - graylog
        - nginx proxy manager
        - freshrss
        - readeack
        - photoprism
        - maelie

    - Network (dev) :
        - coder
        - cloudflared

- Semaphore UI
    - https://semui.co/

- Backup
    - https://www.backblaze.com/cloud-storage
    - Backup via hetzner

- Créer les dossiers /mnt/docker-volumes/xxx pour chaque docker compose

- Test live

- Quid de ufw ?
- Comment acceder aux bases de données dans coder ?
- Module Ansible / Terraform pour les dns Cloudflare ?