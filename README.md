<a name="haut-readme"></a>

<!-- SHIELDS DU PROJET -->
<!--
*** Les badges de ce document contiennent des liens, qui sont définis dans des variables.
*** Voyez le bas du document pour les déclarations.
*** Référence :
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Étoiles ajoutées][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![Licence AGPLv3][license-shield]][license-url]



<!-- LOGO DU PROJET -->
<!--
<br />
<div align="center">
  <a href="https://github.com/Eternilab/gallus">
    <img src="TODO" alt=Logo Gallus" width="80" height="80">
  </a>
-->

<!-- TITRE -->
<h1 align="center">Gallus</h1>

  <p align="center">
    Constructeur de média d'installation de postes sécurisés sous Microsoft Windows
    <br />
    <a href="https://github.com/Eternilab/gallus/wiki/Home-fr#"><strong>Documentation »</strong></a>
    <br />
    <br />
    <a href="https://github.com/Eternilab/gallus/issues/new?labels=TODO(bug)&template=bug---.md">Signaler un bug</a>
    ·
    <a href="https://github.com/Eternilab/gallus/issues/new?labels=TODO(amelioration)&template=feature-request---.md">Demander une fonctionnalité</a>
  </p>
</div>

# À propos du projet

<!-- [![Capture d'écran de Gallus][gallus-screenshot]](https://example.com) TODO -->

Ce projet a pour but de générer avec le minimum d'interaction humaine des médias d'installation de postes sécurisés sous Microsoft Windows 11.


### Propulsé par

* [![Powershell][Powershell-badge]][Powershell-url]
* [![Windows 11][Windows11-badge]][Windows11-url]
* [![HTML5][HTML5-badge]][HTML5-url]
* [![CSS3][CSS3-badge]][CSS3-url]
* [![JavaScript][JavaScript-badge]][JavaScript-url]

<p align="right">(<a href="#haut-readme">retour au début</a>)</p>

# Bien démarrer

# Version Beta

Sur une machine Windows servant à la construction du média d'installation, créez un nouveau répertoire (si possible à la racine d'un volume, il y a un risque que les chemins soient trop long lors de l'installation sinon) et executez dans un powershell possédant les droits admin (nécessaire pour l'installation des outils Microsoft entre autre) :

```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; & ([scriptblock]::Create((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Eternilab/gallus/main/gallus_full.ps1')))
```

Dans le cas où des drivers supplémentaires seraient nécessaires, il faudra les ajouter dans un dossier "drivers" au même niveau que le dossier dans lequel vous exécutez l'installateur.  
Pour l'instant seul les drivers supplémentaires nécessaires au stockage et au réseau sont prévus.  
Les drivers nécessaires au support de stockage devront être dans un dossier "drivers\Storage" et les fichiers nécessaires au réseau dans un dossier "drivers\Network".  
