"""
    RegressionExtremeValueModel

Abstract type for regression extreme value models.
"""
abstract type RegressionExtremeValueModel{D<:UnivariateDistribution} <: ContinuousExtremeValueModel end

get_distribution(model::RegressionExtremeValueModel{D},θ::NamedTuple) where {D} = D.(model, evaluateParameters(θ))

get_distribution(model::RegressionExtremeValueModel{D},covariates::DataFrame,θ::NamedTuple) where {D} = D.(model, evaluateParameters(covariates,θ))

function loglikelihood_derivative(model::RegressionExtremeValueModel,θ::NamedTuple)
    param_names = get_parameters(model)
    params = evaluateParameters(model,θ)
    dists = get_distribution(model,θ)
    scores = score_function.(dists, model.data)
    # transform scores into named tuple of vectors