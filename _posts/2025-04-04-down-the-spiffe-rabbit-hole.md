---
layout: post
authors: [oumaima_zerouali, bjorn_de_craemer]
title: "Down the SPIFFE Rabbit Hole: A KubeCon 2025 Adventure"
image: /img/2025-04-04-down-the-spiffe-rabit-hole.jpg
tags: [SPIFFE, Security]
category: Security
comments: true
---

> "We’re not cavemen! We have technology!" - SpongeBob SquarePants

## Introduction
When our colleague first mentioned SPIFFE, hyping it up as a “revolutionary framework for cloud-native security,” we were instantly intrigued. 
A universal identity layer that promised to solve service identity across clouds, clusters, and compute types? 
*Yes, please.* 
So when KubeCon 2025 landed in London with several SPIFFE-heavy sessions on the agenda, we made it our mission to attend three talks and come back as newly-minted SPIFFE experts.

**Spoiler alert: we came back with more questions than answers.**

This post is a recount of our journey—through conference halls, confusing terminology, and some deep-dive docs and community boards, as we tried to understand what SPIFFE is, what problems it actually solves, and whether it deserves a place in our dev toolbox.

## Setting the Stage: What Did We Know About SPIFFE?
Before KubeCon, our SPIFFE knowledge was pretty shallow. 
We knew it was about securing workloads and issuing cryptographic identities in a vendor-neutral way. 
Our colleague, who had already experimented with it, made it sound like a game-changer.

**And we weren’t alone.** 
KubeCon this year was *packed* with SPIFFE mentions. 
Whether it was in talks on zero-trust, service meshes, or AI agents, the name kept popping up. 
Naturally, we picked three SPIFFE-flavored talks we thought would give us a well-rounded picture.

## The Quest Begins

We assumed attending these three talks would connect the dots:
- What gap does SPIFFE fill?
- How does it work in practice?
- Should we seriously consider using it?

Here’s a breakdown of each talk and what we got from them.

