# Use correct Maven + Java 17 image
FROM maven:3.9.4-eclipse-temurin-17

# Set working directory
WORKDIR /app

# Copy project files
COPY pom.xml .
COPY src ./src

# Build the project
RUN mvn clean package

# Install Tomcat
RUN apt-get update && apt-get install -y wget unzip && \
    wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.tar.gz && \
    tar -xzf apache-tomcat-9.0.85.tar.gz && \
    mv apache-tomcat-9.0.85 /opt/tomcat && \
    rm apache-tomcat-9.0.85.tar.gz && \
    apt-get clean

# Copy WAR file to Tomcat webapps
RUN cp target/*.war /opt/tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8081

# Start Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
