<!--
Readme-Template adapted from https://github.com/othneildrew/Best-README-Template
-->



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
<!-- [![LinkedIn][linkedin-shield]][linkedin-url] -->

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/Mithrandir2k18/dockerized-https-ipfs-gateway">
    <img src="https://ipfs.io/ipfs/QmaodApcM6Kp96MnDxHiLN3mniMsrcfNzsQAUTfFkkey1r?filename=logo.png" alt="Logo" width="800" height="400">
  </a>

  <h3 align="center">HTTPS IPFS Gateway in Docker</h3>

  <p align="center">
    A mostly automated way to set up an IPFS Gateway with HTTPS in Docker Containers
    <br />
    <a href="https://github.com/Mithrandir2k18/dockerized-https-ipfs-gateway"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/Mithrandir2k18/dockerized-https-ipfs-gateway">View Demo</a>
    ·
    <a href="https://github.com/Mithrandir2k18/dockerized-https-ipfs-gateway/issues">Report Bug</a>
    ·
    <a href="https://github.com/Mithrandir2k18/dockerized-https-ipfs-gateway/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
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
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project
[IPFS](https://ipfs.io) is a decentralized protocol that aims to serve content
not by addressing it by where it comes from (URI), but instead replacing the
central authority and use Content IDentifiers to find content and retrieve it
from the closest peer that has content with the same hash.

To make IPFS more
accessible, similarly to how IPv6 is/was tunneled in IPv4, IPFS can deliver
content via the HTTP protocol by addressing a gateway that has an IPFS node set
up.

Having more public gateways helps to share the load of the main `ipfs.io`
gateway and it can make sharing content with others a lot faster, as you can
seed data from your own gateway, guaranteeing that it is located quickly.

### Built With

* [Docker](https://www.docker.com/)
* [Docker Compose](https://docs.docker.com/compose/)
* [Go-IPFS](https://github.com/ipfs/go-ipfs)
* [nginx](https://nginx.org/en/)
* [certbot](https://certbot.eff.org/)
* [Let's Encrypt](https://letsencrypt.org/)


<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

Install [Docker](https://docs.docker.com/desktop/#download-and-install) and
[docker-compose](https://docs.docker.com/compose/install/) as instructed by
the linked resources. Make sure to add your user to the
[docker group](https://docs.docker.com/engine/install/linux-postinstall/)!

Furthermore, if you're behind a NAT, you'll need to set up port-forwarding
to the device that'll run the gateway. Required are port 80(for incoming
HTTP; it will be upgraded to HTTPS via a 301 response), 443(for HTTPS) and
4001(for IPFS).

And lastly, your device needs to have a DNS entry that points to your (static)
IP address. If you don't have either, I recommend a service like
[DuckDNS](https://duckdns.org).


### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/Mithrandir2k18/dockerized-https-ipfs-gateway.git
   ```
2. If you're not on the amd64/x86_64 architecture:
   1. Execute the `build_go-ipfs.sh` script. 
   2. Edit the `docker-compose.yaml` and add an image tag to the service
   "certbot" that matches your system. Find the tags
   [here](https://hub.docker.com/r/certbot/certbot/tags?page=1&ordering=last_updated)
   and it like this: `certbot/certbot:TAGNAME`
3. Edit the `nginx.conf` file and replace every mention of `mydomain.com` with
your registered domain.
4. Edit the `setup_configs.sh` script and change the first two variables to
match your registered domain and email.
5. Execute the `setup_configs.sh` script. If any errors are shown, cancel it,
using `CTRL+C`, debug it, delete the created `data` directory and try again.
6. At the end of the script you'll be asked some questions. After that your
dockerized HTTPS IPFS Gateway should be up and running!
7. If you want to start the gateway on each reboot of your device add
`sleep 10 && cd /path/to/repo/ && docker-compose up -d` to your [crontab](https://crontabjob.com/how-to-add-crontab-jobs-in-linux-unix/)!



<!-- USAGE EXAMPLES -->
## Usage

Once your gateway is up and running and publicly reachable, you can use and
share HTTPS Gateway links like
`https://ipfs.io/ipfs/QmPChd2hVbrJ6bfo3WBcTW4iZnpHm8TEzWkLHmLpXhF68A`, but
instead of using the `ipfs.io` gateway you can now use links using yours like
this: `https://mydomain.com/ipfs/QmPChd2hVbrJ6bfo3WBcTW4iZnpHm8TEzWkLHmLpXhF68A`!

<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/Mithrandir2k18/dockerized-https-ipfs-gateway/issues) for a list of proposed features (and known issues).



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

The license may be subject to change in the future.


<!-- CONTACT -->
## Contact

Mithrandir2k18 - themithrandir09@gmail.com

Project Link: [https://github.com/Mithrandir2k18/dockerized-https-ipfs-gateway](https://github.com/Mithrandir2k18/dockerized-https-ipfs-gateway)

<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

* This project was inspired
[here](https://www.reddit.com/r/ipfs/comments/l509at/how_to_set_up_a_dockerized_ipfs_gateway_with_https/gktbmj4?utm_source=share&utm_medium=web2x&context=3).
* This project is an implementation of
[this guide](`https://willschenk.com/articles/2019/setting_up_an_ipfs_node/`).
* Thanks to [alexzorin](https://github.com/alexzorin), who has been a quick
and [huge help](https://github.com/certbot/certbot/issues/8619)!
* README Template from [here](https://github.com/othneildrew/Best-README-Template).


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Mithrandir2k18/dockerized-https-ipfs-gateway.svg?style=for-the-badge
[contributors-url]: https://github.com/Mithrandir2k18/dockerized-https-ipfs-gateway/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Mithrandir2k18/dockerized-https-ipfs-gateway.svg?style=for-the-badge
[forks-url]: https://github.com/Mithrandir2k18/dockerized-https-ipfs-gateway/network/members
[stars-shield]: https://img.shields.io/github/stars/Mithrandir2k18/dockerized-https-ipfs-gateway.svg?style=for-the-badge
[stars-url]: https://github.com/Mithrandir2k18/dockerized-https-ipfs-gateway/stargazers
[issues-shield]: https://img.shields.io/github/issues/Mithrandir2k18/dockerized-https-ipfs-gateway.svg?style=for-the-badge
[issues-url]: https://github.com/Mithrandir2k18/dockerized-https-ipfs-gateway/issues
[license-shield]: https://img.shields.io/github/license/Mithrandir2k18/dockerized-https-ipfs-gateway.svg?style=for-the-badge
[license-url]: https://github.com/Mithrandir2k18/dockerized-https-ipfs-gateway/blob/master/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/Mithrandir2k18
