BUILD_DIR = ./temp
DIST_DIR = ./dist

all:
	if [ ! -d "$(BUILD_DIR)" ]; then mkdir "$(BUILD_DIR)"; else rm -rf "$(BUILD_DIR)" &&  mkdir "$(BUILD_DIR)"; fi
	protoc global-types.proto --go_out=plugins=grpc:$(BUILD_DIR)
	protoc user-management-api.proto --go_out=plugins=grpc:"$(BUILD_DIR)"
	protoc auth-service-api.proto --go_out=plugins=grpc:"$(BUILD_DIR)"
	if [ ! -d "$(DIST_DIR)" ]; then mkdir "$(DIST_DIR)"; else rm -rf "$(DIST_DIR)" &&  mkdir "$(DIST_DIR)"; fi
	cp -R $(BUILD_DIR)/github.com/influenzanet/api/dist/ $(DIST_DIR)
	rm -rf $(BUILD_DIR)
