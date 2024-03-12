struct UnivariateGEVModel <: UnivariateExtremeValueModel
    data::Vector{Float64}
end
get_distribution(
    model::UnivariateGEVModel,
    θ::NamedTuple{(:μ, :σ, :ξ), Tuple{Float64,Float64,Float64}}
) = 
GeneralizedExtremeValue(θ.μ, θ.σ, θ.ξ)