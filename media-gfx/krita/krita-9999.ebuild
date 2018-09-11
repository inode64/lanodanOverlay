# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDE_TEST="forceoptional"
VIRTUALX_REQUIRED="test"
PYTHON_COMPAT=( python3_{4,5,6} )
inherit kde5 python-single-r1 git-r3

DESCRIPTION="Free digital painting application. Digital Painting, Creative Freedom!"
HOMEPAGE="https://www.kde.org/applications/graphics/krita/ https://krita.org/"
SRC_URI=""
EGIT_REPO_URI="git://anongit.kde.org/krita.git"

LICENSE="GPL-3"
KEYWORDS=""
IUSE="color-management fftw gif +gsl +jpeg openexr pdf python qtmedia +raw tiff vc threads curl zlib"

COMMON_DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_qt_dep qtconcurrent)
	$(add_qt_dep qtgui '-gles2')
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtprintsupport)
	$(add_qt_dep qtsvg)
	$(add_qt_dep qttest)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtx11extras)
	$(add_qt_dep qtxml)
	color-management? ( media-libs/opencolorio )
	curl? ( net-misc/curl )
	dev-libs/boost:=
	fftw? ( sci-libs/fftw:3.0= )
	gif? ( media-libs/giflib )
	gsl? ( sci-libs/gsl:= )
	jpeg? ( virtual/jpeg:0 )
	media-gfx/exiv2:=
	media-libs/lcms
	media-libs/libpng:0=
	openexr? (
		media-libs/ilmbase:=
		media-libs/openexr
	)
	pdf? ( app-text/poppler[qt5] )
	python? (
		${PYTHON_DEPS}
		dev-python/PyQt5[${PYTHON_USEDEP}]
		dev-python/sip[${PYTHON_USEDEP}]
	)
	qtmedia? ( $(add_qt_dep qtmultimedia) )
	raw? ( <media-libs/libraw-0.19:= )
	threads? ( dev-libs/libpthread-stubs )
	tiff? ( media-libs/tiff:0 )
	virtual/opengl
	x11-apps/xinput
	zlib? ( sys-libs/zlib )
"
DEPEND="${COMMON_DEPEND}
	dev-cpp/eigen:3
	dev-lang/perl
	sys-devel/gettext
	vc? ( >=dev-libs/vc-1.1.0 )
"
RDEPEND="${COMMON_DEPEND}
	!app-office/calligra:4[calligra_features_krita]
	!app-office/calligra-l10n:4[calligra_features_krita(+)]
"

# https://bugs.gentoo.org/630508
RESTRICT+=" test"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package color-management OCIO)
		$(cmake-utils_use_find_package fftw FFTW3)
		$(cmake-utils_use_find_package gif GIF)
		$(cmake-utils_use_find_package gsl GSL)
		$(cmake-utils_use_find_package jpeg JPEG)
		$(cmake-utils_use_find_package openexr OpenEXR)
		$(cmake-utils_use_find_package pdf Poppler)
		$(cmake-utils_use_find_package python PyQt5)
		$(cmake-utils_use_find_package python SIP)
		$(cmake-utils_use_find_package qtmedia Qt5Multimedia)
		$(cmake-utils_use_find_package raw LibRaw)
		$(cmake-utils_use_find_package tiff TIFF)
		$(cmake-utils_use_find_package vc Vc)
	)

	kde5_src_configure
}
