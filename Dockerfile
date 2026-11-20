# Stage 1: Build
FROM maven:3.9.9-eclipse-temurin-21-alpine AS build
WORKDIR /workspace
COPY pom.xml .
COPY src ./src
RUN mvn -B clean package -DskipTests

# Stage 2: Hardened Runtime
FROM eclipse-temurin:21-jre-alpine
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
WORKDIR /app
COPY --from=build /workspace/target/app.jar app.jar
USER appuser
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]