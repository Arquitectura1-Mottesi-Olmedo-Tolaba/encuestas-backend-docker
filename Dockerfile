FROM maven:3.5.3-jdk-8-slim

# Added git
RUN apt-get update && \
    apt-get install -y \
    git

WORKDIR /tmp

# Start encuestas-backend
COPY pom.xml /tmp
RUN mvn verify
RUN rm pom.xml

WORKDIR /usr/src
RUN git clone https://github.com/Arquitectura1-Mottesi-Olmedo-Tolaba/encuestas-backend.git

WORKDIR /usr/src/encuestas-backend
RUN mkdir newrelic
COPY newrelic/ newrelic/.
COPY jdbc.properties .
RUN cp jdbc.properties src/main/resources/META-INF/jdbc.properties

EXPOSE 8080
ENV JAVA_OPTIONS="${JAVA_OPTIONS} -javaagent:/usr/src/encuestas-backend/newrelic/newrelic.jar"
ENV MAVEN_OPTS="${MAVEN_OPTS} -javaagent:/usr/src/encuestas-backend/newrelic/newrelic.jar -Xmx1536m -Xms1536m"
RUN export

CMD [ "mvn", "jetty:run" ]
