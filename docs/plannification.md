# Plannification 
Ce document repertorie mon avancement durant ces 2 semaines
## Setuper mon environnement (WSL Ubuntu ou Fedora Physique) 
J'ai procéder à la mise en place de mon environnement de base du système sous Linux avec l'installation et la config des affaires suivantes:
- [x] git
- [x] mysql/mariadb
- [x] zsh
- [x] curl
- [x] wget
- [x] tmux 
- [x] vim/nvim
- [x] ruby/rbenv/ruby-build
- [x] gcc, build-essential, ssh
- [x] docker
- [] node/nvm 
- [] rust, rustop, starship, cargo
- [] apache2, passenger, nginx?
Ensuite, j'ai mis en place mon environnement de dev, 

(25 mai 2026)
## Docker et Ollama
J'ai fait des recherches du fonctionnement de docker, d'ollama et mise en place les conteneurs de base
...
après cela, j'ai procéder au téléchargement des modèles en parallèle la rédaction de ma doc pour une futur automatisation via docker compose et/ou bash. Enfin, j'ai mis en place l'interface graphique avec Open WebUI et je me suis promené dessus pour avoir une prise en main rapide (fonctionnement, méthode d'authentification, personnalisation, choix de modèle...) (mercredi 27, jeudi 28) 

## Enjeux sécurité et SysAdmin 
### Analyse sur la possible utilisation de iptables 
Dans mon cas: 
> Non, pas directement, et voici pourquoi (Le piège WSL) :
> Le rôle de Docker : Dès que tu lances un conteneur avec le commutateur -p 3000:8080, Docker manipule déjà ses propres règles iptables en tâche de fond dans le noyau Linux pour ouvrir le port.
> L'architecture réseau de WSL 2 : Ta distribution Ubuntu ne possède pas sa propre adresse IP physique sur ton routeur Wi-Fi. Elle est cachée derrière ton Windows (ton hôte) via un réseau virtuel interne en mode NAT (Network Address Translation).
> Où ça bloque ? Si tu essaies de taper l'IP de ton ordinateur depuis ton cellulaire, tu vas frapper la porte de Windows, pas celle de ton Ubuntu WSL. C'est le pare-feu de Windows (Windows Firewall) et la table de routage de ton hôte qui bloquent le trafic.

### Enjeux et risques
<blockquote> 
Si tu ouvres ton infrastructure à l'aveugle en mode "Western", voici ce qui va se passer :
Le vol de VRAM / Déni de service (DoS) : Ton API Ollama (port 12367) n'a aucune authentification native. Si tu exposes le port d'Ollama directement sur ton réseau sans protection, n'importe qui sur le Wi-Fi du Cégep ou de chez toi peut envoyer des requêtes massives à ta carte graphique, saturer tes 8 Go de VRAM et faire crasher ton Legion.
Le trafic en clair (Man-in-the-Middle) : Pour l'instant, ton interface Open WebUI tourne en HTTP (Port 3000). Tes identifiants administrateurs et l'historique de tes chats transitent sur l'air (Wi-Fi) en texte brut. Un simple sniffeur de paquets (comme Wireshark) pourrait intercepter ton mot de passe.
Le contournement d'accès : Open WebUI possède une option d'inscription pour les nouveaux utilisateurs. Si tu ouvres l'accès sans désactiver les inscriptions publiques, des inconnus sur le réseau pourraient se créer un compte sur ton AiBarr et utiliser tes modèles.
</blockquote>

### Edge-Cases SysAdmin
<blockquote>
- Le changement d'IP dynamique (DHCP) : Ton Legion change d'adresse IP à chaque fois que tu passes du Wi-Fi de chez toi à celui du Cégep (ex: 192.168.1.45 ➡️ 10.160.X.X). Ton cellulaire devra sans cesse changer l'URL pour te trouver.
- La mise en veille de Windows : Si ton ordinateur portable ferme son écran ou tombe en veille, la VM WSL 2 se fige instantanément. Ton cellulaire perdra la connexion.
</blockquote>

Pour le match de l'ouverture, de la sécurisation et du rollback de AiBarr, voir https://github.com/AlimouDiallo367/aibarr/blob/main/docs/deployment_proc.md
