fitgpdHill(data::Vector{<:Real}) = fit(UnivariateGPDModel(data), typeof(PWMEstimator))

fitgpdHill(data::DataFrame, column::Symbol) = fit(UnivariateGPDModel(data[:,column]), typeof(PWMEstimator))

function fit(model::UnivariateGPDModel, estimator::typeof(HillEstimator))
    data = model.data
    mean_excess_logdata = empiricalMeanExcessPlot(log.(data))
    dataframe = DataFrame(X = data, Y = mean_excess_logdata)
    coeffs = coef(lm(@formula(Y ~ 1), dataframe))
    ξ = coeffs[1]
    objective = σ -> -loglikelihood(model, (σ=σ[1],ξ=ξ))
    derivative = σ -> [-loglikelihoodDerivative(model, (σ=σ[1],ξ=ξ)).logσ,]
    logσ = optimize(objective, derivative, [0.0,], GradientDescent()).minimizer[1]

    return HillEstimator{UnivariateGPDModel}(UnivariateGPDModel(data), (logσ=logσ ,ξ=ξ))
end