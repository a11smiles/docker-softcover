FROM docker.io/ubuntu:latest

ENV PHANTOM_JS_VERSION 2.1.1

# update package lists
RUN apt-get update

# install library dependencies
RUN apt-get install ruby -y
RUN apt-get install ruby-dev -y
RUN apt-get install gcc -y
RUN apt-get install zlib1g-dev -y
RUN apt-get install libxml2-dev -y
RUN apt-get install libxslt-dev -y
RUN apt-get install build-essential -y
RUN apt-get install libcurl4-openssl-dev -y
#RUN apt-get install bzip2 -y
RUN apt-get install wget -y

# install softcover dependencies
RUN apt-get install texlive-full -y
RUN apt-get install imagemagick -y
RUN apt-get install nodejs -y
RUN apt-get install inkscape -y
RUN apt-get install calibre -y
RUN apt-get install default-jre -y
RUN apt-get install epubcheck -y

# download & install phantomjs
WORKDIR /tmp/phantomjs
RUN wget "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOM_JS_VERSION}-linux-x86_64.tar.bz2"
RUN tar xvfj "./phantomjs-${PHANTOM_JS_VERSION}-linux-x86_64.tar.bz2"
RUN mv "./phantomjs-${PHANTOM_JS_VERSION}-linux-x86_64" /opt/phantomjs

# download & install kindlegen
WORKDIR /tmp/kindlegen
RUN wget http://kindlegen.s3.amazonaws.com/kindlegen_linux_2.6_i386_v2_9.tar.gz
RUN tar -zxvf kindlegen_linux_2.6_i386_v2_9.tar.gz
RUN cp kindlegen /opt/kindlegen

# clean up
WORKDIR /
RUN rm -r /tmp/phantomjs
RUN rm -r /tmp/kindlegen

# create symbolic links
RUN ln -sf /usr/bin/nodejs /usr/local/bin/node
RUN ln -sf /opt/phantomjs/bin/phantomjs /usr/local/bin/phantomjs
RUN ln -sf /opt/kindlegen /usr/local/bin/kindlegen

# install softcover
RUN gem install softcover

# export default development server port
EXPOSE 4000

