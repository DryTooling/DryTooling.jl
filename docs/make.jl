# -*- coding: utf-8 -*-
using Documenter
using DocumenterCitations
using DryToolingCore
using DryToolingGranular

const NAME = "Walter Dal'Maz Silva"
const MAIL = "walter.dalmazsilva.manager@gmail.com"
const GITHUBUSER = "DryTooling"
const SITENAME = "DryTooling.jl"
const REPOLINK = "https://github.com/$(GITHUBUSER)/$(SITENAME)"

DocMeta.setdocmeta!(DryToolingCore, :DocTestSetup, :(using DryToolingCore); recursive=true)
# DocMeta.setdocmeta!(PkgOther, :DocTestSetup, :(using PkgOther))

bib_filepath = joinpath(@__DIR__, "src/references.bib")
bib = CitationBibliography(bib_filepath)

formats = [
    Documenter.HTML(;
        prettyurls = get(ENV, "CI", "false") == "true",
        canonical  = "https://$(GITHUBUSER).github.io/$(SITENAME)",
        repolink   = REPOLINK,
        edit_link  = "main",
        assets     = String[],
    ),
    Documenter.LaTeX(;
        platform = "tectonic",
        tectonic = "$(@__DIR__)/tectonic.exe"
    )
]

pages  = [
    "Home" => "index.md",
    
    ################################################################

    "Core" => [
        "DryToolingCore/index.md",
        "DryToolingCore/abstract.md"
    ],

    ################################################################

    "Granular" => [
        "DryToolingGranular/index.md",
    ],

    ################################################################

    "Theory Guide"      => [
        "Granular"         => "DryToolingGranular/theory.md",
        "References"       => "references.md",
    ],

    ################################################################

    "Validation Studies" => [
        "Kramers' model" => "DryToolingGranular/validation/kramers-model.md",
    ],

    ################################################################

    "Reference API"         => "api.md",
    "Table of Contents"     => "toc.md",
    "Developement Guide"    => "dev.md",
]

modules = [
    DryToolingCore,
    DryToolingGranular,
]

makedocs(;
    modules  = modules,
    format   = formats[1],
    clean    = true,
    sitename = SITENAME,
    authors  = "$(NAME) <$(MAIL)>",
    repo     = "$(REPOLINK)/blob/{commit}{path}#{line}",
    pages    = pages,
    plugins  = [bib],
)

deploydocs(;
    repo      = "github.com/$(GITHUBUSER)/$(SITENAME)",
    devbranch = "main"
)
