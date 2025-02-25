struct RegressionGEVModel<:RegressionExtremeValueModel{GeneralizedExtremeValue}
    data::Vector{Float64}
    locationFormula::FormulaTerm
    scaleFormula::FormulaTerm
    shapeFormula::FormulaTerm
    locationMatrix::Matrix{Float64}
    scaleMatrix::Matrix{Float64}
    shapeMatrix::Matrix{Float64}
end

getModelParameters(model::RegressionGEVModel) = (:μ, :σ, :ξ)

function evaluateLocationParameter(model::RegressionGEVModel, μ::Vector{Float64})
    return model.locationMatrix * μ
end

function evaluateLocationParameter(model::RegressionGEVModel, covariates::DataFrame, μ::Vector{Float64})
    return modelmatrix(model.locationFormula.rhs, covariates) * μ
end

function evaluateJacobianLocationParameter(model::RegressionGEVModel, μ::Vector{Float64})
    return model.locationMatrix
end

function evaluateJacobianLocationParameter(model::RegressionGEVModel, covariates::DataFrame, μ::Vector{Float64})
    return modelmatrix(model.locationFormula.rhs, covariates)
end

function evaluateScaleParameter(model::RegressionGEVModel, σ::Vector{Float64})
    return exp.(model.scaleMatrix * σ)
end

function evaluateScaleParameter(model::RegressionGEVModel, covariates::DataFrame, σ::Vector{Float64})
    return exp.(modelmatrix(model.scaleFormula.rhs, covariates) * σ)
end

function evaluateJacobianScaleParameter(model::RegressionGEVModel, σ::Vector{Float64})
    return evaluateScaleParameter(model, σ).*model.scaleMatrix
end

function evaluateJacobianScaleParameter(model::RegressionGEVModel, covariates::DataFrame, σ::Vector{Float64})
    return evaluateScaleParameter(model, covariates, σ).*modelmatrix(model.scaleFormula.rhs, covariates)
end

function evaluateShapeParameter(model::RegressionGEVModel, ξ::Vector{Float64})
    return model.shapeMatrix * ξ
end

function evaluateShapeParameter(model::RegressionGEVModel, covariates::DataFrame, ξ::Vector{Float64})
    return modelmatrix(model.shapeFormula.rhs, covariates) * ξ
end

function evaluateJacobianShapeParameter(model::RegressionGEVModel, ξ::Vector{Float64})
    return model.shapeMatrix
end

function evaluateJacobianShapeParameter(model::RegressionGEVModel, covariates::DataFrame, ξ::Vector{Float64})
    return modelmatrix(model.shapeFormula.rhs, covariates)
end

_evaluateDistributionParameters(model::RegressionGEVModel; μ, σ, ξ) = (μ = evaluateLocationParameter(model, μ),σ =  evaluateScaleParameter(model, σ),ξ = evaluateShapeParameter(model, ξ))

evaluateDistributionParameters(model::RegressionGEVModel, θ::NamedTuple) = _evaluateDistributionParameters(model;θ...)

_evaluateDistributionParameters(model::RegressionGEVModel, covariates::DataFrame; μ, σ, ξ) = (μ = evaluateLocationParameter(model, covariates, μ),σ =  evaluateScaleParameter(model, covariates, σ),ξ = evaluateShapeParameter(model, covariates, ξ))

evaluateDistributionParameters(model::RegressionGEVModel, covariates::DataFrame, θ::NamedTuple) = _evaluateDistributionParameters(model, covariates;θ...)

_evaluateJacobianDistributionParameters(model::RegressionGEVModel; μ, σ, ξ) = (μ = evaluateJacobianLocationParamater(model, μ),σ = evaluateJacobianScaleParameter(model, σ), ξ = evaluateJacobianShapeParameter(model, ξ))

evaluateJacobianDistributionParameters(model::RegressionGEVModel, θ::NamedTuple) = _evaluateJacobianDistributionParameters(model; θ...)

_evaluateJacobianDistributionParameters(model::RegressionGEVModel, covariates::DataFrame; μ, σ, ξ) = (μ = evaluateJacobianLocationParameter(model, covariates, μ), σ =  evaluateJacobianScaleParameter(model, covariates, σ), ξ = evaluateJacobianShapeParameter(model, covariates, ξ))

evaluateJacobianDistributionParameters(model::RegressionGEVModel, covariates::DataFrame, θ::NamedTuple) = _evaluateJacobianDistributionParameters(model, covariates; θ...)