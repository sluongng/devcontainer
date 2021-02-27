#########
# Bazel #
#########
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

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
        "darwin_amd64": ("go1.16.darwin-amd64.tar.gz", "6000a9522975d116bf76044967d7e69e04e982e9625330d9a539a8b45395f9a8"),
        "linux_amd64": ("go1.16.linux-amd64.tar.gz", "013a489ebb3e24ef3d915abe5b94c3286c070dfe0818d5bca8108f1d6e8440d2"),
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
RULES_DOCKER_COMMIT = "e15c9ebf203b7fa708e69ff5f1cdcf427d7edf6f"

RULES_DOCKER_SHA256 = "f4a39a410da7e497a7ccd19e28c69c93a851d6adb76798355a0c8ba9855e9b75"

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = RULES_DOCKER_SHA256,
    strip_prefix = "rules_docker-{}".format(RULES_DOCKER_COMMIT),
    urls = [
        "https://github.com/bazelbuild/rules_docker/archive/{}.zip".format(RULES_DOCKER_COMMIT),
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

#############
# Packaging #
#############
http_archive(
    name = "aisbaa_rules_deb_packages",
    sha256 = "efff23139e27eccf22f696dda42265903b1eff6dfa2420c4339aa98cdc80a7b9",
    urls = [
        "https://github.com/aisbaa/deb_packages/releases/download/v0.3-beta/deb_packages.tar.gz",
    ],
)

load("@aisbaa_rules_deb_packages//deb_packages:deps.bzl", "deb_packages_setup")

deb_packages_setup()

# dowload gpg key for Debian 11
http_file(
    name = "debian_bullseye_archive_key",
    sha256 = "0b7dc94b880f0b63e2093394b113cafd870badb86e020a35614f49b9d83beb1e",
    urls = ["https://ftp-master.debian.org/keys/archive-key-11.asc"],
)

load("@aisbaa_rules_deb_packages//deb_packages:defs.bzl", "deb_repository")

deb_repository(
    name = "debian_bullseye_amd64_pkgs",
    arch = "amd64",
    distro = "bullseye",
    distro_type = "debian",
    mirrors = [
        "http://snapshot.debian.org/archive/debian/20210223T211250Z/",
        "http://deb.debian.org/debian",
    ],
    packages = {
        "fd-find": "pool/main/r/rust-fd-find/fd-find_8.2.1-1+b1_amd64.deb",
        "fzf": "pool/main/f/fzf/fzf_0.24.3-1+b1_amd64.deb",
        "git": "pool/main/g/git/git_2.30.0-1_amd64.deb",
        "ripgrep": "pool/main/r/rust-ripgrep/ripgrep_12.1.1-1+b1_amd64.deb",
    },
    packages_sha256 = {
        "fd-find": "c9991b3efa8ccd41b8c27e204c4130562a86016787b9611a2141687906fec375",
        "fzf": "ddc3f9a379d85a24471b4eb8ba729a91818ae65bc3cd9e73379b9fbe9167f56d",
        "git": "32c6107a72665be54354585da69a464807a5c3d64654826307255da2c64bf930",
        "ripgrep": "206c8365bbb26afd769b313d61002f8f15b655782d727d6c3b48dd3df7e57ed9",
    },
)
