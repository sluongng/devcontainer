#########
# Bazel #
#########
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

##########
# Golang #
##########
http_archive(
    name = "io_bazel_rules_go",
    sha256 = "69de5c704a05ff37862f7e0f5534d4f479418afc21806c887db544a316f3cb6b",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.27.0/rules_go-v0.27.0.tar.gz",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.27.0/rules_go-v0.27.0.tar.gz",
    ],
)

http_archive(
    name = "bazel_gazelle",
    sha256 = "62ca106be173579c0a167deb23358fdfe71ffa1e4cfdddf5582af26520f1c66f",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.23.0/bazel-gazelle-v0.23.0.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.23.0/bazel-gazelle-v0.23.0.tar.gz",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_download_sdk", "go_register_toolchains", "go_rules_dependencies")

go_download_sdk(
    name = "go_sdk",
    sdks = {
        "darwin_amd64": ("go1.16.2.darwin-amd64.tar.gz", "c98cde81517c5daf427f3071412f39d5bc58f6120e90a0d94cc51480fa04dbc1"),
        "linux_amd64": ("go1.16.2.linux-amd64.tar.gz", "542e936b19542e62679766194364f45141fde55169db2d8d01046555ca9eb4b8"),
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
    sha256 = "932160d5694e688cb7a05ac38efba4b9a90470c75f39716d85fb1d2f95eec96d",
    strip_prefix = "buildtools-4.0.1",
    urls = [
        "https://github.com/bazelbuild/buildtools/archive/4.0.1.zip",
    ],
)

http_archive(
    name = "com_google_protobuf",
    sha256 = "a96d66a29df73991ece4d82f04abf242d28f4cdacd7eb0ddf47f75a344a290af",
    strip_prefix = "protobuf-3.15.6",
    urls = [
        "https://github.com/protocolbuffers/protobuf/releases/download/v3.15.6/protobuf-all-3.15.6.tar.gz",
    ],
)

#############
# Container #
#############
http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "95d39fd84ff4474babaf190450ee034d958202043e366b9fc38f438c9e6c3334",
    strip_prefix = "rules_docker-0.16.0",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.16.0/rules_docker-v0.16.0.tar.gz"],
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
