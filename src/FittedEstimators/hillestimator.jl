struct HillEstimator<:FittedEstimator{UnivariateGPDModel}
    model::UnivariateGPDModel
    θ̂::NamedTuple
end

function _getParameters(he::HillEstimator)
    return he.θ̂
end

function _getDistribution(he::HillEstimator)
    return getDistribution(he.model, he.θ̂)
end