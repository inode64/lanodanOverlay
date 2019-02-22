# Copyright 1999-2018 Gentoo Foundation
# Copyright 2018-2019 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib user flag-o-matic pam toolchain-funcs autotools systemd

DESCRIPTION="Lightweight but featured SMTP daemon from OpenBSD"
HOMEPAGE="https://www.opensmtpd.org"
SRC_URI="https://www.opensmtpd.org/archives/${P/_}.tar.gz"

LICENSE="ISC BSD BSD-1 BSD-2 BSD-4"
SLOT="0"
KEYWORDS="~amd64"
IUSE="libressl pam mandoc +mta"

DEPEND="
	!libressl? ( dev-libs/openssl:0 )
	libressl? ( dev-libs/libressl )
	sys-libs/zlib
	pam? ( virtual/pam )
	elibc_musl? ( sys-libs/fts-standalone )
	mandoc? ( app-text/mandoc )
	sys-libs/db:=
	dev-libs/libevent
	app-misc/ca-certificates
	net-mail/mailbase
	net-libs/libasr
	!mail-mta/courier
	!mail-mta/esmtp
	!mail-mta/exim
	!mail-mta/mini-qmail
	!mail-mta/msmtp[mta]
	!mail-mta/netqmail
	!mail-mta/nullmailer
	!mail-mta/postfix
	!mail-mta/qmail-ldap
	!mail-mta/sendmail
	!mail-mta/ssmtp[mta]
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P/_}

# PATCHES=( "${FILESDIR}/opensmtpd-6.4.0_p1_missing_object_file_smtpctl.patch" )

src_prepare() {
	default

	# Use /run instead of /var/run
	sed -i -e '/pidfile_path/s:_PATH_VARRUN:"/run/":' openbsd-compat/pidfile.c || die
	sed -i -e 's;/usr/libexec/;/usr/libexec/opensmtpd/;g' smtpd/parse.y || die

	append-cflags "-ffunction-sections"
	append-ldflags "-Wl,--gc-sections"

	eautoreconf
}

src_configure() {
	tc-export AR
	AR="$(which "$AR")" econf \
		--with-table-db \
		--with-user-smtpd=smtpd \
		--with-user-queue=smtpq \
		--with-group-queue=smtpq \
		--with-path-socket=/run \
		--with-path-CAfile=/etc/ssl/certs/ca-certificates.crt \
		--sysconfdir=/etc/opensmtpd \
		--with-mantype=doc \
		$(use_with pam auth-pam)
}

src_install() {
	default

	newinitd "${FILESDIR}"/smtpd.initd smtpd
	systemd_dounit "${FILESDIR}"/smtpd.{service,socket}

	use pam && newpamd "${FILESDIR}"/smtpd.pam smtpd

	dosym /usr/sbin/smtpctl /usr/sbin/makemap
	dosym /usr/sbin/smtpctl /usr/sbin/newaliases

	if use mta ; then
		dodir /usr/sbin
		dosym /usr/sbin/smtpctl /usr/sbin/sendmail
		dosym /usr/sbin/smtpctl /usr/bin/sendmail
		dosym /usr/sbin/smtpctl /usr/$(get_libdir)/sendmail
	fi
}

pkg_preinst() {
	enewgroup smtpd 25
	enewuser smtpd 25 -1 /var/empty smtpd
	enewgroup smtpq 252
	enewuser smtpq 252 -1 /var/empty smtpq
}

pkg_postinst() {
	einfo
	einfo "Plugins for SQLite, MySQL, PostgreSQL, LDAP, socketmaps,"
	einfo "Redis, and many other useful addons and filters are"
	einfo "available in the mail-filter/opensmtpd-extras package."
	einfo
}
