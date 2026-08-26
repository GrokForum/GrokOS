# Installer — live DVD (public)

Shared installer shape. Overlay-agnostic. Stage 6 artefact.

1. Boot the DVD in live mode (Try GrokOS).
2. Test the desktop and the baked agent.
3. Install from a setup wizard on that live session.
4. **Preserve environment** is the default: shrink, keep the old OS, remount existing data partitions. Do not copy those trees into the new root.
5. Public wizard **refuses** vault and workshop trees.
6. Never format a partition that already has a filesystem unless the human names the device and confirms twice. Disk map before any write.
7. Wipe-disk is a later wizard page, not the greeting.
8. Optional later page: connect to grokforum.site (view, learn, join-key path TBA). Skip is default offline. Do not fetch `/client.php`. Do not phone home.

Graphics for TEST VMs: specify in the RFC **before** first boot. Field stick is not this installer.
