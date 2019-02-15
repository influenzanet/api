.PHONY: deploy install-go
VERSION = v1.0.0

deploy:
	if [ ! -d "dist" ]; then mkdir "dist"; else rm -rf "dist" &&  mkdir "dist"; fi
	cd dist && mkdir "github.com" && cd github.com && mkdir "Influenzanet" && cd Influenzanet && git clone https://github.com/Influenzanet/api.git
	protoc global-types.proto --go_out=plugins=grpc:dist
	protoc user-management-api.proto --go_out=plugins=grpc:dist
	protoc auth-service-api.proto --go_out=plugins=grpc:dist
	cd dist/github.com/Influenzanet/api && git add . && git commit -m "update api files"
	-cd dist/github.com/Influenzanet/api && git push --delete origin $(VERSION) && git tag --delete $(VERSION)
	cd dist/github.com/Influenzanet/api && git tag $(VERSION) && git push origin master && git push origin $(VERSION)
install-go:
	go get -u github.com/Influenzanet/api/go