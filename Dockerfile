# Container image that runs your code
FROM alpine:3.19

WORKDIR /action/workspace

RUN apk update && \
  apk add --no-cache \
   bash \
   curl \
   jq \
   yq

COPY *.sh /action/workspace/

RUN chmod +x /action/workspace/entrypoint.sh

ENTRYPOINT ["/action/workspace/entrypoint.sh"]
