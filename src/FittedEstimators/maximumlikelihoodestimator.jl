struct MaximumLikelihoodEstimator{M<:ExtremeValueModel} <: FittedEstimator{M}
    model::M
    θ̂::NamedTuple
    converged :: Bool
end

function _getParameters(mle::MaximumLikelihoodEstimator)
    return mle.θ̂
end

function _getDistribution(mle::MaximumLikelihoodEstimator)
    return getDistribution(mle.model, mle.θ̂)
end