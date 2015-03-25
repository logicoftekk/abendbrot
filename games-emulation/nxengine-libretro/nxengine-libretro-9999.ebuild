# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="libretro implementation of NXEngine. (Cave Story)"
HOMEPAGE="https://github.com/libretro/nxengine-libretro"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/nxengine-libretro.git"

LICENSE="GPL-3"
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
	insinto /usr/$(get_libdir)/libretro
	doins "${S}"/nxengine_libretro.so
	insinto /usr/share/libretro/info/
	doins "${WORKDIR}"/infos/dist/info/nxengine_libretro.info
}

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PV}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		elog ""
		elog "To play a game, like Cave Story, put the gamefiles"
		elog "to your rgui_browser_directory and select the executable as game"
		elog ""
		ewarn "This message will only be displayed once!"
		ewarn ""
	fi
}
