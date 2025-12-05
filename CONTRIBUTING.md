# Contributing Guide

Welcome! There are many ways to contribute, including submitting bug
reports, improving documentation, submitting feature requests, reviewing
new submissions, or contributing code that can be incorporated into the
project.

## Review process

For any **significant** changes please create a new GitHub issue and
enhancements that you wish to make. Describe the feature you would like
to see, why you need it, and how it will work. Discuss your ideas
transparently and get community feedback before proceeding.

Small changes can directly be crafted and submitted to the GitHub
Repository as a Pull Request. This requires creating a **repo fork** using
[instruction](https://docs.github.com/en/get-started/quickstart/fork-a-repo).

## Initial setup for local development

### Install Git

Please follow
[instruction](https://docs.github.com/en/get-started/quickstart/set-up-git).

### Clone the repo

Open terminal and run these commands:

```bash
git clone git@github.com:myuser/hadoop-docker.git

cd hadoop-docker
```

### Enable pre-commit hooks

[pre-commit](https://pre-commit.com/) hooks allows to validate & fix
repository content before making new commit. It allows to run linters,
formatters, fix file permissions and so on. If something is wrong,
changes cannot be committed.

Firstly, install pre-commit:

```bash
pip install pre-commit
```

Then install pre-commit hooks:

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

Note: images should be build one-by-one and in the same order as described before,
as next one depends on previous.

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

Note: this is only for repo maintainers

Just add tag with desired version number to ``master`` branch:

```bash
git checkout master
git pull -p
git tag 1.2.3
git push origin 1.2.3
```
