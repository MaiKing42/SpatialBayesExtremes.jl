struct MeanExcessEstimator <: FittedEstimator{UnivariateGPDModel}
    model::UnivariateGPDModel
    θ̂::NamedTuple
end

function _getParameters(mee::MeanExcessEstimator)
    return mee.θ̂
end

function _getDistribution(mee::MeanExcessEstimator)
    return getDistribution(mee.model, getParameters(mee))
end