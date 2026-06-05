# AiBarr - Rapport  

**Cours** : Veille technologique (420-1SH-SW)  
**Date de remise** : 05 mai 2026  
**Préparé par** : Thierno Alimou Diallo  
**Présenté à** : Nicolas Bourre 

--- 
## 1. Introduction 
Dans une ère où l'intelligence artificielle (IA) est de plus en plus présente dans le quotidien des développeurs et des administrateurs système, la quasi-totalité des outils populaires repose sur un modèle unique : le cloud. Pour coder ou automatiser des tâches, l'approche dominante exige d'envoyer constamment des données et du code source sur des serveurs externes. Au-delà de la dépendance à des abonnements payants, cette centralisation pose un réel problème de souveraineté numérique. À l'échelle internationale, la prise de conscience est globale : des réglementations strictes comme le *Règlement général sur la protection des données* (RGPD) en Europe, les directives sur la cybersécurité aux États-Unis, telles que le cadre de cybersécurité du *National Institute of Standards and Technology* (NIST), ou encore la *Loi 25* ici, au Québec, forcent une réévaluation rigoureuse de la gestion des données. Dans ce contexte, externaliser des informations sensibles chez un tiers devient un risque de sécurité majeur que de nombreuses organisations ne peuvent plus tolérer.

C’est là qu'en s'appuyant sur des technologies open-source existantes, le projet AiBarr propose de déployer une infrastructure d'IA locale, performante et entièrement déconnectée. Ce rapport présente l’architecture de cette solution, la vulgarisation des outils qui la rendent possible, comme Ollama et le mécanisme de *Retrieval-Augmented Generation* (RAG), et la façon dont cette infrastructure s'intègre de manière minimaliste dans un environnement de développement moderne.

## 2. Explication du projet 
### 2.1 Objectifs et philosphie du projet 
Le projet repose sur trois approches : le local-first, le no-cloud et le minimalisme technique. L'objectif étant de prouver que nous pouvons exploiter la puissance des modèles de langage actuels sans dépendre d'infrastructures distantes. Alors que la majorité des solutions du marché exigent d'envoyer nos données d'infrastructure et notre code source sur des plateformes externes, AiBarr confine l'ensemble des traitements sur la machine de l'utilisateur. C'est une alternative concrète et souveraine face aux abonnements payants imposés par les géants du secteur comme ChatGPT, Gemini ou Claude.

Le but recherché est d'obtenir une fluidité et une pertinence de réponse identiques aux outils cloud, mais de manière totalement autonome et gratuite après le téléchargement des modèles. Le minimalisme du projet s'exprime également dans le refus de réinventer la roue en créant une nouvelle interface utilisateur graphique à partir de zéro, ce qui alourdirait inutilement le système. J'ai plutôt choisi d'intégrer *Open WebUI*, un projet existant que je juge très bien fait, fluide et mature. Cela permet de concentrer la totalité des ressources de calcul de la machine sur ce qui importe vraiment : l'inférence brute et la gestion locale des données.

