fitgpd_meplot(data::Vector{<:Real}) = fit(UnivariateGPDModel(data), typeof(PWMEstimator))

fitgpd_meplot(data::DataFrame, column::Symbol) = fit(UnivariateGPDModel(data[:,column]), typeof(PWMEstimator))

function fit(data::Vector{<:Real}, estimator::typeof(PWMEstimator))
    mean_excess_data = empirical_mean_excess_plot(data)
    dataframe = DataFrame(X = data, Y = mean_excess_data)
    coeffs = GLM.coef(GLM.lm(@formula(Y ~ X), dataframe))
    ξ = coeffs[2]/(coeffs[2]+1)
    σ = coeffs[1]/(1-ξ)

    return PWMEstimator{UnivariateGPDModel}(UnivariateGPDModel(data), (logσ=log(σ),ξ=ξ))
end