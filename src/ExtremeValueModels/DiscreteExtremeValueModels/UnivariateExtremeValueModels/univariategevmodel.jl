struct UnivariateGEVModel <: UnivariateExtremeValueModel
    data::Vector{Float64}
end

get_parameters(model::UnivariateGEVModel) = (:μ,:σ,:ξ)

evaluateLocationParameter(model::UnivariateGEVModel, μ::Float64) = μ

evaluateDerivativeLocationParameter(model::UnivariateGEVModel, μ::Float64) = 1.0

evaluateScaleParameter(model::UnivariateGEVModel, σ::Float64) = exp(σ)

evaluateDerivativeScaleParameter(model::UnivariateGEVModel, σ::Float64) = exp(σ)

evaluateShapeParameter(model::UnivariateGEVModel, ξ::Float64) = ξ

evaluateDerivativeShapeParameter(model::UnivariateGEVModel, ξ::Float64) = 1.0

_evaluateParameters(model::UnivariateGEVModel; μ, σ, ξ) = (μ = evaluateLocationParameter(model, μ),σ =  evaluateScaleParameter(model, σ),ξ = evaluateShapeParameter(model, ξ))

evaluateParameters(model::UnivariateGEVModel, θ::NamedTuple) = _evaluateParameters(model; θ...)

_evaluateDerivative_Parameters(model::UnivariateGEVModel; μ, σ, ξ) = (μ = evaluateDerivativeLocationParameter(model, μ),σ =  evaluateDerivativeScaleParameter(model, σ),ξ = evaluateDerivativeShapeParameter(model, ξ))

evaluateDerivative_Parameters(model::UnivariateGEVModel, θ::NamedTuple) = _evaluateDerivative_Parameters(model; θ...)