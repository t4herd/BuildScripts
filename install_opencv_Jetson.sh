#!/bin/bash
#
# Copyright (c) 2022, NVIDIA CORPORATION.  All rights reserved.
#
# NVIDIA Corporation and its licensors retain all intellectual property
# and proprietary rights in and to this software, related documentation
# and any modifications thereto.  Any use, reproduction, disclosure or
# distribution of this software and related documentation without an express
# license agreement from NVIDIA Corporation is strictly prohibited.
#
# Modified: t4her 20251204

version="4.5.5"
folder="opencv"

for (( ; ; ))
do
    echo "Do you want to remove the default OpenCV (yes/no)?"
    read rm_old

    if [ "$rm_old" = "yes" ]; then
        echo "** Remove other OpenCV first"
        sudo apt -y purge *libopencv*
	break
    elif [ "$rm_old" = "no" ]; then
	break
    fi
done


echo "------------------------------------"
echo "** Install requirement (1/4)"
echo "------------------------------------"
sudo apt update
sudo apt install -y \
		build-essential cmake git unzip pkg-config \
		libgtk2.0-dev libgtk-3-dev libcanberra-gtk* \
		libgl1-mesa-dev libglu1-mesa-dev libegl1-mesa-dev freeglut3-dev \
		libavcodec-dev libavformat-dev libavutil-dev libavresample-dev libswscale-dev \
		libdc1394-22-dev libv4l-dev v4l-utils qv4l2 \
		libxvidcore-dev libx264-dev libjpeg-dev libjpeg8-dev libjpeg-turbo8-dev libpng-dev libtiff-dev libtiff5-dev libopenexr-dev \
		libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-good1.0-dev \
		libtbb2 libtbb-dev \
		libeigen3-dev libatlas-base-dev libopenblas-dev liblapack-dev liblapacke-dev libblas-dev gfortran \
		python-dev python-numpy python3-dev python3-numpy python3-py python3-pytest python3-matplotlib \
		curl libprotobuf-dev protobuf-compiler \
		libgoogle-glog-dev libgflags-dev libglew-dev \
		libopencore-amrnb-dev libopencore-amrwb-dev libfaac-dev libmp3lame-dev libtheora-dev libvorbis-dev libxine2-dev \
		libpostproc-dev libtesseract-dev zlib1g-dev libopenjp*



echo "------------------------------------"
echo "** Download opencv "${version}" (2/4)"
echo "------------------------------------"
# mkdir $folder
# cd ${folder}
#curl -L https://github.com/opencv/opencv/archive/${version}.zip -o opencv-${version}.zip
#curl -L https://github.com/opencv/opencv_contrib/archive/${version}.zip -o opencv_contrib-${version}.zip
#unzip opencv-${version}.zip
#unzip opencv_contrib-${version}.zip
#rm opencv-${version}.zip opencv_contrib-${version}.zip
cd opencv-${version}/


echo "------------------------------------"
echo "** Build opencv "${version}" (3/4)"
echo "------------------------------------"
mkdir release
cd release/
cmake -D WITH_CUDA=ON -D WITH_CUDNN=ON -D CUDNN_VERSION="8.0" -D CUDA_ARCH_BIN="7.2" -D CUDA_ARCH_PTX="7.2" -D OPENCV_GENERATE_PKGCONFIG=ON -D WITH_GSTREAMER=ON -D WITH_LIBV4L=ON -D CMAKE_CXX_STANDARD=17 -D ENABLE_CXX11=OFF -D ENABLE_FAST_MATH=ON -D CUDA_FAST_MATH=ON -D WITH_CUBLAS=ON -D OPENCV_DNN_CUDA=ON -D BUILD_opencv_dnn=ON -D WITH_V4L=ON -D WITH_QT=OFF -D WITH_OPENGL=ON -D WITH_EIGEN=ON -D WITH_TBB=ON -D WITH_OPENMP=ON -D BUILD_opencv_python3=ON -D BUILD_opencv_python2=OFF -D BUILD_opencv_world=OFF -D EIGEN_INCLUDE_PATH=/usr/include/eigen3 -D ENABLE_NEON=ON -D WITH_OPENCL=ON -D CPU_DISPATCH=NEON -D WITH_1394=OFF -D WITH_GTK=ON -D OPENCV_ENABLE_NONFREE=ON -D WITH_LAPACK=ON -D OpenBLAS_INCLUDE_DIR=/usr/include/aarch64-linux-gnu/openblas-pthread -D OpenBLAS_LIB=/usr/lib/aarch64-linux-gnu/libopenblas.so -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_EXAMPLES=OFF -D CMAKE_BUILD_TYPE=RELEASE -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-${version}/modules -D CMAKE_INSTALL_PREFIX=/usr/local ..

make -j$(nproc)


echo "------------------------------------"
echo "** Install opencv "${version}" (4/4)"
echo "------------------------------------"
sudo make install
sudo ldconfig
echo 'export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
echo 'export PYTHONPATH=/usr/local/lib/python3.8/site-packages/:$PYTHONPATH' >> ~/.bashrc
source ~/.bashrc


echo "** Install opencv "${version}" successfully"
echo "** Bye :)"