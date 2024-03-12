"""
    ExtremeValueModel

Abstract type for extreme value models.
"""
abstract type ExtremeValueModel end

function loglikelihood(model::ExtremeValueModel,θ)
    distributions = get_distribution(model,θ)
    return sum(logpdf.(distributions, model.data))
end

likelihood(model::ExtremeValueModel,θ) = exp(loglikelihood(model,θ))

include(joinpath("ExtremeValueModels","univariateextremevaluemodel.jl"))
include(joinpath("ExtremeValueModels","regressionextremevaluemodel.jl"))