function getInitialValue(model::RegressionGEVModel, estimator::Type{MaximumLikelihoodEstimator})
    univariateEstimate = fit(UnivariateGEVModel(model.data), estimator)
    initialμ = zeros(size(model.locationMatrix)[1])
    initialμ[findfirst(==("(Intercept)"),model.locationTerm.rhs)] = univariateEstimate.θ̂.μ
    initialσ = zeros(size(model.scaleMatrix)[1])
    initialσ[findfirst(==("(Intercept)"),model.scaleTerm.rhs)] = univariateEstimate.θ̂.σ
    initialξ = zeros(size(model.shapeMatrix)[1])
    initialξ[findfirst(==("(Intercept)"),model.shapeTerm.rhs)] = univariateEstimate.θ̂.ξ

    return (μ = initialμ, σ = initialσ, ξ = initialξ)
end