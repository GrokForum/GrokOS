#!/usr/bin/env bash
# RFC-0.29 curl door. Frozen LFS pin only. Not a bake. Not a VM.
set -euo pipefail

if [ "${GROKOS_GET:-}" != 1 ]; then
  echo "REFUSE: RFC-0.29 get. This is the pin door, not a bake."
  echo "  GROKOS_GET=1 bash overlay/public/docs/get-0.29.sh"
  echo "Needs src/lfs/wget-list in this tree. Silence = hardened + vm."
  echo "Does not compile, bake, partition, or start a VM."
  exit 1
fi

if [ "$(id -u)" -eq 0 ]; then
  echo "ABORT: do not run as root"
  exit 1
fi

offering=${GROKOS_OFFERING:-hardened}
how=${GROKOS_HOW:-vm}
case "$offering" in
  hardened|security) offering=hardened ;;
  workstation) ;;
  specialist)
    echo "REFUSE: specialist waits a map RFC"
    exit 1
    ;;
  *)
    echo "ABORT: offering must be hardened, workstation, or specialist"
    exit 1
    ;;
esac
case "$how" in
  vm|tin) ;;
  *)
    echo "ABORT: how must be vm or tin"
    exit 1
    ;;
esac

if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
  here=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
  root=$(cd "$here/../../.." && pwd)
else
  root=$(pwd)
fi

list="$root/src/lfs/wget-list"
sums="$root/src/lfs/md5sums"
pin="$root/src/lfs/PIN.md"
for f in "$list" "$sums" "$pin"; do
  if [ ! -s "$f" ]; then
    echo "ABORT: missing $f"
    echo "Do not fetch the live book. The pin is the frozen file in this tree."
    exit 1
  fi
done

want_list=2b54534c9192eeb3bbf45f6971d4a3978fba9f0cb153f5d36749b2a3e0575327
want_sums=a8765c3d7432cbd564f0d099ab4f63a706febe6bd4ac55ede2eaef44097f3f43
got_list=$(sha256sum "$list" | awk '{print $1}')
got_sums=$(sha256sum "$sums" | awk '{print $1}')
if [ "$got_list" != "$want_list" ] || [ "$got_sums" != "$want_sums" ]; then
  echo "ABORT: pin hash mismatch. Do not float the book."
  exit 1
fi
grep -q "$want_list" "$pin"
grep -q "$want_sums" "$pin"
nurl=$(grep -cE '^https?://' "$list")
nkept=$(grep -cE '^src/lfs/kept/' "$list")
if [ "$nurl" != 96 ] || [ "$nkept" != 3 ]; then
  echo "ABORT: wget-list has $nurl urls and $nkept kept files, want 96 and 3"
  exit 1
fi

if [ -z "${GROKOS_SOURCES:-}" ] && [ -z "${HOME:-}" ]; then
  echo "ABORT: HOME unset and GROKOS_SOURCES unset"
  exit 1
fi
dest=${GROKOS_SOURCES:-"$HOME/grokos-sources"}
dest_real=$(realpath -m "$dest")
root_real=$(realpath -m "$root")
case "$dest_real" in
  /|/boot|/boot/*|/etc|/etc/*|/usr|/usr/*|/vbox|/vbox/*|"$root_real"|"$root_real"/*)
    echo "ABORT: refuse dest $dest_real"
    exit 1
    ;;
esac

mkdir -p "$dest"
printf '%s\n' "{\"rfc\":\"0.29\",\"offering\":\"$offering\",\"how\":\"$how\",\"pin\":\"r13.0-197-systemd\"}" >"$dest/choices.json"
if [ "$how" = tin ]; then
  echo "tin: pin only. Disk write stays a later RFC."
fi
echo "RFC-0.29 get. wget -c into $dest_real. Will not compile. Will not bake. Will not start a VM."
urls=$(mktemp)
trap 'rm -f "$urls"' EXIT
while IFS= read -r line || [ -n "$line" ]; do
  case "$line" in
    https://*|http://*)
      printf '%s\n' "$line" >> "$urls"
      ;;
    src/lfs/kept/*)
      cp -a "$root/$line" "$dest_real/$(basename "$line")"
      ;;
  esac
done < "$list"
wget --continue --tries=5 --timeout=60 --directory-prefix="$dest_real" -i "$urls"
echo "=== md5 ==="
(cd "$dest_real" && md5sum -c "$sums")
echo "RFC-0.29 get done. Bake is a later named GO."
