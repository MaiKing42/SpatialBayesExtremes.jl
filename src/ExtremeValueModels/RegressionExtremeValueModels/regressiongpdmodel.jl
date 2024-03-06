struct RegressionGPDModel<:RegressionExtremeValueModel
    data::Vector{Float64}
    scaleMatrix::Matrix{Float64}
    shapeMatrix::Matrix{Float64}
end


function evaluateScaleParameter(model::RegressionGPDModel, θ::Array{Float64, 1})
    return exp.(model.scaleMatrix * θ)
end

function evaluateShapeParameter(model::RegressionGPDModel, θ::Array{Float64, 1})
    return model.shapeMatrix * θ
end

function evaluateParameters(model::RegressionModel, θ::NamedTuple{(:σ, :ξ), Tuple{Array{Float64, 1}, Array{Float64, 1}, Array{Float64, 1}}})
    return (evaluateLocationParameter(model, θ.σ), evaluateScaleParameter(model, θ.ξ))
end

generateDistribution(modeltype::Type{RegressionGPDModel}, σ::Real, ξ::Real) = GeneralizedPareto(σ, ξ)