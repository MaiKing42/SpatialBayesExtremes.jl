struct HillEstimator<:FittedEstimator{UnivariateGPDModel}
    model::UnivariateGPDModel
    θ̂::NamedTuple
end

function _getParameterEstimate(he::HillEstimator)
    return he.θ̂
end

function _getDistributionEstimate(he::HillEstimator)
    return getDistribution(he.model, he.θ̂)
end