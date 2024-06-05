# docker build -t nutanix_exporter:1.x .
ARG GO_VERSION=1.22.2
FROM golang:${GO_VERSION} AS builder

ENV GOPATH /go
WORKDIR /app

COPY . .

# Install dependencies and build the binary.
RUN go get -d && \
    CGO_ENABLED=0 GOOS=linux go build -a -tags netgo -ldflags '-w' -o nutanix_exporter

# Final image.
FROM alpine:latest

LABEL maintainer="Peter"
ARG VERSION=1.2.3

# Add metadata
LABEL version="${VERSION}"

WORKDIR /app

# Copy binary from builder stage.
COPY --from=builder /app/nutanix_exporter /app/nutanix_exporter

# Use non-root user
RUN adduser -D nonroot
USER nonroot

EXPOSE 9404
ENTRYPOINT ["/app/nutanix_exporter"]
