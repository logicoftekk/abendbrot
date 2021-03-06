# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 gnome2-utils

DESCRIPTION="Papirus customization for KDE distros"
HOMEPAGE="https://github.com/varlesh/papirus-pack-kde"
SRC_URI=""
EGIT_REPO_URI="git://github.com/varlesh/papirus-pack-kde.git"
LICENSE="CC-BY-SA-4.0 GPL-3"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+aurorae-themes +color-scheme gtk-themes +icons kmail-theme +konsole-colorscheme +plasma-themes +yakuake-skins"

DEPEND="aurorae-themes? ( || ( kde-plasma/kwin kde-base/kwin ) )
	icons? ( kde-plasma/breeze:5
		kde-frameworks/oxygen-icons:* )
	gtk-themes? ( x11-themes/gtk-engines-murrine
		    x11-libs/gtk+:3 )
	kmail-theme? ( || ( kde-apps/kdepim:5[kdepim_features_kmail] kde-base/kmail ) )
	konsole-colorscheme? ( kde-apps/konsole:* )
	yakuake-skins? ( kde-misc/yakuake:* )"
RDEPEND="${DEPEND}"

src_install() {
	if use aurorae-themes; then
		insinto /usr/share/aurorae/themes
		doins -r aurorae-themes/Papirus
		doins -r aurorae-themes/PapirusDark
	fi
	if use color-scheme; then
		insinto /usr/share/color-schemes/
		doins color-schemes/Papirus.colors
		doins color-schemes/PapirusDark.colors
	fi
	if use gtk-themes; then
		insinto /usr/share/themes/
		doins -r gtk-themes/papirus
		doins -r gtk-themes/papirus-dark
	fi
	if use icons; then
		insinto /usr/share/icons/
		doins -r icons/papirus
		doins -r icons/papirus-dark
		doins -r icons/papirus-black-panel
	fi
	if use kmail-theme; then
		insinto /usr/share/messageviewer/themes/
		doins -r kmail-theme/papirus
		doins -r kmail-theme/papirus-dark
	fi
	if use konsole-colorscheme; then
		insinto /usr/share/konsole
		doins konsole-colorschemes/Papirus.colorscheme
		doins "konsole-colorschemes/Papirus Dark.colorscheme"
	fi
	if use plasma-themes; then
		insinto /usr/share/plasma/desktoptheme/
		doins -r plasma-themes/papirus
		doins -r plasma-themes/papirus-dark
	fi
	if use yakuake-skins; then
		insinto /usr/share/yakuake/skins/
		doins -r yakuake-skins/papirus
		doins -r yakuake-skins/papirus-dark
	fi
	if use color-scheme && use icons && use plasma-themes; then
		insinto /usr/share/plasma/look-and-feel/
		doins -r look-and-feel/com.github.varlesh.papirus
		doins -r look-and-feel/com.github.varlesh.papirus-dark
	fi
	dodoc README.md
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
