FROM node:argon

# Accept EULA for Microsoft fonts
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
RUN echo deb http://mirrors.kernel.org/debian/ jessie main contrib non-free >> /etc/apt/sources.list

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y make nodejs unoconv ttf-mscorefonts-installer
RUN fc-cache -f

WORKDIR /app

COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
RUN npm install

COPY . /app

CMD make && /usr/bin/unoconv --listener && make pdf
