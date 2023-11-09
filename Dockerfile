#FROM maven:3-openjdk-17 AS build
#COPY src /home/app/src
#COPY pom.xml /home/app
#RUN mvn -f /home/app/pom.xml clean package


FROM openjdk:17-jdk-slim
WORKDIR /app
COPY pom.xml src/ /app/


# Run Maven to download dependencies and compile the application
RUN apt-get update && \
    apt-get install -y maven && \
    mvn clean package
    
    
# Copy the generated JAR file to /usr/local/lib/
RUN cp target/*.jar /usr/local/lib/demo.jar
EXPOSE 8080
CMD ["java", "-jar", "/usr/local/lib/demo.jar"]    
    
    
#COPY --from=build /home/app/target/aws-rest-service-0.0.1-SNAPSHOT.jar /usr/local/lib/demo.jar

#ENTRYPOINT ["java","-jar","/usr/local/lib/demo.jar"]




# docker build -t app-rest-not-kafka:v4.0 . --label "not-kafka"
# docker create -p 8080:8080 --name web-rest-api-not-kafka  app-rest-not-kafka:v4.0
# docker run -it --rm -p 8080:8080  --name web-rest-api-not-kafka  app-rest-not-kafka:v4.0
# docker  tag app-rest-not-kafka:v4.0   rocha7778/app-rest-not-kafka:v4.0
# docker push rocha7778/app-rest-not-kafka:v4.0
# kubectl port-forward pod/web-java 8080:8080
# docker rmi rocha7778/app-rest-not-kafka:v4.0
# docker rmi app-rest-not-kafka:v4.0

# mysql

# docker create -p 3306:3306 --name mysql-product-command -e MYSQL_ROOT_PASSWORD=123456 -e MYSQL_DATABASE=product mysql 
# docker network disconnect  cqrs  mysql-product-comman
# docker create -p 3306:3306 --name mysql-product-query  mysql  
# use product;
# select * from product.product_command;
