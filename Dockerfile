# Use an official Maven image to build the application
FROM maven:3.8.6-openjdk-11 AS builder

# Set the working directory in the container
WORKDIR /app

# Copy the pom.xml and the source code into the container
COPY pom.xml .
COPY src ./src

# Package the application, skipping tests
RUN mvn clean package -DskipTests

# Use an official OpenJDK image to run the application
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the jar file from the builder stage to the current working directory
COPY --from=builder /app/target/service-b-1.0-SNAPSHOT.jar app.jar

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

