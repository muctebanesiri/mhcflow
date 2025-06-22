FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
  build-essential \
  curl \
  python3.10 \
  python3-pip \
  libncurses5-dev \
  libbz2-dev \
  liblzma-dev \
  libssl-dev \
  zlib1g-dev \
  libcurl4-gnutls-dev \
  && rm -rf /var/lib/apt/lists/*

ENV SAMTOOLS_DIR=/opt/samtools
ENV HTSLIB_DIR=/opt/htslib

ENV SAMTOOLS_VERSION=1.22
ENV HTSLIB_VERSION=1.22

RUN mkdir -p /tmp/build_samtools
WORKDIR /tmp/build_samtools

RUN curl -L https://github.com/samtools/htslib/releases/download/${HTSLIB_VERSION}/htslib-${HTSLIB_VERSION}.tar.bz2 -o htslib.tar.bz2 && \
  tar -xjf htslib.tar.bz2 && \
  cd htslib-${HTSLIB_VERSION} && \
  ./configure --prefix=${HTSLIB_DIR} && \
  make && \
  make install

RUN cd /tmp/build_samtools && \
  curl -L https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VERSION}/samtools-${SAMTOOLS_VERSION}.tar.bz2 -o samtools.tar.bz2 && \
  tar -xjf samtools.tar.bz2 && \
  cd samtools-${SAMTOOLS_VERSION} && \
  ./configure --prefix=${SAMTOOLS_DIR} && \
  make && \
  make install

RUN rm -rf /tmp/build_samtools

ENV PATH="${SAMTOOLS_DIR}/bin:${HTSLIB_DIR}/bin:${PATH}"

RUN pip install --upgrade pip setuptools wheel

RUN pip install mhcflow

WORKDIR /mhcflow

RUN mkdir -p /opt/bin

ENV PATH="/opt/bin:${PATH}"

RUN mkdir -p /resources

CMD ["mhcflow", "-h"]
