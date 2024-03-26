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

function loglikelihood(model::ExtremeValueModel,θ)
    distributions = get_distribution(model,θ)
    return sum(logpdf.(distributions, model.data))
end

likelihood(model::ExtremeValueModel,θ) = exp(loglikelihood(model,θ))

include(joinpath("ExtremeValueModels","univariateextremevaluemodel.jl"))
include(joinpath("ExtremeValueModels","regressionextremevaluemodel.jl"))