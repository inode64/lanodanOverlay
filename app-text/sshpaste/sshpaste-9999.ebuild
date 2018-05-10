# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="wgetpaste clone for pushing to your own server"
HOMEPAGE="https://hacktivis.me/git/sshpaste/"
SRC_URI=""

EGIT_REPO_URI="https://hacktivis.me/git/sshpaste.git"

LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE="X"

DEPEND=""
RDEPEND="
	${DEPEND}
	virtual/ssh
	X? ( x11-misc/xclip )
"

src_install() {
	dodoc README.md
	dodoc Changelog.md
	dobin sshpaste
}
