FROM centos:centos7
MAINTAINER abi
# Install prepare infrastructure
RUN yum -y update && \
 yum -y install wget && \
 yum -y install tar
 
#ENV CATALINA_HOME /opt/tomcat
# Install Java
RUN yum -y install java
# Install Java
RUN yum -y install maven
WORKDIR /opt/tomcat
RUN curl -O https://www-eu.apache.org/dist/tomcat/tomcat-8/v8.5.40/bin/apache-tomcat-8.5.40.tar.gz
RUN tar xvfz apache*.tar.gz
RUN mv apache-tomcat-8.5.40/* /opt/tomcat/.
COPY target/java-tomcat-maven-example.war /opt/tomcat/webapps
#EXPOSE 8080
EXPOSE 8009
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
