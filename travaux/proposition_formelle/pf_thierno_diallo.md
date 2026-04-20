# Proposition formelle - Veille technologique 

**Titre du projet** : **AiBarr** - Déploiement d'une infrastructure IA locale. 

**Date de remise** : 19 avril 2026  
**Proposé par** : Thierno Alimou Diallo  
**Dépôt Git** : https://github.com/nbourre/1sh_notes_cours 

---

## 1. Introduction

L'émergence des modèles de langage (LLM) transforme radicalement le métier d'informaticien. Cependant, la dépendance aux services infonuagiques pose des défis majeurs en termes de confidentialité des données et de coûts récurrents (dépendance au cloud, abonnements, compagnies externes). En tant qu'**opérateur informatique** au **Cégep de Shawinigan**, je constate un besoin croissant pour des outils d'assistance qui respectent la vie privée et la sécurité des données institutionnelles.

Ce projet s'inscrit directement dans le thème « L’IA au service du développeur ». L'objectif est de concevoir un environnement de travail local, sécurisé et personnalisé pour l'assistance au codage (DevSecOps) et l'optimisation/automatisation du support technique, sans dépendance aux services Cloud externes.

---

## 2. Prérecherche 

Avant de fixer le choix final, trois idées ont été explorées : 

* **Idée A : Infrastructure IA Locale avec Ollama et Open WebUI**
    * **Description** : Déploiement d'un serveur d'IA auto-hébergé utilisant la conteneurisation pour faire tourner des modèles ouverts.
    * **Faisabilité** : Élevée (7 jours). Requiert la maîtrise de Linux et des environnements isolés.
    * **Intérêt personnel** : Atteindre une autonomie technologique totale.

* **Idée B : Intégration LLM locale dans Neovim via Lua**
    * **Description** : Intégration d'un LLM local dans mon environnement de travail Neovim configuré entièrement en Lua pour l'assistance au code.
    * **Faisabilité** : Moyenne. Demande une configuration fine des plugins LSP et de l'interface d'inférence.
    * **Intérêt personnel** : Optimiser mon environnement de développement minimaliste.

* **Idée C : Outil d'audit de sécurité en Rust (SecBarr-CLI)**
    * **Description** : Développement d'un outil CLI en Rust pour l'audit réseau et la détection de vulnérabilités.
    * **Faisabilité** : Moyenne. Focus sur la performance du langage Rust.
    * **Intérêt personnel** : Approfondir la programmation système et la cybersécurité.

**Justification du choix final** : L'Idée A a été retenue car elle constitue la fondation infrastructurelle indispensable. Sans un serveur local robuste, l'intégration sécurisée d'une IA dans un flux de travail professionnel ou dans un éditeur terminal minimaliste est impossible.

---

## 3. Objectifs du projet

* Déployer un serveur IA fonctionnel sous Linux accessible sur le réseau local.
* Assurer l'inférence de modèles spécialisés. 
  > Note : Priorisation de Llama 3, Gemma et Mistral pour les besoins institutionnels, réservant DeepSeek (DeepSeekV3 Coder) à un usage strictement personnel.
* Documenter le déploiement pour une potentielle standardisation en milieu professionnel.

---

## 4. MVP (Minimum Viable Product)

Le projet sera considéré comme terminé si, après 7 jours, les éléments suivants sont opérationnels :

* Un conteneur **Incus/LXC** ou **Docker** faisant tourner **Ollama**.
* Une interface utilisateur fonctionnelle via **Open WebUI**.
* **Génération de code** : Capacité confirmée de générer du code en **C++**, **Rust** ou **Ruby** localement. 
* **Support technique** : Capacité confirmée de répondre à des requêtes sur l'administration système (ex: scripts PowerShell pour GLPI, Microsoft Entra, Active Directory) sans connexion internet.

---

## 5. Méthodologie

**Approche envisagée :** Le projet suivra une approche itérative et expérimentale. La priorité sera d'abord d'établir une fondation stable (infrastructure), puis d'y greffer les modèles d'IA, et enfin de valider leur utilité à travers des cas d'usage réels du support technique et du développement.

Le projet sera réalisé en plusieurs phases :  

### Phase 1 - Recherche et installation de l'infrastructure *(Jour 1-2)*
- Étudier la documentation de Docker et réviser les configurations Incus/LXC.  
- Déployer l'environnement conteneurisé sur une machine Linux locale.  
- Installer le moteur d'inférence Ollama.

### Phase 2 - Déploiement des modèles et de l'interface *(Jour 3-4)* 
- Télécharger et configurer les modèles sélectionnés (Llama 3, Mistral, Gemma).  
- Installer et relier l'interface Open WebUI au moteur Ollama.
- Sécuriser l'accès à l'interface sur le réseau local.

### Phase 3 - Tests, intégration et ajustements *(Jour 5-6)*
- Tester les capacités de génération de code en Rust, C++ et Ruby.  
- Simuler des scénarios de support TI réels (ex: demander à l'IA d'expliquer une procédure GLPI ou de générer un script PowerShell pour Microsoft Entra).
- Ajuster les paramètres du système pour optimiser la vitesse de réponse (tokens/seconde).

