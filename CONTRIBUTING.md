# Contributing Guide

Welcome! There are many ways to contribute, including submitting bug
reports, improving documentation, submitting feature requests, reviewing
new submissions, or contributing code that can be incorporated into the
project.

## Initial setup for local development

### Install Git

Please follow
[instruction](https://docs.github.com/en/get-started/quickstart/set-up-git).

## Create a fork

If you are not a member of a development team building hadoop-docker,
you should create a fork before making any changes.

Please follow
[instruction](https://docs.github.com/en/get-started/quickstart/fork-a-repo).

### Clone the repo

Open terminal and run these commands:

```bash
git clone https://github.com/MobileTeleSystems/hadoop-docker

cd hadoop-docker
```

### Enable pre-commit hooks

[pre-commit](https://pre-commit.com/) hooks allows to validate & fix
repository content before making new commit. It allows to run linters,
formatters, fix file permissions and so on. If something is wrong,
changes cannot be committed.

Firstly, install pre-commit hooks:

```bash
pre-commit install --install-hooks
```

Ant then test hooks run:

```bash
pre-commit run
```

# How to

## Build images

HDFS:

```bash
cd hdfs
docker-compose build
```

Yarn:

```bash
cd yarn
docker-compose build
```

Hive:

```bash
cd hive
docker-compose build
```

Note: images should be build one-by-one and in the same order as described before.

## Review process

Please create a new GitHub issue for any significant changes and
enhancements that you wish to make. Provide the feature you would like
to see, why you need it, and how it will work. Discuss your ideas
transparently and get community feedback before proceeding.

Significant Changes that you wish to contribute to the project should be
discussed first in a GitHub issue that clearly outlines the changes and
benefits of the feature.

Small Changes can directly be crafted and submitted to the GitHub
Repository as a Pull Request.

### Create pull request

Commit your changes:

```bash
git commit -m "Commit message"
git push
```

Then open Github interface and [create pull request](https://docs.github.com/en/get-started/quickstart/contributing-to-projects#making-a-pull-request).
Please follow guide from PR body template.

After pull request is created, it get a corresponding number, e.g. 123
(`pr_number`).

## Release Process

Just add tag with desired version number to ``master`` branch:

```bash
git checkout master
git pull -p
git tag 1.2.3
git push origin 1.2.3
```
