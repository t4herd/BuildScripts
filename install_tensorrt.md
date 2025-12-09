# TensorRT installation guide
## Install from file
wget https://developer.nvidia.com/downloads/compute/machine-learning/tensorrt/secure/8.6.1/tars/TensorRT-8.6.1.6.Linux.x86_64-gnu.cuda-11.8.tar.gz

tar -xvzf TensorRT-8.6.1.6.Linux.x86_64-gnu.cuda-11.8.tar.gz

//sudo mkdir -p /usr/local/TensorRT-8
sudo cp -r TensorRT-8.6.1.6 /usr/local/

cd /usr/local/TensorRT-8.6/python
python -m pip install tensorrt-*-cp310-none-linux_x86_64.whl

export TRT_ROOT=/usr/local/TensorRT-8.6
export LD_LIBRARY_PATH=$TRT_ROOT/lib:$LD_LIBRARY_PATH
export PATH=$TRT_ROOT/bin:$PATH
export CPATH=$TRT_ROOT/include:$CPATH
