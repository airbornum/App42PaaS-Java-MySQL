FROM maven:3.6.0
#FROM ubuntu:20.04
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update
RUN apt install git -y
WORKDIR /app
RUN git clone https://github.com/airbornum/App42PaaS-Java-MySQL.git
WORKDIR /app/App42PaaS-Java-MySQL
RUN mvn package
RUN mv target/App42PaaS-Java-MySQL-Sample-0.0.1-SNAPSHOT.war ROOT.war
