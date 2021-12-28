FROM openjdk:17

WORKDIR /usr/src/buildtools
RUN curl -z BuildTools.jar -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

COPY --from=bitnami/git /opt/bitnami/git/bin/git /bin/git
COPY --from=bitnami/git /opt/bitnami/git/bin/git-upload-pack /bin/git-upload-pack

RUN java -jar BuildTools.jar --rev latest

RUN mkdir /usr/src/build
RUN cp spigot-*.jar /usr/src/build/spigot.jar

WORKDIR /server
EXPOSE 25565
COPY ./scripts/run.sh /scripts/run.sh

CMD [ "/scripts/run.sh" ]