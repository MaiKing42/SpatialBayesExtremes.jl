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
        scaleMatrix = modelcols(scaleFormula.rhs, covariates)
        shapeMatrix = modelcols(shapeFormula.rhs, covariates)
        new(data, threshold, scaleFormula, shapeFormula, scaleMatrix, shapeMatrix)
    end
end

getModelParameters(model::RegressionGPDModel) = (:σ, :ξ)

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

evaluateDistributionParameters(model::RegressionGPDModel, θ::NamedTuple) = _evaluateDistributionParameters(model; θ...)

_evaluateDistributionParameters(model::RegressionGPDModel, covariates::DataFrame; σ, ξ) = (μ = threshold*ones(length(data)), σ = evaluateScaleParameter(model, covariates, σ), ξ = evaluateShapeParameter(model, covariates, ξ))

evaluateDistributionParameters(model::RegressionGPDModel, covariates::DataFrame, θ::NamedTuple) = _evaluateDistributionParameters(model, covariates; θ...)

_evaluateJacobianDistributionParameters(model::RegressionGPDModel; σ, ξ) = (μ = zeros(length(data)), σ = evaluateJacobianScaleParameter(model, σ), ξ = evaluateJacobianShapeModel(model, ξ))

evaluateJacobianDistributionParameters(model::RegressionGPDModel, θ::NamedTuple) = _evaluateJacobianDistributionParameters(model; θ...)

_evaluateJacobianDistributionParameters(model::RegressionGPDModel, covariates::DataFrame; σ, ξ) = (μ = zeros(length(data)), σ = evaluateJacobianScaleModel(model, covariates, σ), ξ = evaluateJacobianShapeModel(model, covariates, ξ))

evaluateJacobianDistributionParameters(model::RegressionGPDModel, covariates::DataFrame, θ::NamedTuple) = _evaluateJacobianDistributionParameters(model, covariates; θ...)