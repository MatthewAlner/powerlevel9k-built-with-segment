#!/usr/bin/env bash

POWERLEVEL9K_CUSTOM_BUILT_WITH="built_with"
POWERLEVEL9K_CUSTOM_BUILT_WITH_BACKGROUND="black"
POWERLEVEL9K_CUSTOM_BUILT_WITH_FOREGROUND="white"

built_with() {
    # bail out if there is no package.json
    if [ ! -f "./package.json" ]; then echo "" && exit 0; fi

    # bail out if 'jq' isn't installed
    if ! (hash jq &> /dev/null) ; then echo "install jq" && exit 0; fi

    # merge together dependencies and devDependencies from package.json
    ALL_DEPS=$(jq < package.json '[.dependencies,.devDependencies] | .[0] + .[1]')
    OUTPUT=""

    for row in $(jq < built-with-config.json -r '.[] | @base64'); do
        _jq() {
            echo "${row}" | base64 --decode | jq -r "${1}"
        }

        built_with_check_package_json "$(_jq '.name')" "$(_jq '.icon')"
    done

    echo "$OUTPUT"
}

built_with_check_package_json() {
    local keyToCheck=${1}
    local icon=${2}
    if [ "$(echo "$ALL_DEPS" | jq --arg KE "$keyToCheck" 'has($KE)')" = 'true' ]; then OUTPUT="$OUTPUT $icon"; fi
}