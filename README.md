Téléchargez le fichier gallus_full.ps1 dans un nouveau répertoire et executez-le sur la machine utilisée pour construire l'installateur

ou éxecutez dans powershell :

```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Jerome-Maurin/Gallus/master/gallus_full.ps1'))
```

Dans le cas où des drivers supplémentaires seraient nécessaires, il faudra les ajouter dans un dossier "drivers" au même niveau que le dossier dans lequel vous exécutez gallus_full.ps1
