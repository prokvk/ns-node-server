FROM node:7.7-alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN echo "http://dl-4.alpinelinux.org/alpine/v3.1/main" >> /etc/apk/repositories && \
	apk add --update --no-cache \
		supervisor \
		make \
		bash \
		curl \
		wget \
		file \
		git \
		rsync \
		openssh-client

RUN npm install -g coffee-script
RUN npm install -g grunt-cli
RUN npm install -g nodemon
RUN mkdir -p /var/log/supervisor

RUN ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa
RUN ssh-keyscan bitbucket.org >> ~/.ssh/known_hosts

CMD [ "supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf" ]
