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

function parsepages(x)
    name, target = x["name"], x["target"]
    if isa(target, Vector{Dict{Any, Any}})
        return name => map(parsepages, target)
    end
    return name => target
end

authors(c)   = "$(c["name"]) <$(c["mail"])> and contributors"
repolink(c)  = "https://github.com/$(c["user"])/$(c["site"])"
canonical(c) = "https://$(c["user"]).github.io/$(c["site"])"

conf = YAML.load_file(joinpath(@__DIR__, "make.yaml"))

formats = [
    Documenter.HTML(;
        prettyurls = get(ENV, "CI", "false") == "true",
        canonical  = canonical(conf),
        repolink   = repolink(conf),
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
    sitename = site,
    authors  = authors(conf),
    repo     = "$(repolink(conf))/blob/{commit}{path}#{line}",
    pages    = map(parsepages, conf["pages"]),
    plugins  = [
        CitationBibliography(joinpath(@__DIR__, "src/references.bib"))
    ],
)

deploydocs(;
    repo      = repo,
    devbranch = "main"
)
