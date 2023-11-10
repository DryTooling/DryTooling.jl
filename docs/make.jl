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

# bib_filepath = joinpath(@__DIR__, "src/references.bib")
# bib = CitationBibliography(bib_filepath)

DocMeta.setdocmeta!(DryToolingCore, :DocTestSetup, :(using DryToolingCore); recursive=true)
# DocMeta.setdocmeta!(PkgOther, :DocTestSetup, :(using PkgOther))

format = Documenter.HTML(;
    prettyurls = get(ENV, "CI", "false") == "true",
    canonical  = "https://$(GITHUBUSER).github.io/$(SITENAME)",
    repolink   = REPOLINK,
    edit_link  = "main",
    assets     = String[],
)

pages  = [
    "Home" => "index.md"
]
# format = Documenter.LaTeX()

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
    pages    = pages
)

deploydocs(;
    repo      = "github.com/$(GITHUBUSER)/$(SITENAME)",
    devbranch = "main"
)
