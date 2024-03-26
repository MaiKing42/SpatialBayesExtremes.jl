"""
    UnivariateExtremeValueModel

Abstract type for univariate extreme value models.
"""
const UnivariateExtremeValueModel = ExtremeValueModel{Univariate}

"""
    get_distribution(model::UnivariateExtremeValueModel, θ::NamedTuple)
"""
get_distribution(model::UnivariateExtremeValueModel{D},θ::NamedTuple) where {D} = D.(model, θ...)

include(joinpath("UnivariateExtremeValueModels","univariategevmodel.jl"))
include(joinpath("UnivariateExtremeValueModels","univariategpdmodel.jl"))