function scoreFunction(dist::GeneralizedExtremeValue,data::Float64)
    μ = dist.μ
    σ = dist.σ
    ξ = dist.ξ
    z = (data - μ)/σ
    ξ_z = ξ*z
    if ξ == 0
        u = exp(-z)
        dξ_log_u = z^2/2
    elseif ξ_z>-1
        u = (1+ξ_z)^(-1/ξ)
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

function scoreFunction(dist::Gumbel,data::Float64)
    μ = dist.μ
    σ = dist.σ
    z = (data - μ)/σ
    u = exp(-z)
    ∂μ = (1-u)/σ
    ∂σ = ((1-u)*z-1)/σ
    return (μ=∂μ,σ=∂σ)
end

function scoreFunction(dist::GeneralizedPareto,data::Float64)
    μ = dist.μ
    σ = dist.σ
    ξ = dist.ξ
    z = (data - μ)/σ
    if (ξ >= 0 && z<=0) || (ξ<0 && (z>-1/ξ || z<0))
        ∂μ = Inf
        ∂σ = Inf
        ∂ξ = Inf
        return (μ=∂μ,σ=∂σ,ξ=∂ξ)
    elseif ξ == 0
        u = exp(-z)
        dξ_log_u = z^2/2
    else
        u = (1+ξ*z)^(-1/ξ)
        dξ_log_u = 1/ξ*(1/ξ*log(1+ξ*z)-z/(1+ξ*z))
    end
    ∂μ = (ξ+1)/(σ*(1+ξ*z))
    ∂σ = -1/σ + (ξ+1)*z/(σ*(1+ξ*z))
    ∂ξ = log(u) + (ξ+1)*dξ_log_u
    return (μ=∂μ,σ=∂σ,ξ=∂ξ)
end