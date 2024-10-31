struct UnivariateGEVModel <: UnivariateExtremeValueModel{GeneralizedExtremeValue}
    data::Vector{Float64}
end

score_function(model::UnivariateExtremeValueModel{GeneralizedExtremeValue},θ::NamedTuple) where {T} = score_gev.(model.data,θ.μ,θ.σ,θ.ξ)