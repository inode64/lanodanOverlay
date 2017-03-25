# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit git-r3

DESCRIPTION="Vis aims to be a modern, legacy free, simple yet efficient vim-like editor."
HOMEPAGE="https://github.com/martanne/vis"
EGIT_REPO_URI="https://github.com/martanne/vis.git"
LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE="+lua +lpeg -selinux tre"

DEPEND="sys-libs/ncurses:= dev-libs/libtermkey lua? ( >=dev-lang/lua-5.2:= ) tre? ( dev-libs/tre:* )"
RDEPEND="${DEPEND} lua? ( lpeg? ( >=dev-lua/lpeg-0.12 ) ) "

src_configure() {
	econf $(use_enable lua)
	econf $(use_enable tre)
	econf $(use_enable selinux)
}

update_symlinks() {
	einfo "Calling eselect vi update --if-unset…"
	eselect vi update --if-unset
}

pkg_postrm() {
	update_symlinks
}

pkg_postinst() {
	update_symlinks
}
