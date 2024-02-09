"""
    ExtremeValueModel

Abstract type for extreme value models.
"""
abstract type ExtremeValueModel end

include(joinpath("ExtremeValueModels","univariateextremevaluemodel.jl"))