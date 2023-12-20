"""
    ExtremeValueModel

Abstract type for extreme value models.
"""
abstract type ExtremeValueModel end

"""
    UnivariateExtremeValueModel

Abstract type for univariate extreme value models.
"""
abstract type UnivariateExtremeValueModel <: ExtremeValueModel end

"""
    RegressionExtremeValueModel

Abstract type for regression extreme value models.
"""
abstract type RegressionExtremeValueModel <: ExtremeValueModel end