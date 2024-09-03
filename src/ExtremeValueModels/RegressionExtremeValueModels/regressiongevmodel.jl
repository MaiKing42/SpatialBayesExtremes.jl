struct RegressionGEVModel<:RegressionExtremeValueModel{GeneralizedExtremeValue}
    data::Vector{Float64}
    locationMatrix::Matrix{Float64}
    scaleMatrix::Matrix{Float64}
    shapeMatrix::Matrix{Float64}
end

function evaluateLocationParameter(model::RegressionGEVModel, μ::Vector{Float64})
    return model.locationMatrix * μ
end

function evaluateJacobian_locationModel(model::RegressionGEVModel, μ::Vector{Float64})
    return model.locationMatrix
end

function evaluateScaleParameter(model::RegressionGEVModel, σ::Vector{Float64})
    return exp.(model.scaleMatrix * σ)
end

function evaluateJacobian_scaleModel(model::RegressionGEVModel, σ::Vector{Float64})
    return evaluateScaleParameter(model, σ).*model.scaleMatrix
end

function evaluateShapeParameter(model::RegressionGEVModel, ξ::Vector{Float64})
    return model.shapeMatrix * ξ
end

function evaluateJacobian_shapeModel(model::RegressionGEVModel, ξ::Vector{Float64})
    return model.shapeMatrix
end

function evaluateParameters(model::RegressionGEVModel, θ::NamedTuple{(:μ, :σ, :ξ), Tuple{Vector{Float64}, Vector{Float64}, Vector{Float64}}})
    return (μ = evaluateLocationParameter(model, θ.μ),σ =  evaluateScaleParameter(model, θ.σ),ξ = evaluateShapeParameter(model, θ.ξ))
end

function evaluateJacobian_parameterModels(model::RegressionGEVModel, θ::NamedTuple{(:μ, :σ, :ξ), Tuple{Vector{Float64}, Vector{Float64}, Vector{Float64}}})
    return (μ = evaluateJacobian_locationModel(model, θ.μ),σ =  evaluateJacobian_scaleModel(model, θ.σ),ξ = evaluateJacobian_shapeModel(model, θ.ξ))
end