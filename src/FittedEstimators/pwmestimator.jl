struct PWMEstimator{M<:UnivariateExtremeValueModel} <: FittedEstimator{M}
    model::M
    θ̂::NamedTuple
end

function _getParameters(pwme::PWMEstimator)
    return pwme.θ̂
end

function _getDistribution(pwme::PWMEstimator)
    return getDistribution(pwme.model, pwme.θ̂)
end