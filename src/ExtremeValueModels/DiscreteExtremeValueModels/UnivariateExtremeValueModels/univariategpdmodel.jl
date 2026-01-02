"""
    UnivariateGPDModel

A univariate extreme value model for the Generalized Pareto Distribution (GPD) suitable for modeling exceedances over a threshold.
The GPD is characterized by its scale parameter `σ` and shape parameter `ξ`. We reparametrize the scale parameter using its logarithm to ensure positivity during estimation.

```julia
fitgpdPWM(data::Vector{<:Real})                                             #fit the univariate GPD model using PWM estimation
fitgpdPWM(data::DataFrame, column::Symbol)                                  #fit the univariate GPD model using PWM estimation on a DataFrame column
fitgpdHill(data::Vector{<:Real})                                            #fit the univariate GPD model using Hill estimation
fitgpdHill(data::DataFrame, column::Symbol)                                 #fit the univariate GPD model using Hill estimation on a DataFrame column
fitgpdMeplot(data::Vector{<:Real})                                          #fit the univariate GPD model using Mean Excess estimation
fitgpdMeplot(data::DataFrame, column::Symbol)                               #fit the univariate GPD model using Mean Excess estimation on a DataFrame column
fitgpdML(data::Vector{<:Real})                                              #fit the univariate GPD model using Maximum Likelihood estimation
fitgpdML(data::DataFrame, column::Symbol)                                   #fit the univariate GPD model using Maximum Likelihood estimation on a DataFrame column
fitgpdML(data::Vector{<:Real}, initialvalue::NamedTuple)                    #fit the univariate GPD model using Maximum Likelihood estimation with initial values (σ=log(σ0), ξ=ξ0)
fitgpdML(data::DataFrame, column::Symbol, initialvalue::NamedTuple)         #fit the univariate GPD model using Maximum Likelihood estimation on a DataFrame column with initial values (σ=log(σ0), ξ=ξ0)
```
"""
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