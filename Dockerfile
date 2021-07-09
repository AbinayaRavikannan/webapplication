FROM centos:centos7
MAINTAINER abi
# Install prepare infrastructure
RUN yum -y update && \
 yum -y install wget && \
 yum -y install tar
 
ENV CATALINA_HOME /opt/tomcat
# Install Java
RUN yum -y install java
# Install Java
RUN yum -y install maven
# Install Tomcat
ENV TOMCAT_MAJOR 9
ENV TOMCAT_VERSION 9.0.39

RUN wget http://mirror.linux-ia64.org/apache/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
 tar -xvf apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
 rm apache-tomcat*.tar.gz && \
 mv apache-tomcat* ${CATALINA_HOME}

RUN chmod +x ${CATALINA_HOME}/bin/*sh
#WORKDIR /opt/tomcat
COPY target/java-tomcat-maven-example.war /usr/local/tomcat/webapps
EXPOSE 8080
EXPOSE 8009
CMD ["catalina.sh", "run"]
