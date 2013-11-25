################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="plexht"
PKG_VERSION="RP-$RASPLEX_VERSION"
PKG_URL="https://github.com/RasPlex/plex-home-theatre/archive/$PKG_VERSION.zip"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.plexapp.com"
PKG_DEPENDS="boost Python zlib bzip2 systemd libass curl libssh rtmpdump fontconfig tinyxml freetype ffmpeg libmad libogg libmodplug faad2 flac libmpeg2 taglib yajl sqlite service.openelec.settings xbmc-addon-settings xbmc-addon-rasplex-updater htop"
PKG_BUILD_DEPENDS_TARGET="toolchain boost Python zlib bzip2 systemd lzo pcre swig  libass enca curl libssh ffmpeg rtmpdump fontconfig fribidi tinyxml libjpeg-turbo libpng tiff freetype jasper libmad libsamplerate libogg libcdio libmodplug faad2 flac libmpeg2 taglib yajl sqlite"

PKG_PRIORITY="optional"
PKG_SECTION="plex"
PKG_SHORTDESC="plexht: Plex Home Theater"
PKG_LONGDESC="Plex Home Theater, is blah blah blah blah"


# for dbus support
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET dbus"
  PKG_DEPENDS="$PKG_DEPENDS dbus"

# needed for hosttools (Texturepacker)
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET lzo:host SDL-host SDL_image-host"

# some python stuff needed for various addons
  PKG_DEPENDS="$PKG_DEPENDS Imaging"
  PKG_DEPENDS="$PKG_DEPENDS simplejson"
  PKG_DEPENDS="$PKG_DEPENDS pycrypto"

# various PVR clients
  PKG_DEPENDS="$PKG_DEPENDS xbmc-pvr-addons"
  PKG_DEPENDS="$PKG_DEPENDS xbmc-addon-xvdr"

if [ "$DISPLAYSERVER" = "xorg-server" ]; then
# for libX11 support
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET libX11 libXext"
  PKG_DEPENDS="$PKG_DEPENDS libX11 libXext"
# for libXrandr support
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET libXrandr"
  PKG_DEPENDS="$PKG_DEPENDS libXrandr"
  XBMC_XORG="--enable-x11 --enable-xrandr"
else
  XBMC_XORG="--disable-x11 --disable-xrandr"
fi

if [ "$OPENGL" = "Mesa" ]; then
# for OpenGL (GLX) support
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET Mesa glu glew"
  PKG_DEPENDS="$PKG_DEPENDS Mesa glu"
  XBMC_OPENGL="--enable-gl"
else
  XBMC_OPENGL="--disable-gl"
fi

if [ "$OPENGLES_SUPPORT" = yes ]; then
# for OpenGL-ES support
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET $OPENGLES"
  PKG_DEPENDS="$PKG_DEPENDS $OPENGLES"
  XBMC_OPENGLES="--enable-gles"
else
  XBMC_OPENGLES="--disable-gles"
fi

if [ "$SDL_SUPPORT" = yes ]; then
# for SDL support
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET SDL SDL_image"
  PKG_DEPENDS="$PKG_DEPENDS SDL SDL_image"
  XBMC_SDL="--enable-sdl"
else
  XBMC_SDL="--disable-sdl"
fi

if [ "$ALSA_SUPPORT" = yes ]; then
# for ALSA support
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET alsa-lib"
  PKG_DEPENDS="$PKG_DEPENDS alsa-lib"
  XBMC_ALSA="--enable-alsa"
else
  XBMC_ALSA="--disable-alsa"
fi

if [ "$CEC_SUPPORT" = yes ]; then
# for CEC support
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET libcec"
  PKG_DEPENDS="$PKG_DEPENDS libcec"
  XBMC_CEC="--enable-libcec"
else
  XBMC_CEC="--disable-libcec"
fi

