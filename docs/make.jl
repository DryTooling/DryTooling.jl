# -*- coding: utf-8 -*-
using Documenter
using Documenter.DocMeta: setdocmeta!
using DocumenterCitations
using YAML

using DryToolingCore
using DryToolingGranular
using DryToolingKinetics

setdocmeta!(DryToolingCore,     :DocTestSetup, :(using DryToolingCore);     recursive=true)
setdocmeta!(DryToolingGranular, :DocTestSetup, :(using DryToolingGranular); recursive=true)
setdocmeta!(DryToolingKinetics, :DocTestSetup, :(using DryToolingKinetics); recursive=true)

modules = [
    DryToolingCore,
    DryToolingGranular,
    DryToolingKinetics,
]

conf = YAML.load_file(joinpath(@__DIR__, "make.yaml"))
repo  = "https://github.com/$(conf["user"])/$(conf["site"])"

formats = [
    Documenter.HTML(;
        prettyurls = get(ENV, "CI", "false") == "true",
        canonical  = "https://$(conf["user"]).github.io/$(conf["site"])",
        repolink   = repo,
        edit_link  = "main",
        assets     = String[],
    ),
    Documenter.LaTeX(;
        platform = "tectonic",
        tectonic = "$(@__DIR__)/tectonic.exe"
    )
]

makedocs(;
    modules  = modules,
    format   = formats[1],
    clean    = true,
    sitename = conf["site"],
    authors  = "$(conf["name"]) <$(conf["mail"])> and contributors",
    repo     = "$(repo)/blob/{commit}{path}#{line}",
    pages    = map(x->x["name"]=>x["target"], conf["pages"]),
    plugins  = [
        CitationBibliography(joinpath(@__DIR__, "src/references.bib"))
    ],
)

deploydocs(; repo = repo, devbranch = "main")
