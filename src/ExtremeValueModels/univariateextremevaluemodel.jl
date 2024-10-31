"""
    UnivariateExtremeValueModel

Abstract type for univariate extreme value models.
"""
abstract type UnivariateExtremeValueModel{D<:UnivariateDistribution} <: DiscreteExtremeVaöueModel end

"""
    get_distribution(model::UnivariateExtremeValueModel, θ::NamedTuple)
"""
get_distribution(model::UnivariateExtremeValueModel{D},θ::NamedTuple) where {D} = D.(θ...)

loglikelihood_derivative(model::UnivariateExtremeValueModel,θ::NamedTuple) = map(sum, score_function(model,θ))

include(joinpath("UnivariateExtremeValueModels","univariategevmodel.jl"))
include(joinpath("UnivariateExtremeValueModels","univariategpdmodel.jl"))