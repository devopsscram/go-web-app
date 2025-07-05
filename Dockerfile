#start wit the base image
FROM golang:1.21 as base

#set the working directory inside the container
WORKDIR /app 

#Copy the go.mod and go.sum files to the working directory
COPY go.mod ./

#Download All the dependencies
RUN go mod download

#Copy the source code to the working directory
COPY . .

#Build the application 

RUN go build -o main .

#######################################################
# Reduce the image size using multi-stage builds
# We will use a distroless image to run the application
FROM gcr.io/distroless/base

# Copy the binary from the previous stage
COPY --from=base /app/main .

# Copy the binary from the previous stage
COPY --from=base /app/main .