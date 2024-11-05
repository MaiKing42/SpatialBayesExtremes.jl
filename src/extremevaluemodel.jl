"""
    ExtremeValueModel

Abstract type for extreme value models.
"""
abstract type ExtremeValueModel end

function get_distribution(model::ExtremeValueModel,θ::NamedTuple) end

loglikelihood(model::ExtremeValueModel,θ::NamedTuple) = sum(logpdf.(get_distibution(model,θ), model.data))

likelihood(model::ExtremeValueModel,θ::NamedTuple) = exp(loglikelihood(model,θ))


include(joinpath("ExtremeValueModels","discreteextremevaluemodel.jl"))
include(joinpath("ExtremeValueModels","continuousextremevaluemodel.jl"))