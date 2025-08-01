# Stage 1: build with Gradle
FROM gradle:8-jdk17 AS build
WORKDIR /home/gradle/project
COPY . .
RUN gradle clean build --no-daemon

# Stage 2: lightweight runtime image
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /home/gradle/project/build/libs/*.jar app.jar
 ENTRYPOINT ["java","-jar","app.jar"]
