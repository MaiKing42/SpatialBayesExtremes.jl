struct UnivariateGPDModel <: UnivariateExtremeValueModel{GeneralizedPareto}
    data::Vector{<:Real}
    threshold::Float64
end

_getModelParameters(model::UnivariateGPDModel) = (:σ,:ξ)

_getModelData(model::UnivariateGPDModel) = model.data

evaluateScaleParameter(model::UnivariateGPDModel, σ::Float64) = exp(σ)

evaluateDerivativeScaleParameter(model::UnivariateGPDModel, σ::Float64) = exp(σ)

evaluateShapeParameter(model::UnivariateGPDModel, ξ::Float64) = ξ

evaluateDerivativeShapeParameter(model::UnivariateGPDModel, ξ::Float64) = 1.0

_evaluateDistributionParameters(model::UnivariateGPDModel; σ, ξ) = (μ = model.threshold, σ = evaluateScaleParameter(model, σ), ξ = evaluateShapeParameter(model, ξ))

_evaluateDerivativeDistributionParameters(model::UnivariateGPDModel; σ, ξ) = (μ = 0, σ = evaluateDerivativeScaleParameter(model, σ), ξ = evaluateDerivativeShapeParameter(model, ξ))