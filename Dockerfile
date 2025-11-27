FROM maven:3.9.6-eclipse-temurin-21 AS build

WORKDIR /usr/src/app

COPY pom.xml .
COPY .mvn .mvn
COPY mvnw .
COPY mvnw.cmd .

RUN ./mvnw dependency:go-offline

COPY src src

RUN ./mvnw package -DskipTests

FROM eclipse-temurin:21-jre-alpine

EXPOSE 8080

COPY --from=build /usr/src/app/target/mediaflow_eureka-0.0.1-SNAPSHOT.jar /app/app.jar

ENTRYPOINT ["java","-jar","/app/app.jar"]