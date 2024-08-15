FROM tomcat:latest
RUN cp -R  /usr/local/tomcat/webapps.dist/*  /usr/local/tomcat/webapps
ARG WAR_FILE=webapp/target/mycart.war 
COPY ${WAR_FILE} /usr/local/tomcat/webapps