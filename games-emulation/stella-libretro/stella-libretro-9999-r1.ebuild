# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit games git-r3

DESCRIPTION="libretro implementation of Stella. (Atari 2600)"
HOMEPAGE="https://github.com/libretro/stella-libretro"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/stella-libretro.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND=""

src_unpack() {
	git-r3_fetch https://github.com/libretro/libretro-super.git HEAD
	git-r3_checkout https://github.com/libretro/libretro-super.git \
		"${WORKDIR}"/infos
	git-r3_fetch
	git-r3_checkout
}

src_install() {
	insinto ${GAMES_PREFIX}/$(get_libdir)/libretro
	doins "${S}"/stella_libretro.so
	insinto ${GAMES_DATADIR}/libretro/info/
	doins "${WORKDIR}"/infos/dist/info/stella_libretro.info
	prepgamesdirs
}
