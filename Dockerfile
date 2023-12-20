FROM golang:1.20-alpine as builder
RUN apk --no-cache add git
RUN CGO_ENABLED=0 go install go.k6.io/xk6/cmd/xk6@latest
RUN CGO_ENABLED=0 xk6 build --with github.com/LeonAdato/xk6-output-statsd --output /tmp/k6

# Stage 2: Create lightweight runtime environment for the custom k6 binary with browser support
FROM alpine:3.17
RUN adduser -D -u 12345 -g 12345 k6
COPY --from=builder /tmp/k6 /usr/bin/k6



USER 12345
WORKDIR /home/k6

ENTRYPOINT ["k6"]