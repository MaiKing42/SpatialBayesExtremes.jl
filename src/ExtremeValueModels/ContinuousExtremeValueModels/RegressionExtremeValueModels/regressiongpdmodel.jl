struct RegressionGPDModel<:RegressionExtremeValueModel
    data::Vector{Float64}
    scaleFormula::FormulaTerm
    shapeFormula::FormulaTerm
    scaleMatrix::Matrix{Float64}
    shapeMatrix::Matrix{Float64}
end

get_parameters(model::RegressionGPDModel) = (:σ, :ξ)

function evaluateScaleParameter(model::RegressionGPDModel, σ::Vector{Float64})
    return exp.(model.scaleMatrix * σ)
end

function evaluateScaleParameter(model::RegressionGPDModel, covariates::DataFrame, σ::Vector{Float64})
    return exp.(modelmatrix(model.scaleFormula.rhs, covariates) * σ)
end

function evaluateJacobian_scaleModel(model::RegressionGPDModel, σ::Vector{Float64})
    return evaluateScaleParameter(model, σ).*model.scaleMatrix
end

function evaluateShapeParameter(model::RegressionGPDModel, ξ::Vector{Float64})
    return model.shapeMatrix * ξ
end

function evaluateShapeParameter(model::RegressionGPDModel, covariates::DataFrame, ξ::Vector{Float64})
    return modelmatrix(model.shapeFormula.rhs, covariates) * ξ
end

function evaluateJacobian_shapeModel(model::RegressionGPDModel, ξ::Vector{Float64})
    return model.shapeMatrix
end

_evaluateParameters(model::RegressionGPDModel; σ, ξ) = (σ = evaluateScaleParameter(model, σ), ξ = evaluateShapeParameter(model, ξ))

evaluateParameters(model::RegressionModel, θ::NamedTuple) = _evaluateParameters(model; θ...)

_evaluateJacobian_parameterModels(model::RegressionGPDModel; σ, ξ) = (σ = evaluateJacobian_scaleModel(model, σ), ξ = evaluateJacobian_shapeModel(model, ξ))

evaluateJacobian_parameterModels(model::RegressionGPDModel, θ::NamedTuple) = _evaluateJacobian_parameterModels(model; θ...)