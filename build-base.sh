#/bin/bash
# 02/12/2019
# author Marco De Simone marco.desimone@ceric-eric.eu

export DEBIAN_FRONTEND=noninteractive

aptsource="/etc/apt/sources.list.d"
apt-get update && apt-get upgrade -y
apt-get install -y tzdata 
# set your timezone
ln -fs /usr/share/zoneinfo/Europe/Rome /etc/localtime
apt-get install -y apt-transport-https ca-certificates curl software-properties-common sudo gnupg  \
                   bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 git mercurial subversion findutils \
                   libglu1-mesa-dev freeglut3-dev mesa-common-dev libgl1 libxcb* qt5dxcb-plugin



dpkg-reconfigure --frontend noninteractive tzdata

TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'`
curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > /tmp/tini.deb  \
&& dpkg -i /tmp/tini.deb \
&& rm /tmp/tini.deb  


umask 0000
curl -sSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh && \
    /bin/bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    chmod 644 /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> /etc/bash.bashrc  && \
    echo "conda activate base" >>/etc/bash.bashrc


USERNAME=oasys
useradd -m $USERNAME && \
echo "$USERNAME:$USERNAME" | chpasswd && \
usermod --shell /bin/bash $USERNAME && \
usermod -aG sudo $USERNAME && \
echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
chmod 0440 /etc/sudoers.d/$USERNAME && \
usermod  --uid 1000 $USERNAME && \
groupmod --gid 1000 $USERNAME #&& \


. /etc/profile
/opt/conda/bin/conda update --all -y
conda activate base

#curl http://xmi-apt.tomschoonjans.eu/xmi.packages.key | sudo apt-key add -
#distributor=`lsb_release  -is| awk '{print tolower($0)}'`
#cat <<EOF >/etc/apt/sources.list.d/xraylib.list
#deb [arch=amd64] http://xmi-apt.tomschoonjans.eu/ubuntu ${codename} stable
#deb-src http://xmi-apt.tomschoonjans.eu/ubuntu ${codename} stable
#EOF
#apt-get update 
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
conda install -c anaconda -y numba six
conda install -c conda-forge -y xraylib 
conda env list
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


python -m pip install --no-cache-dir -r /tmp/reqs.txt




rm -rf /root/.cache/pip

apt-get -y clean 
find /opt/conda/ -follow -type f -name '*.a' -delete && \
find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
find /opt/conda/ -follow -type f -name '*.pyc' -delete && \
find /opt/conda/ -follow -type f -name '*.js.map' -delete &&\
#find /opt/conda/lib/python*/site-packages/bokeh/server/static -follow -type f -name '*.js' ! -name '*.min.js' -delete


rm -rf /var/log && mkdir /var/log
rm -rf /root/.cache


rm -rf /root/.cache
rm -rf /var/cache/debconf/*-old
rm -rf /var/lib/apt/lists/*
rm -rf /root/.cache


