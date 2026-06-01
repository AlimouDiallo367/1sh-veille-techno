# AiBarr - Rapport de recherche 

**Cours** : Veille technologique (420-1SH-SW) 
**Date de remise** : 22 avril 2026  
**Préparé par** : Thierno Alimou Diallo  
**Présenté à** : Nicolas Bourre 

--- 
## 1. Introduction 
Dans une ère où l'intelligence artificielle (IA) est de plus en plus présente dans le quotidien des développeurs et des administrateurs système, la quasi-totalité des outils populaires repose sur un modèle unique : le cloud. Pour coder ou automatiser des tâches, l'approche dominante exige d'envoyer constamment des données et du code source sur des serveurs externes. Au-delà de la dépendance à des abonnements payants, cette centralisation pose un réel problème de souveraineté numérique. À l'échelle internationale, la prise de conscience est globale : des réglementations strictes comme le *Règlement général sur la protection des données* (RGPD) en Europe, les directives sur la cybersécurité aux États-Unis, telles que le cadre de cybersécurité du *National Institute of Standards and Technology* (NIST), ou encore la *Loi 25* ici, au Québec, forcent une réévaluation rigoureuse de la gestion des données. Dans ce contexte, externaliser des informations sensibles chez un tiers devient un risque de sécurité majeur que de nombreuses organisations ne peuvent plus tolérer.

C’est dans ce contexte que s'inscrit le projet **AiBarr**. L’objectif ici n’est pas de concevoir un nouveau modèle d'intelligence artificielle, mais plutôt de déployer une infrastructure d'IA locale, performante et entièrement déconnectée. En assemblant des technologies open-source existantes, AiBarr permet d'exécuter l'inférence directement sur la machine de l'utilisateur, garantissant ainsi une confidentialité totale et une indépendance absolue vis-à-vis des services tiers.

Ce rapport présente l’architecture de cette solution, la vulgarisation des outils qui la rendent possible, comme Ollama et le mécanisme de *Retrieval-Augmented Generation* (RAG), et la façon dont cette infrastructure s'intègre de manière minimaliste dans un environnement de développement moderne.

## 2. Explication du projet 
Vue d'ensemble du projet *(Le "Quoi" et le "Pourquoi")*
### 2.1 Objectifs et philosphie du projet 
- [ ] À rédiger : Expliquer le concept du Local-first et de l'infrastructure déconnectée.
- [ ] À rédiger : Présenter le but d'AiBarr : offrir la même réactivité qu'un outil cloud, mais de manière souveraine, sur du matériel standard et sans fuite de données. dans explication des fonctionnalités]

### 2.2 Architecture 
- [ ] À rédiger : Décrire l'approche par micro-services conteneurisés avec Docker.
- [ ] À rédiger : Schématiser ou expliquer le flux de données général entre les trois grands piliers : le moteur d'inférence, l'interface utilisateur sécurisée par un proxy inversé (Nginx) et le moteur de contexte.

---

## 3. Explication des fonctionnalités 
Technique *(Le "Comment")*
### 3.1 Le moteur de langage : LLM et Ollama 
- [ ] À rédiger : Définir ce qu'est un LLM (Large Language Model) et justifier l'importance des modèles open-source (auditabilité, contrôle des poids). Mentionner le choix de Llama 3 et DeepSeek-Coder.
- [ ] À rédiger : Expliquer la signification des paramètres (7B / 8B) et pourquoi ils représentent le compromis idéal (sweet spot) pour la mémoire vive (RAM/VRAM) d'une machine locale.
- [ ] À rédiger : Présenter Ollama comme le moteur d'exécution en Go qui gère les modèles et expose l'API locale.

### 3.2 L'injection de contexte : Le RAG 
- [ ] À rédiger : Vulgariser le concept de RAG (Retrieval-Augmented Generation) pour éliminer les hallucinations en fournissant une documentation de référence locale.
- [ ] À rédiger : Définir brièvement les notions clés :
    - Embeddings : Traduction sémantique du texte en coordonnées mathématiques.
    - Vector DB (Chroma DB) : Stockage et recherche instantanée par similarité.
    - Context Window & System Prompt : La mémoire à court terme allouée et les directives de comportement données à l'IA.

### 3.3 Mon écosystème de travail : NeoVim et MCP GLPI 
- [ ] À rédiger : Présenter NeoVim comme l'éditeur minimaliste et performant (configurable en Lua) pour intégrer l'IA directement dans le terminal de travail.
- [ ] À rédiger : Expliquer le protocole MCP (Model Context Protocol) et comment il permet de lier l'IA locale à des outils externes de gestion d'infrastructure comme GLPI pour aider le technicien en direct.

## 4. Conclusion 
- [ ] À rédiger : Synthèse 

## 5. Référence / Médiagraphie
- [RGPD](https://fr.wikipedia.org/wiki/R%C3%A8glement_g%C3%A9n%C3%A9ral_sur_la_protection_des_donn%C3%A9es)
- [Loi 25 - Québec](https://www.quebec.ca/nouvelles/actualites/details/loi-25-nouvelles-dispositions-protegeant-la-vie-privee-des-quebecois-certaines-dispositions-entrent-en-vigueur-aujourdhui-43212)
- [Loi 25 - Legis Québec](https://www.legisquebec.gouv.qc.ca/fr/document/lc/P-39.1)
- [NIST](https://www.nist.gov/)
- [Autre liens à ajouter ici]()

> 2 à 3 Pages Max excluant les pages structurelles!!! Support visuel à ajouter

