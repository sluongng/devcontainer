# devcontainer

Experimental setup for dotfiles + devcontainer (WIP)

## What is this

My personal experimental setup for dotfiles + devcontainer that can be used with Github CodeSpace and VSCode Devcontainer extension.

## How

Docker images and packages and personal utilities, dotfiles are versioned with git and managed and built with Bazel to ensure
reproducibility.

Container image will be tested with container_test bazel rule to ensure the content is correct.

Base image should be distroless with busybox installed.

## Reference

This repo is greatly inspired by https://github.com/whilp/world