### 2.2 Architecture (Windows - WSL - Docker) 
![Architecture globale d'AiBarr](assets/aibarr.png)
*Figure 1 : Comparaison paradigme dépendant du cloud vs local.*

Pour bâtir ce prototype, la pile technologique a été sélectionnée pour maximiser la productivité et l'efficacité opérationnelle :
* **L'environnement hôte** : Bien qu'un environnement Linux natif (comme une distribution Fedora en dual-boot) demeure mon choix de coeur pour le développement pur, la réalité du terrain et des contraintes de maintenance nous ont poussés vers une autre stratégie. Redémarrer constamment la machine pour basculer d'un système à l'autre nuit à la productivité quotidienne. Choisir Windows 11 combiné avec Windows Subsystem for Linux (WSL 2) s'est avéré une alternative redoutable d'efficacité. Cette couche nous permet d'exécuter un noyau Linux Ubuntu natif et léger directement à l'intérieur de notre session de travail, sans quitter les outils Windows. C'est ce pont qui permet aux conteneurs Linux d'accéder directement et de manière fluide aux ressources de calcul de la carte graphique (GPU) de la machine hôte via le passthrough matériel.
* **L'orchestration par micro-services (Docker & Docker Compose)** : Au lieu de tout installer directement sur le système au risque de corrompre l'environnement ou de saturer les dépendances, l'application est découpée en services isolés dans des conteneurs distincts.

J'ai volontairement choisi de séparer le moteur d'inférence (Ollama) et l'interface utilisateur graphique (Open WebUI) dans des conteneurs différents pour trois raisons majeures :
1. La modularité et la maintenance : Si nous devons mettre à jour l'interface utilisateur ou modifier sa configuration, le moteur d'inférence reste intact en arrière-plan et continue de faire tourner les modèles sans interruption.
2. La gestion des ressources : Le conteneur Ollama nécessite des privilèges d'accès stricts au GPU, tandis que l'interface graphique n'a besoin que de ressources CPU et réseau standards. Isoler les composants évite les conflits de configuration.
3. L'évolution vers l'automatisation : Bien que les premiers tests du prototype aient été lancés à l'aide de commandes manuelles (docker run), cette séparation a été pensée dès le départ pour industrialiser le déploiement via Docker Compose. En centralisant l'infrastructure dans un seul fichier de configuration docker-compose.yml, le projet devient une solution "clés en main". N'importe quel autre développeur ou administrateur système peut récupérer le projet et démarrer l'écosystème complet en une seule ligne de commande, assurant ainsi la portabilité réelle de la solution.

> *Note : Sur le plan de la connectivité, l'infrastructure d'AiBarr est configurée de manière étanche et n'est accessible qu'en boucle locale via localhost, l'interface d'Open WebUI répondant sur mon port personnalisé 1367. Dans le but de tester la flexibilité du système et de valider l'ouverture du projet pour d'éventuelles démonstrations, j'ai mené des expérimentations concrètes en laboratoire. J'ai notamment tenté de lier mon environnement local à une machine virtuelle externe hébergée sur MonkeyRank à l'aide d'une liaison SSH, en plus d'explorer l'utilisation d'un utilitaire de tunnel public comme localtunnel.*

---

## 3. Explication des fonctionnalités 
### 3.1 Le moteur de langage : LLM et Ollama 
Pour faire fonctionner AiBarr sans dépendre d'une connexion Internet, le système s'appuie sur un LLM (Large Language Model). Un LLM est un modèle statistique entraîné à prédire et générer du texte de manière cohérente en fonction d'un contexte fourni. Plutôt que d'utiliser les API fermées des géants du web, j'ai choisi de basculer exclusivement sur des modèles open-source. Cela nous permet, entre autres, de contrôler les poids du modèle, d'auditer le comportement du système et élimine par définition toute exfiltration ou fuite de données.

Mon infrastructure compte actuellement quatre modèles installés:
- LLama3:latest (8B)
- Gemma4:latest (8B)
- Qwen2.5:latest (7.6B)
- DeepSeek-Coder:latest (1B)

Le « B » signifie Billion (milliard de paramètres), soit les variables internes dictant la capacité de réflexion du modèle. Plus ce chiffre est élevé, plus le raisonnement est fin, mais plus le chargement est lourd. Sur ma machine dotée de 8 Go de VRAM, les formats de 7B ou 8B représentent le compromis idéal (sweet spot). L'exécution est fluide pour la majorité de mes outils, à l'exception de Gemma 4 qui s'avère un peu plus gourmand et long à répondre lors de l'inférence.

Pour orchestrer ces fichiers de modèles, l'infrastructure utilise **Ollama**. Développé en Go, Ollama agit comme un moteur d'exécution léger qui gère l'arrière-plan technique de l'inférence. C'est lui qui prend le fichier brut du modèle, le charge proprement dans la VRAM de la carte graphique et gère la puissance de calcul requise pour générer le texte en temps réel. Il me permet de télécharger et de basculer d'un modèle à l'autre en une seule ligne de commande, tout en exposant une API locale sécurisée avec laquelle mon interface graphique (Open WebUI) et mes outils de développement peuvent communiquer directement en tâche de fond.

### 3.2 L'injection de contexte : Le RAG 
Bien qu'un LLM soit performant, il ne possède aucune connaissance de mes fichiers locaux ou de mes documentations internes, et il a tendance à « halluciner » (inventer des faits erronés avec beaucoup d'assurance) si ses données d'entraînement font défaut. Pour régler ce problème, AiBarr intègre le mécanisme de *RAG*.