if [ "$XBMC_SCR_RSXS" = yes ]; then
# for RSXS Screensaver support
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET libXt libXmu"
  XBMC_RSXS="--enable-rsxs"
# fix build of RSXS Screensaver support if not using libiconv
  export jm_cv_func_gettimeofday_clobber=no
else
  XBMC_RSXS="--disable-rsxs"
fi

if [ "$XBMC_VIS_PROJECTM" = yes ]; then
# for ProjectM Visualisation support
  XBMC_PROJECTM="--enable-projectm"
else
  XBMC_PROJECTM="--disable-projectm"
fi

if [ "$XBMC_VIS_GOOM" = yes ]; then
# for GOOM Visualisation support
  XBMC_GOOM="--enable-goom"
else
  XBMC_GOOM="--disable-goom"
fi

if [ "$JOYSTICK_SUPPORT" = yes ]; then
# for Joystick support
  XBMC_JOYSTICK="--enable-joystick"
else
  XBMC_JOYSTICK="--disable-joystick"
fi

if [ "$OPTICAL_DRIVE_SUPPORT" = yes ]; then
  XBMC_OPTICAL="--enable-optical-drive"
else
  XBMC_OPTICAL="--disable-optical-drive"
fi

if [ "$NONFREE_SUPPORT" = yes ]; then
# for non-free support
  XBMC_NONFREE="--enable-non-free"
else
  XBMC_NONFREE="--disable-non-free"
fi

if [ "$DVDCSS_SUPPORT" = yes ]; then
  XBMC_DVDCSS="--enable-dvdcss"
else
  XBMC_DVDCSS="--disable-dvdcss"
fi

if [ "$FAAC_SUPPORT" = yes ]; then
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET faac"
  PKG_DEPENDS="$PKG_DEPENDS faac"
fi

if [ "$ENCODER_LAME" = yes ]; then
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET lame"
  PKG_DEPENDS="$PKG_DEPENDS lame"
  XBMC_LAMEENC="--enable-libmp3lame"
else
  XBMC_LAMEENC="--disable-libmp3lame"
fi

if [ "$ENCODER_VORBIS" = yes ]; then
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET libvorbis"
  PKG_DEPENDS="$PKG_DEPENDS libvorbis"
  XBMC_VORBISENC="--enable-libvorbisenc"
else
  XBMC_VORBISENC="--disable-libvorbisenc"
fi

if [ "$BLURAY_SUPPORT" = yes ]; then
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET libbluray"
  PKG_DEPENDS="$PKG_DEPENDS libbluray"
  XBMC_BLURAY="--enable-libbluray"
else
  XBMC_BLURAY="--disable-libbluray"
fi

if [ "$AVAHI_DAEMON" = yes ]; then
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET avahi"
  PKG_DEPENDS="$PKG_DEPENDS avahi"
  XBMC_AVAHI="--enable-avahi"
else
  XBMC_AVAHI="--disable-avahi"
fi

if [ "$MYSQL_SUPPORT" = yes ]; then
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET mysql"
  PKG_DEPENDS="$PKG_DEPENDS mysql"
  XBMC_MYSQL="--enable-mysql"
else
  XBMC_MYSQL="--disable-mysql"
fi

if [ "$AIRPLAY_SUPPORT" = yes ]; then
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET libplist"
  PKG_DEPENDS="$PKG_DEPENDS libplist"
  XBMC_AIRPLAY="--enable-airplay"
else
  XBMC_AIRPLAY="--disable-airplay"
fi

if [ "$AIRTUNES_SUPPORT" = yes ]; then
  if [ "$XBMC" = master ]; then
    PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET libshairplay"
    PKG_DEPENDS="$PKG_DEPENDS libshairplay"
  else
    PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET libshairport"
    PKG_DEPENDS="$PKG_DEPENDS libshairport"
  fi
  XBMC_AIRTUNES="--enable-airtunes"
