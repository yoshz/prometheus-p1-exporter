FROM golang AS BUILD
WORKDIR /src
ADD main.go .
RUN go get -d ./...
RUN go build -ldflags "-linkmode external -extldflags -static" -o prometheus-p1-exporter

FROM scratch
COPY --from=build /src/prometheus-p1-exporter /
ENV SERIAL_DEVICE /dev/ttyUSB0
EXPOSE 9222
CMD ["/prometheus-p1-exporter"]
