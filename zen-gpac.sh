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

function gpac_build {
  host=$1
  pushDir $WORK/src

  svn co svn://svn.code.sf.net/p/gpac/code/trunk/gpac gpac -r 5600
  pushDir gpac
  svn revert -R .
  popDir

# local ARCH=$(get_arch $host)
  local OS=$(get_os $host)
  local crossPrefix=$(get_cross_prefix $BUILD $host)

  # GPAC needs uppercase os name, e.g "MINGW32".
  OS=${OS^^}

  mkdir -p gpac/build/$host
  pushDir gpac/build/$host
  ../../configure \
    --target-os=$OS \
    --prefix=$PREFIX/$host \
    --extra-cflags="-I$PREFIX/$host/include -w -fPIC" \
    --extra-ldflags="-L$PREFIX/$host/lib" \
    --disable-jack \
    --enable-amr \
    --cross-prefix="$crossPrefix"

  $MAKE
  $MAKE install
  popDir

  popDir
}

function gpac_get_deps {
  echo opencore-amr
  echo zlib
  echo libsdl
  echo freetype2
  echo libvorbis
  echo libogg
}

