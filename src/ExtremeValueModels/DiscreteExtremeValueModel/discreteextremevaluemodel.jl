"""
    DiscreteExtremeValueModel

Abstract type for discrete extreme value models.
"""

abstract type DiscreteExtremeValueModel <: ExtremeValueModel end

include(joinpath("UnivariateExtremeValueModels","univariateextremevaluemodel.jl"))