FROM ubuntu:13.10

# Install packages needed
RUN apt-get update
RUN apt-get install -y git curl maven wget software-properties-common

# Install Java.
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN apt-get install -y oracle-java7-installer

# Environment variable
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

ADD startup_server.sh /startup_server.sh
RUN chmod 700 /startup_server.sh

# Application
ADD gs-spring-boot.war /gs-spring-boot.war

# Port
EXPOSE 8080

CMD ["/startup_server.sh"]
