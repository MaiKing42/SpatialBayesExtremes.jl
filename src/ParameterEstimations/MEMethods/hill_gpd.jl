fitgpdHill(data::Vector{<:Real}) = fit(UnivariateGPDModel(data), HillEstimator)

fitgpdHill(data::DataFrame, column::Symbol) = fit(UnivariateGPDModel(data[:,column]), HillEstimator)

function fit(model::UnivariateGPDModel, estimator::Type{HillEstimator})
    data = sort(model.data)
    ξ = empiricalMeanExcess(log.(data),log(data[1]))
    objective = σ -> -loglikelihood(model, (σ=σ[1],ξ=ξ))
    derivative = σ -> [-loglikelihoodDerivative(model, (σ=σ[1],ξ=ξ)).logσ,]
    logσ = optimize(objective, derivative, [0.0,], GradientDescent()).minimizer[1]

    return HillEstimator{UnivariateGPDModel}(UnivariateGPDModel(data), (σ=logσ ,ξ=ξ))
end