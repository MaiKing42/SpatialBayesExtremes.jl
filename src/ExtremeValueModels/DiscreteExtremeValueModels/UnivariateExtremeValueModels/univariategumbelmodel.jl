struct UnivariateGumbelModel <: UnivariateExtremeValueModel{Gumbel}
    data::Vector{<:Real}
end

getModelParameters(model::UnivariateGumbelModel) = (:μ,:σ)

evaluateLocationParameter(model::UnivariateGumbelModel, μ::Float64) = μ

evaluateDerivativeLocationParameter(model::UnivariateGumbelModel, μ::Float64) = 1.0

evaluateScaleParameter(model::UnivariateGumbelModel, σ::Float64) = exp(σ)

evaluateDerivativeScaleParameter(model::UnivariateGumbelModel, σ::Float64) = exp(σ)

_evaluateDistributionParameters(model::UnivariateGumbelModel; μ, σ) = (μ = evaluateLocationParameter(model, μ),σ =  evaluateScaleParameter(model, σ))

evaluateDistributionParameters(model::UnivariateGumbelModel, θ::NamedTuple) = _evaluateDistributionParameters(model; θ...)

_evaluateDerivativeDistributionParameters(model::UnivariateGumbelModel; μ, σ) = (μ = evaluateDerivativeLocationParameter(model, μ),σ =  evaluateDerivativeScaleParameter(model, σ))

evaluateDerivativeDistributionParameters(model::UnivariateGumbelModel, θ::NamedTuple) = _evaluateDerivativeDistributionParameters(model; θ...)