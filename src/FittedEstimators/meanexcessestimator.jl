struct MeanExcessEstimator <: FittedEstimator{UnivariateGPDModel}
    model::UnivariateGPDModel
    θ̂::NamedTuple
end

function _getParameterEstimate(mee::MeanExcessEstimator)
    return mee.θ̂
end

function _getDistributionEstimate(mee::MeanExcessEstimator)
    return getDistribution(mee.model, getParameters(mee))
end