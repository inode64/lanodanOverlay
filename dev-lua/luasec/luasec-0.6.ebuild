# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Lua binding for OpenSSL library to provide TLS/SSL communication"
HOMEPAGE="https://github.com/brunoos/luasec http://www.inf.puc-rio.br/~brunoos/luasec/"
SRC_URI="https://github.com/brunoos/luasec/archive/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="libressl"

RDEPEND="
	>=dev-lang/lua-5.1:*[deprecated]
	dev-lua/luasocket
	libressl? ( dev-libs/libressl:= )
	!libressl? ( dev-libs/openssl:= )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${PN}-${P}

src_prepare() {
	sed -i -e "s#^LUAPATH.*#LUAPATH=$(pkg-config --variable INSTALL_LMOD lua)#"\
		-e "s#^LUACPATH.*#LUACPATH=$(pkg-config --variable INSTALL_CMOD lua)#" Makefile
	sed -i "s/=-O2 /=/g" src/Makefile

	sed -i 's/$(LUACPATH)/$(DESTDIR)$(LUACPATH)/' Makefile
	sed -i 's/$(LUAPATH)/$(DESTDIR)$(LUAPATH)/' Makefile

	lua src/options.lua -g /usr/include/openssl/ssl.h > src/options.h

	eapply_user
}

src_compile() {
	emake linux
}