else
  XBMC_AIRTUNES="--disable-airtunes"
fi

if [ "$NFS_SUPPORT" = yes ]; then
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET libnfs"
  PKG_DEPENDS="$PKG_DEPENDS libnfs"
  XBMC_NFS="--enable-nfs"
else
  XBMC_NFS="--disable-nfs"
fi

if [ "$AFP_SUPPORT" = yes ]; then
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET afpfs-ng"
  PKG_DEPENDS="$PKG_DEPENDS afpfs-ng"
  XBMC_AFP="--enable-afpclient"
else
  XBMC_AFP="--disable-afpclient"
fi

if [ "$SAMBA_SUPPORT" = yes ]; then
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET samba"
  PKG_DEPENDS="$PKG_DEPENDS samba"
  XBMC_SAMBA="--enable-samba"
  XBMC_LIBS="$XBMC_LIBS -ltalloc -ltdb -ltevent -lwbclient"
else
  XBMC_SAMBA="--disable-samba"
fi

if [ "$WEBSERVER" = yes ]; then
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET libmicrohttpd"
  XBMC_WEBSERVER="--enable-webserver"
else
  XBMC_WEBSERVER="--disable-webserver"
fi

if [ "$UPNP_SUPPORT" = yes ]; then
  XBMC_UPNP="--enable-upnp"
else
  XBMC_UPNP="--disable-upnp"
fi

if [ "$SSHLIB_SUPPORT" = yes ]; then
  XBMC_SSH="--enable-ssh"
else
  XBMC_SSH="--disable-ssh"
fi

if [ ! "$XBMCPLAYER_DRIVER" = default ]; then
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET $XBMCPLAYER_DRIVER"
  PKG_DEPENDS="$PKG_DEPENDS $XBMCPLAYER_DRIVER"

  if [ "$XBMCPLAYER_DRIVER" = bcm2835-driver ]; then
    XBMC_OPENMAX="--enable-openmax"
    XBMC_PLAYER="--enable-player=omxplayer"
    XBMC_CODEC="--with-platform=raspberry-pi"
    BCM2835_INCLUDES="-I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads/ \
                      -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux"
    XBMC_CFLAGS="$XBMC_CFLAGS $BCM2835_INCLUDES"
    XBMC_CXXFLAGS="$XBMC_CXXFLAGS $BCM2835_INCLUDES"
  elif [ "$XBMCPLAYER_DRIVER" = "marvell-libgfx" ]; then
    PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET marvell-ipp"
    PKG_DEPENDS="$PKG_DEPENDS marvell-ipp"
    XBMC_OPENMAX="--disable-openmax"
    XBMC_PLAYER="--with-platform=marvell-dove"
    XBMC_CODEC=""
  elif [ "$XBMCPLAYER_DRIVER" = "libamlplayer-m1" -o "$XBMCPLAYER_DRIVER" = "libamlplayer-m3" ]; then
    XBMC_OPENMAX="--disable-openmax"
    XBMC_PLAYER="--enable-player=amlplayer"
    XBMC_CODEC="--enable-codec=amcodec"
    AMLPLAYER_INCLUDES="-I$SYSROOT_PREFIX/usr/include/amlplayer"
    XBMC_CFLAGS="$XBMC_CFLAGS $AMLPLAYER_INCLUDES"
    XBMC_CXXFLAGS="$XBMC_CXXFLAGS $AMLPLAYER_INCLUDES"

  else
    XBMC_OPENMAX="--disable-openmax"
  fi
fi

if [ "$VDPAU" = yes ]; then
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET libvdpau"
  PKG_DEPENDS="$PKG_DEPENDS libvdpau"
  XBMC_VDPAU="--enable-vdpau"
else
  XBMC_VDPAU="--disable-vdpau"
fi

if [ "$VAAPI" = yes ]; then
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET libva"
  PKG_DEPENDS="$PKG_DEPENDS libva"
  XBMC_VAAPI="--enable-vaapi"
