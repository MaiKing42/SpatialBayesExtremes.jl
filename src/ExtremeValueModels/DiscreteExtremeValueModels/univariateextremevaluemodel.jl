"""
    UnivariateExtremeValueModel

Abstract type for univariate extreme value models.
"""
abstract type UnivariateExtremeValueModel{D<:UnivariateDistribution} <: DiscreteDistributionModel end

function evaluateParameters(model::UnivariateExtremeValueModel,θ::NamedTuple) end

function evaluateDerivative_Parameters(model::UnivariateExtremeValueModel,θ::NamedTuple) end

function get_distribution(model::UnivariateExtremeValueModel{D},θ::NamedTuple) where {D}
    return D(evaluate_parameters(model,θ)...)
end

loglikelihood_derivative(model::UnivariateExtremeValueModel{D},θ::NamedTuple) where {D}
    params = evaluate_parameters(model,θ)
    params_derivatives = evaluateDerivative_Parameters(model,θ)
    

include(joinpath("UnivariateExtremeValueModels","univariategevmodel.jl"))
include(joinpath("UnivariateExtremeValueModels","univariategpdmodel.jl"))