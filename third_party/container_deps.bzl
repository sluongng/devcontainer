"""
External Container Images
"""

load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

def external_containner_images():
    """Load all external container images

    Keep track of external images and their SHA256 / tag
    """
    container_pull(
        name = "amd64_ubuntu20.10",
        digest = "sha256:160a9181d622d428f6836e17245fea90b87e9f7abb86939d002c2e301383c8a8",
        registry = "docker.io",
        repository = "amd64/ubuntu",
        tag = "20.10",
    )
