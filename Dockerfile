FROM openjdk:17.0.1-buster

WORKDIR /usr/src/buildtools
RUN curl -z BuildTools.jar -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

RUN java -jar BuildTools.jar --rev latest

RUN mkdir /usr/src/build
RUN cp spigot-*.jar /usr/src/build/spigot.jar

WORKDIR /server

EXPOSE 25565
# If using bedrock proxy
EXPOSE 19132

COPY ./scripts/run.sh /scripts/run.sh

RUN chmod +x /scripts/run.sh

ENTRYPOINT [ "bash", "-c", "/scripts/run.sh" ]
CMD "java -Xmx10G -jar spigot.jar"