Le RAG consiste à intercepter ma question, à chercher les extraits correspondants dans une documentation locale de référence, puis à injecter ces extraits directement dans la mémoire à court terme du LLM pour qu’il formule une réponse exacte et vérifiable. Ce processus repose sur trois concepts clés :

- **Les Embeddings** : Des modèles spécialisés traduisent mes documents textuels en suites de nombres (vecteurs) représentant leur sens sémantique.
- **La Vector DB (Chroma DB)** : Une base de données vectorielle optimisée pour stocker ces coordonnées mathématiques et retrouver instantanément les segments de texte les plus proches du sens de ma question.
- **La fenêtre de contexte & le prompt système** : La fenêtre de contexte est la limite de mémoire allouée au LLM pour une conversation. C'est là que sont poussés les extraits de Chroma DB. Le System Prompt, lui, définit les règles de comportement de l'IA (ex. : « Réponds uniquement à l'aide des documents fournis. Si tu l'ignoreras, dis-le. »).

> *Note : Pour une analyse exhaustive de la plomberie mathématique et de l'indexation de la base de données vectorielle, veuillez vous référer au fichier d'ingénierie [rag.md](rag.md). Le suivi de sa mise en place et les chronologies de mes laboratoires sont documentés dans le fichier [planification.md](planification.md).*

### 3.3 Mon écosystème de travail : NeoVim  
L'objectif d'AiBarr est de s'intégrer de manière transparente directement là où j'écris mon code, sans m'obliger à ouvrir un navigateur web. C'est pourquoi j'ai connecté mon infrastructure locale à **NeoVim**, un éditeur de texte minimaliste basé sur le terminal et configurable en langage Lua.

Via le plugin CodeCompanion, je reproduis gratuitement et localement les fonctionnalités des extensions cloud payantes selon trois modes distincts :

- **Le mode Chat (avec Qwen 2.5)** : C'est l'équivalent d'avoir un collègue à qui on pose des questions sur une chaise d'à côté. Une interface de discussion s'ouvre sur le côté pour concevoir l'architecture d'un script ou comprendre un concept. J'ai choisi Qwen 2.5 (7.6B) pour ce mode en raison de ses capacités de raisonnement général et de sa fluidité conversationnelle.
- **Le mode Inline (avec DeepSeek-Coder)** : C'est l'équivalent d'un correcteur automatique qui réécrit directement sur notre feuille. On sélectionne un bloc de code et le modèle le modifie ou l'optimise directement à l'emplacement du curseur. Pour cette tâche précise, j'ai configuré le modèle spécialisé DeepSeek-Coder (1B) car étant léger, cela me permet d'avoir un temps de réponse plus rapide.  
- **Le mode Agentique** : C'est l'équivalent d'un assistant stagiaire à qui on donne une consigne et qui va fouiller lui-même dans les dossiers. Le modèle reçoit une directive et enchaîne de manière autonome des actions complexes (lire un fichier, exécuter un outil technique, analyser les erreurs) pour résoudre le problème.

> *Note : Si les modes Chat et Inline répondent plus ou moins bien à mes besoins les tests effectués, le mode agentique local n'a pas été pleinement fonctionnel lors de ses derniers.*

### 3.4 Bonus : Intégration TTS (Kokoro-TTS) 
Au-delà du texte brut, j'ai profité de la modularité d'Open WebUI pour explorer la dimension sonore de l'IA locale. J'ai intégré avec succès Kokoro-TTS, un modèle open-source de synthèse vocale (Text-to-Speech) ultra-léger. Ce module s'exécute localement et permet de faire lire à haute voix les réponses générées par les assistants.

