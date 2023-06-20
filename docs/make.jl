using SpatialBayesExtremes
using Documenter

DocMeta.setdocmeta!(SpatialBayesExtremes, :DocTestSetup, :(using SpatialBayesExtremes); recursive=true)

makedocs(;
    modules=[SpatialBayesExtremes],
    authors="Marcel Kipping <kipping.marcel@web.de> and contributors",
    repo="https://github.com/MaiKing42/SpatialBayesExtremes.jl/blob/{commit}{path}#{line}",
    sitename="SpatialBayesExtremes.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://MaiKing42.github.io/SpatialBayesExtremes.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/MaiKing42/SpatialBayesExtremes.jl",
    devbranch="master",
)
