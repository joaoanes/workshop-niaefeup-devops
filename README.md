# 4-Hour DevOps Workshop

A condensed, hands-on DevOps intro. Students provision an EC2 with Terraform,
install a Minecraft server (with Dynmap) via `null_resource`, then point a
custom domain at it via DNS.

Derived from the 2-day `devops-workshop` deck — content reused liberally.

## Structure

```
devops-4h-workshop/
├── slides/                  # Slidev deck (npm run dev)
│   ├── slides.md            # Entry point, imports sections in order
│   └── sections/            # One file per section (see below)
└── support/
    ├── tf/
    │   ├── iam-gen/         # Generates 20 student IAM users (EC2-locked)
    │   ├── minecraft/       # Reference impl + TODOs
    │   └── checkpoints/     # Working states at each major step (stage-1...stage-4)
    └── scripts/
        └── teardown.sh      # End-of-workshop cleanup (destroy everything)
```

## Sections

0. **Prerequisites** — terminal + Terraform install per OS (macOS / Linux / WSL / Windows)
1. **What is DevOps?**
2. **Live exercise: "You type google.com, then what?"**
3. **Hosting & AWS access** — hand out keys
4. **Demo: EC2 by clicking the AWS console**
5. **Terraform** — `init`/`plan`/`apply`/`destroy`, first EC2
6. **Minecraft + Dynmap via `null_resource`** — provisioners, replace cascades
7. **DNS** — Namecheap A record live demo, connect via URL
8. **Wrap + teardown**

## Running the deck

```bash
cd slides
npm install
npm run dev
```
