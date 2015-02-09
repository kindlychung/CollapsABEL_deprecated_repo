#!/usr/bin/env bash

# install required packages
if [[ $(uname -a) == *"Ubuntu"* ]]; then
    sudo apt-get -y build-dep libcurl4-gnutls-dev
    sudo apt-get -y install libcurl4-gnutls-dev
    sudo apt-get -y install \
        r-base git \
        libboost-system-dev libboost-filesystem-dev libboost-program-options-dev \
        libarpack2-dev liblapack-dev libatlas-dev libopenblas-dev \
        cmake
elif [[ $(ls /etc/*-release) == *"fedora-release"*  ]]; then
    sudo yum -y install \
        R git libcurl libcurl-devel \
        boost-system boost-filesystem boost-program-options \
        lapack arpack atlas openblas \
        lapack-devel arpack-devel atlas-devel openblas-devel \
        cmake
elif [[ $(ls /etc/*-release) == *"SuSE-release"*  ]]; then
    sudo zypper -n install \
        R-base libcurl4 libcurl-devel git \
        libboost_system* libboost_filesystem* libboost_program_options* \
        liblapack* lapack-devel \
        libarpack* arpack-ng-devel \
        libatlas3 libatlas3-devel  \
        libopenblas* openblas-devel \
        cmake
else
    echo "Linux distribution not recognized."
    exit
fi

# install armadillo library
cd /tmp
wget http://sourceforge.net/projects/arma/files/armadillo-4.600.4.tar.gz
tar zvxf armadillo-4.600.4.tar.gz
cd armadillo-4.600.4/
cmake .
make
sudo make install

# install bedcoll
cd /tmp
git clone https://kindlychung@bitbucket.org/kindlychung/bedcoll.git
cd bedcoll/
./build.sh
sudo cp bedcoll /usr/local/bin/

