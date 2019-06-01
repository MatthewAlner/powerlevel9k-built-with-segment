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
    ROW_OUTPUT=""

    for row in $(jq < "$HOME"/built-with-config.json -r '.[] | @base64'); do
        _jq() {
            echo "${row}" | base64 --decode | jq -r "${1}"
        }

        if [ "$(echo "${row}" | base64 --decode | jq 'has("keyExists")')" = 'true' ]; then 
            built_with_check_package_json_key_exists "$(_jq '.keyExists')" "$(_jq '.icon')" "$(_jq '.showIcon')" "$(_jq '.showVersion')"
        fi
        if [ "$(echo "${row}" | base64 --decode | jq 'has("fileExists")')" = 'true' ]; then 
            built_with_check_file_exists "$(_jq '.fileExists')" "$(_jq '.icon')" "$(_jq '.showIcon')" "$(_jq '.showVersion')"
        fi
        if [ "$(echo "${row}" | base64 --decode | jq 'has("keyAbsent")')" = 'true' ]; then 
            built_with_check_package_json_key_absent "$(_jq '.keyAbsent')"
        fi

        OUTPUT="$OUTPUT$ROW_OUTPUT"
        ROW_OUTPUT=""
    done

    echo "$OUTPUT"
}

built_with_check_package_json_key_exists() {
    local keyToCheck=${1}
    local icon=${2}
    local showIcon=${3}
    local showVersion=${4}

    if [ "$(echo "$ALL_DEPS" | jq --arg KEY "$keyToCheck" 'has($KEY)')" = 'true' ]; then
        local versionNumber
        versionNumber="$(echo "$ALL_DEPS" | jq --arg KEY "$keyToCheck" '.[$KEY'] | tr -d '"')"
        if [ "$showIcon" = 'true' ]; then ROW_OUTPUT="$ROW_OUTPUT $icon"; fi
        if [ "$showVersion" = 'true' ]; then ROW_OUTPUT="$ROW_OUTPUT $versionNumber"; fi
    fi
}

built_with_check_file_exists() {
    local fileToCheck=${1}
    local icon=${2}
    local showIcon=${3}
    local showVersion=${4}

    if [ -f "$fileToCheck" ]; then
        if [ "$showIcon" = 'true' ]; then ROW_OUTPUT="$ROW_OUTPUT $icon"; fi
    fi
}

built_with_check_package_json_key_absent() {
    local keyToCheck=${1}

    if [ "$(echo "$ALL_DEPS" | jq --arg KEY "$keyToCheck" 'has($KEY)')" = 'true' ]; then
        ROW_OUTPUT="";
    fi
}