# Copyright 2018-2019 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="A GTK+ Jabber client"
HOMEPAGE="https://gajim.org"
KEYWORDS="~amd64"
SRC_URI="https://gajim.org/downloads/$(ver_cut 1-2)/${P}.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
IUSE="webp gpg idn"

RDEPEND="
	dev-python/keyring
	>=dev-python/python-nbxmpp-0.6.9
	>=dev-python/pyopenssl-0.12
	>=dev-python/cssutils-1.0.2
	>=dev-python/precis-i18n-1.0.0
	webp? ( dev-python/pillow )
	gpg? ( dev-python/python-gnupg )
	idn? (
		dev-python/idna
		dev-python/precis-i18n
	)
"
