struct UnivariateGumbelModel <: UnivariateExtremeValueModel{Gumbel}
    data::Vector{<:Real}
end

get_parameters(model::UnivariateGumbelModel) = (:μ,:σ)

evaluateLocationParameter(model::UnivariateGumbelModel, μ::Float64) = μ

evaluateDerivativeLocationParameter(model::UnivariateGumbelModel, μ::Float64) = 1.0

evaluateScaleParameter(model::UnivariateGumbelModel, σ::Float64) = exp(σ)

evaluateDerivativeScaleParameter(model::UnivariateGumbelModel, σ::Float64) = exp(σ)

_evaluateParameters(model::UnivariateGumbelModel; μ, σ) = (μ = evaluateLocationParameter(model, μ),σ =  evaluateScaleParameter(model, σ))

evaluateParameters(model::UnivariateGumbelModel, θ::NamedTuple) = _evaluateParameters(model; θ...)

_evaluateDerivativeParameters(model::UnivariateGumbelModel; μ, σ) = (μ = evaluateDerivativeLocationParameter(model, μ),σ =  evaluateDerivativeScaleParameter(model, σ))

evaluateDerivativeParameters(model::UnivariateGumbelModel, θ::NamedTuple) = _evaluateDerivativeParameters(model; θ...)