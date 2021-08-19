FROM tomcat:10-jdk11-openjdk-slim

#USER newuser
COPY target/petclinic-jakarta.war /petclinic.war
COPY docker-resources/context.xml /tmp/context.xml
COPY docker-resources/tomcat-users.xml $CATALINA_HOME/conf/tomcat-users.xml

RUN mv /usr/local/tomcat/webapps /usr/local/tomcat/webapps2
RUN mv /usr/local/tomcat/webapps.dist /usr/local/tomcat/webapps
RUN cp /tmp/context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml

# Remove existing assets (if any)
# RUN rm -rf $CATALINA_HOME/webapps/*
# Copy WAR file into place
RUN cp /petclinic.war $CATALINA_HOME/webapps
#RUN cp /tmp/context.xml $CATALINA_HOME/webapps/petclinic/META-INF/


#EXPOSE 8080
CMD ["catalina.sh", "run"]
