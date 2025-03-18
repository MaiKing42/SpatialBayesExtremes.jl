fitgpdMeplot(data::Vector{<:Real}) = fit(UnivariateGPDModel(data), MeanExcessEstimator)

fitgpdMeplot(data::DataFrame, column::Symbol) = fit(UnivariateGPDModel(data[:,column]), MeanExcessEstimator)

function fit(model::UnivariateGPDModel, estimator::Type{PWMEstimator})
    data = model.data
    mean_excess_data = empiricalMeanExcessPlot(data)
    dataframe = DataFrame(X = data, Y = mean_excess_data)
    coeffs = coef(lm(@formula(Y ~ X), dataframe))
    ξ = coeffs[2]/(coeffs[2]+1)
    σ = coeffs[1]/(1-ξ)

    return PWMEstimator{UnivariateGPDModel}(UnivariateGPDModel(data), (σ=log(σ),ξ=ξ))
end