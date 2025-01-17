# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1 rebar3

DESCRIPTION="Erlang build tool that makes it easy to compile and test Erlang applications and releases"
HOMEPAGE="https://www.rebar3.org/"
LICENSE="Apache-2.0 MIT BSD"
SRC_URI="https://github.com/erlang/rebar3/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}3-${PV}"
SLOT="3"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~sparc ~x86"
IUSE="test"

RESTRICT="!test? ( test )"

DEPEND="
	dev-lang/erlang[ssl]
	!dev-util/rebar-bin
	test? ( dev-erlang/meck )
"
RDEPEND="${DEPEND}"

src_prepare() {
	rebar3_src_prepare
	sed -i 's;{deps, \[{meck, "[^"]*"}\]};{deps, []};' rebar.config || die
}

src_compile() {
	./bootstrap || die
}

src_test() {
	./rebar3 ct || die
}

src_install() {
	rebar3_src_install

	dobin rebar3
	doman manpages/rebar3.1
	dodoc rebar.config.sample

	newenvd - 98rebar3 <<EOF
REBAR3_CMD=${EPREFIX}/usr/bin/rebar3
MIX_REBAR3=${EPREFIX}/usr/bin/rebar3
EOF

	dobashcomp apps/rebar/priv/shell-completion/bash/rebar3

	insinto /usr/share/fish/completion
	newins apps/rebar/priv/shell-completion/fish/rebar3.fish rebar3

	insinto /usr/share/zsh/site-functions
	doins apps/rebar/priv/shell-completion/zsh/_rebar3
}
