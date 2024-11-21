"""
    UnivariateExtremeValueModel

Abstract type for univariate extreme value models.
"""
abstract type UnivariateExtremeValueModel{D<:UnivariateDistribution} <: DiscreteDistributionModel end

function evaluateParameters(model::UnivariateExtremeValueModel,θ::NamedTuple) end

function evaluateDerivativeParameters(model::UnivariateExtremeValueModel,θ::NamedTuple) end

function get_distribution(model::UnivariateExtremeValueModel{D},θ::NamedTuple) where {D}
    return D(evaluate_parameters(model,θ)...)
end

function loglikelihood_derivative(model::UnivariateExtremeValueModel{D},θ::NamedTuple) where {D}
    params = get_parameters(model)
    dist = get_distribution(model,θ)
    scores = score_function(dist,model.data)
    derivatives = evaluateDerivativeParameters(model,θ)
    return NamedTuple(k=>sum(map(x->x[k],scores))*derivatives[k] for k in params)
end


include(joinpath("UnivariateExtremeValueModels","univariategevmodel.jl"))
include(joinpath("UnivariateExtremeValueModels","univariategpdmodel.jl"))