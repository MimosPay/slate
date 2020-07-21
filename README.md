# MimosPay REST Documentation

![Build](https://github.com/MimosPay/slate/workflows/Build/badge.svg)
![Deploy](https://github.com/MimosPay/slate/workflows/Deploy/badge.svg)

MimosPay's API documentation is created with [Slate](https://github.com/slatedocs/slate).

Check it out at https://mimospay.github.io/slate

## Changes

- Using `Includes` to break `index.html.md` into multiple files
- Using `{#custom-id}` to custom heading IDs
- Using Middlemans' [Internationalization features](https://middlemanapp.com/advanced/localization/)
  * I18n.t(:title), equivalent: I18n.t('title'), keys which can be both Symbols or Strings
  * I18n.t('guide.title'), nested keys
  * ~~I18n.t('guide.text_html'), keys with a '_html' suffix and keys named 'html' are marked as HTML safe~~ I18n.t('guide.text'), HTML safe
  * I18n.t('guide.request_limit', count: '100'), perform interpolation
- Update `Dockerfile` with APT/RubyGems mirrors
- Using `Makefile` to run commands more efficiently, `make <tab>`

## Using in Docker

- Dockerfile, use multi-stage builds from original/mirror by conditions

  ```shell
  # build on mirror version,
  > DOCKER_BUILDKIT=1 docker build --build-arg BUILD_VERSION=1 . -t slate

  # build on original version
  > DOCKER_BUILDKIT=1 docker build . -t slate
  ```

- Dockerfile.mirror, build on mirror only

  ```shell
  > docker build -f Dockerfile.mirror . -t slate
  ```

- Dockerfile.original, [build on original only][slate-docker-original]

  ```shell
  > docker build -f Dockerfile.original . -t slate
  ```

**NOTE**: Recommended version of Docker is 18.09 or higher

## [Updating Slate](https://github.com/slatedocs/slate/wiki/Updating-Slate)

```shell
> git remote add upstream https://github.com/slatedocs/slate.git

> git fetch upstream

> git merge upstream/main
```

[slate-docker-original]: https://github.com/slatedocs/slate/wiki/Using-Slate-in-Docker
