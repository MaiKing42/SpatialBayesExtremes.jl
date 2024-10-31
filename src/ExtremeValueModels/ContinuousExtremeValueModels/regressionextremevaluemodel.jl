"""
    RegressionExtremeValueModel

Abstract type for regression extreme value models.
"""
abstract type RegressionExtremeValueModel{D<:UnivariateDistribution} <: ContinuousExtremeValueModel end

"""
    get_distribution(model::RegressionExtremeValueModel, θ::NamedTuple)
"""
get_distribution(model::RegressionExtremeValueModel{D},θ::NamedTuple) where {D} = D.(evaluateParameters(model, θ)...)

function loglikelihood_derivative(model::RegressionExtremeValueModel,θ::NamedTuple)
    scores = score_function(model,evaluateParameters(model, θ))
    jacobians = evaluateJacobian_parameterModels(model, θ)
    return NamedTuple(k=>(scores[k]'*jacobians[k])' for k in keys(scores))
end

include(joinpath("RegressionExtremeValueModels","regressiongevmodel.jl"))
include(joinpath("RegressionExtremeValueModels","regressiongpdmodel.jl"))