# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ "${PV}" == "9999" ]]
then
	EGIT_REPO_URI="https://github.com/rzr/${PN}"
	inherit git-r3
else
	SRC_URI="https://github.com/rzr/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~ppc ~sparc ~x86"
fi

DESCRIPTION="Hurd table for games-arcade/emilia-pinball"
HOMEPAGE="https://github.com/rzr/${PN}"

LICENSE="GPL-2+ Free-Art-1.3 CC-BY-SA-3.0"
SLOT="0"
IUSE=""

RDEPEND="
	media-libs/libsdl2
	>=games-arcade/emilia-pinball-0.3.2020
"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	./bootstrap || die
}
