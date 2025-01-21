abstract type FittedEstimator{M<:ExtremeValueModel} end

include(joinpath("FittedEstimators","pwmestimator.jl"))
include(joinpath("FittedEstimators","meanexcessestimator.jl"))
include(joinpath("FittedEstimators","maximumlikelihoodestimator.jl"))
include(joinpath("FittedEstimators","bayesianestimator.jl"))