FROM golang:tip-alpine3.22 AS build

WORKDIR /app

COPY go-app/ .

RUN go build -o server


FROM scratch

WORKDIR /

COPY --from=build /app/server /server

USER 1000

EXPOSE 8080

CMD ["/server"]