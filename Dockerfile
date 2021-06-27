FROM ubuntu:20.04
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update
RUN apt install openjdk-8-jdk maven git -y
WORKDIR /app
RUN git clone https://github.com/airbornum/App42PaaS-Java-MySQL.git
WORKDIR /app/sample-java-app
RUN mvn package
RUN mv target/App42PaaS-Java-MySQL-Sample-0.0.1-SNAPSHOT.war ROOT.war
