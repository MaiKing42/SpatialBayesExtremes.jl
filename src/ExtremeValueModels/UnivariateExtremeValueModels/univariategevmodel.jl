struct UnivariateGEVModel <: UnivariateExtremeValueModel
    data::Vector{Float64}
end


function getdistribution(θ::NamedTuple{(:μ, :σ, :ξ)}{T}) where T<:Real
    return GEV(θ.μ, θ.σ, θ.ξ)
end