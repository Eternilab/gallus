Téléchargez le fichier gallus_full.ps1 et executez-le sur la machine utilisée pour construire l'installateur

ou éxecutez dans powershell :

```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Jerome-Maurin/Gallus/master/gallus_full.ps1'))
```