### Talk 1: IAM for AI Agents
> “Identity for Autonomous AI” – [Matthew Bates, Cofide](https://kccnceu2025.sched.com/event/1tx8O/iam-agent-identity-for-autonomous-ai-matthew-bates-cofide?iframe=yes&w=100%&sidebar=yes&bg=no)

The focus was on AI agents—multiple LLMs collaborating autonomously—and how that changes the IAM game. 
These agents resemble microservices in some ways but bring in unique challenges around trust, delegation, and identity across human-machine boundaries.

SPIFFE popped up as a promising foundation, but the talk mostly stayed high-level. Cool concept, but we didn’t walk out with practical SPIFFE insights.

### Talk 2: SPIFFE for WebAssembly
> “Universal Identity for WebAssembly Workloads” – [Cosmonic & Adobe](https://kccnceu2025.sched.com/event/1tx8U/spiffe-in-practice-universal-identity-for-webassembly-workloads-joonas-bergius-cosmonic-colin-murphy-adobe?iframe=yes&w=100%&sidebar=yes&bg=no)

This was hands-down the most “concrete” talk. 
They walked through how wasmCloud adopted SPIFFE, from conceptual design all the way to production.

We saw SPIFFE in action: issuing identities to WebAssembly modules, attesting workloads, and enabling secure service-to-service communication. 
It felt like *this* was the use case SPIFFE was born for—multi-cloud, portable workloads with high security demands.

But even here, the path wasn’t smooth. 
Their SPIFFE journey involved significant custom integrations, and the learning curve was evident.

### Talk 3: Developer-Centric Identity
> “Workload Identity for Humans” – [Vish Abrams, Heroku](https://kccnceu2025.sched.com/event/1txEa/workload-identity-for-humans-a-twelve-factor-approach-vish-abrams-heroku?iframe=yes&w=100%&sidebar=yes&bg=no)

This one hit close to home. 
Instead of focusing on infra, it looked at how SPIFFE could be made more developer-friendly. 
The takeaway: SPIFFE is powerful but often too platform-focused. Developers are left building their own identity solutions on top of SPIFFE primitives.

It introduced a layered approach—think “Twelve-Factor Identity”—designed to abstract away the SPIFFE internals and provide a cleaner DX.

We appreciated the focus, but again, it felt like the developer story around SPIFFE is still maturing.

## The Question That Remains

After three sessions, we still hadn’t answered the core question:  
**Is SPIFFE something we actually want to adopt?**

So we took matters into our own hands.

### The Investigation

Our curiosity led us down a rabbit hole of blog posts, docs, and forums. 
A major kickstarter? 
[Our colleague Nicholas’ excellent walkthrough on going password-less with SPIFFE in a multi-cloud environment](#).

His post walks through a hands-on implementation of SPIFFE in a Kubernetes cluster—from setting up `cert-manager`, deploying SPIFFE, and configuring AWS Roles Anywhere, all the way to securely accessing S3 via short-lived mTLS certificates.

Some key takeaways from his post:
- SPIFFE issues short-lived certificates mounted in pods, which are automatically rotated—no more static secrets.
- By integrating with AWS Roles Anywhere, the setup avoids traditional credentials altogether.
- The whole solution was applied to real infrastructure, showcasing SPIFFE in action in a multi-cloud scenario.

What struck us was how smooth the experience looked *on paper*. It ticked every box: no passwords, no key rotation nightmares, strong cryptographic identity.

But then we asked: **how well does this hold up when teams try to use it at scale, in the wild?**

That’s where our investigation began.

### SPIFFE’s Core Value (Through Our Eyes)

**1. Universal Service Identity:**  
Standardized identities (`spiffe://trust-domain/path`) that work across cloud, on-prem, containers, VMs—you name it. 
No more cloud-specific identity plumbing.

**2. Workload Attestation:**  
Identity is earned, not assumed. SPIFFE issues identities based on trusted attributes like image hashes or environment metadata.

**3. Short-lived Credentials:**  
It auto-rotates certificates (SVIDs), removing the burden and risk of static secrets.

**4. Simplified Auth:**  
Services get identities via agents—no more hardcoded tokens or custom auth logic. It just works.

### Where SPIFFE Shines (vs Alternatives)

| Alternative         | Why SPIFFE Wins                        |
|---------------------|----------------------------------------|
| K8s Service Accounts | Works across *all* platforms           |
| Cloud IAM            | Cloud-agnostic, no lock-in             |
| Vault                | Purpose-built for identity, not secrets|
| Custom mTLS          | Auto cert rotation, built-in attestation|
| OAuth/OIDC           | Peer-to-peer auth, no central server   |
| Service Mesh         | Identity layer works *with or without* a mesh|

### But Here’s the Catch: Implementation Isn’t Trivial

**1. Technical Hurdles:**
- SPIRE servers need to be deployed and reachable
- Agents must be placed on *all* workload hosts
- It requires stable networking and some serious infra hygiene

**2. Organizational Challenges:**
- Teams need to understand PKI and attestation
- Security, DevOps, and app teams must collaborate
- Observability and monitoring of identities is a must

**3. App-level changes:**
- Apps may need updates to trust SPIFFE identities
- Migration can be messy if you’re deep into another auth system

## Conclusion: Does SPIFFE Live Up to the Hype?

**Yes—but only if you’re facing the right problems.**

SPIFFE is *not* a silver bullet. 
It’s a solid foundation for service identity in complex, cloud-native environments. 
If you’ve ever had to scale mTLS across cloud boundaries or build identity from scratch, SPIFFE will feel like a breath of fresh air.

But if you’re running a single Kubernetes cluster with simple service communication? 
The SPIFFE overhead may be more pain than gain.

**SPIFFE isn’t magic.** 
It’s not hype either.
It’s a sophisticated solution to a real and nasty problem. 
If that problem is on your roadmap, SPIFFE might just be the best path forward.

So, the question remains : Is it something we need to adopt or look into?
It is at least a fascinating rabbit hole we will for sure dive into in the near future.
