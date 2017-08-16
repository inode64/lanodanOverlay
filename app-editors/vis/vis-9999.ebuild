# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inheri<M-Down>t git-r3

DESCRIPTION="modern, legacy free, simple yet efficient vim-like editor."
HOMEPAGE="https://github.com/martanne/vis"
EGIT_REPO_URI="https://github.com/martanne/vis.git"
LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE="+ncurses lua lpeg selinux test tre"

#TODO: virtual/curses
DEPEND="dev-libs/libtermkey
	lua? ( >=dev-lang/lua-5.2:= )
	tre? ( dev-libs/tre:= )
	ncurses? ( sys-libs/ncurses:= )"
RDEPEND="${DEPEND}
	lua? ( lpeg? ( >=dev-lua/lpeg-0.12 ) )
	app-eselect/eselect-vi"

src_prepare() {
	if use test; then
		type -P vim &>/dev/null || sed -i 's/.*vim.*//' test/Makefile || die
	fi

	default
}

src_configure() {
	econf \
		$(use_enable lua) \
		$(use_enable ncurses curses) \
		$(use_enable selinux) \
		$(use_enable tre)
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
