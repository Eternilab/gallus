<a name="readme-top"></a>

<!-- PROJECT SHIELDS -->
<!--
*** This document's badges contain link, defined in variables.
*** See the bottom for variables definitions.
*** Reference :
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![AGPLv3 License][license-shield]][license-url]



<!-- PROJECT LOGO -->
<!--
<br />
<div align="center">
  <a href="https://github.com/Eternilab/gallus">
    <img src="TODO" alt=Gallus Logo" width="80" height="80">
  </a>
-->

<!-- TITLE -->
<h1 align="center">Gallus</h1>

  <p align="center">
	Installation media generator for reinforced Microsoft Windows computers
    <br />
    <a href="https://github.com/Eternilab/gallus/wiki/Home-fr#"><strong>Read the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/Eternilab/gallus/issues/new?labels=TODO(bug)&template=bug---.md">Report a bug</a>
    ·
    <a href="https://github.com/Eternilab/gallus/issues/new?labels=TODO(amelioration)&template=feature-request---.md">Request a feature</a>
  </p>
</div>



<!-- Table of contents -->
<details>
  <summary>Table of contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About the project</a>
    </li>
    <li>
      <a href="#getting-started">Getting started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#Usage-and-commands">Usage and commands</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <!-- <li><a href="#acknowledgments">Acknowledgments</a></li> -->
  </ol>
</details>



# About the project

<!-- [![Gallus Screen Shot][gallus-screenshot]](https://example.com) TODO -->

This project aims to generate Microsoft Windows 11 installation media with the minium amount of human interaction.

### Powered by

* [![Powershell][Powershell-badge]][Powershell-url]
* [![Windows 11][Windows11-badge]][Windows11-url]
* [![HTML5][HTML5-badge]][HTML5-url]
* [![CSS3][CSS3-badge]][CSS3-url]
* [![JavaScript][JavaScript-badge]][JavaScript-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>



# Getting started

## Prerequisites

Gallus needs to be ran on a machine running Windows (TODO : 10/11/2016/2022 ?) with an active internet connection. You can run Gallus on a machine deployed by itself.

## Installation

*Note : Complementary drivers may be necessary for Gallus to function properly on target computers. Refer to the [docs](https://github.com/Eternilab/gallus/wiki/Home-en#Common-issues-drivers) for more details.*

### Install and run (Quick)
*Installs Gallus in the system root and runs it with default settings.*

1. On a Windows machine, open a Powershell instance with admin rights.
2. Run the following command in Powershell :
```powershell
mkdir \Gallus; cd \Gallus; Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; & ([scriptblock]::Create((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Eternilab/gallus/main/gallus_full.ps1')))
```
Wait for its execution to end, which can [take a while](https://github.com/Eternilab/gallus/wiki/Home-en#Installation-duration). Gallus has successfully been installed.
</br>

### Installation only (Advanced use)
*Installs Gallus in the desired folder and lets you run [each command](#Usage-and-commands) to alter Gallus' configuration according to your needs.*

<table>
<tr>
	<td>
		<details>
			<summary>Using Git</summary>

#TODO

		</details>
	</td>
</tr>
<tr>
	<td>
		<details>
			<summary>Using Powershell</summary>

#TODO

		</details>
	</td>
</tr>
<tr>
	<td>
		<details>
			<summary>Using something else</summary>

#TODO

		</details>
	</td>
</tr>
</table>


<p align="right">(<a href="#readme-top">back to top</a>)</p>



## Usage and commands

If you installed Gallus using [the advanced method](#Installation-only), you will need to go through each step manually to further customize your experience.

*For more details about each command, including examples, please refer to the [docs](https://github.com/Eternilab/gallus/wiki/Home-en#Commands).*

TODO :

1 - Gallus Build ([docs](https://github.com/Eternilab/gallus/wiki/Home-en#Commands-build))
```powershell
gallus build
```
2 - Gallus Run ([docs](https://github.com/Eternilab/gallus/wiki/Home-en#Commands-run))
```powershell
gallus run
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## Roadmap
<!--
- [ ] TODO
- [ ] TODO
- [ ] TODO
    - [ ] TODO
-->
See the open [issues](https://github.com/Eternilab/gallus/issues) for a full list of proposed features and known issues.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## Contributing

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply [open an issue with the "enhancement" tag](https://github.com/Eternilab/gallus/issues/new?labels=TODO(amelioration)&template=feature-request---.md).

Any contributions are **greatly appreciated.**


1. [Fork the repo](https://github.com/Eternilab/gallus/fork)
2. Create a branch in your shell :
```shell
git checkout -b TODO (feature/AmazingFeature)
```
3. Commit your changes :
```shell
git commit -m "Added a feature"
```
4. Push to the branch :
```shell
git push origin feature/AmazingFeature
```
5. [Open a pull request](https://github.com/Eternilab/gallus/compare)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## License

Distributed under the AGPLv3 license. See [Licence.txt](https://github.com/Eternilab/gallus/LICENCE.txt) for more info.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## Contact

Eternilab - [@eternilab](https://twitter.com/eternilab) - [tech@eternilab.com](mailto:tech@eternilab.com)

Repo link : [https://github.com/Eternilab/gallus](https://github.com/Eternilab/gallus)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- Ackowledgments -->
<!-- Ackowledgments of contributions will be added here
## Acknowledgments

TODO :

* []()
* []()
* []()

<p align="right">(<a href="#readme-top">back to top</a>)</p>

-->

<!-- MARKDOWN LINKS AND IMAGES -->
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
