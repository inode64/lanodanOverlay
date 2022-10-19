# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit savedconfig font

MY_PN="${PN%-*}"
MY_PV=$(ver_rs 3 '-' 4 '.')
MY_P="${MY_PN^}-${MY_PV}"

# curl -sSL https://github.com/be5invis/Iosevka/raw/v16.1.0/package-lock.json | jq -r '.dependencies | to_entries | map(if (.key|startswith("@")) then .value.resolved + " -> " + (.key|sub("/";"-")) + "-" + .value.version + ".tgz" else .value.resolved end) | .[]'
NODE_SRC="
https://registry.npmjs.org/@eslint/eslintrc/-/eslintrc-1.3.0.tgz -> @eslint-eslintrc-1.3.0.tgz
https://registry.npmjs.org/@humanwhocodes/config-array/-/config-array-0.10.4.tgz -> @humanwhocodes-config-array-0.10.4.tgz
https://registry.npmjs.org/@humanwhocodes/gitignore-to-minimatch/-/gitignore-to-minimatch-1.0.2.tgz -> @humanwhocodes-gitignore-to-minimatch-1.0.2.tgz
https://registry.npmjs.org/@humanwhocodes/object-schema/-/object-schema-1.2.1.tgz -> @humanwhocodes-object-schema-1.2.1.tgz
https://registry.npmjs.org/@iarna/toml/-/toml-2.2.5.tgz -> @iarna-toml-2.2.5.tgz
https://registry.npmjs.org/@msgpack/msgpack/-/msgpack-2.7.2.tgz -> @msgpack-msgpack-2.7.2.tgz
https://registry.npmjs.org/@nodelib/fs.scandir/-/fs.scandir-2.1.5.tgz -> @nodelib-fs.scandir-2.1.5.tgz
https://registry.npmjs.org/@nodelib/fs.stat/-/fs.stat-2.0.5.tgz -> @nodelib-fs.stat-2.0.5.tgz
https://registry.npmjs.org/@nodelib/fs.walk/-/fs.walk-1.2.8.tgz -> @nodelib-fs.walk-1.2.8.tgz
https://registry.npmjs.org/@ot-builder/bin-composite-types/-/bin-composite-types-1.5.4.tgz -> @ot-builder-bin-composite-types-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/bin-util/-/bin-util-1.5.4.tgz -> @ot-builder-bin-util-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/cli-help-shower/-/cli-help-shower-1.5.4.tgz -> @ot-builder-cli-help-shower-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/cli-proc/-/cli-proc-1.5.4.tgz -> @ot-builder-cli-proc-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/cli-shared/-/cli-shared-1.5.4.tgz -> @ot-builder-cli-shared-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/common-impl/-/common-impl-1.5.4.tgz -> @ot-builder-common-impl-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/errors/-/errors-1.5.4.tgz -> @ot-builder-errors-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/io-bin-cff/-/io-bin-cff-1.5.4.tgz -> @ot-builder-io-bin-cff-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/io-bin-encoding/-/io-bin-encoding-1.5.4.tgz -> @ot-builder-io-bin-encoding-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/io-bin-ext-private/-/io-bin-ext-private-1.5.4.tgz -> @ot-builder-io-bin-ext-private-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/io-bin-font/-/io-bin-font-1.5.4.tgz -> @ot-builder-io-bin-font-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/io-bin-glyph-store/-/io-bin-glyph-store-1.5.4.tgz -> @ot-builder-io-bin-glyph-store-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/io-bin-layout/-/io-bin-layout-1.5.4.tgz -> @ot-builder-io-bin-layout-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/io-bin-metadata/-/io-bin-metadata-1.5.4.tgz -> @ot-builder-io-bin-metadata-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/io-bin-metric/-/io-bin-metric-1.5.4.tgz -> @ot-builder-io-bin-metric-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/io-bin-name/-/io-bin-name-1.5.4.tgz -> @ot-builder-io-bin-name-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/io-bin-sfnt/-/io-bin-sfnt-1.5.4.tgz -> @ot-builder-io-bin-sfnt-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/io-bin-ttf/-/io-bin-ttf-1.5.4.tgz -> @ot-builder-io-bin-ttf-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/io-bin-vtt-private/-/io-bin-vtt-private-1.5.4.tgz -> @ot-builder-io-bin-vtt-private-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/ot/-/ot-1.5.4.tgz -> @ot-builder-ot-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/ot-encoding/-/ot-encoding-1.5.4.tgz -> @ot-builder-ot-encoding-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/ot-ext-private/-/ot-ext-private-1.5.4.tgz -> @ot-builder-ot-ext-private-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/ot-glyphs/-/ot-glyphs-1.5.4.tgz -> @ot-builder-ot-glyphs-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/ot-layout/-/ot-layout-1.5.4.tgz -> @ot-builder-ot-layout-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/ot-metadata/-/ot-metadata-1.5.4.tgz -> @ot-builder-ot-metadata-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/ot-name/-/ot-name-1.5.4.tgz -> @ot-builder-ot-name-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/ot-sfnt/-/ot-sfnt-1.5.4.tgz -> @ot-builder-ot-sfnt-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/ot-standard-glyph-namer/-/ot-standard-glyph-namer-1.5.4.tgz -> @ot-builder-ot-standard-glyph-namer-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/ot-vtt-private/-/ot-vtt-private-1.5.4.tgz -> @ot-builder-ot-vtt-private-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/prelude/-/prelude-1.5.4.tgz -> @ot-builder-prelude-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/primitive/-/primitive-1.5.4.tgz -> @ot-builder-primitive-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/rectify/-/rectify-1.5.4.tgz -> @ot-builder-rectify-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/stat-glyphs/-/stat-glyphs-1.5.4.tgz -> @ot-builder-stat-glyphs-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/trace/-/trace-1.5.4.tgz -> @ot-builder-trace-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/var-store/-/var-store-1.5.4.tgz -> @ot-builder-var-store-1.5.4.tgz
https://registry.npmjs.org/@ot-builder/variance/-/variance-1.5.4.tgz -> @ot-builder-variance-1.5.4.tgz
https://registry.npmjs.org/@types/json5/-/json5-0.0.29.tgz -> @types-json5-0.0.29.tgz
https://registry.npmjs.org/@unicode/unicode-14.0.0/-/unicode-14.0.0-1.3.0.tgz -> @unicode-unicode-14.0.0-1.3.0.tgz
https://registry.npmjs.org/@xmldom/xmldom/-/xmldom-0.8.2.tgz -> @xmldom-xmldom-0.8.2.tgz
https://registry.npmjs.org/acorn/-/acorn-8.8.0.tgz
https://registry.npmjs.org/acorn-jsx/-/acorn-jsx-5.3.2.tgz
https://registry.npmjs.org/aglfn/-/aglfn-1.0.2.tgz
https://registry.npmjs.org/ajv/-/ajv-6.12.6.tgz
https://registry.npmjs.org/amdefine/-/amdefine-1.0.1.tgz
https://registry.npmjs.org/ansi-regex/-/ansi-regex-5.0.1.tgz
https://registry.npmjs.org/ansi-styles/-/ansi-styles-4.3.0.tgz
https://registry.npmjs.org/argparse/-/argparse-2.0.1.tgz
https://registry.npmjs.org/array-includes/-/array-includes-3.1.5.tgz
https://registry.npmjs.org/array-union/-/array-union-2.1.0.tgz
https://registry.npmjs.org/array.prototype.flat/-/array.prototype.flat-1.3.0.tgz
https://registry.npmjs.org/balanced-match/-/balanced-match-1.0.2.tgz
https://registry.npmjs.org/brace-expansion/-/brace-expansion-1.1.11.tgz
https://registry.npmjs.org/braces/-/braces-3.0.2.tgz
https://registry.npmjs.org/call-bind/-/call-bind-1.0.2.tgz
https://registry.npmjs.org/callsites/-/callsites-3.1.0.tgz
https://registry.npmjs.org/chainsaw/-/chainsaw-0.0.9.tgz
https://registry.npmjs.org/chalk/-/chalk-4.1.2.tgz
https://registry.npmjs.org/cldr/-/cldr-7.2.0.tgz
https://registry.npmjs.org/cli-cursor/-/cli-cursor-3.1.0.tgz
https://registry.npmjs.org/clipper-lib/-/clipper-lib-6.4.2.tgz
https://registry.npmjs.org/cliui/-/cliui-7.0.4.tgz
https://registry.npmjs.org/color-convert/-/color-convert-2.0.1.tgz
https://registry.npmjs.org/color-name/-/color-name-1.1.4.tgz
https://registry.npmjs.org/concat-map/-/concat-map-0.0.1.tgz
https://registry.npmjs.org/cross-spawn/-/cross-spawn-7.0.3.tgz
https://registry.npmjs.org/debug/-/debug-4.3.4.tgz
https://registry.npmjs.org/deep-is/-/deep-is-0.1.4.tgz
https://registry.npmjs.org/define-properties/-/define-properties-1.1.4.tgz
https://registry.npmjs.org/dir-glob/-/dir-glob-3.0.1.tgz
https://registry.npmjs.org/doctrine/-/doctrine-3.0.0.tgz
https://registry.npmjs.org/emoji-regex/-/emoji-regex-8.0.0.tgz
https://registry.npmjs.org/es-abstract/-/es-abstract-1.20.1.tgz
https://registry.npmjs.org/es-shim-unscopables/-/es-shim-unscopables-1.0.0.tgz
https://registry.npmjs.org/es-to-primitive/-/es-to-primitive-1.2.1.tgz
https://registry.npmjs.org/escalade/-/escalade-3.1.1.tgz
https://registry.npmjs.org/escape-string-regexp/-/escape-string-regexp-4.0.0.tgz
https://registry.npmjs.org/escodegen/-/escodegen-2.0.0.tgz
https://registry.npmjs.org/escope/-/escope-1.0.3.tgz
https://registry.npmjs.org/eslint/-/eslint-8.21.0.tgz
https://registry.npmjs.org/eslint-config-prettier/-/eslint-config-prettier-8.5.0.tgz
https://registry.npmjs.org/eslint-import-resolver-node/-/eslint-import-resolver-node-0.3.6.tgz
https://registry.npmjs.org/eslint-module-utils/-/eslint-module-utils-2.7.3.tgz
https://registry.npmjs.org/eslint-plugin-import/-/eslint-plugin-import-2.26.0.tgz
https://registry.npmjs.org/eslint-scope/-/eslint-scope-7.1.1.tgz
https://registry.npmjs.org/eslint-utils/-/eslint-utils-3.0.0.tgz
https://registry.npmjs.org/eslint-visitor-keys/-/eslint-visitor-keys-3.3.0.tgz
https://registry.npmjs.org/esmangle/-/esmangle-1.0.1.tgz
https://registry.npmjs.org/espree/-/espree-9.3.3.tgz
https://registry.npmjs.org/esprima/-/esprima-4.0.1.tgz
https://registry.npmjs.org/esquery/-/esquery-1.4.0.tgz
https://registry.npmjs.org/esrecurse/-/esrecurse-4.3.0.tgz
https://registry.npmjs.org/esshorten/-/esshorten-1.1.1.tgz
https://registry.npmjs.org/estraverse/-/estraverse-5.3.0.tgz
https://registry.npmjs.org/esutils/-/esutils-2.0.3.tgz
https://registry.npmjs.org/fast-deep-equal/-/fast-deep-equal-3.1.3.tgz
https://registry.npmjs.org/fast-glob/-/fast-glob-3.2.11.tgz
https://registry.npmjs.org/fast-json-stable-stringify/-/fast-json-stable-stringify-2.1.0.tgz
https://registry.npmjs.org/fast-levenshtein/-/fast-levenshtein-2.0.6.tgz
https://registry.npmjs.org/fastq/-/fastq-1.13.0.tgz
https://registry.npmjs.org/file-entry-cache/-/file-entry-cache-6.0.1.tgz
https://registry.npmjs.org/fill-range/-/fill-range-7.0.1.tgz
https://registry.npmjs.org/find-up/-/find-up-5.0.0.tgz
https://registry.npmjs.org/flat-cache/-/flat-cache-3.0.4.tgz
https://registry.npmjs.org/flatted/-/flatted-3.2.6.tgz
https://registry.npmjs.org/fs-extra/-/fs-extra-10.1.0.tgz
https://registry.npmjs.org/fs.realpath/-/fs.realpath-1.0.0.tgz
https://registry.npmjs.org/function-bind/-/function-bind-1.1.1.tgz
https://registry.npmjs.org/function.prototype.name/-/function.prototype.name-1.1.5.tgz
https://registry.npmjs.org/functional-red-black-tree/-/functional-red-black-tree-1.0.1.tgz
https://registry.npmjs.org/functions-have-names/-/functions-have-names-1.2.3.tgz
https://registry.npmjs.org/get-caller-file/-/get-caller-file-2.0.5.tgz
https://registry.npmjs.org/get-intrinsic/-/get-intrinsic-1.1.2.tgz
https://registry.npmjs.org/get-symbol-description/-/get-symbol-description-1.0.0.tgz
https://registry.npmjs.org/glob/-/glob-7.2.3.tgz
https://registry.npmjs.org/glob-parent/-/glob-parent-6.0.2.tgz
https://registry.npmjs.org/globals/-/globals-13.17.0.tgz
https://registry.npmjs.org/globby/-/globby-11.1.0.tgz
https://registry.npmjs.org/graceful-fs/-/graceful-fs-4.2.10.tgz
https://registry.npmjs.org/grapheme-splitter/-/grapheme-splitter-1.0.4.tgz
https://registry.npmjs.org/has/-/has-1.0.3.tgz
https://registry.npmjs.org/has-bigints/-/has-bigints-1.0.2.tgz
https://registry.npmjs.org/has-flag/-/has-flag-4.0.0.tgz
https://registry.npmjs.org/has-property-descriptors/-/has-property-descriptors-1.0.0.tgz
https://registry.npmjs.org/has-symbols/-/has-symbols-1.0.3.tgz
https://registry.npmjs.org/has-tostringtag/-/has-tostringtag-1.0.0.tgz
https://registry.npmjs.org/hashish/-/hashish-0.0.4.tgz
https://registry.npmjs.org/iconv-lite/-/iconv-lite-0.6.3.tgz
https://registry.npmjs.org/ignore/-/ignore-5.2.0.tgz
https://registry.npmjs.org/import-fresh/-/import-fresh-3.3.0.tgz
https://registry.npmjs.org/imurmurhash/-/imurmurhash-0.1.4.tgz
https://registry.npmjs.org/inflight/-/inflight-1.0.6.tgz
https://registry.npmjs.org/inherits/-/inherits-2.0.4.tgz
https://registry.npmjs.org/internal-slot/-/internal-slot-1.0.3.tgz
https://registry.npmjs.org/is-bigint/-/is-bigint-1.0.4.tgz
https://registry.npmjs.org/is-boolean-object/-/is-boolean-object-1.1.2.tgz
https://registry.npmjs.org/is-callable/-/is-callable-1.2.4.tgz
https://registry.npmjs.org/is-core-module/-/is-core-module-2.10.0.tgz
https://registry.npmjs.org/is-date-object/-/is-date-object-1.0.5.tgz
https://registry.npmjs.org/is-extglob/-/is-extglob-2.1.1.tgz
https://registry.npmjs.org/is-fullwidth-code-point/-/is-fullwidth-code-point-3.0.0.tgz
https://registry.npmjs.org/is-glob/-/is-glob-4.0.3.tgz
https://registry.npmjs.org/is-negative-zero/-/is-negative-zero-2.0.2.tgz
https://registry.npmjs.org/is-number/-/is-number-7.0.0.tgz
https://registry.npmjs.org/is-number-object/-/is-number-object-1.0.7.tgz
https://registry.npmjs.org/is-regex/-/is-regex-1.1.4.tgz
https://registry.npmjs.org/is-shared-array-buffer/-/is-shared-array-buffer-1.0.2.tgz
https://registry.npmjs.org/is-string/-/is-string-1.0.7.tgz
https://registry.npmjs.org/is-symbol/-/is-symbol-1.0.4.tgz
https://registry.npmjs.org/is-weakref/-/is-weakref-1.0.2.tgz
https://registry.npmjs.org/isexe/-/isexe-2.0.0.tgz
https://registry.npmjs.org/js-yaml/-/js-yaml-4.1.0.tgz
https://registry.npmjs.org/json-schema-traverse/-/json-schema-traverse-0.4.1.tgz
https://registry.npmjs.org/json-stable-stringify-without-jsonify/-/json-stable-stringify-without-jsonify-1.0.1.tgz
https://registry.npmjs.org/json5/-/json5-1.0.1.tgz
https://registry.npmjs.org/jsonfile/-/jsonfile-6.1.0.tgz
https://registry.npmjs.org/levn/-/levn-0.4.1.tgz
https://registry.npmjs.org/locate-path/-/locate-path-6.0.0.tgz
https://registry.npmjs.org/lodash.merge/-/lodash.merge-4.6.2.tgz
https://registry.npmjs.org/lru-cache/-/lru-cache-2.5.0.tgz
https://registry.npmjs.org/memoizeasync/-/memoizeasync-1.1.0.tgz
https://registry.npmjs.org/merge2/-/merge2-1.4.1.tgz
https://registry.npmjs.org/micromatch/-/micromatch-4.0.5.tgz
https://registry.npmjs.org/mimic-fn/-/mimic-fn-2.1.0.tgz
https://registry.npmjs.org/minimatch/-/minimatch-3.1.2.tgz
https://registry.npmjs.org/minimist/-/minimist-1.2.6.tgz
https://registry.npmjs.org/ms/-/ms-2.1.2.tgz
https://registry.npmjs.org/natural-compare/-/natural-compare-1.4.0.tgz
https://registry.npmjs.org/object-inspect/-/object-inspect-1.12.2.tgz
https://registry.npmjs.org/object-keys/-/object-keys-1.1.1.tgz
https://registry.npmjs.org/object.assign/-/object.assign-4.1.3.tgz
https://registry.npmjs.org/object.values/-/object.values-1.1.5.tgz
https://registry.npmjs.org/once/-/once-1.4.0.tgz
https://registry.npmjs.org/onetime/-/onetime-5.1.2.tgz
https://registry.npmjs.org/optionator/-/optionator-0.8.3.tgz
https://registry.npmjs.org/ot-builder/-/ot-builder-1.5.4.tgz
https://registry.npmjs.org/otb-ttc-bundle/-/otb-ttc-bundle-1.5.4.tgz
https://registry.npmjs.org/p-limit/-/p-limit-3.1.0.tgz
https://registry.npmjs.org/p-locate/-/p-locate-5.0.0.tgz
https://registry.npmjs.org/p-try/-/p-try-1.0.0.tgz
https://registry.npmjs.org/parent-module/-/parent-module-1.0.1.tgz
https://registry.npmjs.org/passerror/-/passerror-1.1.1.tgz
https://registry.npmjs.org/patel/-/patel-0.38.0.tgz
https://registry.npmjs.org/path-exists/-/path-exists-4.0.0.tgz
https://registry.npmjs.org/path-is-absolute/-/path-is-absolute-1.0.1.tgz
https://registry.npmjs.org/path-key/-/path-key-3.1.1.tgz
https://registry.npmjs.org/path-parse/-/path-parse-1.0.7.tgz
https://registry.npmjs.org/path-type/-/path-type-4.0.0.tgz
https://registry.npmjs.org/patrisika/-/patrisika-0.25.0.tgz
https://registry.npmjs.org/patrisika-scopes/-/patrisika-scopes-0.12.0.tgz
https://registry.npmjs.org/pegjs/-/pegjs-0.10.0.tgz
https://registry.npmjs.org/picomatch/-/picomatch-2.3.1.tgz
https://registry.npmjs.org/prelude-ls/-/prelude-ls-1.2.1.tgz
https://registry.npmjs.org/prettier/-/prettier-2.7.1.tgz
https://registry.npmjs.org/punycode/-/punycode-2.1.1.tgz
https://registry.npmjs.org/queue-microtask/-/queue-microtask-1.2.3.tgz
https://registry.npmjs.org/regexp.prototype.flags/-/regexp.prototype.flags-1.4.3.tgz
https://registry.npmjs.org/regexpp/-/regexpp-3.2.0.tgz
https://registry.npmjs.org/require-directory/-/require-directory-2.1.1.tgz
https://registry.npmjs.org/resolve/-/resolve-1.22.1.tgz
https://registry.npmjs.org/resolve-from/-/resolve-from-4.0.0.tgz
https://registry.npmjs.org/restore-cursor/-/restore-cursor-3.1.0.tgz
https://registry.npmjs.org/resumer/-/resumer-0.0.0.tgz
https://registry.npmjs.org/reusify/-/reusify-1.0.4.tgz
https://registry.npmjs.org/rimraf/-/rimraf-3.0.2.tgz
https://registry.npmjs.org/run-parallel/-/run-parallel-1.2.0.tgz
https://registry.npmjs.org/safer-buffer/-/safer-buffer-2.1.2.tgz
https://registry.npmjs.org/semaphore-async-await/-/semaphore-async-await-1.5.1.tgz
https://registry.npmjs.org/semver/-/semver-7.3.7.tgz
https://registry.npmjs.org/seq/-/seq-0.3.5.tgz
https://registry.npmjs.org/shebang-command/-/shebang-command-2.0.0.tgz
https://registry.npmjs.org/shebang-regex/-/shebang-regex-3.0.0.tgz
https://registry.npmjs.org/side-channel/-/side-channel-1.0.4.tgz
https://registry.npmjs.org/signal-exit/-/signal-exit-3.0.7.tgz
https://registry.npmjs.org/slash/-/slash-3.0.0.tgz
https://registry.npmjs.org/source-map/-/source-map-0.6.1.tgz
https://registry.npmjs.org/spiro/-/spiro-3.0.0.tgz
https://registry.npmjs.org/string-width/-/string-width-4.2.3.tgz
https://registry.npmjs.org/string.prototype.trimend/-/string.prototype.trimend-1.0.5.tgz
https://registry.npmjs.org/string.prototype.trimstart/-/string.prototype.trimstart-1.0.5.tgz
https://registry.npmjs.org/strip-ansi/-/strip-ansi-6.0.1.tgz
https://registry.npmjs.org/strip-bom/-/strip-bom-3.0.0.tgz
https://registry.npmjs.org/strip-json-comments/-/strip-json-comments-3.1.1.tgz
https://registry.npmjs.org/supports-color/-/supports-color-7.2.0.tgz
https://registry.npmjs.org/supports-preserve-symlinks-flag/-/supports-preserve-symlinks-flag-1.0.0.tgz
https://registry.npmjs.org/text-table/-/text-table-0.2.0.tgz
https://registry.npmjs.org/through/-/through-2.3.8.tgz
https://registry.npmjs.org/to-regex-range/-/to-regex-range-5.0.1.tgz
https://registry.npmjs.org/toposort/-/toposort-2.0.2.tgz
https://registry.npmjs.org/traverse/-/traverse-0.3.9.tgz
https://registry.npmjs.org/tsconfig-paths/-/tsconfig-paths-3.14.1.tgz
https://registry.npmjs.org/tslib/-/tslib-2.4.0.tgz
https://registry.npmjs.org/type-check/-/type-check-0.4.0.tgz
https://registry.npmjs.org/type-fest/-/type-fest-0.20.2.tgz
https://registry.npmjs.org/typo-geom/-/typo-geom-0.12.1.tgz
https://registry.npmjs.org/unbox-primitive/-/unbox-primitive-1.0.2.tgz
https://registry.npmjs.org/unicoderegexp/-/unicoderegexp-0.4.1.tgz
https://registry.npmjs.org/universalify/-/universalify-2.0.0.tgz
https://registry.npmjs.org/uri-js/-/uri-js-4.4.1.tgz
https://registry.npmjs.org/uuid/-/uuid-8.3.2.tgz
https://registry.npmjs.org/v8-compile-cache/-/v8-compile-cache-2.3.0.tgz
https://registry.npmjs.org/verda/-/verda-1.10.0.tgz
https://registry.npmjs.org/wawoff2/-/wawoff2-2.0.1.tgz
https://registry.npmjs.org/which/-/which-2.0.2.tgz
https://registry.npmjs.org/which-boxed-primitive/-/which-boxed-primitive-1.0.2.tgz
https://registry.npmjs.org/word-wrap/-/word-wrap-1.2.3.tgz
https://registry.npmjs.org/wordwrap/-/wordwrap-0.0.3.tgz
https://registry.npmjs.org/wrap-ansi/-/wrap-ansi-7.0.0.tgz
https://registry.npmjs.org/wrappy/-/wrappy-1.0.2.tgz
https://registry.npmjs.org/xpath/-/xpath-0.0.32.tgz
https://registry.npmjs.org/y18n/-/y18n-5.0.8.tgz
https://registry.npmjs.org/yallist/-/yallist-4.0.0.tgz
https://registry.npmjs.org/yargs/-/yargs-16.2.0.tgz
https://registry.npmjs.org/yargs-parser/-/yargs-parser-20.2.9.tgz
https://registry.npmjs.org/yocto-queue/-/yocto-queue-0.1.0.tgz
"

