FROM centos
MAINTAINER abi
RUN yum -y install tomcat
COPY target/java-tomcat-maven-example.war /usr/local/tomcat/webapps
EXPOSE 8383
CMD ["catalina.sh", "run"]
