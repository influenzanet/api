# Influenzanet backend services APIs

## Getting started
gRPC API definitions

Checkout repo ...

### Requirements:
Protobuffer tool 'protoc' has to be installed. On mac, one way is to use homebrew ('brew install protobuf')
For other platforms visit : https://github.com/protocolbuffers/protobuf/releases/tag/v3.8.0

And install go dependencies by running 
```bash
make install-go
```

Make sure the installed tools are in path (usually installed into $GOPATH/bin)
And add it to the PATH variable in .bash_profile for example.

## Build Services
make build

## Deploy generated go files into each services

```bash
# Deploy all
make deploy
# Deploy by service
make deploy-auth
make deploy-messaging
make deploy-api
make deploy-user
```

## Services
TODO: reference each service with sub-document

## Examples
