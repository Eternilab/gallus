<a name="readme-top"></a>

<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/Eternilab/gallus">
    <img src="TODO" alt="Gallus Logo" width="80" height="80">
  </a>

<h1 align="center">Gallus</h1>

  <p align="center">
    Constructeur de média d'installation de postes sécurisés sous Microsoft Windows
    <br />
    <a href="https://github.com/Eternilab/gallus/wiki/Home-fr#"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="TODO">View Demo</a>
    ·
    <a href="https://github.com/Eternilab/gallus/issues/new?labels=TODO(bug)&template=bug-report---.md">Report Bug</a>
    ·
    <a href="https://github.com/Eternilab/gallus/issues/new?labels=TODO(amelioration)&template=feature-request---.md">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
# About The Project

[![Gallus Screen Shot][product-screenshot]](https://example.com) TODO

Ce projet a pour but de générer avec le minimum d'interaction humaine un installateur de postes sécurisés sous Microsoft Windows 11.


### Powered by

* [![Powershell][Powershell-badge]][Powershell-url]
* [![Windows 11][Windows11-badge]][Windows11-url]
* [![HTML5][HTML5-badge]][HTML5-url]
* [![CSS3][CSS3-badge]][CSS3-url]
* [![JavaScript][JavaScript-badge]][JavaScript-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
# Getting Started

## Prerequisites

Gallus nécessite d'être exécuté sous Windows (préciser TODO, 10/11/2016/Server 2022) avec une connexion internet active. Il peut être exécuté sur un poste déployé par lui-même.

## Installation

*Note : Il est possible que des drivers supplémentaires soient nécessaires afin d'assurer le bon fonctionnement de Gallus sur les postes à déployer. Référez-vous à la [documentation](https://github.com/Eternilab/gallus/wiki#Problemes-drivers).*

### Installation et exécution (Rapide)
*Installe Gallus à la racine du système et l'exécute avec ses options par défaut.*

1. Sur une machine Windows, ouvrez une instance de Powershell avec des droits d'administration.
2. Exécutez cette commande dans Powershell : 
```powershell
mkdir \Gallus; cd \Gallus; Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; & ([scriptblock]::Create((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Eternilab/gallus/main/gallus_full.ps1')))
```
Attendez la fin de son exécution, qui peut [prendre un moment](https://github.com/Eternilab/gallus/wiki#Installation-duree). Gallus est installé !
</br>

### <a name="Installation-avance"></a>Installation uniquement (Usage avancé)
*Installe Gallus à l'emplacement désiré et vous permet d'exécuter [chaque commande](#Usage) pour adapter votre utilisation de Gallus à vos besoins.*

<table style="width: 100%">
<tr>
	<td>
		<details>
			<summary>Avec Git</summary>

#TODO

		</details>
	</td>
</tr>
<tr>
	<td>
		<details>
			<summary>Avec Powershell</summary>

#TODO

		</details>
	</td>
</tr>
<tr>
	<td>
		<details>
			<summary>Avec Autre chose</summary>

#TODO

		</details>
	</td>
</tr>
</table>


<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## <a name="usage"></a>Usage & Commands

Si vous avez installé Gallus avec [la méthode avancée](#Installation-avance), vous aurez besoin d'exécuter chaque étape de Gallus manuellement afin de personnaliser votre expérience.

*Pour plus de détails sur chaque commande, incluant des exemples, référez-vous à la [documentation](https://github.com/Eternilab/gallus/wiki#Commandes).*

TODO :

1 - Gallus Build ([docs / details ? nom? TODO](https://github.com/Eternilab/gallus/wiki#Commandes-build))
```powershell
gallus build
```
2 - Gallus Run ([docs](https://github.com/Eternilab/gallus/wiki#Commandes-run))
```powershell
gallus run
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [ ] TODO
- [ ] TODO
- [ ] TODO
    - [ ] TODO

Accédez aux [tickets](https://github.com/Eternilab/gallus/issues) pour une liste exhaustive des fonctionnalités proposées et problèmes connus.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

TODO

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

Si vous avez une suggestion qui améliorerait ce projet, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. [Bifurquez (Fork) le dépôt](https://github.com/Eternilab/gallus/fork)
2. Créez dans votre shell votre branche :
```shell
git checkout -b TODO (feature/AmazingFeature)
```
3. Commitez (Commit) vos changements :
```shell
git commit -m "Ajouté une fonctionnalité"
```
4. Poussez (Push) vers la branche :
```shell
git push origin feature/AmazingFeature
```
5. [Ouvrez une demande d'intégration (Pull Request)](https://github.com/Eternilab/gallus/compare)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distribué sous licence AGPLv3. Voir [LICENSE.txt](https://github.com/Eternilab/gallus/LICENCE.txt) pour plus d'information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

TODO :

Your Name - [@twitter_handle](https://twitter.com/twitter_handle) - email@email_client.com

Lien du dépôt : [https://github.com/Eternilab/gallus](https://github.com/Eternilab/gallus)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

TODO :

* []()
* []()
* []()

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Eternilab/gallus.svg?style=for-the-badge
[contributors-url]: https://github.com/Eternilab/gallus/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Eternilab/gallus.svg?style=for-the-badge
[forks-url]: https://github.com/Eternilab/gallus/network/members
[stars-shield]: https://img.shields.io/github/stars/Eternilab/gallus.svg?style=for-the-badge
[stars-url]: https://github.com/Eternilab/gallus/stargazers
[issues-shield]: https://img.shields.io/github/issues/Eternilab/gallus.svg?style=for-the-badge
[issues-url]: https://github.com/Eternilab/gallus/issues
[license-shield]: https://img.shields.io/github/license/Eternilab/gallus.svg?style=for-the-badge
[license-url]: https://github.com/Eternilab/gallus/blob/master/LICENSE.txt

[Powershell-badge]: https://img.shields.io/badge/PowerShell-%235391FE.svg?style=for-the-badge&logo=powershell&logoColor=white
[Powershell-url]: https://github.com/PowerShell/PowerShell
[Windows11-badge]: https://img.shields.io/badge/Windows%2011-%230079d5.svg?style=for-the-badge&logo=Windows%2011&logoColor=white
[Windows11-url]: https://www.microsoft.com/software-download/windows11
[CSS3-badge]: https://img.shields.io/badge/css3-%231572B6.svg?style=for-the-badge&logo=css3&logoColor=white
[CSS3-url]: https://developer.mozilla.org/en-US/docs/Web/CSS
[JavaScript-badge]: https://img.shields.io/badge/javascript-%23323330.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E
[JavaScript-url]: https://developer.mozilla.org/en-US/docs/Web/JavaScript
[HTML5-badge]: https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white
[HTML5-url]: https://developer.mozilla.org/en-US/docs/Web/HTML
