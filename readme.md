# Documentation

!!! todo !!!

## Apprise

Pour tester les notifcations depuis l'interface web de Apprise, visiter l'admin à l'adresse apprise.YOURDOMAIN.XX et renseigner la configuration suivante :
```
backup=DISCORD_WEBHOOK_BACKUP
update=DISCORD_WEBHOOK_UPDATE
down=DISCORD_WEBHOOK_DOWN
```
Où DISCORD_WEBHOOK_BACKUP, DISCORD_WEBHOOK_UPDATE et DISCORD_WEBHOOK_DOWN correspondent aux adresses des webhooks discord.
Ceux ci sont renseignés dans le fichier "/host_wars/YOUR_ENV/all.yml".