Dans cette même démarche de veille, j'ai également exploré d'autres alternatives comme le modèle Orpheus-TTS, XTTS V2 et Chatterbox TTS. Bien que ces outils aient été écartés de l'infrastructure finale car ils saturaient inutilement mes ressources matérielles, ces manipulations m'ont permis d'évaluer concrètement les compromis entre la qualité audio et l'empreinte sur la mémoire vidéo (VRAM), tout en approfondissant le fonctionnement de la synthèse vocale.

## 4. Conclusion 
Le projet AiBarr prouve qu'en 2026, l'autonomie et la souveraineté numérique sont tout à fait accessibles pour un professionnel de l'informatique. En orchestrant des technologies matures comme Docker, Ollama et Open WebUI, j'ai démontré la viabilité d'une infrastructure d'IA performante, gratuite et entièrement coupée du réseau extérieur sur un poste de travail standard doté d'un GPU dédié.

Les défis de routage rencontrés sous WSL 2 pour l'ouverture hors de mon localhost (tests de liaison SSH vers ma VM MonkeyRank et usage de localtunnel) m'ont forcé à maintenir un cloisonnement local strict. Ce constat de laboratoire valide toutefois la philosophie d'étanchéité et de sécurité du projet.

Les prochaines étapes logiques consisteront à automatiser l'installation complète de mon poste via un dépôt de configurations (dotfiles) et à lier cette infrastructure locale au système de gestion de parc informatique (GLPI) du Cégep. L'intégration du protocole ouvert MCP (Model Context Protocol) permettra ainsi d'assister la gestion des tickets et de l'inventaire de manière totalement sécurisée, sans qu'aucune donnée technique sensible ne sorte du réseau local.

## 5. Référence / Médiagraphie
[1] Wikipédia, « Règlement général sur la protection des données », Wikipedia, L'encyclopédie libre, 2026. [En ligne]. Disponible sur : https://fr.wikipedia.org/wiki/R%C3%A8glement_g%C3%A9n%C3%A9ral_sur_la_protection_des_donn%C3%A9es. (Consulté pour l'analyse des contraintes de confidentialité européennes).

[2] Gouvernement du Québec, « Loi 25 - Nouvelles dispositions protégeant la vie privée des Québécois », Portail Québec, 2022. [En ligne]. Disponible sur : [https://www.quebec.ca/nouvelles/actualites/details/loi-25-nouvelles-dispositions-protegeant-la-vie-privee-des-quebecois-certaines-dispositions-entrent-en-vigueur-aujourdhui-43212]. (Consulté pour la conformité et l'alignement réglementaire d'AiBarr).

[3] National Institute of Standards and Technology, « NIST Cybersecurity Framework (CSF) », U.S. Department of Commerce, 2026. [En ligne]. Disponible sur : https://www.nist.gov/. (Consulté pour les lignes directices à l'utilisation de l'IA).

[4] Ollama Team, « Ollama: Get up and running with large language models locally », GitHub, 2026. [En ligne]. Disponible sur : https://github.com/ollama/ollama. (Moteur d'inférence principal retenu pour le projet).

[5] Docker Hub, « Docker Compose Documentation », Docker Docs, 2026. [En ligne]. Disponible sur : https://docs.docker.com/compose/. (Référence technique exploitée pour l'orchestration et la portabilité de l'infrastructure).

[6] Open WebUI Team, « Open WebUI Documentation », Open WebUI, 2026. [En ligne]. Disponible sur : https://docs.openwebui.com/. (Interface graphique retenue pour sa fluidité et sa légèreté matérielle).

[7] Google, « Large Language Model Gemini », Outil d'aide à la réflexion et à la structuration de contenu, 2026. (Utilisé pour la mise en forme et l'organisation du plan provisoire et de la médiagraphie IEEE ainsi que pour l'assistance à l'automatisation de mon déploiement).

**[Médiagraphie complète](https://github.com/AlimouDiallo367/1sh-veille-techno/blob/main/docs/references.md)**
