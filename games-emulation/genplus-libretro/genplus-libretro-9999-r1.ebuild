# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit games git-r3

DESCRIPTION="libretro implementation of Genesis Plus GX. \
(Sega Genesis/Sega CD)"
HOMEPAGE="https://github.com/libretro/Genesis-Plus-GX"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/Genesis-Plus-GX.git"

LICENSE="GPGX"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="sys-libs/zlib"
DEPEND=""

src_unpack() {
	git-r3_fetch https://github.com/libretro/libretro-super.git HEAD
	git-r3_checkout https://github.com/libretro/libretro-super.git \
		"${WORKDIR}"/infos
	git-r3_fetch
	git-r3_checkout
}

src_compile() {
	emake -f Makefile.libretro || die "emake failed"
}

src_install() {
	insinto ${GAMES_PREFIX}/$(get_libdir)/libretro
	doins "${S}"/genesis_plus_gx_libretro.so
	insinto ${GAMES_DATADIR}/libretro/info/
	doins "${WORKDIR}"/infos/dist/info/genesis_plus_gx_libretro.info
	insinto ${GAMES_DATADIR}/libretro/genesis_plus_gx_libretro
	doins "${S}"/LICENSE.txt
	prepgamesdirs
}

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		ewarn ""
		ewarn "You need to have the following files in your 'system_directory' folder:"
		ewarn "Required:"
		ewarn "bios_CD_E.bin (MegaCD EU BIOS)"
		ewarn "bios_CD_U.bin (SegaCD US BIOS)"
		ewarn "bios_CD_J.bin (MegaCD JP BIOS)"
		ewarn
		elog "Optional:"
		elog "bios_E.sms (MasterSystem EU BIOS)"
		elog "bios_U.sms (MasterSystem US BIOS)"
		elog "bios_J.sms (MasterSystem JP BIOS)"
		elog "bios.gg (GameGear BIOS)"
		elog "sk.bin (Sonic & Knuckles (2 MiB) ROM)"
		elog "s2k.bin (Sonic & Knuckles UPMEM (256 KiB) ROM) = b4e76e416b887f4e7413ba76fa735f16"
		elog "areplay.bin (Action Replay (Pro) ROM)"
		elog "ggenie.bin (Game Genie ROM)"
		elog ""
		ewarn "This message will only be displayed once!"
		ewarn ""
	fi
}
