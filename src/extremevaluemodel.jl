"""
T<:ModelType specifies the type of the Extreme Value model.
"""
abstract type ModelType end

"""
    Regression <: ModelType

Type for regression models.
"""
abstract type Regression <: ModelType end

"""
    Univariate <: ModelType

Type for univariate models.
"""
abstract type Univariate <: ModelType end

"""
    ExtremeValueModel{T,D}

Abstract type for extreme value models.
"""
abstract type ExtremeValueModel{T<:ModelType,D<:Distribution} end

loglikelihood(model::ExtremeValueModel,θ::NamedTuple) = sum(logpdf.(get_distibutions(model,θ), model.data))

likelihood(model::ExtremeValueModel,θ::NamedTuple) = exp(loglikelihood(model,θ))

score_function(model::ExtremeValueModel,θ::NamedTuple) =  NamedTuple(k=>ForwardDiff.derivative(x -> sum(logpdf.(get_distributions(model,merge(θ, [k=>x])...),1.0)),v) for (k,v) in pairs(θ))

score_function(model::ExtremeValueModel{T,GeneralizedExtremeValue},θ::NamedTuple) where {T} = score_gev.(model.data,θ.μ,θ.σ,θ.ξ)

include(joinpath("ExtremeValueModels","univariateextremevaluemodel.jl"))
include(joinpath("ExtremeValueModels","regressionextremevaluemodel.jl"))