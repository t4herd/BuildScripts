#!/bin/bash
#
# Author: t4her
# Brief: Build Qt from source. You should have Qt Creator v14.0.2 installed on jetson then use Qt as kit.
# Date: 20251126
# Last modified: 20251129

version="5.15.12"
folder="Qt"
installpath=~/Qt/${version}


echo "------------------------------------"
echo "** Install requirement (1/4)"
echo "------------------------------------"
sudo apt-get update
sudo apt install -y \
	build-essential perl git python3 pkg-config cmake-qt-gui ninja-build qtbase5-dev \
	llvm llvm-dev clang libclang-dev clazy \
	libssl-dev \
	libxext-dev libxfixes-dev libxi-dev libxrender-dev libxrandr-dev libxcursor-dev libxinerama-dev libxkb* libx11* libxcb* \
	libgtk-3-dev libglib2.0-dev libglu1-mesa-dev libglfw3* libgles2* libgl1* libegl1* libglx* \
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
mkdir build
cd build/
export LLVM_INSTALL_DIR=/usr/lib/llvm-9
../configure  -prefix ${installpath} -release -opensource -confirm-license -platform linux-g++ -doc -qt-zlib -qt-libpng -qt-webp -qt-libjpeg -feature-fontconfig -fontconfig -system-freetype -opengl desktop -feature-vulkan -gstreamer 1.0 -skip qt3d -skip qtdatavis3d -skip qtlottie -skip qtmacextras -skip qtnetworkauth -skip qtpurchasing -skip qtremoteobjects -skip qtscript -skip qtspeech -skip qtvirtualkeyboard -skip qtandroidextras -skip qtsensors -skip qtwayland -skip qtwebengine -skip webchannel -skip webengine -skip qtwebglplugin -skip qtwebchannel -skip qtwebview -make libs -make tools -nomake examples -nomake tests

make -j$(nproc)


echo "------------------------------------"
echo "**  Install Qt "${version}"    (4/4)"
echo "------------------------------------"
sudo make install
sudo ldconfig
echo 'export PATH='${instalpath}'/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH='${instalpath}'/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc


echo "** Install Qt"${version}" successfully"
echo "** Bye :)"