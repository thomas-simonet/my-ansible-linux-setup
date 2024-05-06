- Config zsh / dotfiles https://github.com/olivomarco/dotfiles/tree/master
- Role SSH (Interdire la connexion par mdp etc.)

- Ajouter les fichiers docker-compose :
    - portainer
    - nginx proxy manager
    - backup
    - cloudflared
    - freshrss
    - coder
    - readeack
- Créer les dossiers /mnt/docker-volumes/xxx pour chaque docker compose
- Séparer les networks (Cloudflared / coder) via warp et le restant via Nginx Proxy Manager
- Test live

- Quid de ufw ?
- Comment acceder aux bade de données ?
- Module Ansible pour les dns Cloudflare ?