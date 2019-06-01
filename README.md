# powerlevel9k-built-with-segment
A "built with" segment for powerlevel9k, showing framework/language/library/build-tool icons.

## Installation

this [powerlevel9k](https://github.com/bhilburn/powerlevel9k) segment is written in `bash` but does have a dependency having [jq](https://stedolan.github.io/jq/download/) installed

just copy and paste the contents of `built-with-segment.sh` into your `.zshrc` or copy it to `$HOME` and source it from `.zshrc`

```bash
source ~/.built-with-segment.sh
ZSH_THEME="powerlevel9k/powerlevel9k"
```

you will also need to place `built-with-config.json` in your `$HOME` dir

## Defining a new type of framework/language/library/build-tool

What defines a project can be set in the `built-with-config.json`.

There are 7 keys that you can provide.

* `name` = the name of the framework/language/library/build-tool
  * (not used in the code but included for the user)
* `icon` = the [nerdfont](https://nerdfonts.com/) icon to use
* `type` = framework | language | library | build-tool
* `keyExists` = check for the existence of this key in `package.json`
* `keyAbsent` = check this key doesn't appear in `package.json`
* `fileExists` = check for the existence of this file in the current folder
* `showIcon` = if found should the icon be shown
* `showVersion` = if found should the version number be shown
  * (this only works if a `keyExists` is also provided)

The three checks `keyExists`, `keyAbsent`, `fileExists` *if included* must all be true for the item to be found, see below for examples.

## Examples

### Angular cli app

![alt text][anuglar]

Snippet of how the config would look in `built-with-config.json` ⬇️

```json
[
  {
    "name": "typescript",
    "type": "language",
    "showIcon": true,
    "showVersion": false,
    "icon": "\ue628",
    "keyExists": "typescript"
  },
  {
    "name": "javascript",
    "type": "language",
    "showIcon": true,
    "showVersion": false,
    "icon": "\ue781",
    "fileExists": "package.json",
    "keyAbsent": "typescript"
  },
  {
    "name": "angular",
    "type": "framework",
    "showIcon": true,
    "showVersion": true,
    "icon": "\ufbb0",
    "keyExists": "@angular/core"
  }
]
```

### A very 2014 frontend

![alt text][2014-frontend]

Snippet of how the config would look in `built-with-config.json` ⬇️

```json
[
  {
    "name": "javascript",
    "type": "language",
    "showIcon": true,
    "showVersion": false,
    "icon": "\ue781",
    "fileExists": "package.json",
    "keyAbsent": "typescript"
  },
  {
    "name": "grunt",
    "type": "build_tool",
    "showIcon": true,
    "showVersion": false,
    "icon": "\ue611",
    "keyExists": "grunt"
  },
  {
    "name": "bower",
    "type": "build_tool",
    "showIcon": true,
    "showVersion": false,
    "icon": "\ue61a",
    "keyExists": "bower"
  }
]
```

### React app

![alt text][react]

Snippet of how the config would look in `built-with-config.json` ⬇️

```json
[
  {
    "name": "javascript",
    "type": "language",
    "showIcon": true,
    "showVersion": false,
    "icon": "\ue781",
    "fileExists": "package.json",
    "keyAbsent": "typescript"
  },
  {
    "name": "react",
    "type": "framework",
    "showIcon": true,
    "showVersion": false,
    "icon": "\ue625",
    "keyExists": "react"
  }
]
```

### Just a folder

If nothing is found the segment is omitted.

![alt text][folder]

### iTerm2

I had a few issues when using [powerlevel9k](https://github.com/bhilburn/powerlevel9k) with iTerm2, I thought i'd document the solutions here in case it helps.

#### Icons aren't displaying and i've set a nerdfont patched font

* Answer: Set it as both the `font` and `Non-ASCII Font` in Preferences > Profiles > Text

#### The bar and bar cap are different colours

* Answer: check `keep background colours opaque` in Preferences > Profiles > Window


[anuglar]: https://res.cloudinary.com/automattech/image/upload/v1559387150/powerlevel9k-built-with-segment/angular.png "Terminal showing angular cli"
[2014-frontend]: https://res.cloudinary.com/automattech/image/upload/q_auto:best/v1559387150/powerlevel9k-built-with-segment/2014-frontend.png "Terminal showing 2014 frontend"
[react]: https://res.cloudinary.com/automattech/image/upload/q_auto:best/v1559387150/powerlevel9k-built-with-segment/react.png "Terminal showing angular cli"
[folder]: https://res.cloudinary.com/automattech/image/upload/q_auto:best/v1559387150/powerlevel9k-built-with-segment/folder.png "Terminal showing folder"
