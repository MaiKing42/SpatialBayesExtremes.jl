"""
    RegressionExtremeValueModel

Abstract type for regression extreme value models.
"""
abstract type RegressionExtremeValueModel <: ExtremeValueModel end

getdistribution(model::RegressionExtremeValueModel, θ::NamedTuple) = generateDistribution.(model, evaluateParameters(model, θ)...)

include(joinpath("RegressionExtremeValueModels","regressiongevmodel.jl"))
include(joinpath("RegressionExtremeValueModels","regressiongpdmodel.jl"))