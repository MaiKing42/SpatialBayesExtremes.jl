"""
    ExtremeValueModel

Abstract type for extreme value models.
"""
abstract type ExtremeValueModel end

loglikelihood(model::ExtremeValueModel,θ::NamedTuple) = sum(logpdf.(get_distibutions(model,θ), model.data))

likelihood(model::ExtremeValueModel,θ::NamedTuple) = exp(loglikelihood(model,θ))

score_function(model::ExtremeValueModel,θ::NamedTuple) =  NamedTuple(k=>ForwardDiff.derivative(x -> sum(logpdf.(get_distributions(model,merge(θ, [k=>x])...),1.0)),v) for (k,v) in pairs(θ))

include(joinpath("DiscreteExtremeValueModels","discreteextremevaluemodel.jl"))
include(joinpath("ContinuousExtremeValueModels","continuousextremevaluemodel.jl"))