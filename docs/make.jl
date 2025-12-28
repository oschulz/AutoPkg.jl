# Use
#
#     DOCUMENTER_DEBUG=true julia --color=yes make.jl local [nonstrict] [fixdoctests]
#
# for local builds.

using Documenter
using AutoPkg

# Doctest setup
DocMeta.setdocmeta!(
    AutoPkg,
    :DocTestSetup,
    :(using AutoPkg);
    recursive = true
)

makedocs(
    sitename = "AutoPkg",
    modules = [AutoPkg],
    format = Documenter.HTML(
        prettyurls = !("local" in ARGS),
        canonical = "https://oschulz.github.io/AutoPkg.jl/stable/"
    ),
    pages = [
        "Home" => "index.md",
        "API" => "api.md",
        "LICENSE" => "LICENSE.md"
    ],
    doctest = ("fixdoctests" in ARGS) ? :fix : true,
    linkcheck = !("nonstrict" in ARGS),
    warnonly = ("nonstrict" in ARGS)
)

deploydocs(
    repo = "github.com/oschulz/AutoPkg.jl.git",
    forcepush = true,
    push_preview = true
)
