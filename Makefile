name := 2023-04-04a

build:
	docker build -t yitsushi/dokuwiki:$(name)-install -f Dockerfile-install .
	docker build -t yitsushi/dokuwiki:$(name) -f Dockerfile .

publish:
	docker tag yitsushi/dokuwiki:$(name) yitsushi/dokuwiki:latest
	docker push yitsushi/dokuwiki:$(name)
	docker push yitsushi/dokuwiki:latest
	docker push yitsushi/dokuwiki:$(name)-install
