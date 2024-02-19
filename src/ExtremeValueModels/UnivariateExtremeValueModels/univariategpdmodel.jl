struct UnivariateGPDModel <: UnivariateExtremeValueModel
    ξ::Float64
    μ::Float64
    σ::Float64
end

function getdistribution(θ::NamedTuple{(:μ, :σ, :ξ)}{T}) where T<:Real
    return GPD(θ.μ, θ.σ, θ.ξ)
end