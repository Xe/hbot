FROM xena/nim:0.20.0 AS build
WORKDIR /hbot
COPY . .
RUN nim --version
RUN yes | nimble build

FROM xena/alpine
COPY --from=build /hbot/bin/hbot /usr/local/bin/hbot
CMD /usr/local/bin/hbot
