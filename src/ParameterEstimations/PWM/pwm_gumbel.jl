fitgev_pwm(data::Vector{<:Real}) = fit(UnivariateGumbelModel(data), typeof(PWMEsstimator))

fitgev_pwm(data::DataFrame, column::Symbol) = fit(UnivariateGumbelModel(data[:,column]), typeof(PWMEstimator))

function fit(model::UnivariateGumbelModel, estimator::typeof(PWMEstimator))
    data = model.data

    β_0 = pwm(y,1,0,0)
    β_1 = pwm(y,1,0,1)

    σ = (β_0 - 2*β_1)/log(2)

    μ = β_0 - Base.MathConstants.eulergamma*σ

    return PWMEstimator{UnivariateGEVModel}(model, (μ=μ,logσ=log(σ)))
end