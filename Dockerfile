FROM phusion/passenger-ruby23:0.9.19

ENV HOME /root

CMD ["/sbin/my_init"]

RUN apt-get update && apt-get install -y -o Dpkg::Options::="--force-confold" netcat

RUN rm -f /etc/service/nginx/down

RUN rm /etc/nginx/sites-enabled/default
ADD webapp.conf /etc/nginx/sites-enabled/webapp.conf

ADD rails-env.conf /etc/nginx/main.d/rails-env.conf

WORKDIR /tmp
ADD Gemfile /tmp/
ADD Gemfile.lock /tmp/
RUN bundle install


RUN mkdir /home/app/webapp
COPY . /home/app/webapp
RUN usermod -u 1000 app
RUN chown -R app:app /home/app/webapp
WORKDIR /home/app/webapp

RUN apt-get clean && rm -rf /var/lib/apt/list/* /tmp/* /var/tmp/*

EXPOSE 80