else
  XBMC_VAAPI="--disable-vaapi"
fi

if [ "$XVBA" = yes ]; then
  get_graphicdrivers
  for drv in $GRAPHIC_DRIVERS; do
    if [ "$drv" = "fglrx" ]; then
      PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET xf86-video-fglrx"
    elif [ "$drv" = "fglrx-legacy" ]; then
      PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET xf86-video-fglrx-legacy"
    fi
  done
  XBMC_XVBA="--enable-xvba"
else
  XBMC_XVBA="--disable-xvba"
fi

if [ "$CRYSTALHD" = yes ]; then
  PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET crystalhd"
  PKG_DEPENDS="$PKG_DEPENDS crystalhd"
  XBMC_CRYSTALHD="--enable-crystalhd"
else
  XBMC_CRYSTALHD="--disable-crystalhd"
fi




pre_configure_target() {


set -x

MAKEFLAGS=-j1
strip_lto
LDFLAGS=`echo $LDFLAGS | sed -e "s|-Wl,--as-needed||"`
PACK_DIR=$ROOT/$BUILD/$PKG_NAME-$PKG_VERSION

cd "$ROOT/$BUILD"
cwd=`pwd`
[ -e $PACK_DIR ] && rm -rf $PACK_DIR
unzip -d "$ROOT/sources/$PKG_NAME/$PKG_VERSION" -o "$ROOT/sources/$PKG_NAME/$PKG_VERSION.zip" &> /dev/null
mv  $ROOT/sources/$PKG_NAME/$PKG_VERSION/*  $PACK_DIR
rm -rf $ROOT/$BUILD/$PKG_NAME-$PKG_VERSION/plex-home-theatre-$PKG_VERSION
cd $PACK_DIR
TOOLCHAIN_DIR="$ROOT/$BUILD/toolchain"
echo $TOOLCHAIN_DIR

cd "$ROOT/$BUILD/$PKG_NAME-$PKG_VERSION"

cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
      -DCMAKE_INSTALL_PREFIX=$INSTALL/usr \
      -DENABLE_PYTHON=on \
      -DSWIG_EXECUTABLE=$TOOLCHAIN_DIR/bin/swig \
      -DSWIG_DIR=$TOOLCHAIN_DIR \
      -DLIBUSBDIR=$SYSROOT_PREFIX/usr \
      -DOPTIONAL_INCLUDE_DIR=$SYSROOT_PREFIX/usr/include \
      -DCMAKE_INCLUDE_PATH="$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux;$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads;$TOOLCHAIN_DIR/armv6zk-openelec-linux-gnueabi/sysroot/usr/include/python2.7/" \
      -DRPI_EXTERNAL_PYTHON_HOME="$TOOLCHAIN_DIR/armv6zk-openelec-linux-gnueabi/sysroot/usr" \
      -DTARGET_PLATFORM=RPI \
      -DTARGET_RPI=1 \
      -DTARGET_PREFIX=$TARGET_PREFIX \
      -DSYSROOT_PREFIX=$SYSROOT_PREFIX \
      -DCMAKE_BUILD_TYPE=$CMAKE_BUILD_TYPE \
      $SRC_DIR




}

pre_build_target() {
# Do nothing
MAKEFLAGS=-j1

}

make_target() {

pwd
make VERBOSE=1


}

post_makeinstall_target() {


echo "sysroot: $SYSROOT_PREFIX"
echo "pkg dir: $PKG_DIR"
PYTHON_LIBDIR=`ls -d $SYSROOT_PREFIX/usr/lib/python*`
echo "$PYTHON_LIBDIR"
echo "pkg build: $PKG_BUILD"
echo "install $INSTALL"

mkdir -p $INSTALL/usr/bin
  cp $PKG_DIR/scripts/cputemp $INSTALL/usr/bin
  cp $PKG_DIR/scripts/gputemp $INSTALL/usr/bin

  cp $PKG_DIR/scripts/setwakeup.sh $INSTALL/usr/bin
  cp $PKG_BUILD/tools/EventClients/Clients/XBMC\ Send/xbmc-send.py $INSTALL/usr/bin/xbmc-send

mkdir -p $INSTALL/usr/lib/plexhometheater/system
  cp $PKG_BUILD/build/plex/plexhometheater $INSTALL/usr/lib/plexhometheater

cd $PKG_BUILD
find build/lib -not \( -name CMakeFiles -prune \) \
    -regextype posix-extended -type f \
    -not -iregex ".*svn.*|.*win32(dx)?\.vis|.*osx\.vis" \
    -iregex ".*-linux.*|.*-arm.*|.*\.vis|.*\.xbs" \
    -exec cp "{}" $INSTALL/usr/lib/plexhometheater/system/ ";"

  find system addons \
    -regextype posix-extended -type f \
    -not -iregex ".*svn.*|.*win32(dx)?\.vis|.*osx\.vis" \
    -iregex ".*-linux.*|.*-arm.*|.*\.vis|.*\.xbs" \
    -exec install -D "{}" $INSTALL/usr/lib/plexhometheater/"{}" ";"
  
  find addons language media sounds userdata system \
    -regextype posix-extended -type f \
    -not -iregex ".*-linux.*|.*-arm.*|.*\.vis|.*\.xbs|.*svn.*|.*\.orig|.*\.so|.*\.dll|.*\.pyd|.*python|.*\.zlib|.*\.conf" \
    -exec install -D -m 0644 "{}" $INSTALL/usr/share/xbmc/"{}" ";"
cd -

if [ ! "$XBMC_SCR_RSXS" = yes ]; then
  rm -rf $INSTALL/usr/share/xbmc/addons/screensaver.rsxs.*
fi

if [ ! "$XBMC_VIS_PROJECTM" = yes ]; then
  rm -rf $INSTALL/usr/share/xbmc/addons/visualization.projectm
fi



rm -rf $INSTALL/usr/share/xbmc/addons/visualization.dxspectrum
rm -rf $INSTALL/usr/share/xbmc/addons/visualization.itunes
rm -rf $INSTALL/usr/share/xbmc/addons/visualization.milkdrop
rm -rf $INSTALL/usr/share/xbmc/addons/script.module.pysqlite
rm -rf $INSTALL/usr/share/xbmc/addons/script.module.simplejson

  mkdir -p $INSTALL/usr/share/xbmc/addons
    cp -R $PKG_DIR/config/os.openelec.tv $INSTALL/usr/share/xbmc/addons
    $SED "s|@OS_VERSION@|$OS_VERSION|g" -i $INSTALL/usr/share/xbmc/addons/os.openelec.tv/addon.xml
    cp -R $PKG_DIR/config/repository.openelec.tv $INSTALL/usr/share/xbmc/addons
    $SED "s|@ADDON_URL@|$ADDON_URL|g" -i $INSTALL/usr/share/xbmc/addons/repository.openelec.tv/addon.xml

  mkdir -p $INSTALL/usr/lib/python"$PYTHON_VERSION"/site-packages/xbmc
    cp -R tools/EventClients/lib/python/* $INSTALL/usr/lib/python"$PYTHON_VERSION"/site-packages/xbmc



mkdir -p $INSTALL/usr/share/xbmc/system/
mkdir -p $INSTALL/usr/bin/

#cp $PKG_DIR/config/advancedsettings.xml $INSTALL/usr/share/xbmc/system/
#cp $PKG_DIR/config/advancedsettings.xml $INSTALL/usr/share/xbmc/
#cp $PKG_DIR/config/guisettings.xml $INSTALL/usr/share/xbmc/system/
#cp $PKG_DIR/config/guisettings.xml $INSTALL/usr/share/xbmc/


}

