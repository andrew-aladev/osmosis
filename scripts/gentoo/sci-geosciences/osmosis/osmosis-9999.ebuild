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
    mysql? ( dev-java/jdbc-mysql )
    postgres? ( dev-java/jdbc-postgresql )
"
DEPEND="${RDEPEND}"

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
    ./gradlew install
}
