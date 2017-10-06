#!/usr/bin/env bash

set -e

export PATH=node_modules/.bin:${PATH}

rm -rf public/
rm -rf static/build
mkdir -p static/build/js static/build/css

hugo gen chromastyles --style=monokai > static/src/scss/highlight.css

node-sass static/src/scss/index.scss static/build/css/index.css --source-map-embed
browserify static/src/js/index.js -o static/build/js/app.js

hugo -v
