function fit(model, estimator) end

function fit(model, estimator, initial_parameters) end

include(joinpath("ParameterEstimations","pwm.jl"))
include(joinpath("ParameterEstimations","maximumlikelihood.jl"))
include(joinpath("ParameterEstimations","bayesian.jl"))