# Get GrokOS

Two doors now, a third later. Then two questions. Grok builds a local image from the pin in this repo. There is no ISO file on GitHub. Nobody logs into a half-built guest to type commands. First boot should be usable while the rest finishes in the background.

## Door

**Clone**

```
git clone https://github.com/GrokForum/GrokOS
cd GrokOS
git checkout rfc-0.54-live-desktop
```

Open Grok in that directory.

**Or give Grok the URL**

Paste `https://github.com/GrokForum/GrokOS` into Grok (Grok Build or grokbuild.site). Grok clones the same tree and checks out `rfc-0.54-live-desktop`.

**Or curl**

From a checkout of `rfc-0.54-live-desktop`. That branch carries `src/lfs/wget-list`. A raw URL of this script, without the checkout, cannot see the pin.

```
GROKOS_GET=1 bash overlay/public/docs/get-0.29.sh
```

Silence = hardened + vm. Set `GROKOS_OFFERING` or `GROKOS_HOW` only when you want the other door. `specialist` refuses. The script downloads the frozen LFS pin into `$HOME/grokos-sources`. It does not compile, bake, partition, or start a VM. Background bootstrap and Grok-at-boot stay later.

`main` still holds the licence seed only. The pin is on `rfc-0.54-live-desktop`. Use that branch until a named release lands on `main`. Pull is voetstoots: as-is, no warranty. Nothing is offered as a public boot image yet. DVD, thumb, or a curl from a running OS are later media for the same two intents (VM or tin). GitHub does not host the ISO file.

## Two questions

Silence keeps the default.

1. **What do you want?**
   - **hardened** (default) — secure daily OS. sshd off. Packages from the pin only.
   - **workstation** — same core plus documents, spreadsheets, and mail.
   - **specialist** — same core plus one extra role (named later). Not available to bake until that role has its own RFC.
2. **How do you run it?**
   - **VM** (default) — Grok bakes a VirtualBox disk on this machine. Try it without touching your existing OS.
   - **tin** — install onto your computer. Default is keep the old system and remount your data. Grok will not format a disk that already has a filesystem unless you name that device and confirm twice.

Grok then pulls the pinned package list and bakes locally. A later live DVD, if one is published, must fit a single-layer disc (4.7 GiB, DVD-5) and follow try-then-install. This site and GitHub do not host the ISO file.

Password is set on the build keyboard at bake time. It is not stored in git.

## Profiles (skip is fine)

| Profile | Meaning |
|---------|---------|
| vanilla | LFS-first core + public cassian trim. Offline default. |
| grokforum | vanilla + grokforum.site opt-in. Skip stays offline. |
| (c) | Reserved. Do not invent a third profile here. |

READMEs: `overlay/public/profiles/vanilla/` and `overlay/public/profiles/grokforum/`.

Customise the overlay after clone. grokforum.site/GrokOS is the public home. The grokforum skill may propose branch patches and independently review; it does not auto-install. Do not fetch `/client.php`.

Public refuses vault and workshop trees.

## Watch

When grokforum.site is live, Watch and stage are on that host. Do not paste keys there. Apex may 404 until a grokforum PROD GO.
