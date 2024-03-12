struct RegressionGEVModel<:RegressionExtremeValueModel
    data::Vector{Float64}
    locationMatrix::Matrix{Float64}
    scaleMatrix::Matrix{Float64}
    shapeMatrix::Matrix{Float64}
end

function evaluateLocationParameter(model::RegressionGEVModel, μ::Vector{Float64})
    return model.locationMatrix * μ
end

function evaluateScaleParameter(model::RegressionGEVModel, σ::Vector{Float64})
    return exp.(model.scaleMatrix * σ)
end

function evaluateShapeParameter(model::RegressionGEVModel, ξ::Vector{Float64})
    return model.shapeMatrix * ξ
end

function evaluateParameters(model::RegressionGEVModel, θ::NamedTuple{(:μ, :σ, :ξ), Tuple{Vector{Float64}, Vector{Float64}, Vector{Float64}}})
    return (evaluateLocationParameter(model, θ.μ), evaluateScaleParameter(model, θ.σ), evaluateShapeParameter(model, θ.ξ))
end

generate_distribution(modeltype::Type{RegressionGEVModel}, μ::Real, σ::Real, ξ::Real) = GeneralizedExtremeValue(μ, σ, ξ)