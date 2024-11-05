"""
    UnivariateExtremeValueModel

Abstract type for univariate extreme value models.
"""
abstract type UnivariateExtremeValueModel{D<:UnivariateDistribution} <: DiscreteExtremeValueModel end

loglikelihood_derivative(model::UnivariateExtremeValueModel,θ::NamedTuple) = map(sum, score_function(model,θ))

include(joinpath("UnivariateExtremeValueModels","univariategevmodel.jl"))
include(joinpath("UnivariateExtremeValueModels","univariategpdmodel.jl"))