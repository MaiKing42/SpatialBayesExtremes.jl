struct RegressionGEVModel<:RegressionExtremeValueModel
    data::Vector{Float64}
    locationFormula::FormulaTerm
    scaleFormula::FormulaTerm
    shapeFormula::FormulaTerm
    locationMatrix::Matrix{Float64}
    scaleMatrix::Matrix{Float64}
    shapeMatrix::Matrix{Float64}
end

get_parameters(model::RegressionGEVModel) = (:μ, :σ, :ξ)

function evaluateLocationParameter(model::RegressionGEVModel, μ::Vector{Float64})
    return model.locationMatrix * μ
end

function evaluateLocationParameter(model::RegressionGEVModel, covariates::DataFrame, μ::Vector{Float64})
    return modelmatrix(model.locationFormula.rhs, covariates) * μ
end

function evaluateJacobian_locationModel(model::RegressionGEVModel, μ::Vector{Float64})
    return model.locationMatrix
end

function evaluateScaleParameter(model::RegressionGEVModel, σ::Vector{Float64})
    return exp.(model.scaleMatrix * σ)
end

function evaluateScaleParameter(model::RegressionGEVModel, covariates::DataFrame, σ::Vector{Float64})
    return exp.(modelmatrix(model.scaleFormula.rhs, covariates) * σ)
end

function evaluateJacobian_scaleModel(model::RegressionGEVModel, σ::Vector{Float64})
    return evaluateScaleParameter(model, σ).*model.scaleMatrix
end

function evaluateShapeParameter(model::RegressionGEVModel, ξ::Vector{Float64})
    return model.shapeMatrix * ξ
end

function evaluateShapeParameter(model::RegressionGEVModel, covariates::DataFrame, ξ::Vector{Float64})
    return modelmatrix(model.shapeFormula.rhs, covariates) * ξ
end

function evaluateJacobian_shapeModel(model::RegressionGEVModel, ξ::Vector{Float64})
    return model.shapeMatrix
end

_evaluateParameters(model::RegressionGEVModel; μ, σ, ξ) = (μ = evaluateLocationParameter(model, μ),σ =  evaluateScaleParameter(model, σ),ξ = evaluateShapeParameter(model, ξ))

evaluateParameters(model::RegressionGEVModel, θ::NamedTuple) = _evaluateParameters(model;θ...)

_evaluateJacobian_parameterModels(model::RegressionGEVModel; μ, σ, ξ) = (μ = evaluateJacobian_locationModel(model, μ),σ =  evaluateJacobian_scaleModel(model, σ),ξ = evaluateJacobian_shapeModel(model, ξ))

evaluateJacobian_parameterModels(model::RegressionGEVModel, θ::NamedTuple) = _evaluateJacobian_parameterModels(model;θ...)