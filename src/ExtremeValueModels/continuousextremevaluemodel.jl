"""
    ContinuousExtremeValueModel

Abstract type for continuous extreme value models.
"""

abstract type ContinuousExtremeValueModel <: ExtremeValueModel end

function get_distribution(model::ContinuousExtremeValueModel, covariates::DataFrame, θ::NamedTuple) end

include(joinpath("ContinuousExtremeValueModels","regressionextremevaluemodel.jl"))