"""
    UnivariateGumbelModel

A univariate extreme value model for the Gumbel distribution suitable for modeling maxima of a dataset.
The Gumbel distribution is characterized by its location parameter `μ` and scale parameter `σ`. We reparametrize the scale parameter using its logarithm to ensure positivity during estimation.

```julia
fitgumbelPWM(data::Vector{<:Real})                  #fit the univariate Gumbel model using PWM estimation
fitgumbelPWM(data::DataFrame, column::Symbol)       #fit the univariate Gumbel model using PWM estimation on a DataFrame column
```

External links

* [Gumbel distribution on Wikipedia](http://en.wikipedia.org/wiki/Gumbel_distribution)
"""
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