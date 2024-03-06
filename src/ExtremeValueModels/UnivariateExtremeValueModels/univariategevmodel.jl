struct UnivariateGEVModel <: UnivariateExtremeValueModel
    data::Vector{Float64}
end


function getdistribution(model::UnivariateGEVModel,θ::NamedTuple{(:μ, :σ, :ξ),Tuple{Float64,Float64,Float64}})
    return GeneralizedExtremeValue(θ.μ, θ.σ, θ.ξ)
end