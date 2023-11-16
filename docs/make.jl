# -*- coding: utf-8 -*-
using Documenter
using Documenter.DocMeta: setdocmeta!
using DocumenterCitations
using TOML
using YAML
using Pkg
LOCALDOCS = true

##############################################################################
# HELPERS
#
# Note: this was proferred over the `Pkg.develop` approach
##############################################################################

"Path to *this* file in *this* directory."
this(f) = joinpath(@__DIR__, f)

"Copy backup of `Project.toml` to temporary file."
backuptoml()  = cp(this("Project.toml"), this("TMP.toml"),     force = true)

"Reverse temporary `Project.toml` backup. "
cleanuptoml() = cp(this("TMP.toml"),     this("Project.toml"), force = true)

"Retrieve data in *this* `Project.toml` file."
function getprojecttoml()
    return open(this("Project.toml")) do io
        TOML.parse(io)
    end
end

"Feed development packages to *this* `Project.toml` file."
function devpackages(pkgs)
    for (key, value) in pkgs
        Pkg.develop(path = this("../src/$(key).jl"))
    end

    # project_data = getprojecttoml()
    # deps = project_data["deps"]
    
    # for (key, value) in pkgs
    #     if !haskey(deps, key)
    #         deps[key] = value
    #     end
    # end
    
    # project_data["deps"] = sort(deps)
    
    # open(this("Project.toml"), "w") do io
    #     TOML.print(io, project_data)
    # end
end

##############################################################################
# PACKAGES BLOCK
##############################################################################

DRYTOOLING = Dict(
    "DryToolingCore"     => "8d904351-f17f-419c-aa8d-05d4f5cffd52",
    "DryToolingGranular" => "c4cd2e39-2c11-49af-bb08-d9d53d680cb6",
    "DryToolingKinetics" => "6073c425-3840-42bf-8fb8-df8bffbffcc3",
)

if LOCALDOCS
    backuptoml()
    devpackages(DRYTOOLING)
end

using DryToolingCore
using DryToolingGranular
using DryToolingKinetics

modules = [
    DryToolingCore,
    DryToolingGranular,
    DryToolingKinetics,
]

##############################################################################
# WORKFLOW
##############################################################################

for m in modules
    setdocmeta!(m, :DocTestSetup, :(using m); warn = false, recursive = true)
end

conf = YAML.load_file(this("make.yaml"))
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
        CitationBibliography(this("src/references.bib"))
    ],
)

deploydocs(; repo = repo, devbranch = "main")

if LOCALDOCS
    cleanuptoml()
end
