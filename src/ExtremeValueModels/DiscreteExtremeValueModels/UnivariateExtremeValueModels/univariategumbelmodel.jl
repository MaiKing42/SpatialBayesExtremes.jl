struct UnivariateGumbelModel <: UnivariateExtremeValueModel{Gumbel}
    data::Vector{<:Real}
end

_getModelParameters(model::UnivariateGumbelModel) = (:μ,:σ)

_getModelData(model::UnivariateGumbelModel) = model.data

evaluateLocationParameter(model::UnivariateGumbelModel, μ::Float64) = μ

evaluateDerivativeLocationParameter(model::UnivariateGumbelModel, μ::Float64) = 1.0

evaluateScaleParameter(model::UnivariateGumbelModel, σ::Float64) = exp(σ)

evaluateDerivativeScaleParameter(model::UnivariateGumbelModel, σ::Float64) = exp(σ)

_evaluateDistributionParameters(model::UnivariateGumbelModel; μ, σ) = (μ = evaluateLocationParameter(model, μ),σ =  evaluateScaleParameter(model, σ))

_evaluateDerivativeDistributionParameters(model::UnivariateGumbelModel; μ, σ) = (μ = evaluateDerivativeLocationParameter(model, μ),σ =  evaluateDerivativeScaleParameter(model, σ))