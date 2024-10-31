abstract type FittedEstimator{M<:ExtremeValueModel} end

include(joinpath("FittedEstimators","bayesianestimator.jl"))
include(joinpath("FittedEstimators","maximumlikelihoodestimator.jl"))
include(joinpath("FittedEstimators","pwmestimator.jl"))