# Copyright 2022 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nodejs

DESCRIPTION="Like which(1) unix command. Find the first instance of an executable in the PATH."
HOMEPAGE="https://github.com/isaacs/node-which"
SRC_URI="https://github.com/isaacs/node-which/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/node-which-${PV}"
LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

#IUSE="test"

RDEPEND="dev-nodejs/isexe"
DEPEND="${RDEPEND}"
#test? (
#	dev-nodejs/mkdirp
#	dev-nodejs/rimraf
#	dev-nodejs/tap
#)"
#RESTRICT="!test? ( test )"

RESTRICT="test"

src_install() {
	insinto "${NODEJS_SITELIB}${PN}"
	doins package.json

	cat package.json | jq -r .files[] | while read pkg
	do
		insinto "${NODEJS_SITELIB}${PN}/$(dirname "$pkg")"
		doins -r "$pkg"
	done

	fperms 755 "${NODEJS_SITELIB}${PN}/bin/node-which"
	dosym "${NODEJS_SITELIB}${PN}/bin/node-which" "${EPREFIX}/usr/bin/node-which"
}
