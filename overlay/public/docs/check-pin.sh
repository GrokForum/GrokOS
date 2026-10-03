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
want_list=cc26ebde163cd67aafe2ba1e618d9cd0527d6a9ce6c72c00e488e1466648ff5f
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
if [ "$nurl" != 99 ]; then
  echo "FAIL: wget-list has $nurl urls, want 99"
  exit 1
fi
grep -q 'XFCE' "$root/README.md"
if grep -q 'No live DVD yet' "$root/README.md"; then
  echo "FAIL: README still says there is no live DVD"
  exit 1
fi
out=$(bash "$root/overlay/public/docs/get-0.29.sh" 2>&1 || true)
echo "$out" | grep -q REFUSE
echo "check-pin PASS"
