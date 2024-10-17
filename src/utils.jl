function score_gev(data::Real,μ::Real,σ::Real,ξ::Real)
    ϵ = 1e-15
    σ = σ + ϵ
    z = (data - μ)/σ
    ξ_z = ξ*z
    if ξ == 0
        u = exp(-z)
        dξ_log_u = z^2/2
    elseif ξ_z>-1
        u = (1+ξ_z).^(-1/ξ)
        dξ_log_u = 1/ξ*(1/ξ*log(1+ξ_z)-z/(1+ξ_z))
    else
        G[1] = Inf
        G[2] = Inf
        G[3] = Inf
        return G
    end
    G[1] = (ξ+1-u)/(σ*(1+ξ_z))
    G[2] = ((1-u)*z-1)/(σ*(1+ξ_z))
    G[3] = (1-u)*dξ_log_u-z/(1+ξ_z)
    return G
end