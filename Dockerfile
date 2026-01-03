# Use Java 17
FROM eclipse-temurin:17-jdk

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Build the project
RUN ./mvnw clean package || mvn clean package

# Expose port (Render uses PORT env variable)
EXPOSE 8081

# Start the app
CMD ["sh", "-c", "java -jar target/*.jar"]
