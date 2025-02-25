fitgpdPWM(data::Vector{<:Real}) = fit(UnivariateGPDModel(data), PWMEstimator)

fitgpdPWM(data::DataFrame, column::Symbol) = fit(UnivariateGPDModel(data[:,column]), PWMEstimator)

function fit(model::UnivariateGPDModel, estimator::Type{PWMEstimator})
    data = model.data

    a_0 = pwm(data,1,0,0)
    a_1 = pwm(data,1,0,1)

    σ = 2*a_0*a_1/(a_0 - 2*a_1)
    k = a_0 / (a_0 - 2*a_1) - 2

    ξ = - k
    
    return PWMEstimator{UnivariateGPDModel}(model, (logσ=log(σ),ξ=ξ))
end