# Gates

Grok builds. The owner signs. A plan is not a host write. Silence is not yes.

## Host writes that need a spoken yes

| Gate | What it covers |
|------|----------------|
| Lab create | Create the lab VM. Do not power it on. |
| Host packages | Four compile deps on the build host. Do not change `/bin/sh`. |
| Toolchain | Unprivileged builder user + book chapters 5–6. |
| Chroot | Bind mounts + book chapters 7–8. |
| Config + kernel | Book chapters 9–10 files on the workshop tree. `grub-install` stays the disk-image quote. |
| Disk image | Format and install onto the lab disk. |
| Power-on | Start the lab VM. Later RFC even after a bootable disk exists. |
| Public live DVD | One image ≤ **4.7 GiB** (DVD-5; RFC-0.18/0.37). Try then install. Git stays the source. Grok bakes locally (RFC-0.25). Do not host the blob. |
| Choices | Two questions (hardened / workstation / specialist, VM / tin). Silence = hardened + VM. Password on the build tty, not in git. |
| Bake image | Compose VDI (VM) or later tin installer from the pin + choices. Not a guest shell. Later named GO. |
| Public `main` | Human merge. Agents do not push `main`. |

Each later quote is a new yes. A yes for host packages is not a yes for chroot.

## Package trust

The pin, or a named public git at a pinned commit. Not a user repository of unreviewed install scripts. Not an overlay VPN that joins itself. Not an extra `sshd` the owner did not ask for.

## Public git

Write identity is GitHub collaborator `farwaters` on a **branch**. No personal access token in this tree. Workshop mailboxes do not belong in these pages.

## Oversight

The owner keeps a printable workshop cockpit. That PDF is not this URL. This page is the public rule: spoken yes, then the named write, then stop.

Independent review (RFC-0.24): a Grok that writes a patch is not the Grok that signs it. cassian, it-project, or the grokforum skill may review. Humans still sign host writes. No `main` from an agent.
