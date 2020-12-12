# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit multilib toolchain-funcs

DESCRIPTION="Suite of tools compiling mdoc and man"
HOMEPAGE="https://mandoc.bsd.lv/"
SRC_URI="https://mandoc.bsd.lv/snapshots/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="static"

LIB_DEPEND="sys-libs/zlib[static-libs(+)]"
RDEPEND="
	!static? ( ${LIB_DEPEND//\[static-libs(+)]} )
	!sys-apps/man-db
	!sys-apps/man
"
DEPEND="${RDEPEND}
	static? ( ${LIB_DEPEND} )"

PATCHES=(
	"$FILESDIR"/mandoc-1.14.5-fix-tbl-null-pointer.patch
	"$FILESDIR"/mandoc_configure.patch
)

src_prepare() {
	default

	# The db-install change is to support parallel installs.
	sed -i \
		-e '/ar rs/s:ar:$(AR):' \
		-e '/^db-install:/s:$: base-install:' \
		Makefile || die

	# Bump Note: Remove -fcommon, fixed in [1] but doesn't applies cleanly
	# and it looks like no one did the rebasing work.
	# 1: https://inbox.vuxu.org/mandoc-source/490dd254e5b643b9@mandoc.bsd.lv/

	cat <<-EOF > "configure.local"
		PREFIX="${EPREFIX}/usr"
		BINDIR="${EPREFIX}/usr/bin"
		SBINDIR="${EPREFIX}/usr/sbin"
		LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		MANDIR="${EPREFIX}/usr/share/man"
		INCLUDEDIR="${EPREFIX}/usr/include/mandoc"
		EXAMPLEDIR="${EPREFIX}/usr/share/examples/mandoc"
		MANPATH_DEFAULT="${EPREFIX}/usr/man:${EPREFIX}/usr/share/man:${EPREFIX}/usr/local/man:${EPREFIX}/usr/local/share/man"

		MANM_MAN=mandoc_man
		MANM_MDOC=mandoc_mdoc
		MANM_ROFF=mandoc_roff
		MANM_EQN=mandoc_eqn
		MANM_TBL=mandoc_tbl
		BINM_SOELIM=msoelim
		CFLAGS="${CFLAGS} ${CPPFLAGS} -fcommon"
		LDFLAGS="${LDFLAGS} $(usex static -static '')"
		AR="$(tc-getAR)"
		CC="$(tc-getCC)"
		# The STATIC variable is only used by man.cgi.
		STATIC=
	EOF
}
