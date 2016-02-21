FROM ubuntu:14.04

RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list

RUN gpg --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
RUN gpg -a --export E084DAB9 | apt-key add -

RUN apt-get update

RUN apt-get -y install r-base
