#########
# Bazel #
#########
load("//third_party:build_rule_deps.bzl", "build_rule_deps")

build_rule_deps()

##########
# Golang #
##########
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

#############
# Container #
#############
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
load("@aisbaa_rules_deb_packages//deb_packages:deps.bzl", "deb_packages_setup")

deb_packages_setup()

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

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
        "http://deb.debian.org/debian",
        "http://snapshot.debian.org/archive/debian/20210223T211250Z/",
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
