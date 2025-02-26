FROM openjdk:21-jdk
EXPOSE 9090
ADD target/app.jar application.jar
ENTRYPOINT ["java", "-jar", "/application.jar"]