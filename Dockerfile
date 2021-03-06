ARG FROM=ubuntu:19.04
FROM $FROM

ARG TARBALL=cache/ccs.tar.gz
#ARG MAJOR_VERSION=8
ARG COMPILER_VERSION=6.4

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8


WORKDIR /ccs_install

COPY "$TARBALL" .

RUN apt-get update

RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y \
  libc6:i386                        \
  libx11-6:i386                     \
  libasound2:i386                   \
  libatk1.0-0:i386                  \
  libcairo2:i386                    \
  libcups2:i386                     \
  libdbus-glib-1-2:i386             \
  libgconf-2-4:i386                 \
  libgcrypt20:i386                  \
  libgdk-pixbuf2.0-0:i386           \
  libgtk-3-0:i386                   \
  libice6:i386                      \
  libncurses5:i386                  \
  libsm6:i386                       \
  liborbit2:i386                    \
  libudev1:i386                     \
  libusb-0.1-4:i386                 \
  libstdc++6:i386                   \
  libstdc++6                        \
  libxt6                            \
  libxt6:i386                       \
  libxtst6:i386                     \
  libgnomeui-0:i386                 \
  libusb-1.0-0-dev:i386             \
  libcanberra-gtk-module:i386       \
  gtk2-engines-murrine:i386         \
  libpython2.7                      \
  openjdk-8-jdk                     \
  openjdk-8-jre                     \
  openjdk-8-jdk-headless            \
  openjdk-8-jre-headless            \
  unzip

RUN apt-get install -y gcc libdpkg-perl lsb-release python3 python3-dev python3-venv virtualenv git
RUN apt-get install -y curl vim nano
# for our python stuff including PyQt5
RUN apt-get install -y python libgl1

RUN virtualenv -p python3 /opt/pipenv
RUN /opt/pipenv/bin/pip install pipenv
RUN ln -s /opt/pipenv/bin/pipenv /usr/local/bin/pipenv
RUN ln -s /opt/pipenv/bin/pew /usr/local/bin/pew

COPY ccstudio_installation_responses .

COPY docker.py .
RUN python3 docker.py

# workspace folder for CCS
RUN mkdir /workspace

# directory for the ccs project
VOLUME /wd
WORKDIR /wd
