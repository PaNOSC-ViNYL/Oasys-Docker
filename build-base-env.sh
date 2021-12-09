#/bin/bash
# ver 0.4
# 09/01/2020
# author Marco De Simone marco.desimone@ceric-eric.eu

export DEBIAN_FRONTEND=noninteractive

MINICONDA="Miniconda3-latest-Linux-x86_64.sh"
aptsource="/etc/apt/sources.list.d"
export PATH=/opt/conda/bin:$PATH
apt-get update && apt-get upgrade -y
apt-get install -y curl xauth
umask 0000
curl -sSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh && \
    /bin/bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    chmod 644 /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> /etc/bash.bashrc  && \
    echo "conda activate base" >>/etc/bash.bashrc


. /etc/profile
/opt/conda/bin/conda update --all -y
conda activate base
# conda install -y numpy scipy numexpr matplotlib pandas h5py ncurses
# conda install -y -c intel mkl
#conda install -y -c conda-forge tifffile pyopengl lmfit
conda update  -c anaconda --all -y
# conda install -y -c anaconda spyder
# conda install -y -c anaconda xarray netcdf4  openpyxl xlsxwriter xlrd dask
# conda install -y -c anaconda cython numba six
# conda install -y -c conda-forge tifffile lmfit ipympl h5netcdf  nodejs=10 ipywidgets
# python3 -mpip install pyabel
#conda install -y -c conda-forge nodejs=10 ipywidgets=
# conda create -y -n PyMca python=3.6
# conda activate PyMca
# conda install -y -c conda-forge matplotlib=3.2.1
# conda install -y -c conda-forge cython fisx numpy
# conda install -y -c conda-forge pymca silx
# python -m PyMca5.tests.TestAll
# conda  clean -afy
#python -m pip install pymca
### install tomogui + freeart
#python -m pip install pyopencl
#cd /tmp 
#git clone https://gitlab.esrf.fr/freeart/freeart.git
#apt-get install -y build-essential
#cd /tmp/freeart 
#python -m pip install .
#python -m pip install tomogui
#cd /tmp
#rm -rf /tmp/*
### end install tomogui + freeart
umask 0022

mkdir /net && mkdir /tmp/.X11-unix && chmod 1777  /tmp/.X11-unix

apt-get -y autoremove --purge
apt-get -y clean 
find /opt/conda/ -follow -type f -name '*.a' -delete && \
find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
find /opt/conda/ -follow -type f -name '*.pyc' -delete && \
find /opt/conda/ -follow -type f -name '*.js.map' -delete &&\
#find /opt/conda/lib/python*/site-packages/bokeh/server/static -follow -type f -name '*.js' ! -name '*.min.js' -delete


rm -rf /var/log && mkdir /var/log
rm -rf /root/.cache
