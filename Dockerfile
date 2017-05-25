FROM jupyter/scipy-notebook

USER root

RUN apt-get update && \
	apt-get install -y \
        build-essential \
        cmake \
        git \
        wget \
        unzip \
        yasm \
        pkg-config \
        libswscale-dev \
        libtbb2 \
        libtbb-dev \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \
        libjasper-dev \
        libavformat-dev \
        libpq-dev \
	libgfortran3


WORKDIR /
RUN wget https://github.com/opencv/opencv_contrib/archive/3.2.0.zip \
&& unzip 3.2.0.zip \
&& rm 3.2.0.zip

RUN wget https://github.com/Itseez/opencv/archive/3.2.0.zip \
&& unzip 3.2.0.zip 

RUN wget http://www.imagemagick.org/download/delegates/jpegsrc.v9a.tar.gz \
&& tar -xzvf jpegsrc.v9a.tar.gz \
&& cd /jpeg-9a \
&& ./configure \
&& make  libdir=/usr/lib/x86_64-linux-gnu \
&& make libdir=/usr/lib/x86_64-linux-gnu install \
&& rm -r /jpeg-9a

RUN mkdir /opencv-3.2.0/cmake_binary \
&& cd /opencv-3.2.0/cmake_binary \
&& cmake -DBUILD_TIFF=ON \
  -DBUILD_opencv_java=OFF \
  -DOPENCV_EXTRA_MODULES_PATH=/opencv_contrib-3.2.0/modules \
  -DWITH_CUDA=OFF \
  -DENABLE_AVX=OFF \
  -DWITH_OPENGL=ON \
  -DWITH_OPENCL=ON \
  -DWITH_IPP=ON \
  -DWITH_TBB=ON \
  -DWITH_EIGEN=ON \
  -DWITH_V4L=ON \
  -DBUILD_TESTS=OFF \
  -DBUILD_PERF_TESTS=OFF \
  -DCMAKE_BUILD_TYPE=RELEASE \
  -DCMAKE_INSTALL_PREFIX=$(python3.5 -c "import sys; print(sys.prefix)") \
  -DPYTHON_EXECUTABLE=$(which python3.5) \
  -DPYTHON_INCLUDE_DIR=$(python3.5 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
  -DPYTHON_PACKAGES_PATH=$(python3.5 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
  -DBUILD_FFMPEG=ON \
  -DWITH_FFMPEG=ON .. \
&& make -j8 \
&& make install \
&& rm /3.2.0.zip \
&& rm -r /opencv-3.2.0 \
&& rm -r /opencv_contrib-3.2.0

RUN pip install flake8 pep8 --upgrade

WORKDIR /home/$NB_USER/work

USER $NB_USER

