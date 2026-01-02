struct BayesianEstimator{M<:ExtremeValueModel} <: FittedEstimator{M}
    model::M
    posterior::AbstractArray
end

function _getParameterEstimate(be::BayesianEstimator)
    return be.posterior
end

function _getDistributionEstimate(be::BayesianEstimator)
    return getDistribution.(be.model, be.posterior)
end