#########
# Bazel #
#########
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

##########
# Golang #
##########
http_archive(
    name = "io_bazel_rules_go",
    sha256 = "7904dbecbaffd068651916dce77ff3437679f9d20e1a7956bff43826e7645fcc",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.25.1/rules_go-v0.25.1.tar.gz",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.25.1/rules_go-v0.25.1.tar.gz",
    ],
)

http_archive(
    name = "bazel_gazelle",
    sha256 = "222e49f034ca7a1d1231422cdb67066b885819885c356673cb1f72f748a3c9d4",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.22.3/bazel-gazelle-v0.22.3.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.22.3/bazel-gazelle-v0.22.3.tar.gz",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_download_sdk", "go_register_toolchains", "go_rules_dependencies")

go_download_sdk(
    name = "go_sdk",
    sdks = {
        "darwin_amd64": ("go1.16rc1.darwin-amd64.tar.gz", "7c060b231b670321bd0f01085a4b2f7dcaf02d584cc50c42de7418158af23771"),
        "linux_amd64": ("go1.16rc1.linux-amd64.tar.gz", "6a62610f56a04bae8702cd2bd73bfea34645c1b89ded3f0b81a841393b6f1f14"),
    },
    urls = [
        "https://dl.google.com/go/{}",
    ],
)

go_rules_dependencies()

go_register_toolchains()

############################
# External Go Dependencies #
############################
load("//third_party:go_deps.bzl", "go_dependencies")

# gazelle:repository_macro third_party/go_deps.bzl%_go_dependencies
go_dependencies()

##############
# Buildtools #
##############
http_archive(
    name = "com_github_bazelbuild_buildtools",
    sha256 = "2adaafee16c53b80adff742b88bc90b2a5e99bf6889a5d82f22ef66655dc467b",
    strip_prefix = "buildtools-4.0.0",
    urls = [
        "https://github.com/bazelbuild/buildtools/archive/4.0.0.zip",
    ],
)

http_archive(
    name = "com_google_protobuf",
    sha256 = "6dd0f6b20094910fbb7f1f7908688df01af2d4f6c5c21331b9f636048674aebf",
    strip_prefix = "protobuf-3.14.0",
    urls = [
        "https://github.com/protocolbuffers/protobuf/releases/download/v3.14.0/protobuf-all-3.14.0.tar.gz",
    ],
)

#############
# Container #
#############
http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "1698624e878b0607052ae6131aa216d45ebb63871ec497f26c67455b34119c80",
    strip_prefix = "rules_docker-0.15.0",
    urls = [
        "https://github.com/bazelbuild/rules_docker/releases/download/v0.15.0/rules_docker-v0.15.0.tar.gz",
    ],
)

load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)

container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

# This would load a set of golang repositories that might bring a different version
# than the one we were expecting in go_dependencies(). So we need to load it after go_dependencies().
container_deps()

load("//third_party:container_deps.bzl", "external_containner_images")

external_containner_images()

################################
# Dependencies for Build Tools #
################################
load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

# This would load a different version of rules_python than the one needed in rules_docker
# so we need to load it after container_deps()
protobuf_deps()
