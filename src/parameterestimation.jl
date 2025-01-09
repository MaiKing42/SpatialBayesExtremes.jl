function fit(data, modeltype, estimator) end

include(joinpath("ParameterEstimations","pwm.jl"))
include(joinpath("ParameterEstimations","maximumlikelihood.jl"))
include(joinpath("ParameterEstimations","bayesian.jl"))