"""
    DiscreteExtremeValueModel <: ExtremeValueModel

An abstract type for discrete extreme value models.
"""
abstract type DiscreteExtremeValueModel <: ExtremeValueModel end

include(joinpath("DiscreteExtremeValueModels","univariateextremevaluemodel.jl"))