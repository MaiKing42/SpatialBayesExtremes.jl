"""
    abstract type ContinuousExtremeValueModel <: ExtremeValueModel end

An abstract type for continuous extreme value models.
"""
abstract type ContinuousExtremeValueModel <: ExtremeValueModel end

"""
    getDistribution(model::ContinuousExtremeValueModel, covariates::DataFrame, θ::NamedTuple)
Returns the probability distribution associated with the model and parameters for an observation sites indicated by `covariates`.
"""
getDistribution(model::ContinuousExtremeValueModel, covariates::DataFrame, θ::NamedTuple) = _getDistribution(model, covariates, θ)

include(joinpath("ContinuousExtremeValueModels","regressionextremevaluemodel.jl"))