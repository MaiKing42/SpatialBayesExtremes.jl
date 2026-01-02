"""
    abstract type RegressionExtremeValueModel{D<:UnivariateDistribution} <: ContinuousExtremeValueModel end

An abstract type for regression extreme value models.
"""
abstract type RegressionExtremeValueModel{D<:UnivariateDistribution} <: ContinuousExtremeValueModel end

# Evaluate distribution parameters given model and parameter values
evaluateDistributionParameters(model::RegressionExtremeValueModel, θ::NamedTuple) = _evaluateDistributionParameters(model, model.data.covariates; θ...)

evaluateDistributionParameters(model::RegressionExtremeValueModel, covariates::DataFrame, θ::NamedTuple) = _evaluateDistributionParameters(model, covariates; θ...)

evaluateJacobianDistributionParameters(model::RegressionExtremeValueModel, θ::NamedTuple) = _evaluateJacobianDistributionParameters(model; θ...)

evaluateJacobianDistributionParameters(model::RegressionExtremeValueModel, covariates::DataFrame, θ::NamedTuple) = _evaluateJacobianDistributionParameters(model, covariates; θ...)

_getDistribution(model::RegressionExtremeValueModel{D}, θ::NamedTuple) where {D} = D.(evaluateDistributionParameters(model, θ))

_getDistribution(model::RegressionExtremeValueModel{D}, covariates::DataFrame, θ::NamedTuple) where {D} = D.(evaluateDistributionParameters(model, covariates, θ))

function loglikelihoodDerivative(model::RegressionExtremeValueModel, θ::NamedTuple)
    param_names = getModelParameters(model)
    dists = getDistribution(model, θ)
    scores = scoreFunction.(dists, model.data)
    jacobians = evaluateJacobian_parameterModels(model, θ)
    return NamedTuple(k=>(map(x->x[k],scores)'*jacobians[k])' for k in param_names)
end

include(joinpath("RegressionExtremeValueModels","regressiongevmodel.jl"))
include(joinpath("RegressionExtremeValueModels","regressiongpdmodel.jl"))