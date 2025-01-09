struct UnivariateGPDModel <: UnivariateExtremeValueModel{GeneralizedPareto}
    data::Vector{<:Real}
end

get_parameters(model::UnivariateGPDModel) = (:σ,:ξ)

evaluateScaleParameter(model::UnivariateGPDModel, σ::Float64) = exp(σ)

evaluateDerivativeScaleParameter(model::UnivariateGPDModel, σ::Float64) = exp(σ)

evaluateShapeParameter(model::UnivariateGPDModel, ξ::Float64) = ξ

evaluateDerivativeShapeParameter(model::UnivariateGPDModel, ξ::Float64) = 1.0

_evaluateParameters(model::UnivariateGPDModel; σ, ξ) = (σ =  evaluateScaleParameter(model, σ),ξ = evaluateShapeParameter(model, ξ))

evaluateParameters(model::UnivariateGPDModel, θ::NamedTuple) = _evaluateParameters(model; θ...)

_evaluateDerivativeParameters(model::UnivariateGPDModel; σ, ξ) = (σ =  evaluateDerivativeScaleParameter(model, σ),ξ = evaluateDerivativeShapeParameter(model, ξ))

evaluateDerivativeParameters(model::UnivariateGPDModel, θ::NamedTuple) = _evaluateDerivativeParameters(model; θ...)