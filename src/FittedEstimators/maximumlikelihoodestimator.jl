struct MaximumLikelihoodEstimator{M<:ExtremeValueModel} <: FittedEstimator{M}
    model::M
    θ̂::NamedTuple
    converged :: Bool
end