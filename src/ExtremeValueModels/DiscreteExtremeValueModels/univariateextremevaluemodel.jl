"""
    UnivariateExtremeValueModel{D<:UnivariateDistribution} <: DiscreteExtremeValueModel end

A `UnivariateExtremeValueModel` is any type of discrete extreme value model used to represent and analyze univariate extreme values in a dataset.
"""
abstract type UnivariateExtremeValueModel{D<:UnivariateDistribution} <: DiscreteExtremeValueModel end

#get from model parameters to distribution parameters
evaluateDistributionParameters(model::UnivariateExtremeValueModel,θ::NamedTuple) = _evaluateDistributionParameters(model;θ...)

evaluateDerivativeDistributionParameters(model::UnivariateExtremeValueModel,θ::NamedTuple) = _evaluateDerivativeDistributionParameters(model;θ...)

function _getDistribution(model::UnivariateExtremeValueModel{D},θ::NamedTuple) where {D}
    return D(evaluateDistributionParameters(model,θ)...)
end

function loglikelihoodDerivative(model::UnivariateExtremeValueModel{D},θ::NamedTuple) where {D}
    params = getModelParameters(model)
    dist = getDistribution(model,θ)
    scores = scoreFunction(dist,model.data)
    derivatives = evaluateDerivativeDistributionParameters(model,θ)
    return NamedTuple(k=>sum(map(x->x[k],scores))*derivatives[k] for k in params)
end


include(joinpath("UnivariateExtremeValueModels","univariategevmodel.jl"))
include(joinpath("UnivariateExtremeValueModels","univariategumbelmodel.jl"))
include(joinpath("UnivariateExtremeValueModels","univariategpdmodel.jl"))