abstract type ContinuousExtremeValueModel <: ExtremeValueModel end

getDistribution(model::ContinuousExtremeValueModel, covariates::DataFrame, θ::NamedTuple) = _getDistribution(model, covariates, θ)

include(joinpath("ContinuousExtremeValueModels","regressionextremevaluemodel.jl"))