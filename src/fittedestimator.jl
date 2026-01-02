"""
    FittedEstimator{M<:ExtremeValueModel}

An abstract type for fitted estimators of extreme value models.
"""
abstract type FittedEstimator{M<:ExtremeValueModel} end

"""
    getParameterEstimate(fe::FittedEstimator)

Returns the parameter estimates.
"""
getParameterEstimate(fe::FittedEstimator) = _getParameterEstimate(fe)

"""
    getDistributionEstimate(fe::FittedEstimator)

Returns the probability distribution associated with the fitted estimator.
"""
getDistributionEstimate(fe::FittedEstimator) = _getDistributionEstimate(fe)

include(joinpath("FittedEstimators","pwmestimator.jl"))
include(joinpath("FittedEstimators","meanexcessestimator.jl"))
include(joinpath("FittedEstimators","hillestimator.jl"))
include(joinpath("FittedEstimators","maximumlikelihoodestimator.jl"))
include(joinpath("FittedEstimators","bayesianestimator.jl"))