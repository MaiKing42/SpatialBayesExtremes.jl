struct UnivariateGPDModel <: UnivariateExtremeValueModel
    values::Vector{Float64}
end

function getdistribution(model::UnivariateGPDModel,θ::NamedTuple{(:μ, :σ, :ξ),Tuple{Float64,Float64,Float64}}) where T<:Real
    return GPD(θ.μ, θ.σ, θ.ξ)
end