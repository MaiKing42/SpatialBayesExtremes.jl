struct UnivariateGPDModel <: UnivariateExtremeValueModel
    values::Vector{Float64}
end

function getdistribution(model::UnivariateGPDModel,θ::NamedTuple{(:μ, :σ, :ξ)}{T}) where T<:Real
    return GPD(θ.μ, θ.σ, θ.ξ)
end