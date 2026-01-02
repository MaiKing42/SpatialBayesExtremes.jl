""""
    UnivariateGEVModel

A univariate extreme value model for the Generalized Extreme Value (GEV) distribution suitable for modeling maxima of a dataset.
The GEV distribution is characterized by its location parameter `μ`, scale parameter `σ`, and shape parameter `ξ`. We reparametrize the scale parameter using its logarithm to ensure positivity during estimation.

```julia
fitgevPWM(data::Vector{<:Real})                                            #fit the univariate GEV model using PWM estimation
fitgevPWM(data::DataFrame, column::Symbol)                                 #fit the univariate GEV model using PWM estimation on a DataFrame column
fitgevML(data::Vector{<:Real})                                             #fit the univariate GEV model using Maximum Likelihood estimation
fitgevML(data::DataFrame, column::Symbol)                                  #fit the univariate GEV model using Maximum Likelihood estimation on a DataFrame column
fitgevML(data::Vector{<:Real}, initialvalue::NamedTuple)                   #fit the univariate GEV model using Maximum Likelihood estimation with initial values (μ=μ0, σ=log(σ0), ξ=ξ0)
fitgevML(data::DataFrame, column::Symbol, initialvalue::NamedTuple)        #fit the univariate GEV model using Maximum Likelihood estimation on a DataFrame column with initial values (μ=μ0, σ=log(σ0), ξ=ξ0)
```
"""
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

_evaluateDerivativeDistributionParameters(model::UnivariateGEVModel; μ, σ, ξ) = (μ = evaluateDerivativeLocationParameter(model, μ),σ =  evaluateDerivativeScaleParameter(model, σ),ξ = evaluateDerivativeShapeParameter(model, ξ))