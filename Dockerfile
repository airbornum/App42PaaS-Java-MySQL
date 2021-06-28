FROM maven:3.2.5-jdk-8 AS builder

WORKDIR /java-app
RUN git clone https://github.com/airbornum/App42PaaS-Java-MySQL.git
WORKDIR /java-app/App42PaaS-Java-MySQL
RUN mvn package

FROM alpine:3.13
RUN apk add openjdk8-jre
RUN wget http://apache.rediris.es/tomcat/tomcat-9/v9.0.48/bin/apache-tomcat-9.0.48.tar.gz -O /tmp/tomcat9.tar.gz
RUN mkdir /opt/tomcat
RUN tar xvzf /tmp/tomcat9.tar.gz  --strip-components 1 --directory /opt/tomcat

WORKDIR /opt/tomcat/webapps
COPY --from=builder /java-app/App42PaaS-Java-MySQL/target/App42PaaS-Java-MySQL-Sample-0.0.1-SNAPSHOT.war .
COPY --from=builder /java-app/App42PaaS-Java-MySQL/WebContent/Config.properties ./ROOT/

EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
