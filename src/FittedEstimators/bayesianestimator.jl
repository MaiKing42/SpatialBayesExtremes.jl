struct BayesianEstimator{M<:ExtremeValueModel} <: FittedEstimator{M}
    model::M
    posterior::AbstractArray
end

function _getParameters(be::BayesianEstimator)
    return be.posterior
end

function _getDistribution(be::BayesianEstimator)
    return getDistribution.(be.model, be.posterior)
end