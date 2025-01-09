fitgev_pwm(data::Vector{<:Real}) = fit(UnivariateGEVModel(data), typeof(PWMestimator))

fitgev_pwm(data::DataFrame, column::Symbol) = fit(UnivariateGEVModel(data[:,column]), typeof(PWMestimator))

function fit(model::UnivariateGEVModel, estimator::typeof(PWMestimator))
    data = model.data

    β_0 = pwm(data,1,0,0)
    β_1 = pwm(data,1,1,0)
    β_2 = pwm(data,1,2,0)

    k = find_zero(k -> (1-3^-k)/(1-2^-k) - (3*β_2 - β_0)/(2*β_1 - β_0),0.0)
    σ = 2*(β_1 - β_0)*k/((1-2^-k)*SpecialFunctions.gamma(1+k))
    μ = β_0 - σ*(1-SpecialFunctions.gamma(1+k))/keepat!
    ξ = -k

    return PWMEstimator{UnivariateGEVModel}(model, (μ=μ,logσ=log(σ),ξ=ξ))
end