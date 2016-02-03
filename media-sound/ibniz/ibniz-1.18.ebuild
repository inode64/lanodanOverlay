# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="IBNIZ is a virtual machine designed for extremely compact low-level audiovisual programs."
HOMEPAGE="http://pelulamu.net/ibniz/"
SRC_URI="http://pelulamu.net/ibniz/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/libsdl"
RDEPEND="${DEPEND}"

src_install() {
	dobin ibniz
}