DESCRIPTION="Spatial efficient monospace font family for programming"
HOMEPAGE="https://be5invis.github.io/Iosevka"
SRC_URI="
	${NODE_SRC}
	mirror://githubcl/be5invis/${MY_PN^}/tar.gz/v${MY_PV} -> ${MY_P}.tar.gz
	https://registry.npmjs.org/lru-cache/-/lru-cache-6.0.0.tgz
	https://registry.npmjs.org/levn/-/levn-0.3.0.tgz
	https://registry.npmjs.org/prelude-ls/-/prelude-ls-1.1.2.tgz
	https://registry.npmjs.org/type-check/-/type-check-0.3.2.tgz
	https://registry.npmjs.org/optionator/-/optionator-0.9.1.tgz
	https://registry.npmjs.org/eslint-visitor-keys/-/eslint-visitor-keys-2.1.0.tgz
	https://registry.npmjs.org/glob-parent/-/glob-parent-5.1.2.tgz
	https://registry.npmjs.org/debug/-/debug-2.6.9.tgz
	https://registry.npmjs.org/doctrine/-/doctrine-2.1.0.tgz
	https://registry.npmjs.org/ms/-/ms-2.0.0.tgz
	https://registry.npmjs.org/debug/-/debug-3.2.7.tgz
	https://registry.npmjs.org/find-up/-/find-up-2.1.0.tgz
	https://registry.npmjs.org/locate-path/-/locate-path-2.0.0.tgz
	https://registry.npmjs.org/p-locate/-/p-locate-2.0.0.tgz
	https://registry.npmjs.org/path-exists/-/path-exists-3.0.0.tgz
	https://registry.npmjs.org/p-limit/-/p-limit-1.3.0.tgz
	https://registry.npmjs.org/escodegen/-/escodegen-1.3.3.tgz
	https://registry.npmjs.org/esprima/-/esprima-1.1.1.tgz
	https://registry.npmjs.org/estraverse/-/estraverse-1.5.1.tgz
	https://registry.npmjs.org/esutils/-/esutils-1.0.0.tgz
	https://registry.npmjs.org/optionator/-/optionator-0.3.0.tgz
	https://registry.npmjs.org/source-map/-/source-map-0.1.43.tgz
	https://registry.npmjs.org/estraverse/-/estraverse-2.0.0.tgz
	https://registry.npmjs.org/estraverse/-/estraverse-4.1.1.tgz
	https://registry.npmjs.org/fast-levenshtein/-/fast-levenshtein-1.0.7.tgz
	https://registry.npmjs.org/levn/-/levn-0.2.5.tgz
	https://registry.npmjs.org/yargs/-/yargs-17.5.1.tgz
	https://registry.npmjs.org/yargs-parser/-/yargs-parser-21.1.1.tgz
