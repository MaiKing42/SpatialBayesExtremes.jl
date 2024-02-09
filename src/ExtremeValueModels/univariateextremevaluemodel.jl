"""
    UnivariateExtremeValueModel

Abstract type for univariate extreme value models.
"""
abstract type UnivariateExtremeValueModel <: ExtremeValueModel end

include(joinpath("UnivariateExtremeValueModels","univariategevmodel.jl"))