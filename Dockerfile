FROM maven:3.5.3-jdk-8-slim

# Added git
RUN apt-get update && \
    apt-get install -y \
    git

WORKDIR /tmp

COPY pom.xml /tmp
RUN mvn verify
RUN rm pom.xml

WORKDIR /usr/src
RUN git clone https://github.com/Arquitectura1-Mottesi-Olmedo-Tolaba/encuestas-backend.git

WORKDIR /usr/src/encuestas-backend

COPY jdbc.properties .
RUN cp jdbc.properties src/main/resources/META-INF/jdbc.properties

EXPOSE 8080

CMD [ "mvn", "jetty:run" ]
