struct UnivariateGPDModel <: UnivariateExtremeValueModel
    data::Vector{Float64}
end

function getdistribution(model::UnivariateGPDModel,θ::NamedTuple{(:σ, :ξ),Tuple{Float64,Float64}})
    return GeneralizedPareto(θ.σ, θ.ξ)
end