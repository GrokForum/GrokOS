# Forks — private vs public

One source-built core. Two overlays from Stage 4. Develop in parallel.

| | Private image | Public image |
|--|----------------|--------------|
| First-boot agent | house direction + execution | cassian empty vessel only |
| Skills | house master tree | cassian + already-public farwaters (`it-project`, `stickynotes`) + `ADD-BEFORE-MVP.md` |
| Not a source | — | private skill dumps |
| Secrets | empty slots on the ISO | empty |
| ISO | daily driver | **trim**: modest hardware, no bloat |
| Hardware | follows the build host | live/install 2–4 GB RAM, 2 CPU. No hypervisor-in-guest |
| Personal trees | migrate skills; remount data partitions | refuse vault and workshop trees |

Packer input: this file + `ADD-BEFORE-MVP.md`. Fail the public image if a house-only skill tree or a key store is present.
