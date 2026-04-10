.PHONY: build deploy ship

build:
	flutter build web --release

deploy:
	firebase deploy --only hosting

prod: build deploy
