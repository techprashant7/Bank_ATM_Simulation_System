# Use a stable Maven + Java 17 image
FROM maven:3.9.4-jdk-17

# Set working directory
WORKDIR /app

# Copy project files
COPY pom.xml .
COPY src ./src

# Build the project
RUN mvn clean install

# Expose port if your app runs a server (adjust if needed)
EXPOSE 8081

# Run your app (adjust the JAR name if different)
CMD ["java", "-jar", "target/Bank_ATM_Simulation_System-1.0-SNAPSHOT.jar"]
