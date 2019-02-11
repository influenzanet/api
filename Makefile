.PHONY: all install

all:
	if [ ! -d "dist" ]; then mkdir "dist"; fi
	protoc global-types.proto --go_out=plugins=grpc:dist
	protoc user-management-api.proto --go_out=plugins=grpc:dist
	protoc auth-service-api.proto --go_out=plugins=grpc:dist

install:
	cp -R dist/*  ./../../../../src/