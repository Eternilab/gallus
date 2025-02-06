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
      <a href="#%C3%A0-propos-du-projet">À propos du projet</a>
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

Ce projet (Gallus) a pour but de générer des médias d'installation (ISO, USB) du système d'exploitation Microsoft Windows 11.

La mise en œuvre de Gallus s'effectue en deux phases :

* Phase 1 : Construction d'un média d'installation sur un premier poste  Microsoft Windows (poste de construction).
* Phase 2 : Démarrage sur un second poste (poste cible) à partir du media d'installation créé lors de la phase précédente, pour installer un système d'exploitation Microsoft Windows sécurisé.

Les phases 1 et 2 se produisent de manière quasi-automatique, voir les sections [Construction du media (Phase 1)](#construction-du-m%C3%A9dia-phase-1) et [Démarrage à partir du media d’installation (Phase 2)](#d%C3%A9marrage-%C3%A0-partir-du-m%C3%A9dia-dinstallation-phase-2).

La phase 2 déploie un poste conforme à :

* [Benchmarks du CIS](https://www.cisecurity.org/benchmark/microsoft_windows_desktop) (intégré dans Gallus)
* [Guide d'Hygiène de l'ANSSI au niveau standard](https://cyber.gouv.fr/publications/guide-dhygiene-informatique) (intégré dans Gallus)
* [Guide d'Hygiène de l'ANSSI au niveau renforcé](https://cyber.gouv.fr/publications/guide-dhygiene-informatique) ([contacter Eternilab](mailto:contact@eternilab.com))
* [Instruction Interministèrielle 901](https://cyber.gouv.fr/instruction-interministerielle-n901) ([contacter Eternilab](mailto:contact@eternilab.com))

Lors de l'étape finale de l'installation en phase 2, des rapports de conformité sont générés et affichés sur le poste.

Le projet OpenSource [HardeningKitty](https://github.com/scipag/HardeningKitty) est utilisé pour appliquer et vérifier la sécurisation du poste déployé grâce au média d'installation construit par Gallus.

L'automatisation utilisée dans ce projet utilise la technologie [MDT](https://learn.microsoft.com/en-us/mem/configmgr/mdt/) de Microsoft instrumentée grâce à [Powershell](https://learn.microsoft.com/en-us/powershell/scripting/overview).


### Propulsé par

* [![Powershell][Powershell-badge]][Powershell-url]
* [![Windows 11][Windows11-badge]][Windows11-url]
* [![HTML5][HTML5-badge]][HTML5-url]
* [![CSS3][CSS3-badge]][CSS3-url]
* [![JavaScript][JavaScript-badge]][JavaScript-url]

<p align="right">(<a href="#haut-readme">retour au début</a>)</p>



# Prérequis

Gallus nécessite d'être utilisé sur un système d'exploitation Windows 10 (ou plus récent) ou Serveur 2016 (ou plus récent).

Une connexion Internet active est nécessaire afin de récupérer les différentes briques logicielles depuis ces URLs :

* https://raw.githubusercontent.com/Eternilab/gallus/*
* https://raw.githubusercontent.com/scipag/HardeningKitty/*
* https://go.microsoft.com/*
* https://download.microsoft.com/download/*

Dans un but de sécurisation des systèmes, il est à noter que seuls les flux sortants précédemment citées sont nécessaires.

En terme d'espace disque, 25Go sont nécessaires à la construction du média d'installation.

Il est possible d'utiliser Gallus sur un système ayant été installé grâce à Gallus lui-même.

Dans le cas ou un système Windows n'est pas disponible nativement, des solutions de virtualisations (VirtualBox, etc.) peuvent être utilisées pour héberger un système Microsoft Windows.

# Construction du média (Phase 1)

Bien que la volonté première de Gallus soit de limiter l'interaction utilisateur nécessaire pour obtenir un installateur, il est possible d'avoir accès à des options avancées (cf: [Installation uniquement (Usage avancé)](#installation-uniquement-usage-avanc%C3%A9)).

Ainsi les choix par défaut de la configuration de Gallus peuvent être modifiés, par exemple :

* Création de multiples médias d'installation
* Réutilisation d'une poste de construction ayant déjà servi pour construire un média d'installation, suite à une mise à jour des images d'installation de Microsoft Windows.

Deux modes d'installation/usage sont donc détaillés ci-après. 

### Installation et exécution (Rapide, TLDR)
*Installe Gallus à la racine du système et l'exécute avec ses options par défaut.*

1. Sur une machine Windows, ouvrez une instance de Powershell avec des droits d'administration.
2. Exécutez cette commande dans Powershell : 
```powershell
mkdir \Gallus; cd \Gallus; Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; & ([scriptblock]::Create((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Eternilab/gallus/main/gallus_full.ps1')))
```
Attendez la fin de son exécution, qui peut prendre un moment.

Gallus à produit un media d'installation au format ISO et vous propose de créer une clé USB d'installation.

Passer ensuite à la section [Démarrage à partir du media d’installation](#d%C3%A9marrage-%C3%A0-partir-du-m%C3%A9dia-dinstallation-phase-2)
</br>

### Installation uniquement (Usage avancé)
*Installe Gallus à l'emplacement désiré et vous permet d'exécuter [chaque commande](#usage--commandes) pour adapter votre utilisation de Gallus à vos besoins.*

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



### Usage & commandes

Si vous avez installé Gallus avec [la méthode avancée](#installation-uniquement-usage-avanc%C3%A9), vous aurez besoin d'exécuter manuellement chaque étape de Gallus à partir du répertoire où vous l'avez installé.

Les différentes étapes de Gallus correspondent à différents scripts PS1 qui sont tous récupérés et exécutés par le script ```gallus_full.ps1```utilisé dans le cas de l'[Installation et exécution (Rapide, TLDR)](#installation-et-ex%C3%A9cution-rapide-tldr).

Voici l'ensemble de ces scripts accompagnés d'une rapide description des actions qu'ils produisent :

* ```1-gallus_download_tools.ps1``` : Télécharge les installateurs des outils depuis le site de Microsoft.

* ```2-gallus_setup_tools.ps1``` : Installe les outils téléchargés précédement.

* ```3-gallus_download_windows_image.ps1``` : Télécharge l'image (format ESD) de l'installateur officiel de Windows 11 depuis les serveurs Microsoft.

* ```4-gallus_extract_windows_image.ps1``` : Extrait les différentes parties de l'image nécessaires à Gallus.

* ```5-gallus_download_drivers.ps1``` : Récupère les pilotes supplémentaires (copie du dossier ```drivers\Storage``` et ```drivers\Network``` dans le répertoire parent de Gallus). cf [Support de périphériques avec pilotes supplémentaires](#support-de-p%C3%A9riph%C3%A9riques-avec-pilotes-suppl%C3%A9mentaires)

* ```6-gallus_download_HardeningKitty.ps1``` : Récupère l'outil HardeningKitty utilisé pour le durcissement du système.

* ```7-gallus_cleanup_MDT.ps1``` : Supprime les potentielles anciennes configurations de MDT.

* ```8-gallus_run_MDT.ps1``` : Exécution de MDT avec les paramètres et les ajouts de Gallus pour construire les fichiers d'installation. Production d'une ISO démarrable.

* ```9-gallus_build_USB_media.ps1``` : Construction d'un média d'installation USB démarrable (sur UEFI uniquement, BIOS non supporté).

<p align="right">(<a href="#haut-readme">retour au début</a>)</p>

# Démarrage à partir du média d’installation (Phase 2)

Maintenant qu'un média d'installation a été produit, il est possible de démarrer le poste cible à partir de ce média.

L'installation de Microsoft Windows se fait de manière automatique dans le cas d'un déroulement nominal.

Attention, par défaut le premier disque détecté sera complètement formaté et toutes les données qui pourraient y être stockées seront effacées !

Cette installation se déroule en plusieurs sous-étapes entre lesquelles il y aura des redémarrages du poste cible, ce qui est parfaitement normal.

Lors de la première sous-étape, le système WinPE (Windows Preinstallation Environment) va copier les fichiers sur le disque dur interne. Cette phase peut-être repérée par le font d'écran gris avec le texte suivant en haut à droite : ```Windows Deployement Toolkit```

Lors des sous-étapes suivantes, le système Windows va démarrer à partir du disque interne et se configurer.

Une fois le système installé, une session de l'utilisateur ```Administrator```, mot de passe ```local```, ayant les droits d'administrateur local s'ouvre automatiquement.

Le durcissement du système s'effectue également automatiquement, suivi de la génération des rapports d'audits de conformité.

Les rapports de conformité sont ensuite ouverts automatiquement dans Microsoft Edge dans plusieurs onglets.

Le poste est maintenant déployé.

Le système Windows est installé sans licence, à vous de fournir la vôtre pour être conforme au [contrat d'utilisateur final de Microsoft](https://www.microsoft.com/content/dam/microsoft/usetm/documents/windows/11/oem-(pre-installed)/UseTerms_OEM_Windows_11_English.pdf).

Cette [Phase 2](#d%C3%A9marrage-%C3%A0-partir-du-m%C3%A9dia-dinstallation-phase-2) est répétable sur autant de postes que désiré.

# Problèmes potentiels

Si votre problème n'est pas décrit dans les sous chapitres qui suivent, veuillez [contacter Eternilab](mailto:contact@eternilab.com) ou [signaler un bug](https://github.com/Eternilab/gallus/issues/new?labels=TODO(bug)&template=bug---.md).
	
### Problèmes d'accès au disque

Dans le cas où l'installation échoue lors de la première sous-phase (font d'écran gris avec le texte suivant en haut à droite : ```Windows Deployement Toolkit```), avec une fenêtre d'erreur nommée ```Script Error``` contenant le message d'erreur ```An error has occured in the script on this page```, par dessus une fenêtre ```Deployment Summary``` avec le sous-titre ```Failure``` et le message ```Operating system deployment did not complete successfully```, il est fort probable qu'il manque des pilotes pour permettre au système WinPE (Windows Preinstallation Environment, système d'exploitation utilisé en phase 2 (cf. [A propos du projet](#%C3%A0-propos-du-projet)) d'accéder au disque.

Pour s'assurer qu'il s'agit bien de ce problème, cliquez sur la croix rouge en haut à droite de la première fenêtre puis faites de même avec la deuxième.

Une invite de commande ```cmd.exe``` devrait s'ouvrir.

Executez la commande suivante :

```notepad.exe ..\temp\SMSTSLog\smsts.log```

L'éditeur de texte Notepad devrait s’ouvrir en vous montrant les journaux d'installation produits jusqu'ici.

Utilisez la fonction de recherche avec le texte suivant : ```Failed to run```

Si vous trouver le message ```Failed to run the action: Format and Partition Disk```, c'est qu'il y a eu en effet une impossibilité de formater le disque souvent due au manque de pilotes correspondants.
Vous trouverez des informations ci-dessous, dans la section [Support de périphériques avec pilotes supplémentaires](#support-de-p%C3%A9riph%C3%A9riques-avec-pilotes-suppl%C3%A9mentaires), pour adresser ce problème.

Dans le cas contraire, un autre problème est survenu, cherchez la réponse dans ce fichier de journaux cité précédemment :

```X:\Windows\temp\SMSTSLog\smsts.log```

# Support de périphériques avec pilotes supplémentaires

Vu la diversité du parc des équipements sur lesquels Microsoft Windows peut fonctionner, des pilotes logiciels supplémentaires doivent être ajoutés pour que l'installation du système d'exploitation puisse aboutir.

Le périphérique dont le support de pilotes est indispensable lors de la phase 2 (cf. [A propos du projet](#%C3%A0-propos-du-projet)) est le disque (SSD, HDD, etc.). L'installateur à besoin d'accéder au disque lors de l'installation du système Microsoft Windows pour le structurer, le formater et y déployer les fichiers du système d'exploitation, sinon l'installation sera interrompue.

Un autre périphérique peut être nécessaire, non pas pendant la phase d'installation à proprement parler, mais lorsque le système démarre les premières fois, il s'agit de la carte réseau, que ce soit filaire (Ethernet) ou sans-fil (Wifi). Avoir au moins une interface réseau utilisable une fois le système déployé permet d'installer d'autres logiciels, de mettre le système à jour et plus généralement d'accéder à Internet.

Il est donc nécessaire dans ces cas de fournir ces pilotes supplémentaires à Gallus lors de la phase 1 (cf. [A propos du projet](#%C3%A0-propos-du-projet)).

Pour ce faire on va récupérer un ensemble de pilotes pour WinPE (Windows Preinstallation Environment, système d'exploitation utilisé en phase 2 (cf. [A propos du projet](#%C3%A0-propos-du-projet)) lors de la première sous-étape).

Dans le cas d'un PC portable DELL, par exemple on cherchera sur un moteur de recherche les mots clé suivants : ```dell WinPE 11 driver pack```

Il s'agit de récupérer un ensemble de pilotes permettant l'accès au disque et au réseau pour plusieurs modèles de postes cible.
Si l'ensemble de pilotes ne représente pas une taille trop importante (quelques centaines de mégaoctets), il peut être intégralement ajouté à Gallus.
Dans le cas ou l'ensemble est trop gros, il faudra isoler les bons pilotes, pour éviter de trop alourdir la taille de l'installateur.

Le risque est de dépasser les 32Go, ce qui empêcherait de fabriquer une clé USB d’installation, car on utilise une partition FAT32 pour respecter le standard UEFI, ce qui limite la taille de la partition à 32Go.

Une fois l'ensemble de pilotes récupérés (ou uniquement les pilotes nécessaires), il faut s'assurer que l'on a un des deux formats suivants :

* Un ensemble de fichiers avec extension .sys et .inf avec éventuellement des .cat (éventuellement des .dll et exe)
* Un ou plusieurs fichiers .cab, contenant l'équivalent du premier point

Le but est de mettre ces fichiers dans l’arborescence suivante à la racine du système de fichier du disque C: :
```
Drivers
├── Network
└── Storage
Gallus
```

Que ce soit le premier ou deuxième cas (ensemble de fichiers ou .cab), si possible il est mieux de séparer les pilotes réseau et stockage dans les dossiers correspondants, sinon on pourra mettre l'ensemble dans le dossier ```Storage```.

Vous pouvez maintenant lancer Gallus, les drivers seront importés dans le média d'installation.

Si vous suivez les instructions de cette section suite à une interruption de l'installation dans la sous-étape 1, voici comment éviter d'avoir à relancer complètement Gallus pour produire le nouveau média d'installation contenant les bon pilotes supplémentaires.

FIXME étape clean MDT puis reexec, puis USB.

# Analyse des journaux d'installation

Comme spécifié dans la section [Problèmes d'accès au disque](#probl%C3%A8mes-dacc%C3%A8s-au-disque), il est facilement possible d’accéder aux journaux d'installation de la sous-étape 1 de la phase 2 (cf. [Démarrage à partir du media d’installation](#d%C3%A9marrage-%C3%A0-partir-du-m%C3%A9dia-dinstallation-phase-2)) lors de l'installation en allant lire le fichier ```X:\Windows\temp\SMSTSLog\smsts.log```.
Néanmoins l'accès à ce journal de cette manière n'est possible qu'en cas de problème entrainant l'interruption de l’exécution durant la première phase d’installation. Il sera accessible autremement une fois le système démarré, comme expliqué ci-dessous.

Nous allons maintenant voir comment accéder aux journaux d'installation à la fin de celle-ci, lorsque le système est installé, ou directement sur le disque de la machine, dans le cas d'un problème lors des autres sous-étapes d'installation.

FIXME.

# Fiche de route
<!--
- [ ] TODO
- [ ] TODO
- [ ] TODO
    - [ ] TODO
-->
Accédez aux [tickets](https://github.com/Eternilab/gallus/issues) pour une liste exhaustive des fonctionnalités demandées, en cours de développement ou des problèmes connus.

<p align="right">(<a href="#haut-readme">retour au début</a>)</p>



# Contribuer

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



# Licence

Distribué sous licence AGPLv3. Voir [Licence.txt](https://github.com/Eternilab/gallus/LICENCE.txt) pour plus d'information.

<p align="right">(<a href="#haut-readme">retour au début</a>)</p>



# Contact

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
