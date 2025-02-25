"""
    ExtremeValueModel

Abstract type for extreme value models.
"""
abstract type ExtremeValueModel end

function getModelParameters(model::ExtremeValueModel) end

function getDistribution(model::ExtremeValueModel,θ::NamedTuple) end

loglikelihood(model::ExtremeValueModel,θ::NamedTuple) = sum(logpdf(getDistribution(model,θ), model.data))

likelihood(model::ExtremeValueModel,θ::NamedTuple) = exp(loglikelihood(model,θ))

function loglikelihoodDerivative(model::ExtremeValueModel,θ::NamedTuple)
    derivative = NamedTuple()
    keys = getModelParameters(model)
    for key in keys
        partialDerivative = ForwardDiff.derivative(θ -> loglikelihood(model, merge(θ, key => θ[key])), θ[key])
        derivative = merge(derivative, [key => partialDerivative])
    end
    return derivative
end



include(joinpath("ExtremeValueModels","discreteextremevaluemodel.jl"))
include(joinpath("ExtremeValueModels","continuousextremevaluemodel.jl"))