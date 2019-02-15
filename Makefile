.PHONY: deploy install-go
VERSION = v1.0.0

deploy:
	if [ ! -d "dist" ]; then mkdir "dist"; else rm -rf "dist" &&  mkdir "dist"; fi
	protoc global-types.proto --go_out=plugins=grpc:dist
	protoc user-management-api.proto --go_out=plugins=grpc:dist
	protoc auth-service-api.proto --go_out=plugins=grpc:dist
	cd dist/github.com/Influenzanet/api && git init && git remote add origin https://github.com/Influenzanet/api.git && git add . && git commit -m "update api files" && git push --delete origin $(VERSION) && git tag $(VERSION) && git push -f -u origin $(VERSION)
install-go:
	go get -u github.com/Influenzanet/api/go