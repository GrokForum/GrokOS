#!/usr/bin/env bash
# Public pin check. Does not wget, compile, bake, or start a VM.
set -euo pipefail
here=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
root=$(cd "$here/../../.." && pwd)
list="$root/src/lfs/wget-list"
sums="$root/src/lfs/md5sums"
pin="$root/src/lfs/PIN.md"
for f in "$list" "$sums" "$pin" "$root/README.md" "$root/overlay/public/docs/get-0.29.sh"; do
  test -s "$f"
done
want_list=2b54534c9192eeb3bbf45f6971d4a3978fba9f0cb153f5d36749b2a3e0575327
want_sums=a8765c3d7432cbd564f0d099ab4f63a706febe6bd4ac55ede2eaef44097f3f43
got_list=$(sha256sum "$list" | awk '{print $1}')
got_sums=$(sha256sum "$sums" | awk '{print $1}')
if [ "$got_list" != "$want_list" ] || [ "$got_sums" != "$want_sums" ]; then
  echo "FAIL: pin hash mismatch"
  exit 1
fi
grep -q "$want_list" "$pin"
grep -q "$want_sums" "$pin"
if grep -q '/vbox\|/files/' "$pin" "$root/README.md"; then
  echo "FAIL: public pin or README names a workshop path"
  exit 1
fi
nurl=$(grep -cE '^https?://' "$list")
nkept=$(grep -cE '^src/lfs/kept/' "$list")
if [ "$nurl" != 96 ] || [ "$nkept" != 3 ]; then
  echo "FAIL: wget-list has $nurl urls and $nkept kept files, want 96 and 3"
  exit 1
fi
for p in src/lfs/kept/coreutils-9.11-i18n-1.patch src/lfs/kept/glibc-2.44-upstream_fixes-1.patch src/lfs/kept/Python-3.14.7-openssl_4-1.patch; do
  test -s "$root/$p"
done
grep -q 'XFCE' "$root/README.md"
if grep -q 'No live DVD yet' "$root/README.md"; then
  echo "FAIL: README still says there is no live DVD"
  exit 1
fi
out=$(bash "$root/overlay/public/docs/get-0.29.sh" 2>&1 || true)
echo "$out" | grep -q REFUSE
echo "check-pin PASS"
