struct RegressionGPDModel<:RegressionExtremeValueModel{GeneralizedPareto}
    data::Vector{Float64}
    scaleMatrix::Matrix{Float64}
    shapeMatrix::Matrix{Float64}
end


function evaluateScaleParameter(model::RegressionGPDModel, σ::Vector{Float64})
    return exp.(model.scaleMatrix * σ)
end

function evaluateJacobian_scaleModel(model::RegressionGPDModel, σ::Vector{Float64})
    return evaluateScaleParameter(model, σ).*model.scaleMatrix
end

function evaluateShapeParameter(model::RegressionGPDModel, ξ::Vector{Float64})
    return model.shapeMatrix * ξ
end

function evaluateJacobian_shapeModel(model::RegressionGPDModel, ξ::Vector{Float64})
    return model.shapeMatrix
end

function evaluateParameters(model::RegressionModel, θ::NamedTuple{(:σ, :ξ), Tuple{Vector{Float64}, Vector{Float64}}})
    return (σ = evaluateLocationParameter(model, θ.σ), ξ = evaluateScaleParameter(model, θ.ξ))
end

function evaluateJacobian_parameterModels(model::RegressionGPDModel, θ::NamedTuple{(:σ, :ξ), Tuple{Vector{Float64}, Vector{Float64}}})
    return (σ = evaluateJacobian_scaleModel(model, θ.σ), ξ = evaluateJacobian_shapeModel(model, θ.ξ))
end