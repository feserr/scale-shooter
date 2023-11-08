#!/usr/bin/env bash
set -e

linter="gdlint"
base_commit=$1

changed_files=$(git diff --name-only --diff-filter=ACMRTUX "${base_commit}" | grep -E "\.gd$" | grep -v "deps\/" | tr '\n' ' ')

if [ -z "${changed_files}" ]; then
    echo "No changes to lint with ${linter}"
    exit 0
fi

echo "Checking the format with '${linter}' for: ${changed_files}"

return_code=0
for changed_file in ${changed_files}; do
    patch_file="${changed_file}.patch"
    ${linter} "${changed_file}" >> "${patch_file}"
    if [ -s "$?" ]; then
        echo "${linter} for ${changed_file}: FAILED"
        cat ${patch_file}
        return_code=1
    fi
    rm -rf "${patch_file}"
done

exit ${return_code}
