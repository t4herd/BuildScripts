# cuda-toolkit installation guide
## remove previous version
sudo apt-get remove --purge nvidia-cuda-toolkit cuda*
sudo apt autoremove

## Install with apt
sudo apt update
sudo apt install cuda-toolkit-12-4
sudo apt install cuda-toolkit-11-8 cuda-toolkit-11-8-config-common

## Install from file
wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda_11.8.0_520.61.05_linux.run
sudo sh cuda_11.8.0_520.61.05_linux.run
sudo sh cuda_11.8.0_520.61.05_linux.run --no-drm --no-driver

sudo sh cuda_11.8.0_520.61.05_linux.run --silent --toolkit --samples --no-driver

Notes:
--silent skips interactive prompts.
--toolkit installs only CUDA toolkit.
--samples optional (installs example code).
--no-driver prevents overwriting your 550 driver.

## Check the installed version
nvcc --version

export CUDA_HOME=/usr/local/cuda-11.8
export PATH=$CUDA_HOME/bin:$PATH
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
