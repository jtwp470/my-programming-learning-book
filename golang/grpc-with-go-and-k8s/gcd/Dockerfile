FROM golang:1.10-alpine AS build

RUN apk add git --no-cache
WORKDIR /go/src/github.com/ryosan-470/gcdservice
RUN git init  # dummy repository なので必要
ADD gcd/main.go .
ADD pb pb

RUN go get -v ./...
RUN go install -v ./...
RUN go build -o gcd

FROM alpine
EXPOSE 3000
COPY --from=build /go/src/github.com/ryosan-470/gcdservice/gcd /usr/local/bin/gcd
ENTRYPOINT [ "/usr/local/bin/gcd" ]