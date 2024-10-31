struct PWMEstimator{M<:UnivariateExtremeValueModel} <: FittedEstimator{M}
    model::M
    θ̂::NamedTuple
end