"""
    abstract type ExtremeValueModel end

`ExtremeValueModel` is any type of statistical model used to represent and analyze extreme values in a dataset.
Any ExtremeValueModel implements the following functions:
* `getDistribution`
* `likelihood`
* `loglikelihood`
"""
abstract type ExtremeValueModel end

getModelParameters(model::ExtremeValueModel) = _getModelParameters(model)

getModelData(model::ExtremeValueModel) = _getModelData(model)

"""
    getDistribution(model::ExtremeValueModel,θ::NamedTuple)

Get the probability distribution associated with the extreme value model given the parameters θ.
"""
getDistribution(model::ExtremeValueModel,θ::NamedTuple) =_getDistribution(model,θ)

"""
    loglikelihood(model::ExtremeValueModel,θ::NamedTuple)

Compute the loglikelihood of the data linked to an extreme value model given the parameters θ.
"""
loglikelihood(model::ExtremeValueModel,θ::NamedTuple) = sum(logpdf(getDistribution(model,θ), getModelData(model)))

"""
    likelihood(model::ExtremeValueModel,θ::NamedTuple)

Compute the likelihood of the data linked to an extreme value model given the parameters θ.
"""
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