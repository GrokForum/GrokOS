# Build

Linux From Scratch is the **method**. This repository does not vendor the LFS book.

Public release is **git profiles** (RFC-0.12), not a hosted DVD farm (RFC-0.18). No ISO, no VDI, no LFS tarball dump in git.

## Doors (RFC-0.28 / 0.29)

| Door | What you do |
|------|-------------|
| **Clone** | `git clone https://github.com/GrokForum/GrokOS` then open Grok in that tree |
| **URL** | Paste that GitHub URL to Grok. Grok clones. Same pin |
| **curl** | `GROKOS_GET=1 bash overlay/public/docs/get-0.29.sh` when `src/lfs/wget-list` is in the tree. Pin download only. Not a bake |

## Two questions (silence = default)

1. **What** — `hardened` (default) · `workstation` · `specialist` (REFUSE until a map RFC)
2. **How** — `vm` (default) · `tin` (preserve-environment; not Stage 8)

Silence = hardened + VM. Hardware is probed at bake, not a sitting interview.

## Pin (your host downloads)

- Book: Linux From Scratch **r13.0-197-systemd**
- Pin file: `src/lfs/PIN.md`
- URLs: `src/lfs/wget-list`
- Do not float versions. wget on **your** machine, like this lab's `$LFS/sources`.
- Overlay tweak: fork `overlay/`, not the workshop tree or vault trees.
- Public denylist: jax, videogen, movie-factory, trevor, keys, PROFILE, `grok_skills` (`scripts/denylist-gate.sh`).

## Identity (RFC-0.25 / 0.48)

Password is `openssl passwd -6` on the **build tty**, baked into the image. Optional: `GROKOS_LIVE_HASH`. Not a third product question. **Not every live boot.**

Live ISO boots getty as baked `grokos`. Root stays locked (`!`). First-boot username prompt is parked for **tin** (disk stamp), not RAM overlay.

## Proved live path

The lab live DVD opens tty1 straight into XFCE. There is no password prompt and no first-boot username interview. Hyprland is not that session. This repository does not carry the disc.

## What this repo will not do

- Host an ISO on GitHub or grokforum.site
- Git-add `*.iso` / `*.vdi`
- Public image over **4.7 GiB** (DVD-5)
- A remaster of an already-built squash as the from-scratch public path. From-pin chroot is Grok plus the inner scripts (RFC-0.29). A full LFS bake is hours and **your** host sudo, not a copy of the lab disc.

A remaster, if you already have a live squash, stays under 4.7 GiB. Never write the host `/boot`.

A clone user does not sit meson hops. Grok runs the already-patched chroot scripts. First boot is meant to be usable (~60s philosophy); remaining work finishes in the background.

That background work is `scripts/grokos-bootstrap-0.29.service` (`Type=idle`, after `multi-user.target`). An empty queue exits. It is not in the 0.48 ISO.

Grok-at-boot is `scripts/grokos-at-boot-0.29.service` (`Type=simple`, after `local-fs.target`, no `Before=` line). It records the public skill set and does not start a model. It is not in the 0.48 ISO.

## Compile rules (so you never paste the error)

| If meson/configure says | Grok does |
|-------------------------|-----------|
| optional feature, wrap-mode nofallback | disable flag |
| `dependency()` with no option | extra tarball beside the frozen 129 |
| rst2man / xmltoman / itstool | skip man/docs (`docs=false` is often gi-docgen only) |
| wrap already in the tarball | `--force-fallback-for=` |
| version pin | keep the pin; add the matching extra |
| `$LFS/sources` 755 root after chroot | G-NET stages beside `$LFS`; G-ROOT copies then wget-fill as root. FAIL url with Permission denied is this, not a dead host |
| meson `Unknown option` | drop the flag; read `meson_options.txt` in the tarball |
| CMake `FetchContent` git (tests) | disable developer/test flag. Do not extra the test git |
| CMake `find_package` / `pkg_check_modules` required (not tests) | extra tarball beside the frozen 129 |
| CMake wants a sibling checkout (`external/spirv-headers`) | pass `SOURCE_DIR` at the install prefix. Do not git submodule |
| CMake `OpenGL::OpenGL` on Mesa without libglvnd | link `OpenGL::GLES3` when sources are EGL+GLES3 |
| Qt `qtopcua` vs OpenSSL 3+/4 opaque `ASN1_TIME` | `-skip qtopcua`. Do not rebuild OpenSSL |
| CMake `find_package(VulkanHeaders REQUIRED)` | extra Vulkan-Headers. SPIRV-Headers is not Vulkan-Headers |
| Quickshell `pkg_check_modules(… REQUIRED jemalloc)` | extra jemalloc 5.3.0. Keep ON so QML does not look like a leak |
| jemalloc 5.3.0 `std::__throw_bad_alloc` on GCC 16 | `--disable-cxx` |
| Quickshell `dbusmenu_autogen_timestamp_deps` Error 2 | `-G Ninja` |
| Quickshell default-ON services without extras | disable: `SERVICE_GREETD` `I3` `NETWORK` `BLUETOOTH` |

Packages are the pin (`src/lfs/wget-list`) or a later named git commit. There is no user-repository install path, and no install script that asks for `sudo` as a feature.

## Test bound

VM testing. Tin is a later named RFC. Field stick is parked.
