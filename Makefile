
setup:
	mkdir -p ./bin

assets:
	which esc || go get github.com/mjibson/esc
	esc -pkg frontend -o services/frontend/gen_assets.go -prefix services/frontend/web_assets services/frontend/web_assets

hotrod: setup assets
	go build -o ./bin/hotrod

hotrod-linux: setup assets
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ./bin/hotrod-linux .

hotrod-docker: hotrod-linux
	docker build -t jaeger-example:latest -f ./docker/Dockerfile .
