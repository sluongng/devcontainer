"""
Golang External Dependencies
"""

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

def go_dependencies():
    """Load all Golang external libraries

    Ensure the loading orders of different rules inside the repository.
    All build rules' optional dependencies should be loaded AFTER
    all the projects direct dependencies declared.
    """
    _go_dependencies()
    gazelle_dependencies()

def _go_dependencies():
    """Direct dependencies of Golang code inside the repositories

    Automanaged by Gazelle via:
    > bazel run //:gazelle -- update-repos -from_file=go.mod -to_macro=third_party/go_deps.bzl%_go_dependencies -prune=true
    """
