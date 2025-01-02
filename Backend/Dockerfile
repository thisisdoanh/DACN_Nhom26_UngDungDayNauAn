FROM openjdk:17

ARG JAR_FILE=target/*.jar

COPY ${JAR_FILE} recipe-service.jar

ENTRYPOINT ["java", "-jar", "recipe-service.jar"]

EXPOSE 8083