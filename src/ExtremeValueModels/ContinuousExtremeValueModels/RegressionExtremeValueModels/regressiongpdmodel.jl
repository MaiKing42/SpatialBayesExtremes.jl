"""
    RegressionGPDModel

A regression generalized Pareto distribution (GPD) model for threshold exceedances with covariate-dependent scale and shape parameters. The model is designed to model the tail behavior of data exceeding a specified threshold while accounting for non-stationary characteristics through covariates.

```julia
fitSpatialgpdML(data::Vector{<:Real}, covariates::DataFrame, scaleFormula::FormulaTerm, shapeFormula::FormulaTerm)                                        #maximum likelihood estimation
fitSpatialgpdML(data::Vector{<:Real}, column::Symbol, scaleFormula::FormulaTerm, shapeFormula::FormulaTerm)                                               #maximum likelihood estimation from joint DataFrame for data and covariates, specifying column for data
fitSpatialgpdML(data::Vector{<:Real}, covariates::DataFrame, scaleFormula::FormulaTerm, shapeFormula::FormulaTerm, initialvalue::NamedTuple)              #maximum likelihood estimation with initial values
fitSpatialgpdML(data::Vector{<:Real}, column::Symbol, scaleFormula::FormulaTerm, shapeFormula::FormulaTerm, initialvalue::NamedTuple)                     #maximum likelihood estimation from joint DataFrame for data and covariates, specifying column for data, with initial values
```
"""
struct RegressionGPDModel<:RegressionExtremeValueModel{GeneralizedPareto}
    data::Vector{Float64}
    threshold::Float64
    scaleTerm::FormulaTerm
    shapeTerm::FormulaTerm
    scaleMatrix::Matrix{Float64}
    shapeMatrix::Matrix{Float64}

    RegressionGPDModel(data::Vector{<:Real}, covariates::DataFrame, threshold::Real, scaleFormula::FormulaTerm, shapeFormula::FormulaTerm) = begin
        length(data) == nrow(covariates) || throw(ArgumentError("The length of the data and the number of rows in the covariates must be the same"))
        scaleTerm = apply_schema(scaleFormula, covariates)
        shapeTerm = apply_schema(shapeFormula, covariates)
        scaleMatrix = modelcols(scaleTerm.rhs, covariates)
        shapeMatrix = modelcols(shapeTerm.rhs, covariates)
        new(data, threshold, scaleTerm, shapeTerm, scaleMatrix, shapeMatrix)
    end
end

_getModelParameters(model::RegressionGPDModel) = (:σ, :ξ)

_getModelData(model::RegressionGPDModel) = model.data

function evaluateScaleParameter(model::RegressionGPDModel, σ::Vector{Float64})
    return exp.(model.scaleMatrix * σ)
end

function evaluateScaleParameter(model::RegressionGPDModel, covariates::DataFrame, σ::Vector{Float64})
    scaleMatrix = modelcols(model.scaleTerm.rhs, covariates)
    return exp.(scaleMatrix * σ)
end

function evaluateJacobianScaleParameter(model::RegressionGPDModel, σ::Vector{Float64})
    return evaluateScaleParameter(model, σ).*model.scaleMatrix
end

function evaluateJacobianScaleParameter(model::RegressionGPDModel, covariates::DataFrame, σ::Vector{Float64})
    scaleMatrix = modelcols(model.scaleTerm.rhs, covariates)
    return evaluateScaleParameter(model, covariates, σ).*scaleMatrix
end

function evaluateShapeParameter(model::RegressionGPDModel, ξ::Vector{Float64})
    return model.shapeMatrix * ξ
end

function evaluateShapeParameter(model::RegressionGPDModel, covariates::DataFrame, ξ::Vector{Float64})
    shapeMatrix = modelcols(model.shapeTerm.rhs, covariates)
    return shapeMatrix * ξ
end

function evaluateJacobianShapeParameter(model::RegressionGPDModel, ξ::Vector{Float64})
    return model.shapeMatrix
end

function evaluateJacobianShapeParameter(model::RegressionGPDModel, covariates::DataFrame, ξ::Vector{Float64})
    shapeMatrix = modelcols(model.shapeTerm.rhs, covariates)
    return shapeMatrix
end

_evaluateDistributionParameters(model::RegressionGPDModel; σ, ξ) = (μ = threshold*ones(length(data)), σ = evaluateScaleParameter(model, σ), ξ = evaluateShapeParameter(model, ξ))

_evaluateDistributionParameters(model::RegressionGPDModel, covariates::DataFrame; σ, ξ) = (μ = threshold*ones(length(data)), σ = evaluateScaleParameter(model, covariates, σ), ξ = evaluateShapeParameter(model, covariates, ξ))

_evaluateJacobianDistributionParameters(model::RegressionGPDModel; σ, ξ) = (μ = zeros(length(data)), σ = evaluateJacobianScaleParameter(model, σ), ξ = evaluateJacobianShapeModel(model, ξ))

_evaluateJacobianDistributionParameters(model::RegressionGPDModel, covariates::DataFrame; σ, ξ) = (μ = zeros(length(data)), σ = evaluateJacobianScaleModel(model, covariates, σ), ξ = evaluateJacobianShapeModel(model, covariates, ξ))