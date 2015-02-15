#!/bin/bash

# Copyright (C) 2014 - Romain Bouqueau
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


function fontconfig_build {
  host=$1
  pushDir $WORK/src

  lazy_download "fontconfig.tar.bz2" "http://www.freedesktop.org/software/fontconfig/release/fontconfig-2.11.92.tar.bz2"
  lazy_extract "fontconfig.tar.bz2"
  mkgit "fontconfig"

  LDFLAGS+=" -L$WORK/release/$host/lib" \
  autoconf_build $host "fontconfig" \
    --enable-static \
    --disable-shared
  popDir
}

function fontconfig_get_deps {
  echo "expat"
  echo "freetype2"
  echo "libpng"
}

