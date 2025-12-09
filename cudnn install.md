# cuDNN installation guide

## Remove CUDA packages (if installed via apt)
```
sudo apt-get purge 'cuda*' 'libcudnn*'
sudo apt-get autoremove
sudo apt-get autoclean

sudo rm -rf /usr/local/cuda*
```

## .deb method
```
wget https://developer.nvidia.com/downloads/compute/cudnn/secure/8.9.7/local_installers/11.x/cudnn-local-repo-ubuntu2204-8.9.7.29_1.0-1_amd64.deb/
sudo dpkg -i cudnn-local-repo-ubuntu2204-8.9.7.29_1.0-1_amd64.deb
sudo cp /var/cudnn-local-repo-ubuntu2204-8.9.7.29/cudnn-*-keyring.gpg /usr/share/keyrings/

sudo apt-get update
sudo apt-get -y install cudnn8-cuda-11
```

## Tarball method
```
tar -xzvf cudnn-linux-x86_64-8.9.7.29_cuda11-archive.tar.xz
sudo cp cuda/include/cudnn*.h /usr/local/cuda/include
sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
```
```
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
source ~/.bashrc
```
