#!/bin/bash
#
# Author: t4her
# Brief: Build Qt from source. You should have Qt Creator v14.0.2 (higher versions dont run because of gcc version on jetsons) installed on jetson then use Qt as kit.
# Date: 20251126
# Last modified: 20251209

version="5.15.12"
installpath=~/Qt/${version}


echo "------------------------------------"
echo "** Install requirement (1/4)"
echo "------------------------------------"
sudo apt-get update
sudo apt install -y \
	build-essential perl git python3 pkg-config ninja-build \
	llvm llvm-dev clang libclang-dev clazy \
	libssl-dev \
	libxext-dev libxfixes-dev libxi-dev libxrender-dev libxrandr-dev libxcursor-dev libxinerama-dev libx11-dev libxcb1-dev libxcb-util0-dev libxcb-xinerama0-dev libxcb-keysyms1-dev libxcb-image0-dev libxcb-shm0-dev libxcb-icccm4-dev libxcb-sync-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-randr0-dev libxcb-render-util0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev mesa-common-dev libglu1-mesa-dev \
	libgtk-3-dev libglib2.0-dev libglfw3 libglfw3-dev libgles2* libgl1* libegl1* libglx* \
	libswt-glx-gtk-4-jni libva-glx2 lsp-plugins* rss-glx \
	libfontconfig1* libfreetype* \
	libwayland-dev libwayland-egl-backend-dev libwayland-cursor0 libwayland-dev \
	libpng-dev libjpeg-dev libxcomposite-dev libxdamage-dev libxv-dev libsm-dev \
    	zlib1g-dev libopenjp* \
    	flex bison gperf libicu-dev libxslt-dev ruby libdbus-1-dev libatspi2.0-dev \
    	libsqlite3-dev libproxy-dev libudev-dev libinput-dev libmtdev-dev libts-dev \
	libasound2-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-good1.0-dev libgstreamer-plugins-bad1.0-dev \
	libusb-1.0-0-dev libftdi1-dev libmad0-dev libsndfile1-dev libfftw3-dev
	

echo "------------------------------------"
echo "**   Download Qt "${version}"  (2/4)"
echo "------------------------------------"
#tar -xzf qt-everywhere-opensource-src-${version}.tar.xz
cd qt-everywhere-src-${version}/


echo "------------------------------------"
echo "**    Build Qt "${version}"    (3/4)"
echo "------------------------------------"
mkdir -p build
cd build/
export LLVM_INSTALL_DIR=$(llvm-config --prefix)
../configure -prefix ${installpath} -release -opensource -confirm-license -platform linux-g++ -qt-zlib -qt-libpng -qt-webp -qt-libjpeg -fontconfig -system-freetype -opengl desktop -qpa xcb -feature-vulkan -gstreamer 1.0 -skip qt3d -skip qtdatavis3d -skip qtlottie -skip qtwinextras -skip qtmacextras -skip qtandroidextras -skip qtgamepad -skip qtnetworkauth -skip qtpurchasing -skip qtremoteobjects -skip qtscript -skip qtspeech -skip qtvirtualkeyboard -skip qtsensors -skip qtwayland -skip qtwebengine -skip qtwebglplugin -skip qtwebchannel -skip qtwebview -make libs -make tools -nomake examples -nomake tests

make -j$(nproc)
#make -j$(nproc) docs

echo "------------------------------------"
echo "**  Install Qt "${version}"    (4/4)"
echo "------------------------------------"
make install
#make install_docs
sudo ldconfig
echo 'export PATH='${installpath}'/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH='${installpath}'/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc


echo "** Install Qt"${version}" successfully"
echo "** Bye :)"