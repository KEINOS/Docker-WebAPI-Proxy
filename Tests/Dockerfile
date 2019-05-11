FROM keinos/alpine

RUN apk update && \
    apk add curl

COPY run-test-container.sh /run-test.sh

CMD [ "/run-test.sh" ]