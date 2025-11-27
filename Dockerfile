FROM maven:3.9.6-eclipse-temurin-21 AS build

WORKDIR /usr/src/app

COPY . .

RUN ./mvnw package -DskipTests

FROM eclipse-temurin:21-jre-alpine

EXPOSE 8080

COPY --from=build /usr/src/app/target/mediaflow_eureka-0.0.1-SNAPSHOT.jar /app/app.jar

ENTRYPOINT ["java","-jar","/app/app.jar"]