############################
# STEP 1 build executable binary
############################
FROM golang:alpine AS builder

# RUN apk update && apk add --no-cache git
WORKDIR /go
COPY hello-go.go .
# Fetch dependencies.
# Using go get.
RUN go get -d -v
# Build the binary.
RUN go build -o /go/bin/hello-go
############################
# STEP 2 build a small image
############################
FROM scratch
# Copy our static executable.
COPY --from=builder /go/bin/hello-go /go/bin/hello-go
# Run the hello binary.
CMD ["/go/bin/hello-go"]
