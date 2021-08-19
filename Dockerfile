FROM tomcat:10-jdk11-openjdk-slim



COPY --chown=1001:0  target/petclinic-jakarta.war /petclinic.war
COPY --chown=1001:0 docker-resources/context.xml /tmp/context.xml
COPY --chown=1001:0 docker-resources/tomcat-users.xml $CATALINA_HOME/conf/tomcat-users.xml

RUN --chown=1001:0  mv /usr/local/tomcat/webapps /usr/local/tomcat/webapps2
RUN --chown=1001:0  mv /usr/local/tomcat/webapps.dist /usr/local/tomcat/webapps
RUN --chown=1001:0 cp /tmp/context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml

# Remove existing assets (if any)
# RUN rm -rf $CATALINA_HOME/webapps/*
# Copy WAR file into place
RUN --chown=1001:0 cp /petclinic.war $CATALINA_HOME/webapps
#RUN cp /tmp/context.xml $CATALINA_HOME/webapps/petclinic/META-INF/

USER 1001
#EXPOSE 8080
CMD ["catalina.sh", "run"]
