# nvidia-driver
## 1
sudo apt remove --purge 'nvidia-*' 'libnvidia-*' 'cuda*'
sudo apt autoremove --purge
sudo rm -rf /usr/local/cuda*
sudo rm -rf /etc/apt/sources.list.d/cuda*
sudo rm -rf /etc/apt/sources.list.d/nvidia*
sudo rm -rf /var/cuda*
sudo rm -rf /var/lib/apt/lists/*
sudo rm -f /usr/share/keyrings/cuda-*-keyring.gpg
sudo rm -f /usr/share/keyrings/nvidia-*-keyring.gpg

sudo rm -rf /var/lib/apt/lists/*
sudo mkdir -p /var/lib/apt/lists/partial

apt-cache policy | grep 580
apt-cache policy libnvidia-compute-580

sudo apt clean
sudo apt update

apt list -a nvidia-driver-550

sudo apt install linux-headers-$(uname -r)

sudo apt-get install wget gnupg
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt update

sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update

sudo apt install --no-install-recommends nvidia-driver-550 nvidia-dkms-550 nvidia-utils-550 nvidia-settings=550.163.01-0ubuntu1

sudo reboot

sudo apt-mark hold nvidia-driver-550 nvidia-dkms-550 nvidia-utils-550 nvidia-settings

## 2
### Remove NVIDIA drivers and CUDA packages and any leftovers
sudo apt-get purge 'nvidia-*' 'cuda*' 'libcudnn*'
sudo apt-get autoremove
sudo apt-get autoclean
sudo rm -rf /usr/local/cuda*

wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda_11.8.0_520.61.05_linux.run
chmod +x cuda_11.8.0_520.61.05_linux.run

sudo apt-get install build-essential dkms freeglut3-dev libxi-dev libxmu-dev libglu1-mesa-dev libx11-dev libxext-dev

sudo sh cuda_11.8.0_520.61.05_linux.run

### install drivers using cuda installer

## 3
sudo apt purge 'nvidia-*' 'cuda-*'
sudo apt autoremove --purge
sudo rm -rf /usr/local/cuda*
sudo reboot

sudo add-apt-repository ppa:graphics-drivers/ppa -y
sudo apt update

sudo apt install nvidia-driver-520
sudo reboot


## Check the installed version
nvidia-smi
