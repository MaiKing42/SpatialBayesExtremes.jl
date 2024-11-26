function score_function(dist::GeneralizedExtremeValue,data::Float64)
    ϵ = 1e-15
    μ = dist.μ
    σ = dist.σ
    ξ = dist.ξ
    z = (data - μ)/σ
    ξ_z = ξ*z
    if dist.ξ == 0
        u = exp(-z)
        dξ_log_u = z^2/2
    elseif ξ_z>-1
        u = (1+ξ_z).^(-1/ξ)
        dξ_log_u = 1/dist.ξ*(1/ξ*log(1+ξ_z)-z/(1+ξ_z))
    else
        ∂μ = Inf
        ∂σ = Inf
        ∂ξ = Inf
        return (μ=∂μ,σ=∂σ,ξ=∂ξ)
    end
    ∂μ = (ξ+1-u)/(σ*(1+ξ_z))
    ∂σ = ((1-u)*z-1)/(σ*(1+ξ_z))
    ∂ξ = (1-u)*dξ_log_u-z/(1+ξ_z)
    return (μ=∂μ,σ=∂σ,ξ=∂ξ)
end