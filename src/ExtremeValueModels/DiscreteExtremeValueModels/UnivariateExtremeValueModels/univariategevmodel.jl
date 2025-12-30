struct UnivariateGEVModel <: UnivariateExtremeValueModel{GeneralizedExtremeValue}
    data::Vector{<:Real}
end

_getModelParameters(model::UnivariateGEVModel) = (:μ,:σ,:ξ)

_getModelData(model::UnivariateGEVModel) = model.data

evaluateLocationParameter(model::UnivariateGEVModel, μ::Float64) = μ

evaluateDerivativeLocationParameter(model::UnivariateGEVModel, μ::Float64) = 1.0

evaluateScaleParameter(model::UnivariateGEVModel, σ::Float64) = exp(σ)

evaluateDerivativeScaleParameter(model::UnivariateGEVModel, σ::Float64) = exp(σ)

evaluateShapeParameter(model::UnivariateGEVModel, ξ::Float64) = ξ

evaluateDerivativeShapeParameter(model::UnivariateGEVModel, ξ::Float64) = 1.0

_evaluateDistributionParameters(model::UnivariateGEVModel; μ, σ, ξ) = (μ = evaluateLocationParameter(model, μ),σ =  evaluateScaleParameter(model, σ),ξ = evaluateShapeParameter(model, ξ))

evaluateDistributionParameters(model::UnivariateGEVModel, θ::NamedTuple) = _evaluateDistributionParameters(model; θ...)

_evaluateDerivativeDistributionParameters(model::UnivariateGEVModel; μ, σ, ξ) = (μ = evaluateDerivativeLocationParameter(model, μ),σ =  evaluateDerivativeScaleParameter(model, σ),ξ = evaluateDerivativeShapeParameter(model, ξ))

evaluateDerivativeDistributionParameters(model::UnivariateGEVModel, θ::NamedTuple) = _evaluateDerivativeDistributionParameters(model; θ...)