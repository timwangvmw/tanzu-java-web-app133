ARG BUILDER_IMAGE=maven
# ARG RUNTIME_IMAGE=gcr.io/distroless/java17-debian11
ARG RUNTIME_IMAGE=openjdk:17.0.2-jdk
FROM $BUILDER_IMAGE AS build
ADD . .
RUN unset MAVEN_CONFIG && ./mvnw clean package -B -DskipTests
FROM $RUNTIME_IMAGE AS runtime
COPY --from=build /target/demo-0.0.1-SNAPSHOT.jar /demo.jar 
COPY ./elastic-apm-agent-1.38.1-20230512.153148-12.jar /var/tmp/elastic-apm-agent-1.38.1-20230512.153148-12.jar
# change users as the last thing in your Dockerfile
USER 1000
CMD [ "/demo.jar" ]