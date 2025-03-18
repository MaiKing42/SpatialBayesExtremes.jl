fitSpatialgevML(data::Vector{<:Real}, covariates::DataFrame, locationFormula::FormulaTerm, scaleFormula::FormulaTerm, shapeFormula::FormulaTerm) = fit(RegressionGEVModel(data, covariates, locationFormula, scaleFormula, shapeFormula), MaximumLikelihoodEstimator)

fitSpatialgevML(data::DataFrame, column::Symbol, locationFormula::FormulaTerm, scaleFormula::FormulaTerm, shapeFormula::FormulaTerm) = fit(RegressionGEVModel(data[:,column], data, locationFormula, scaleFormula, shapeFormula), MaximumLikelihoodEstimator)

fitSpatialgevML(data::Vector{<:Real}, covariates::DataFrame, locationFormula::FormulaTerm, scaleFormula::FormulaTerm, shapeFormula::FormulaTerm, initialvalue::NamedTuple) = fit(RegressionGEVModel(data, covariates, locationFormula, scaleFormula, shapeFormula), initialvalue, MaximumLikelihoodEstimator)

fitSpatialgevML(data::DataFrame, column::Symbol, locationFormula::FormulaTerm, scaleFormula::FormulaTerm, shapeFormula::FormulaTerm, initialvalue::NamedTuple) = fit(RegressionGEVModel(data[:,column], data, locationFormula, scaleFormula, shapeFormula), initialvalue, MaximumLikelihoodEstimator)

function getInitialValue(model::RegressionGEVModel, estimator::Type{MaximumLikelihoodEstimator})
    univariateEstimate = fit(UnivariateGEVModel(model.data), estimator)
    initialμ = zeros(size(model.locationMatrix,1))
    initialμ[findfirst(==("(Intercept)"),coefnames(model.locationTerm.rhs))] = univariateEstimate.θ̂.μ
    initialσ = zeros(size(model.scaleMatrix,1))
    initialσ[findfirst(==("(Intercept)"),coefnames(model.scaleTerm.rhs))] = univariateEstimate.θ̂.σ
    initialξ = zeros(size(model.shapeMatrix,1))
    initialξ[findfirst(==("(Intercept)"),coefnames(model.shapeTerm.rhs))] = univariateEstimate.θ̂.ξ

    return (μ = initialμ, σ = initialσ, ξ = initialξ)
end