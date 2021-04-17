load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

##########
# Golang #
##########
def build_rule_deps():
    http_archive(
        name = "io_bazel_rules_go",
        sha256 = "69de5c704a05ff37862f7e0f5534d4f479418afc21806c887db544a316f3cb6b",
        urls = [
            "https://github.com/bazelbuild/rules_go/releases/download/v0.27.0/rules_go-v0.27.0.tar.gz",
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.27.0/rules_go-v0.27.0.tar.gz",
        ],
    )

    http_archive(
        name = "bazel_gazelle",
        sha256 = "62ca106be173579c0a167deb23358fdfe71ffa1e4cfdddf5582af26520f1c66f",
        urls = [
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.23.0/bazel-gazelle-v0.23.0.tar.gz",
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.23.0/bazel-gazelle-v0.23.0.tar.gz",
        ],
    )

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

    http_archive(
        name = "io_bazel_rules_docker",
        sha256 = "95d39fd84ff4474babaf190450ee034d958202043e366b9fc38f438c9e6c3334",
        strip_prefix = "rules_docker-0.16.0",
        urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.16.0/rules_docker-v0.16.0.tar.gz"],
    )

    http_archive(
        name = "aisbaa_rules_deb_packages",
        sha256 = "efff23139e27eccf22f696dda42265903b1eff6dfa2420c4339aa98cdc80a7b9",
        urls = [
            "https://github.com/aisbaa/deb_packages/releases/download/v0.3-beta/deb_packages.tar.gz",
        ],
    )
