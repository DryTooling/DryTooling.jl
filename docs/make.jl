# -*- coding: utf-8 -*-
using Documenter
using DocumenterCitations
using DryToolingCore
# using PkgOther

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

    "Theory Guide"      => [
        "References"       => "references.md",
    ],

    ################################################################

    "Reference API"         => "api.md",
    "Table of contents"     => "toc.md",
]

format = formats[1]

makedocs(;
    modules  = [
        DryToolingCore,
        # PkgOther
    ],
    format   = format,
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
