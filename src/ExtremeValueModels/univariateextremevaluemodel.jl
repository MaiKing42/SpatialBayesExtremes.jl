"""
    UnivariateExtremeValueModel

Abstract type for univariate extreme value models.
"""
abstract type UnivariateExtremeValueModel <: ExtremeValueModel end

function getValues(model::UnivariateExtremeValueModel)
    return model.values
end

include(joinpath("UnivariateExtremeValueModels","univariategevmodel.jl"))
include(joinpath("UnivariateExtremeValueModels","univariategpdmodel.jl"))