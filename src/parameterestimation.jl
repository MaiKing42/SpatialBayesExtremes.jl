function fit(model, estimator)
    error("fit not implemented for this ExtremeValueModel and estimator")
end

function fit(model, estimator, initial_parameters)
    error("fit not implemented for this ExtremeValueModel and estimator")
end

include(joinpath("ParameterEstimations","pwm.jl"))
include(joinpath("ParameterEstimations","meplot.jl"))
include(joinpath("ParameterEstimations","maximumlikelihood.jl"))
include(joinpath("ParameterEstimations","bayesian.jl"))
