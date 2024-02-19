struct UnivariateGEVModel <: UnivariateExtremeValueModel
    data::Vector{Float64}
end


function getdistribution(model::UnivariateGEVModel,θ::NamedTuple{(:μ, :σ, :ξ)}{T}) where T<:Real
    return GEV(θ.μ, θ.σ, θ.ξ)
end