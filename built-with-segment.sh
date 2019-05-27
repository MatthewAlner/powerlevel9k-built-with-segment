#!/usr/bin/env bash

POWERLEVEL9K_CUSTOM_BUILT_WITH="built_with"
POWERLEVEL9K_CUSTOM_BUILT_WITH_BACKGROUND="black"
POWERLEVEL9K_CUSTOM_BUILT_WITH_FOREGROUND="white"

built_with() {
    # bail out if there is no package.json
    if [ ! -f "./package.json" ]; then echo "" && exit 0; fi

    # bail out if there is no package.json
    if ! (hash jq &> /dev/null) ; then echo "install jq" && exit 0; fi

    # merge together dependencies and devDependencies from package.json
    ALL_DEPS=$(jq < package.json '[.dependencies,.devDependencies] | .[0] + .[1]')
    OUTPUT=""
    # echo "$opt" | tr -d '"'
    if [ "$(echo "$ALL_DEPS" | jq 'has("@angular/core")')" = 'true' ]; then OUTPUT="$OUTPUT \ufbb0"; fi
    if [ "$(echo "$ALL_DEPS" | jq 'has("typescript")')" = 'true' ]; then OUTPUT="$OUTPUT \ue628"; fi
    if [ "$(echo "$ALL_DEPS" | jq 'has("grunt")')" = 'true' ]; then OUTPUT="$OUTPUT \ue611"; fi
    if [ "$(echo "$ALL_DEPS" | jq 'has("gulp")')" = 'true' ]; then OUTPUT="$OUTPUT \ue610"; fi
    if [ "$(echo "$ALL_DEPS" | jq 'has("react")')" = 'true' ]; then OUTPUT="$OUTPUT \ue625"; fi
    if [ "$(echo "$ALL_DEPS" | jq 'has("vue")')" = 'true' ]; then OUTPUT="$OUTPUT \ufd42"; fi
    if [ "$(echo "$ALL_DEPS" | jq 'has("webpack")')" = 'true' ]; then OUTPUT="$OUTPUT \ufc29"; fi
    echo "$OUTPUT"
}