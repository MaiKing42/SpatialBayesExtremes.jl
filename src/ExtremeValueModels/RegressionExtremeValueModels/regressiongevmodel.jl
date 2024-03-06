struct RegressionGEVModel<:RegressionExtremeValueModel
    data::DataFrame
    values::Symbol
    locationMatrix::Array{Float64, 2}
    scaleMatrix::Array{Float64, 2}
    shapeMatrix::Array{Float64, 2}
end

function evaluateLocationParameter(model::RegressionGEVModel, θ::Array{Float64, 1})
    return model.locationMatrix * θ
end

function evaluateScaleParameter(model::RegressionGEVModel, θ::Array{Float64, 1})
    return exp.(model.scaleMatrix * θ)
end

function evaluateShapeParameter(model::RegressionGEVModel, θ::Array{Float64, 1})
    return model.shapeMatrix * θ
end

function evaluateParameters(model::RegressionModel, θ::NamedTuple{(:location, :scale, :shape), Tuple{Array{Float64, 1}, Array{Float64, 1}, Array{Float64, 1}}})
    return (evaluateLocationParameter(model, θ.location), evaluateScaleParameter(model, θ.scale), evaluateShapeParameter(model, θ.shape))
end

generateDistribution(modeltype::Type{RegressionGEVModel}, μ::Real, σ::Real, ξ::Real) = GEV(μ, σ, ξ)