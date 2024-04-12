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



<!-- Table des matières -->
<details>
  <summary>Table des matières</summary>
  <ol>
    <li>
      <a href="#a-propos-du-projet">À propos du projet</a>
    </li>
    <li>
      <a href="#bien-demarrer">Bien démarrer</a>
      <ul>
        <li><a href="#prerequis">Prérequis</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#Usage-et-commandes">Usage & commandes</a></li>
    <li><a href="#fiche-de-route">Fiche de route</a></li>
    <li><a href="#contribuer">Contribuer</a></li>
    <li><a href="#licence">Licence</a></li>
    <li><a href="#contact">Contact</a></li>
    <!-- <li><a href="#remerciements">Remerciements</a></li> -->
  </ol>
</details>



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

## Prérequis

Gallus nécessite d'être exécuté sous Windows (préciser TODO, 10/11/2016/Server 2022) avec une connexion internet active. Il peut être exécuté sur un poste déployé par lui-même.

## Installation

*Note : Il est possible que des drivers supplémentaires soient nécessaires afin d'assurer le bon fonctionnement de Gallus sur les postes à déployer. Référez-vous à la [documentation](https://github.com/Eternilab/gallus/wiki/Home-fr#Problemes-drivers).*

### Installation et exécution (Rapide)
*Installe Gallus à la racine du système et l'exécute avec ses options par défaut.*

1. Sur une machine Windows, ouvrez une instance de Powershell avec des droits d'administration.
2. Exécutez cette commande dans Powershell : 
```powershell
mkdir \Gallus; cd \Gallus; Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; & ([scriptblock]::Create((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Eternilab/gallus/main/gallus_full.ps1')))
```
Attendez la fin de son exécution, qui peut [prendre un moment](https://github.com/Eternilab/gallus/wiki/Home-fr#Installation-duree). Gallus est installé.
</br>

### Installation uniquement (Usage avancé)
*Installe Gallus à l'emplacement désiré et vous permet d'exécuter [chaque commande](#Usage-et-commandes) pour adapter votre utilisation de Gallus à vos besoins.*

<table>
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


<p align="right">(<a href="#haut-readme">retour au début</a>)</p>



## Usage & commandes

Si vous avez installé Gallus avec [la méthode avancée](#Installation-uniquement), vous aurez besoin d'exécuter chaque étape de Gallus manuellement afin de personnaliser votre expérience.

*Pour plus de détails sur chaque commande, incluant des exemples, référez-vous à la [documentation](https://github.com/Eternilab/gallus/wiki/Home-fr#Commandes).*

TODO :

1 - Gallus Build ([docs](https://github.com/Eternilab/gallus/wiki/Home-fr#Commandes-build))
```powershell
gallus build
```
2 - Gallus Run ([docs](https://github.com/Eternilab/gallus/wiki/Home-fr#Commandes-run))
```powershell
gallus run
```

<p align="right">(<a href="#haut-readme">retour au début</a>)</p>



## Fiche de route
<!--
- [ ] TODO
- [ ] TODO
- [ ] TODO
    - [ ] TODO
-->
Accédez aux [tickets](https://github.com/Eternilab/gallus/issues) pour une liste exhaustive des fonctionnalités proposées et problèmes connus.

<p align="right">(<a href="#haut-readme">retour au début</a>)</p>



## Contribuer

Si vous avez une suggestion qui améliorerait ce projet, Veuillez s'il vous plaît bifurquer le dépôt et créer une demande d'intégration. Vous pouvez aussi simplement [créer un ticket avec le tag "amélioration"](https://github.com/Eternilab/gallus/issues/new?labels=TODO(amelioration)&template=feature-request---.md).

Toute contribution sera **grandement appréciée**.

1. [Bifurquez (Fork) le dépôt](https://github.com/Eternilab/gallus/fork)
2. Créez une branche dans votre shell:
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

<p align="right">(<a href="#haut-readme">retour au début</a>)</p>



## Licence

Distribué sous licence AGPLv3. Voir [Licence.txt](https://github.com/Eternilab/gallus/LICENCE.txt) pour plus d'information.

<p align="right">(<a href="#haut-readme">retour au début</a>)</p>



## Contact

Eternilab - [@eternilab](https://twitter.com/eternilab) - [tech@eternilab.com](mailto:tech@eternilab.com)

Lien du dépôt : [https://github.com/Eternilab/gallus](https://github.com/Eternilab/gallus)

<p align="right">(<a href="#haut-readme">retour au début</a>)</p>


<!-- Remerciements -->
<!-- les remerciements aux contributions seront ajoutés ici
## Remerciements

TODO :

* []()
* []()
* []()

<p align="right">(<a href="#haut-readme">retour au début</a>)</p>

-->

<!-- LIENS ET IMAGES MARKDOWN -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
<!--
[gallus-logo]: images/gallus-logo
[gallus-screenshot]: images/gallus-screenshot
-->

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
