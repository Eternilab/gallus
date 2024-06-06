# Version Beta

Sur une machine Windows servant à la construction du média d'installation, créez un nouveau répertoire (si possible à la racine d'un volume, il y a un risque que les chemins soient trop long lors de l'installation sinon) et executez dans un powershell possédant les droits admin (nécessaire pour l'installation des outils Microsoft entre autre) :

```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; & ([scriptblock]::Create((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Eternilab/gallus/main/gallus_full.ps1')))
```

Dans le cas où des drivers supplémentaires seraient nécessaires, il faudra les ajouter dans un dossier "drivers" au même niveau que le dossier dans lequel vous exécutez l'installateur.  
Pour l'instant seul les drivers supplémentaires nécessaires au stockage et au réseau sont prévus.  
Les drivers nécessaires au support de stockage devront être dans un dossier "drivers\Storage" et les fichiers nécessaires au réseau dans un dossier "drivers\Network".  
