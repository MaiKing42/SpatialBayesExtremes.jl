"""
    FittedEstimator{M<:ExtremeValueModel}

An abstract type for fitted estimators of extreme value models.
"""
abstract type FittedEstimator{M<:ExtremeValueModel} end

"""
    getParameters(fe::FittedEstimator)

Returns the parameter estimates.
"""
getParameters(fe::FittedEstimator) = _getParameters(fe)

"""
    getDistribution(fe::FittedEstimator)

Returns the probability distribution associated with the fitted estimator.
"""
getDistribution(fe::FittedEstimator) = _getDistribution(fe)

include(joinpath("FittedEstimators","pwmestimator.jl"))
include(joinpath("FittedEstimators","meanexcessestimator.jl"))
include(joinpath("FittedEstimators","hillestimator.jl"))
include(joinpath("FittedEstimators","maximumlikelihoodestimator.jl"))
include(joinpath("FittedEstimators","bayesianestimator.jl"))