### Phase 4 - Analyse, documentation et rapport *(Jour 7)*
- Rédiger le rapport expliquant les défis rencontrés et les choix techniques.  
- Documenter le processus de déploiement pour permettre une éventuelle standardisation en milieu professionnel.
- Préparer la démonstration finale du projet.

---

## 6. Outils et technologies

* **Moteur d'IA** : Ollama.
* **Conteneurisation** : Incus/LXC, Docker.
* **Modèles** : Llama, Gemma, Mistral, DeepSeek-Coder.
* **Environnement** : Linux (Debian/Ubuntu), Neovim (Lua). 

---

## 7. Résultats attendus

Démonstration d'un assistant IA souverain, performant et sécurisé. La validation se fera par des tests de génération de solutions techniques avec un temps de réponse acceptable sur matériel local.

---

## Bonus - Projet pour un OBNL

* **Identification de l'organisme** : Cégep de Shawinigan (Service informatique).
* **Besoin réel** : Assurer la confidentialité des données institutionnelles tout en offrant aux techniciens un outil d'automatisation pour le support (GLPI, Active Directory, Microsoft Intune, SCCM, infrastructure réseau, etc.).

---

## Annexe : Utilisation de l'IA

L'IA (Gemini) a été utilisée pour structurer la proposition et raffiner la formulation technique.

**Prompts utilisés** :
1. « Aide-moi à structurer mes 3 idées de projet pour mon cours de veille technologique (Infrastructure IA locale, Intégration Neovim, CLI Sec Tool en Rust). »
2. « Rédige la proposition formelle en format Markdown en respectant le plan : Introduction, Prérecherche, Objectifs, MVP, Méthodologie, Outils, Résultats. J'ajusterai de mon côté. »
3. « Comment formuler la section bonus OBNL pour que mon projet au travail soit reconnu ? »
4. « Aide-moi à définir un MVP réaliste pour un déploiement local d'IA via Docker/Incus. »
5. « Recherches techniques sur les concepts de RAG, MCP et comparaison de modèles open source vs propriétaires. »
6. « Comment adapter la section Méthodologie en un format de phases temporelles strictes sur 7 jours, en m'inspirant de l'exemple fourni en classe ? »
7. « Aide-moi à formuler une justification professionnelle pour prioriser les modèles Llama et Mistral en milieu institutionnel par rapport à DeepSeek, en tenant compte des enjeux géopolitiques et de conformité. »
8. « Quelle stratégie de nommage adopter pour séparer mon projet personnel (AiBarr) de mon projet professionnel (ShawAI) afin de protéger ma propriété intellectuelle ? Aussi, aide-moi à rendre le ton de ma proposition plus académique tout en conservant mon identité de développeur axé sur le minimalisme et la performance (Rust/C++) »

---

## Conclusion

Ce projet représente une opportunité majeure d'approfondir mes compétences en administration système et en DevSecOps. L'intégration de l'intelligence artificielle dans nos flux de travail est inévitable, mais elle ne doit pas se faire au détriment de la souveraineté de nos données et de notre code. 

En mettant sur pied l'infrastructure AiBarr, je souhaite démontrer qu'il est tout à fait possible d'allier la puissance des modèles de langage modernes avec la sécurité d'un environnement auto-hébergé. Ce projet jettera les bases d'outils d'automatisation qui me serviront tout au long de ma carrière, tant pour mes développements personnels que pour l'optimisation des services informatiques en milieu institutionnel.

---

## Références

* **Aide génération et recherche**: [Gemini](https://gemini.google.com/app)
* **Exemples de cours :** [Dépôt GitHub de Nicolas Bourré](https://github.com/nbourre/1sh_notes_cours)
* **Modèles et Moteurs :**
    * [Ollama](https://ollama.com/)
    * [Llama](https://llama.meta.com/)
    * [Gemma](https://ai.google.dev/gemma)
    * [Mistral](https://mistral.ai/)
    * [Llama.cpp](https://github.com/ggerganov/llama.cpp)
* **Infrastructures :**
    * [Docker](https://www.docker.com/)
    * [Incus/LXC](https://linuxcontainers.org/incus/)
* **Vidéos et Documentation :**
    * [Anthropic MCP (Documentation officielle)](https://www.anthropic.com/news/model-context-protocol)
    * [Le guide ultime pour comprendre les MCP (+3 demos) - Shubham SHARMA (YouTube)](https://www.youtube.com/watch?v=9RV5gttT6rA)
    * [Is RAG Still Needed? Choosing the Best Approach for LLMs - IBM Technology (YouTube)](https://www.youtube.com/watch?v=UabBYexBD4k)
    * [On reçoit Arthur Mensch, PDG de Mistral AI - Underscore_ (YouTube)](https://www.youtube.com/watch?v=bzs0wFP_6ck)