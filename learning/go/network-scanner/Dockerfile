FROM golang:1.20

WORKDIR /app
COPY . .

RUN go build -o network-scanner main.go

CMD ["./network-scanner"]
