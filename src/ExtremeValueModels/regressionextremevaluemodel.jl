"""
    RegressionExtremeValueModel

Abstract type for regression extreme value models.
"""
abstract type RegressionExtremeValueModel <: ExtremeValueModel end
"""
    get_distribution(model::RegressionExtremeValueModel, θ::NamedTuple)
"""
get_distribution(
    model::RegressionExtremeValueModel,
    θ::NamedTuple
) = 
generate_distribution.(
    typeof(model), 
    evaluateParameters(model, θ)...
)

include(joinpath("RegressionExtremeValueModels","regressiongevmodel.jl"))
include(joinpath("RegressionExtremeValueModels","regressiongpdmodel.jl"))