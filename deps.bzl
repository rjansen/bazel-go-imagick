load("@bazel_gazelle//:deps.bzl", "go_repository")

def go_dependencies():
    go_repository(
        name = "gopkg_in_gographics_imagick_v2_imagick",
        importpath = "gopkg.in/gographics/imagick.v2/imagick",
        sum = "h1:ewRsUQk3QkjGumERlndbFn/kTYRjyMaPY5gxwpuAhik=",
        version = "v2.6.0",
    )
