# Copyright 2016 Daniel 'herrnst' Scheller
# Based on sys-kernel/gentoo-sources, copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="1"
K_DEBLOB_AVAILABLE="0"
K_KDBUS_AVAILABLE="0"

inherit kernel-2
detect_version
detect_arch

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
HOMEPAGE="https://dev.gentoo.org/~mpagano/genpatches"
IUSE="experimental dddvb-api-extra"

DDBRIDGE_PATCHES_BASE_URI="https://github.com/herrnst/dddvb-linux-kernel/compare/v${KV_MAJOR}.${KV_MINOR}...v${KV_MAJOR}.${KV_MINOR}.0-ddbridge.diff -> linux-${KV_MAJOR}.${KV_MINOR}-ddbridge-base.patch"
DDBRIDGE_PATCHES_FEATURES_URI="https://github.com/herrnst/dddvb-linux-kernel/compare/v${KV_MAJOR}.${KV_MINOR}.0-ddbridge...v${KV_MAJOR}.${KV_MINOR}.0-ddbridge-features.diff -> linux-${KV_MAJOR}.${KV_MINOR}-ddbridge-features.patch"

DESCRIPTION="Full sources including the Gentoo patchset and Digital Devices drivers for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${DDBRIDGE_PATCHES_BASE_URI} ${DDBRIDGE_PATCHES_FEATURES_URI}"

src_unpack() {
	UNIPATCH_LIST+=" "${DISTDIR}"/linux-${KV_MAJOR}.${KV_MINOR}-ddbridge-base.patch"

	if use dddvb-api-extra ; then
		UNIPATCH_LIST+=" "${DISTDIR}"/linux-${KV_MAJOR}.${KV_MINOR}-ddbridge-features.patch"
	fi

	kernel-2_src_unpack
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
