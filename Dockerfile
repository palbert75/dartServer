FROM google/dart-runtime

RUN chmod 777 -R /root
RUN chmod 777 -R /root/.pub-cache
RUN chmod 777 -R /root/.pub-cache/*

USER 123456789
