# -*- coding: utf-8 -*-
using Documenter
using Documenter.DocMeta: setdocmeta!
using DocumenterCitations
using YAML

# For local generation add these to Project.toml:
# DryToolingCore = "8d904351-f17f-419c-aa8d-05d4f5cffd52"
# DryToolingGranular = "c4cd2e39-2c11-49af-bb08-d9d53d680cb6"
# DryToolingKinetics = "6073c425-3840-42bf-8fb8-df8bffbffcc3"

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


bib = CitationBibliography(joinpath(@__DIR__, "src/references.bib"))
conf = YAML.load_file(joinpath(@__DIR__, "make.yaml"))

name = conf["name"]
mail = conf["mail"]
user = conf["user"]
site = conf["site"]
repo = "https://github.com/$(user)/$(site)"

formats = [
    Documenter.HTML(;
        prettyurls = get(ENV, "CI", "false") == "true",
        canonical  = "https://$(user).github.io/$(site)",
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
    sitename = site,
    authors  = "$(name) <$(mail)>",
    repo     = "$(repo)/blob/{commit}{path}#{line}",
    pages    = map(parsepages, conf["pages"]),
    plugins  = [bib],
)

deploydocs(;
    repo      = repo,
    devbranch = "main"
)
