struct UnivariateGPDModel <: UnivariateExtremeValueModel
    data::Vector{Float64}
end

function getdistribution(model::UnivariateGPDModel,θ::NamedTuple{(:μ, :σ, :ξ),Tuple{Float64,Float64,Float64}})
    return GPD(θ.μ, θ.σ, θ.ξ)
end