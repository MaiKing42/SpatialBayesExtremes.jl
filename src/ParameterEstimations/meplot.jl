function empiricalMeanExcess(data::Vector{T},threshold::T) where {T<:Real}
    return mean(data[data .> threshold] .- threshold)
end

function empiricalMeanExcessPlot(data::Vector{T}) where {T<:Real}
    n = length(data)
    return [mean_excess(data,data[i]) for i in 1:n-1]
end

include(joinpath("MEMethods","meplot_gpd.jl"))
include(joinpath("MEMethods","hill_gpd.jl"))