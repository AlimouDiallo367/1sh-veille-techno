# AiBarr - Rapport de recherche 

**Cours** : Veille technologique (420-1SH-SW)  
**Date de remise** : 22 avril 2026  
**Préparé par** : Thierno Alimou Diallo  
**Présenté à** : Nicolas Bourre 

--- 
## 1. Introduction 
Dans une ère où l'intelligence artificielle (IA) est de plus en plus présente dans le quotidien des développeurs et des administrateurs système, la quasi-totalité des outils populaires repose sur un modèle unique : le cloud. Pour coder ou automatiser des tâches, l'approche dominante exige d'envoyer constamment des données et du code source sur des serveurs externes. Au-delà de la dépendance à des abonnements payants, cette centralisation pose un réel problème de souveraineté numérique. À l'échelle internationale, la prise de conscience est globale : des réglementations strictes comme le *Règlement général sur la protection des données* (RGPD) en Europe, les directives sur la cybersécurité aux États-Unis, telles que le cadre de cybersécurité du *National Institute of Standards and Technology* (NIST), ou encore la *Loi 25* ici, au Québec, forcent une réévaluation rigoureuse de la gestion des données. Dans ce contexte, externaliser des informations sensibles chez un tiers devient un risque de sécurité majeur que de nombreuses organisations ne peuvent plus tolérer.

C’est là qu'en s'appuyant sur des technologies open-source existantes, le projet AiBarr propose de déployer une infrastructure d'IA locale, performante et entièrement déconnectée. Ce rapport présente l’architecture de cette solution, la vulgarisation des outils qui la rendent possible, comme Ollama et le mécanisme de *Retrieval-Augmented Generation* (RAG), et la façon dont cette infrastructure s'intègre de manière minimaliste dans un environnement de développement moderne.

## 2. Explication du projet 
### 2.1 Objectifs et philosphie du projet 
Le projet **AiBarr** repose sur une approche claire : le local-first, le no-cloud et le minimalisme technique. L'objectif fondamental consiste à prouver que nous pouvons exploiter la puissance des modèles de langage actuels sans dépendre d'infrastructures distantes. Alors que la majorité des solutions du marché exigent d'envoyer nos données d'infrastructure et notre code source sur des plateformes externes, AiBarr confine l'ensemble des traitements sur la machine de l'utilisateur. C'est une alternative concrète et souveraine face aux abonnements payants imposés par les géants du secteur comme ChatGPT, Gemini ou Claude.

Le but recherché est d'obtenir une fluidité et une pertinence de réponse identiques aux outils cloud, mais de manière totalement autonome et gratuite après le téléchargement des modèles. Le minimalisme du projet s'exprime également dans le refus de réinventer la roue en créant une nouvelle interface utilisateur graphique à partir de zéro, ce qui alourdirait inutilement le système. J'ai plutôt choisi d'intégrer *Open WebUI*, un projet existant que je juge extrêmement bien conçu, fluide et mature. Cela permet de concentrer la totalité des ressources de calcul de la machine sur ce qui importe vraiment : l'inférence brute et la gestion locale des données.

### 2.2 Architecture (Windows - WSL - Docker) 
Pour bâtir ce prototype, la pile technologique a été sélectionnée pour maximiser la productivité et l'efficacité opérationnelle :
* **L'environnement hôte** : Bien qu'un environnement Linux natif (comme une distribution Fedora en dual-boot) demeure le choix de cœur pour le développement pur, la réalité du terrain et des contraintes de maintenance nous ont poussés vers une autre stratégie. Redémarrer constamment la machine pour basculer d'un système à l'autre nuit à la productivité quotidienne. Choisir Windows 11 combiné avec Windows Subsystem for Linux (WSL 2) s'est avéré une alternative redoutable d'efficacité. Cette couche nous permet d'exécuter un noyau Linux Ubuntu natif et léger directement à l'intérieur de notre session de travail, sans quitter les outils Windows. C'est ce pont qui permet aux conteneurs Linux d'accéder directement et de manière fluide aux ressources de calcul de la carte graphique (GPU) de la machine hôte via le passthrough matériel.
* **L'orchestration par micro-services (Docker & Docker Compose)** : Au lieu de tout installer directement sur le système au risque de corrompre l'environnement ou de saturer les dépendances, l'application est découpée en services isolés dans des conteneurs distincts.

J'ai volontairement choisi de séparer le moteur d'inférence (Ollama) et l'interface utilisateur graphique (Open WebUI) dans des conteneurs différents pour trois raisons majeures :
- La modularité et la maintenance : Si nous devons mettre à jour l'interface utilisateur ou modifier sa configuration, le moteur d'inférence reste intact en arrière-plan et continue de faire tourner les modèles sans interruption.
- La gestion des ressources : Le conteneur Ollama nécessite des privilèges d'accès stricts au GPU, tandis que l'interface graphique n'a besoin que de ressources CPU et réseau standards. Isoler les composants évite les conflits de configuration.
- L'évolution vers l'automatisation : Bien que les premiers tests du prototype aient été lancés à l'aide de commandes manuelles (docker run), cette séparation a été pensée dès le départ pour industrialiser le déploiement via Docker Compose. En centralisant l'infrastructure dans un seul fichier de configuration docker-compose.yml, le projet devient une solution "clés en main". N'importe quel autre développeur ou administrateur système peut récupérer le projet et démarrer l'écosystème complet en une seule ligne de commande, assurant ainsi la portabilité réelle de la solution.