"

S="${WORKDIR}/${MY_P}"
KEYWORDS="~amd64 ~x86"

LICENSE="OFL-1.1"
SLOT="0"
IUSE="+autohint savedconfig"
BDEPEND="
	sys-apps/yarn
	autohint? ( media-gfx/ttfautohint )
"

FONT_SUFFIX="ttf"
FONT_PN="${MY_PN}"
FONT_S="${S}/dist/iosevka/ttf"

src_unpack() {
	unpack "${MY_P}.tar.gz"
}

src_prepare() {
	default

	rm package-lock.json || die
	cp "${FILESDIR}/${MY_P}-yarn.lock" "${S}/yarn.lock" || die

	if use savedconfig; then
		local _p="private-build-plans.toml"
		FONT_S="${S}/dist/iosevka-custom/ttf"

		restore_config ${_p}

		if [ ! -e "${S}"/${_p} ]
		then
			die "Custom build requires ${_p} file at ${PORTAGE_CONFIGROOT}etc/portage/savedconfig/${CATEGORY}/${PN}, see https://github.com/be5invis/Iosevka#configuring-custom-build"
		fi
	fi
}

src_compile() {
	yarn config set yarn-offline-mirror "${DISTDIR}" || die
	#yarn --offline --verbose import || die
	yarn --offline install || die

	if use savedconfig
	then
		yarn --offline run build ttf::iosevka-custom || die
	else
		yarn --offline run build ttf::iosevka || die
	fi
}