FROM anapsix/alpine-java:8
WORKDIR /app
COPY main/build/libs/main-0.0.3-SNAPSHOT.jar /app/app.jar
EXPOSE 8080
CMD java -jar /app/app.jar