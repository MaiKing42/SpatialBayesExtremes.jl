"""
    RegressionExtremeValueModel

Abstract type for regression extreme value models.
"""
abstract type RegressionExtremeValueModel{D<:UnivariateDistribution} <: ContinuousExtremeValueModel end

function evaluateDistributionParameters(model::RegressionExtremeValueModel, θ::NamedTuple) end

function evaluateDistributionParameters(model::RegressionExtremeValueModel, covariates::DataFrame, θ::NamedTuple) end

function evaluateJacobianDistributionParameters(model::RegressionExtremeValueModel, θ::NamedTuple) end

function evaluateJacobianDistributionParameters(model::RegressionExtremeValueModel, covariates::DataFrame, θ::NamedTuple) end

get_distribution(model::RegressionExtremeValueModel{D}, θ::NamedTuple) where {D} = D.(evaluateDistributionParameters(model, θ))

get_distribution(model::RegressionExtremeValueModel{D}, covariates::DataFrame, θ::NamedTuple) where {D} = D.(evaluateDistributionParameters(model, covariates, θ))

function loglikelihood_derivative(model::RegressionExtremeValueModel, θ::NamedTuple)
    param_names = getModelParameters(model)
    dists = get_distribution(model, θ)
    scores = score_function.(dists, model.data)
    jacobians = evaluateJacobian_parameterModels(model, θ)
    return NamedTuple(k=>(map(x->x[k],scores)'*jacobians[k])' for k in param_names)
end

include(joinpath("RegressionExtremeValueModels","regressiongevmodel.jl"))
include(joinpath("RegressionExtremeValueModels","regressiongpdmodel.jl"))