#!/bin/bash

# Copyright (C) 2014 - Sebastien Alaiwan
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 3
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

function freetype2_build {
  host=$1
  pushDir $WORK/src

  lazy_download "freetype2.tar.bz2" "http://download.savannah.gnu.org/releases/freetype/freetype-2.7.1.tar.bz2"
  lazy_extract "freetype2.tar.bz2"
  mkgit "freetype2"

  pushDir "freetype2"
  freetype2_patches
  popDir

  autoconf_build $host "freetype2" \
    "--without-png" \
    "--enable-shared" \
    "--disable-static"

  popDir
}

function freetype2_get_deps {
  echo zlib
}

function freetype2_patches {
  local patchFile=$scriptDir/patches/freetype2_01_pkgconfig.diff
  cat << 'EOF' > $patchFile
diff --git a/builds/unix/freetype2.in b/builds/unix/freetype2.in
index c4dfda4..97f256e 100644
--- a/builds/unix/freetype2.in
+++ b/builds/unix/freetype2.in
@@ -7,7 +7,7 @@ Name: FreeType 2
 URL: http://freetype.org
 Description: A free, high-quality, and portable font engine.
 Version: %ft_version%
-Requires:
+Requires: %REQUIRES_PRIVATE%
 Requires.private: %REQUIRES_PRIVATE%
 Libs: -L${libdir} -lfreetype
 Libs.private: %LIBS_PRIVATE%
EOF

  applyPatch $patchFile
}
