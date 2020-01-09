cd ~/
git clone https://github.com/intel/linux-sgx.git
cd linux-sgx
./download_prebuilt.sh
make sdk
make sdk_install_pkg

sudo echo "yes" | ./linux/installer/bin/sgx_linux_x64_sdk_*.bin 
sudo cp -rf sgxsdk /opt/intel/
source /opt/intel/environment

make psw
make deb_pkg

sudo dpkg -i linux/installer/deb/libsgx-enclave-common_*-*_amd64.deb 
sudo dpkg -i linux/installer/deb/libsgx-urts_*-*_amd64.deb
sudo dpkg -i linux/installer/deb/libsgx-enclave-common-dev_*-*_amd64.deb 

cd ~/

git clone https://github.com/intel/SGXDataCenterAttestationPrimitives.git
cd SGXDataCenterAttestationPrimitives/QuoteGeneration && ./download_prebuilt.sh && make

#sudo dpkg -i  installer/linux/deb/libsgx-ae-pce_*-*_amd64.deb
#sudo dpkg -i  installer/linux/deb/libsgx-ae-qe3_*-*_amd64.deb
#sudo dpkg -i  installer/linux/deb/libsgx-ae-qve_*-*_amd64.deb
sudo dpkg -i installer/linux/deb/libsgx-dcap-ql_*-*_amd64.deb
sudo dpkg -i installer/linux/deb/libsgx-dcap-ql-dev_*-*_amd64.deb

cd ~/
git clone https://github.com/openenclave/openenclave.git
sudo openenclave/scripts/ansible/install-ansible.sh
sudo ansible-playbook openenclave/scripts/ansible/oe-vanilla-prelibsgx-setup.yml

mkdir build && cd build && cmake -G "Unix Makefiles" .. && make && ctest