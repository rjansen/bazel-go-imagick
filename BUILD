load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")
load("@bazel_gazelle//:def.bzl", "gazelle")
load("@io_bazel_rules_docker//go:image.bzl", "go_image")
load("@io_bazel_rules_docker//container:container.bzl", "container_push")

# gazelle:prefix bazel_poc
gazelle(name = "gazelle")

go_library(
    name = "bazel_go_imagick",
    srcs = ["main.go"],
    importpath = "main",
    visibility = ["//visibility:private"],
    deps = ["@gopkg_in_gographics_imagick_v2_imagick//:go_default_library"],
)

go_binary(
    name = "bazel_go_imagick",
    embed = [":bazel_go_imagick"],
    visibility = ["//visibility:public"],
)
