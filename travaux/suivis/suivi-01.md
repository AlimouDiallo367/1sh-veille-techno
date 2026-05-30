# Suivi 01 - Documentation des sources et liens de référence

**Cours :** Veille technologique (420-1SH-SW)
**Projet :** AiBarr - Déploiement d'une infrastructure d'IA locale.
**Date du suivi :**  28 mai 2026
**Effectué par :** Thierno Alimou Diallo

---

## 1. Contexte
Dans le cadre de la première phase de recherche, ce document recense l'ensemble des ressources techniques, documentations officielles et études de cas utilisées pour  valider la faisabilité du projet. 

L'objectif de ce suivi est de démontrer le travail de recherche ainsi que la profondeur de la veille technologique effectuée dans le cadre du projet. Quatre objectifs ciblés sont prévus:
1. **Avoir un Proof of Concept (PoC) rapidement** (Moteur + Interface web).
2. **Automatiser l'infrastructure de base** via Bash et Docker Compose pour monter l'environnement instantanément sur n'importe quel poste.
3. **Garantir la confidentialité absolue** en circuit 100% fermé (No-Cloud/Local-First). 
4. **Se démarquer** en optimisant mon flux de dev avec une intégration directe Neovim ou via OpenClaw.

---

## 2. Documentations officielles

### Moteurs et Infrastructures
* **Ollama (Moteur) :** https://github.com/ollama/ollama
* **Llama.cpp (Backend & Quantification GGUF) :** https://github.com/ggerganov/llama.cpp
* **Docker & Docker Compose (Conteneurisation) :** https://docs.docker.com/compose/
* **Incus / LXC Containers (Alternative d'isolation) :** https://linuxcontainers.org/incus/

### Interfaces et/ou Intégration Workflow
* **Open WebUI (Interface PoC) :** https://docs.openwebui.com/
* **OpenClaw (Orchestration d'agents) :** https://openclaw.ai/
* **Neovim (Environnement de dev personnel) :** https://github.com/AlimouDiallo367/AlimouNvim

### Modèles de langages
* **Meta Llama 3 :** https://www.llama.com/models/llama-3/
* **Google Gemma 4 :** https://deepmind.google/models/gemma/gemma-4/
* **Mistral AI :** https://docs.mistral.ai/models/
* **DeepSeek-Coder-V2 :** https://github.com/deepseek-ai/DeepSeek-Coder-V2

---

## 3. Concepts (Médiagraphie IEEE)
[1] Anthropic, « Model Context Protocol », Anthropic News, 2024. [En ligne]. Disponible sur : https://www.anthropic.com/news/model-context-protocol. (Utilisé pour l'étude du standard ouvert d'interopérabilité des agents locaux).

[2] S. Sharma, « Le guide ultime pour comprendre les MCP (+3 demos) », YouTube, 2024. [En ligne]. Disponible sur : https://www.youtube.com/watch?v=9RV5gttT6rA. (Analysé pour les cas pratiques d'intégration et d'automatisation système).

[3] IBM Technology, « Is RAG Still Needed? Choosing the Best Approach for LLMs », YouTube, 2024. [En ligne]. Disponible sur : https://www.youtube.com/watch?v=UabBYexBD4k. (Consulté pour la validation des architectures RAG face au fine-tuning sur le traitement de documents privés).

[4] Underscore_, « On reçoit Arthur Mensch, PDG de Mistral AI », YouTube, 2024. [En ligne]. Disponible sur : https://www.youtube.com/watch?v=bzs0wFP_6ck. (Étudié pour la veille stratégique sur l'optimisation des petits modèles ouverts).

---

## 4. Alternatives étudiées (Médiagraphie IEEE)
[5] vLLM Team, « vLLM: A high-throughput and memory-efficient LLM serving engine », GitHub. [En ligne]. Disponible sur : https://github.com/vllm-project/vllm. (Écarté : architecture trop lourde, optimisée pour la production scale-up).

[6] LocalAI Project, « LocalAI: The free, Open Source OpenAI alternative », LocalAI. [En ligne]. Disponible sur : https://localai.io/. (Écarté : alternative délaissée au profit d'Ollama pour la simplicité de gestion via Modelfiles).

[7] Wikipédia, « Fine-tuning (deep learning) », Wikipedia, The Free Encyclopedia. [En ligne]. Disponible sur : https://en.wikipedia.org/wiki/Fine-tuning_(deep_learning). (Écarté : processus figé et matériellement inaccessible avec les 8 Go de VRAM de ma RTX 4060).

[8] T. Dero, « ExLlamaV2: An optimized inference engine for LLaMA models », GitHub. [En ligne]. Disponible sur : https://github.com/turboderp/exllamav2. (Écarté : requiert des configurations de dépendances trop strictes sous Linux par rapport à l'agilité d'Ollama).

[9] Oobabooga, « Text-Generation-WebUI », GitHub. [En ligne]. Disponible sur : https://github.com/oobabooga/text-generation-webui. (Écarté : interface basée sur Gradio, jugée trop lourde, complexe à automatiser proprement via Docker).

[10] LibreChat Team, « LibreChat: Every AI Model in One App », LibreChat. [En ligne]. Disponible sur : https://www.librechat.ai/. (Écarté : excellente interface utilisateur mais configuration multi-services trop lourde pour un PoC agile).

[11] Google, « Large Language Model Gemini », Outil d'aide à la réflexion et à la structuration de contenu, 2026. (Utilisé pour la mise en forme et l'organisation du plan provisoire et de la médiagraphie IEEE ainsi que pour l'assistance à l'automatisation de mon déploiement).

[12] MyBib, « IEEE Citation Generator », MyBib Tools. [En ligne]. Disponible sur : https://www.mybib.com/tools/ieee-citation-generator. (Utilisé pour le formatage automatique des références bibliographiques à la norme standard).
