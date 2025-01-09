function fit(data, modeltype, method) end

include(joinpath("ParameterEstimations","pwm.jl"))
include(joinpath("ParameterEstimations","maximumlikelihood.jl"))
include(joinpath("ParameterEstimations","bayesian.jl"))