"""
    ExtremeValueModel

Abstract type for extreme value models.
"""
abstract type ExtremeValueModel end

"""
    DiscreteExtremeValueModel

Abstract type for discrete extreme value models.
"""

abstract type DiscreteExtremeValueModel <: ExtremeValueModel end

"""
    ContinuousExtremeValueModel

Abstract type for continuous extreme value models.
"""

abstract type ContinuousExtremeValueModel <: ExtremeValueModel end

loglikelihood(model::ExtremeValueModel,θ::NamedTuple) = sum(logpdf.(get_distibutions(model,θ), model.data))

likelihood(model::ExtremeValueModel,θ::NamedTuple) = exp(loglikelihood(model,θ))

score_function(model::ExtremeValueModel,θ::NamedTuple) =  NamedTuple(k=>ForwardDiff.derivative(x -> sum(logpdf.(get_distributions(model,merge(θ, [k=>x])...),1.0)),v) for (k,v) in pairs(θ))

score_function(model::UnivariateExtremeValueModel{GeneralizedExtremeValue},θ::NamedTuple) where {T} = score_gev.(model.data,θ.μ,θ.σ,θ.ξ)

include(joinpath("DiscreteExtremeValueModel","univariateextremevaluemodel.jl"))
include(joinpath("ContinuousExtremeValueModel","regressionextremevaluemodel.jl"))