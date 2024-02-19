"""
    ExtremeValueModel

Abstract type for extreme value models.
"""
abstract type ExtremeValueModel end

include(joinpath("ExtremeValueModels","univariateextremevaluemodel.jl"))
include(joinpath("ExtremeValueModels","regressionextremevaluemodel.jl"))

function getdistribution end

function loglikelihood(model::ExtremeValueModel,θ)
    distributions = getdistribution(θ)
    return sum(logpdf.(distributions, model.data))
end

likelihood(model::ExtremeValueModel,θ) = exp(loglikelihood(model,θ))
