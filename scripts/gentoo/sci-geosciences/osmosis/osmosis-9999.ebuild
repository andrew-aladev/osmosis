# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit java-pkg-2 git-2

DESCRIPTION="Osmosis is a command line java app for processing OSM data."
HOMEPAGE="https://github.com/andrew-aladev/osmosis"
EGIT_REPO_URI="https://github.com/andrew-aladev/osmosis.git"

LICENSE="Unknown Apache-2.0"
SLOT="0"
KEYWORDS=""

IUSE="mysql postgres"

RDEPEND="
    app-arch/tar
    app-arch/gzip
    mysql? ( dev-java/jdbc-mysql )
    postgres? ( dev-java/jdbc-postgresql )
"
DEPEND="${RDEPEND}"

src_unpack() {
    git-2_src_unpack
}

pkg_setup() {
    if ! use mysql && ! use postgres; then
        ewarn "If you use neither the mysql nor the postgres USE-flags"
        ewarn "you will have no support for databases"
    fi
}

src_compile() {
    ./gradlew clean && ./gradlew assemble || die "gradle build failed"
}

src_install() {
    mkdir "${D}/opt/osmosis" \
      && tar zxvf package/build/distribution/osmosis*.tgz -C "${D}/opt/osmosis" \
      || die "archive unpack to ${D}/opt/osmosis failed"
    dodir "${D}/opt/osmosis" || die "installation to ${D}/opt failed"
    dosym "${D}/opt/osmosis/bin/osmosis" "${D}/usr/bin/osmosis" || die "symlink to ${D}/usr/bin failed"
}
