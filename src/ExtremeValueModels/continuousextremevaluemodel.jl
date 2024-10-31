"""
    ContinuousExtremeValueModel

Abstract type for continuous extreme value models.
"""

abstract type ContinuousExtremeValueModel <: ExtremeValueModel end

include(joinpath("ContinuousExtremeValueModels","regressionextremevaluemodel.jl"))