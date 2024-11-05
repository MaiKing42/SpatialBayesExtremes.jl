struct UnivariateGEVModel <: UnivariateExtremeValueModel
    data::Vector{Float64}
end

get_parameters(model::UnivariateGEVModel) = (:μ,:σ,:ξ)

_get_distribution(model::UnivariateGEVModel; μ, σ, ξ) = GeneralizedExtremeValue(μ,σ,ξ)

get_distribution(model::UnivariateGEVModel,θ::NamedTuple) = _get_distribution(model; θ...)

#score_function(model::UnivariateGEVModel,θ::NamedTuple) = score_gev.(model.data,θ.μ,θ.σ,θ.ξ)