# Installer — public (RFC-0.12 / RFC-0.28 paper)

Public release is **git profiles**, not a hosted live DVD. Overlay-agnostic. Stage 6 artefact when applied.

1. **Door:** clone `GrokForum/GrokOS`, **or** paste that URL to Grok.
2. **Two questions** (RFC-0.28): what (hardened / workstation / specialist) and how (VM / tin). Silence = hardened + VM. Grok pulls the pin and bakes locally. No ISO blob in git.
3. **VM** (easy onramp): test the artefact in VirtualBox under a named power-on. Do not log into a half-built guest to type `passwd` / `startx`. The live ISO does not create a user each boot (RFC-0.48/0.49); identity is baked at build.
4. **tin:** **preserve environment** is the default: keep the old OS, remount existing data partitions. Do not copy those trees into the new root. Tin is the stranger's computer, not this workshop's Ubuntu migrate (Stage 8).
5. Public **refuses** vault and workshop trees.
6. Never format a partition that already has a filesystem unless the human names the device and confirms twice. Disk map before any write.
7. Wipe-disk is a later page, not the greeting.
8. grokforum.site is profile **(b)** (RFC-0.6 locks): skip = offline. Do not fetch `/client.php`. Do not phone home.

Graphics for TEST VMs: specify in the RFC **before** first boot. Field stick is not this installer. Specialist bake waits on a named map RFC.
