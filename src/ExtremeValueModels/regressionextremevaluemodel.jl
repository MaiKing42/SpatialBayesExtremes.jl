"""
    RegressionExtremeValueModel

Abstract type for regression extreme value models.
"""
const RegressionExtremeValueModel = ExtremeValueModel{Regression}
"""
    get_distribution(model::RegressionExtremeValueModel, θ::NamedTuple)
"""
get_distribution(model::RegressionExtremeValueModel{D},θ::NamedTuple) where {D} = D.(model, evaluateParameters(model, θ)...)

include(joinpath("RegressionExtremeValueModels","regressiongevmodel.jl"))
include(joinpath("RegressionExtremeValueModels","regressiongpdmodel.jl"))