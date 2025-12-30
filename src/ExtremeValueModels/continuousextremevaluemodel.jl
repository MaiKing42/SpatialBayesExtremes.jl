abstract type ContinuousExtremeValueModel <: ExtremeValueModel end

function getDistribution(model::ContinuousExtremeValueModel, covariates::DataFrame, θ::NamedTuple) end

include(joinpath("ContinuousExtremeValueModels","regressionextremevaluemodel.jl"))