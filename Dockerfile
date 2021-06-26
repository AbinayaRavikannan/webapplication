FROM aravikan/tomcat:v1
MAINTAINER abi
COPY target/java-tomcat-maven-example.war /usr/local/tomcat/webapps
EXPOSE 8080
CMD ["catalina.sh", "run"]
