"""
    RegressionExtremeValueModel

Abstract type for regression extreme value models.
"""
abstract type RegressionExtremeValueModel <: ExtremeValueModel end

include(joinpath("RegressionExtremeValueModels","regressiongevmodel.jl"))
include(joinpath("RegressionExtremeValueModels","regressiongpdmodel.jl"))

getDistribution(model::RegressionExtremeValueModel, θ::NamedTuple{(:location, :scale, :shape), Tuple{Array{Float64, 1}, Array{Float64, 1}, Array{Float64, 1}}}) = generateDistribution.(model, evaluateParameters(model, θ)...)