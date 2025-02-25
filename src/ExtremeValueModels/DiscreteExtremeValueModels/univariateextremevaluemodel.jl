"""
    UnivariateExtremeValueModel

Abstract type for univariate extreme value models.
"""
abstract type UnivariateExtremeValueModel{D<:UnivariateDistribution} <: DiscreteExtremeValueModel end

function evaluateDistributionParameters(model::UnivariateExtremeValueModel,θ::NamedTuple) end

function evaluateDerivativeDistributionParameters(model::UnivariateExtremeValueModel,θ::NamedTuple) end

function get_distribution(model::UnivariateExtremeValueModel{D},θ::NamedTuple) where {D}
    return D(evaluateDistributionParameters(model,θ)...)
end

function loglikelihood_derivative(model::UnivariateExtremeValueModel{D},θ::NamedTuple) where {D}
    params = getModelParameters(model)
    dist = get_distribution(model,θ)
    scores = score_function(dist,model.data)
    derivatives = evaluateDerivativeDistributionParameters(model,θ)
    return NamedTuple(k=>sum(map(x->x[k],scores))*derivatives[k] for k in params)
end


include(joinpath("UnivariateExtremeValueModels","univariategevmodel.jl"))
include(joinpath("UnivariateExtremeValueModels","univariategumbelmodel.jl"))
include(joinpath("UnivariateExtremeValueModels","univariategpdmodel.jl"))