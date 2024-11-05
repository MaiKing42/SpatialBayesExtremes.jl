"""
    ExtremeValueModel

Abstract type for extreme value models.
"""
abstract type ExtremeValueModel end

function get_parameters(model::ExtremeValueModel) end

function get_distribution(model::ExtremeValueModel,θ::NamedTuple) end

loglikelihood(model::ExtremeValueModel,θ::NamedTuple) = sum(logpdf.(get_distibution(model,θ), model.data))

likelihood(model::ExtremeValueModel,θ::NamedTuple) = exp(loglikelihood(model,θ))

function loglikelihood_derivative(model::ExtremeValueModel,θ::NamedTuple)
    derivative = NamedTuple()
    keys = get_parameters(model)
    for key in keys
        partial_derivative = ForwardDiff.derivative(θ -> loglikelihood(model, merge(θ, key => θ[key])), θ[key])
        derivative = merge(derivative, [key => partial_derivative])
    end
    return derivative
end



include(joinpath("ExtremeValueModels","discreteextremevaluemodel.jl"))
include(joinpath("ExtremeValueModels","continuousextremevaluemodel.jl"))