> *Note : Sur le plan de la connectivité, l'infrastructure d'AiBarr est configurée de manière étanche et n'est accessible qu'en boucle locale via localhost, l'interface d'Open WebUI répondant sur mon port personnalisé 1367. Dans le but de tester la flexibilité du système et de valider l'ouverture du projet pour d'éventuelles démonstrations, j'ai mené des expérimentations concrètes en laboratoire. J'ai notamment tenté de lier mon environnement local à une machine virtuelle externe hébergée sur MonkeyRank à l'aide d'une liaison SSH, en plus d'explorer l'utilisation d'un utilitaire de tunnel public comme localtunnel.*

---

## 3. Explication des fonctionnalités 
### 3.1 Le moteur de langage : LLM et Ollama 
- [ ] À rédiger : Définir ce qu'est un LLM (Large Language Model) et justifier l'importance des modèles open-source (auditabilité, contrôle des poids). Mentionner le choix de Llama 3 et DeepSeek-Coder.
- [ ] À rédiger : Expliquer la signification des paramètres (7B / 8B) et pourquoi ils représentent le compromis idéal (sweet spot) pour la mémoire vive (RAM/VRAM) d'une machine locale.
- [ ] À rédiger : Présenter Ollama comme le moteur d'exécution en Go qui gère les modèles et expose l'API locale.

### 3.2 L'injection de contexte : Le RAG 
Bien qu'un LLM soit performant, il ne possède aucune connaissance de mes fichiers locaux ou de mes documentations internes, et il a tendance à « halluciner » (inventer des faits erronés avec beaucoup d'assurance) si ses données d'entraînement font défaut. Pour régler ce problème, AiBarr intègre le mécanisme de RAG (Retrieval-Augmented Generation).

Le RAG consiste à intercepter ma question, à chercher les extraits correspondants dans une documentation locale de référence, puis à injecter ces extraits directement dans la mémoire à court terme du LLM pour qu’il formule une réponse exacte et vérifiable. Ce processus repose sur trois concepts clés :court terme allouée et les directives de comportement données à l'IA.

- **Les Embeddings** : Des modèles spécialisés traduisent mes documents textuels en suites de nombres (vecteurs) représentant leur sens sémantique.
- **La Vector DB (Chroma DB)** : Une base de données vectorielle optimisée pour stocker ces coordonnées mathématiques et retrouver instantanément les segments de texte les plus proches du sens de ma question.
- **La fenêtre de contexte & le prompt système** : La fenêtre de contexte est la limite de mémoire allouée au LLM pour une conversation. C'est là que sont poussés les extraits de Chroma DB. Le System Prompt, lui, définit les règles de comportement de l'IA (ex. : « Réponds uniquement à l'aide des documents fournis. Si tu l'ignoreras, dis-le. »).

> *Note : Pour une analyse exhaustive de la plomberie mathématique et de l'indexation de la base de données vectorielle, veuillez vous référer au fichier d'ingénierie [rag.md](rag.md). Le suivi de sa mise en place et les chronologies de mes laboratoires sont documentés dans le fichier [planification.md](planification.md).*

### 3.3 Mon écosystème de travail : NeoVim  
- [ ] À rédiger : Présenter NeoVim comme l'éditeur minimaliste et performant (configurable en Lua) pour intégrer l'IA directement dans le terminal de travail.

> *Note : plugin CodeCompanion, expliquer les différents mode de fonctionnement, chat, inline et agentique. Peut être rédiriger vers une page mcp.md ou neovim.md ou autre*

### 3.4 Bonus : Intégration TTS et Web Search (Kokoro-TTS, Opheus-TTS) 
- Dire que Kokoro-TTS fonctionne bien, j'ai exploré d'autres modèles de son comme Opheus-TTS et Chatbox

## 4. Conclusion 
- [ ] À rédiger : Synthèse 

## 5. Référence / Médiagraphie
- [RGPD](https://fr.wikipedia.org/wiki/R%C3%A8glement_g%C3%A9n%C3%A9ral_sur_la_protection_des_donn%C3%A9es)
- [Loi 25 - Québec](https://www.quebec.ca/nouvelles/actualites/details/loi-25-nouvelles-dispositions-protegeant-la-vie-privee-des-quebecois-certaines-dispositions-entrent-en-vigueur-aujourdhui-43212)
- [Loi 25 - Legis Québec](https://www.legisquebec.gouv.qc.ca/fr/document/lc/P-39.1)
- [NIST](https://www.nist.gov/)
- [Autre liens à ajouter ici]()

> 2 à 3 Pages Max excluant les pages structurelles!!! Support visuel à ajouter

