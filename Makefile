BUILD_DIR = ./temp
DIST_DIR = ./dist

all:
	if [ ! -d "$(BUILD_DIR)" ]; then mkdir "$(BUILD_DIR)"; else rm -rf "$(BUILD_DIR)" &&  mkdir "$(BUILD_DIR)"; fi
	find *.proto -maxdepth 1 -type f -exec protoc {} --go_out=plugins=grpc:$(BUILD_DIR) \;
	if [ ! -d "$(DIST_DIR)" ]; then mkdir "$(DIST_DIR)"; else rm -rf "$(DIST_DIR)" &&  mkdir "$(DIST_DIR)"; fi
	cp -R $(BUILD_DIR)/github.com/influenzanet/api/dist/ $(DIST_DIR)
	rm -rf $(BUILD_DIR)
