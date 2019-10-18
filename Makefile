
DEPLOY_TARGETS := deploy-auth deploy-user deploy-study deploy-messaging deploy-api

.PHONY: deploy install-go build $(DEPLOY_TARGETS)

BUILD_DIR = ./build

# Path to go files once generated. Should point directly to the level of global-types.pb.go
PROTO_BUILD_DIR=$(BUILD_DIR)

# By default Make the assumption all services dirs are in upper level of the current dir by default
# Directory names of the services are the same as the repo
ifndef SERVICE_DIR
	SERVICE_DIR= ..
endif

ifndef AUTH_SERVICE_DIR
	AUTH_SERVICE_DIR=$(SERVICE_DIR)/authentication-service/api
endif

ifndef USER_SERVICE_DIR
	USER_SERVICE_DIR=$(SERVICE_DIR)/user-management-service/api
endif

ifndef API_SERVICE_DIR
	API_SERVICE_DIR=$(SERVICE_DIR)/api-gateway/api
endif

ifndef MESSAGING_SERVICE_DIR
	MESSAGING_SERVICE_DIR=$(SERVICE_DIR)/messaging-service/api
endif

ifndef STUDY_SERVICE_DIR
	STUDY_SERVICE_DIR=$(SERVICE_DIR)/study-service/api
endif

build:
	if [ ! -d "$(BUILD_DIR)" ]; then mkdir "$(BUILD_DIR)"; else rm -rf "$(BUILD_DIR)" &&  mkdir "$(BUILD_DIR)"; fi
	find *.proto -maxdepth 1 -type f -exec protoc {} --go_out=plugins=grpc:$(BUILD_DIR) \;

install-go:
	go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
	go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
	go get -u github.com/golang/protobuf/protoc-gen-go

deploy-auth: DEPLOY_DIR = $(AUTH_SERVICE_DIR)
deploy-auth:
	mkdir -p $(DEPLOY_DIR)
	cp -Rf $(PROTO_BUILD_DIR)/* $(DEPLOY_DIR)/

deploy-user: DEPLOY_DIR = $(USER_SERVICE_DIR)
deploy-user:
	mkdir -p $(DEPLOY_DIR)
	cp -Rf $(PROTO_BUILD_DIR)/* $(DEPLOY_DIR)/

deploy-messaging: DEPLOY_DIR = $(MESSAGING_SERVICE_DIR)
deploy-messaging:
	mkdir -p $(DEPLOY_DIR)
	cp -Rf $(PROTO_BUILD_DIR)/* $(DEPLOY_DIR)/

deploy-api: DEPLOY_DIR=$(API_SERVICE_DIR)
deploy-api:
	mkdir -p $(DEPLOY_DIR)
	cp -Rf $(PROTO_BUILD_DIR)/* $(DEPLOY_DIR)/

deploy-study: DEPLOY_DIR = $(STUDY_SERVICE_DIR)
deploy-study:
	mkdir -p $(DEPLOY_DIR)
	cp -Rf $(PROTO_BUILD_DIR)/* $(DEPLOY_DIR)/

deploy: $(DEPLOY_TARGETS)
