struct MaximumLikelihoodEstimator{M<:ExtremeValueModel} <: FittedEstimator{M}
    model::M
    θ̂::NamedTuple
    converged :: Bool
end

function _getParameterEstimate(mle::MaximumLikelihoodEstimator)
    return mle.θ̂
end

function _getDistributionEstimate(mle::MaximumLikelihoodEstimator)
    return getDistribution(mle.model, mle.θ̂)
end