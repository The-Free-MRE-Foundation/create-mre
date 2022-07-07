#!/bin/bash

test $# -lt 1 && exit
dir=$1
cwd=$(pwd)

sudo apt install -y npm git jq

mkdir -p $dir
cd $dir

npm init -y

# install typescript
npm install typescript --save-dev

# generate tsconfig.json
npx tsc --init --rootDir src --outDir build \
--esModuleInterop --resolveJsonModule --lib es6 \
--module commonjs --allowJs true --noImplicitAny true

# create src dir
mkdir src

# install eslint
npm install --save-dev eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin

# .eslintrc.js
cat << EOF >.eslintrc.js
module.exports = {
  "root": true,
  "parser": "@typescript-eslint/parser",
  "plugins": [
    "@typescript-eslint"
  ],
  "extends": [
    "eslint:recommended",
    "plugin:@typescript-eslint/eslint-recommended",
    "plugin:@typescript-eslint/recommended"
  ]
}
EOF

cat << EOF >.eslintignore
node_modules
dist
EOF

cat << EOF >.gitignore
build/
node_modules/
tsconfig.tsbuildinfo
EOF

# install mre sdk
npm install --save @microsoft/mixed-reality-extension-sdk dotenv

# cp empty typescript template
cp $cwd/server.ts src/
cp $cwd/app.ts src/

# modify package.json
cat package.json | \
  jq '.scripts.build="tsc --build"' | \
  jq '.scripts.start="node ."' | \
  jq '.main="build/server.js"' > package.json.tmp
mv package.json.tmp package.json