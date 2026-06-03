# Planification 
Ce document repertorie mon avancement durant ces 2 semaines.

--- 

## 1. Setup environnement de base linux (WSL vs Physique)
Mise en place de l'environnement système avec l'installation et la configuration des outils suivants :
- [x] Installation et configuration de Git
- [x] mysql/mariadb, sqlite3
- [x] zsh (uniquement installé, shell par défaut: bash)
- [x] curl
- [x] wget
- [x] tmux, tree
- [x] vim/nvim
- [x] ruby/rbenv/ruby-build
- [x] gcc, build-essential, ssh
- [x] docker
- [x] apache2, passenger, nginx (conteneur nginx)
- [x] node/nvm 
- [x] rust, rustop, starship, cargo

> *Note: Cet environnement sera éventuellement automatisé via un dépôt dotfiles (25 mai 2026).* 

## 2. Docker, Ollama, LLM et Open WebUI
- [x] Suivi 01 avec Nick - Document des liens pour effectuer le travail 
- [x] Recherches sur le fonctionnement de Docker et Ollama (site officiel, Gemini et wikipedia)
- [x] Déploiement et mise en place des conteneurs de base (aibarr_ollama, aibarr_ui). 
- [x] Téléchargement des modèles Llama3, Gemma4 et DeepSeek-CoderV2
- [x] En parallèle, rédaction de la documentation (en vue d'une future automatisation via Docker Compose et/ou scripts Bash).
- [x] Déploiement de l'interface graphique avec Open WebUI (port 1367 au lieu de 3000)
- [x] Prise en main rapide de Open WebUI (exploration du fonctionnement, méthodes d'authentification, personnalisation, choix des modèles...)

> *Chronologie : Mercredi 27 mai (recherche, rédaction doc/proc) et Jeudi 28 mai (déploiement).*

---

## 3. Ouverture, reverse proxy et protection AiBarr
- [x] Analyse de la faisabilité avec iptables sous WSL 2 ([Voir explications](#analyse-iptables))
- [x] Identification des risques de sécurité et cas limites ([Voir analyses](#enjeux-et-risques))
- [x] Déploiement d'un conteneur Nginx et configuration des certificats SSL
- [x] Contournement du blocage réseau localhost via utilitaires tiers pour le PoC (`localtunnel` / `ngrok`)
- [x] Mise à jour planification 
- [x] Préparation Suivi 02 - Struture du document et un peu de contenu  
- [ ] Résolution du problème d'accès réseau direct hors localhost (investigation pare-feu Windows et règles de routage)

> *Chronologie : Vendredi 29 mai (reverse proxy, rédaction doc/proc) et Lundi 01 juin (RAG).*
> *Note : je demanderai peut être d'avoir accès à la doc interne du dept pour le RAG ou sinon j'utiliserai de la doc perso pour alimenter mon RAG*

--- 

## 4. Retrieval-Augmented Generation
- [x] Mise en place du RAG
- [x] Essaie avec document personnel vs document cégep?! (documentation onenote vs livre de code?)
- [x] Choix probable Rust Book, Ruby lang, Github Nicolas (robotique), site web James, Cppreference
- [x] Bonus, mise en place de Kokoro API  
- [ ] Faire plus de tests avec le RAG pour l'affiner avec Open WebUI 


> *Chronologie : lundi 01 juin (reverse proxy, rédaction doc/proc, rag, base de connaissance 1sx).*
> *Open WebUI prend le contrôle, découpe tes fichiers en morceaux, calcule les embeddings et peuple son instance ChromaDB locale. Tu vas voir une icône de chargement tourner pendant qu'il indexe le tout. Aussi, pour les tests avec le cours de robotique de Nick j'ai du ajuster les paramètres chunks et top K (1000 à 500 et 3 à 5)* 

--- 
## 5. Intégration environnement NeoVim 
- [x] CodeCompanion 

## 6. Intégration VS Code + Mode agentique??? 

---

## Annexes : Analyses techniques et sécurité

### Analyse sur la possible utilisation de iptables <a id="analyse-iptables"></a>
Dans mon cas, l'utilisation directe n'est pas possible pour les raisons suivantes (Le piège WSL) :

- **Le rôle de Docker :** Dès le lancement d'un conteneur avec le commutateur `-p 3000:8080`, Docker manipule déjà ses propres règles iptables en tâche de fond dans le noyau Linux pour ouvrir le port.
- **L'architecture réseau de WSL 2 :** Ma distribution Ubuntu ne possède pas sa propre adresse IP physique sur mon routeur Wi-Fi. Elle est masquée derrière mon hôte Windows via un réseau virtuel interne en mode NAT (Network Address Translation).
- **Le point de blocage :** Si je tente de joindre l'IP de mon ordinateur depuis mon cellulaire, la requête frappe la porte de Windows, pas celle de mon Ubuntu WSL. C'est le pare-feu de Windows (Windows Firewall) et la table de routage de mon hôte qui bloquent le trafic.

### Enjeux et risques <a id="enjeux-et-risques"></a>
Si j'ouvre mon infrastructure à l'aveugle sans protection, voici les risques identifiés:

- **Le vol de VRAM / Déni de service (DoS) :** Mon API Ollama (port 12367) n'a aucune authentification native. Si j'expose le port d'Ollama directement sur mon réseau sans protection, n'importe qui sur le Wi-Fi du Cégep ou de chez moi peut envoyer des requêtes massives à ma carte graphique, saturer mes 8 Go de VRAM et faire crasher mon Legion.
- **Le trafic en clair (Man-in-the-Middle) :** Pour l'instant, mon interface Open WebUI tourne en HTTP (Port 3000). Mes identifiants administrateurs et l'historique de mes requêtes transitent sur le réseau Wi-Fi en texte brut. Un simple sniffeur de paquets (comme Wireshark) pourrait intercepter mon mot de passe.
- **Le contournement d'accès :** Open WebUI possède une option d'inscription pour les nouveaux utilisateurs. Si j'ouvre l'accès sans désactiver les inscriptions publiques, des inconnus sur le réseau pourraient se créer un compte sur mon AiBarr et consommer les ressources de mes modèles.

### Edge-Cases SysAdmin
- **Le changement d'IP dynamique (DHCP) :** Mon Legion change d'adresse IP à chaque fois que je passe du Wi-Fi de chez moi à celui du Cégep (ex: 192.168.1.45 => 10.160.X.X). Mon cellulaire devra sans cesse changer l'URL pour me trouver.
- **La mise en veille de Windows :** Si mon ordinateur portable ferme son écran ou tombe en veille, la VM WSL 2 se fige instantanément. Mon cellulaire perdra la connexion.

### Détails sur ce qui a été fait
J'ai mis en place un conteneur nginx et configuré les certificats ssl. Malheureusement, pour une raison que j'ignore, je n'arrive pas à accéder à aibarr autrement qu'en localhost. Plusieurs solutions ont été essayées (pare-feu windows, règles), et seule l'utilisation d'utilitaires tiers comme localtunnel ou ngrok permettent de le faire. Pour le moment, je maintiens cette solution là pour le PoC, je reviendrai sur le problème plus tard.

## Référence
Voir la procédure de déploiement ici [AiBarr](https://github.com/AlimouDiallo367/aibarr/blob/main/docs/deployment_proc.md)
