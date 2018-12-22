FROM bsb:latest

USER root

WORKDIR /src
COPY . .

RUN npm i && npm test

CMD ["/bin/bash"]
