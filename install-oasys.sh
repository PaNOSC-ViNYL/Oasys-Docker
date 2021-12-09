#!/bin/bash
# ver 0.2 
# 31.01.2020
# author Marco De Simone marco.desimone@ceric-eric.eu

export DEBIAN_FRONTEND=noninteractive

if [ -x $(which lsb_release) ] ; then
  codename=`lsb_release -sc`
else # default fallback to bionic
  codename="bionic"
fi
curl http://xmi-apt.tomschoonjans.eu/xmi.packages.key | sudo apt-key add -
distributor=`lsb_release  -is| awk '{print tolower($0)}'`
#cat <<EOF >/etc/apt/sources.list.d/xraylib.list
#deb [arch=amd64] http://xmi-apt.tomschoonjans.eu/ubuntu ${codename} stable
#deb-src http://xmi-apt.tomschoonjans.eu/ubuntu ${codename} stable
#EOF
apt-get update 
#apt-cache policy xraylib
### from prepare script
# SCIPY
apt-get -y install libblas-dev liblapack-dev libatlas-base-dev build-essential
# MATPLOTLIB
apt-get -y install libfreetype6 libfreetype6-dev

# XRAYLIB
apt-get -y install swig
apt-get -y install htop
source /opt/conda/bin/activate
conda create --name oasys python=3.7
conda activate oasys
conda install -c conda-forge -y xraylib
conda install -c anaconda -y numba six numpy scipy matplotlib h5py openssl
conda env list
python -m pip install --no-cache-dir pyqt5 
python -m pip install --no-cache-dir resources --upgrade
python -m pip install --no-cache-dir numpy --upgrade
python -m pip install --no-cache-dir scipy --upgrade
python -m pip install --no-cache-dir matplotlib --upgrade
python -m pip install oasys1

cat > /tmp/reqs.txt <<EOF
LibWiser
WofryWiser
OASYS1-ShadowOui
OASYS1-SRW
OASYS1-XOPPY
OASYS1-Syned
OASYS1-WOFRY
OASYS1-ELETTRA-Extensions
OASYS1-OasysWiser
OASYS1-Panosc
EOF

# ho tolto
#OASYS1-XRayServer
# 21/09 - remove obsolete OASYS1-WISEr package
#OASYS1-WISEr


python -m pip install --no-cache-dir -r /tmp/reqs.txt

#echo ". /etc/profile.d/oasysenv.sh" >> ~/.bashrc && \
#echo ". /etc/profile.d/oasysenv.sh" >> /etc/bash.bashrc


apt-get remove --purge -y g++-7 gcc-7 manpages manpages*dev build-essential\
      && apt-get purge -y  lib*-dev \
      && apt-get -y clean 

find /opt/conda/ -follow -type f -name '*.a' -delete && \
find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
find /opt/conda/ -follow -type f -name '*.pyc' -delete && \
find /opt/conda/ -follow -type f -name '*.js.map' -delete &&\
#find /opt/conda/lib/python*/site-packages/bokeh/server/static -follow -type f -name '*.js' ! -name '*.min.js' -delete


rm -rf /root/.cache/pip
