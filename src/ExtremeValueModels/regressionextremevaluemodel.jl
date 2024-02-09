"""
    RegressionExtremeValueModel

Abstract type for regression extreme value models.
"""
abstract type RegressionExtremeValueModel <: ExtremeValueModel end

include(joinpath("RegressionExtremeValueModels","regressiongevmodel.jl"))
include(joinpath("RegressionExtremeValueModels","regressiongpdmodel.jl"))