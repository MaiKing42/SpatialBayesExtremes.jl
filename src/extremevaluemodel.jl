"""
    ExtremeValueModel

Abstract type for extreme value models.
"""
abstract type ExtremeValueModel end

include(joinpath("ExtremeValueModels","univariateextremevaluemodel.jl"))
include(joinpath("ExtremeValueModels","regressionextremevaluemodel.jl"))

function loglikelihood(model::ExtremeValueModel,θ)
    distributions = getdistribution(model,θ)
    return sum(logpdf.(distributions, model.data))
end

likelihood(model::ExtremeValueModel,θ) = exp(loglikelihood(model,θ))
