fitSpatialgpdML(data::Vector{<:Real}, covariates::DataFrame, scaleFormula::FormulaTerm, shapeFormula::FormulaTerm) = fit(SpatialGPDModel(data, covariates, scaleFormula, shapeFormula), MaximumLikelihoodEstimator)

fitSpatialgpdML(data::DataFrame, column::Symbol, scaleFormula::FormulaTerm, shapeFormula::FormulaTerm) = fit(SpatialGPDModel(data[:,column], data, scaleFormula, shapeFormula), MaximumLikelihoodEstimator)

fitSpatialgpdML(data::Vector{<:Real}, covariates::DataFrame, scaleFormula::FormulaTerm, shapeFormula::FormulaTerm, initialvalue::NamedTuple) = fit(SpatialGPDModel(data, covariates, scaleFormula, shapeFormula), initialvalue, MaximumLikelihoodEstimator)

fitSpatialgpdML(data::DataFrame, column::Symbol, scaleFormula::FormulaTerm, shapeFormula::FormulaTerm, initialvalue::NamedTuple) = fit(SpatialGPDModel(data[:,column], data, scaleFormula, shapeFormula), initialvalue, MaximumLikelihoodEstimator)

function getInitialValue(model::SpatialGPDModel, estimator::Type{MaximumLikelihoodEstimator})
    univariateEstimate = fit(UnivariateGPDModel(model.data), estimator)
    initialσ = zeros(size(model.scaleMatrix,1))
    initialσ[findfirst(==("(Intercept)"),coefnames(model.scaleTerm.rhs))] = univariateEstimate.θ̂.σ
    initialξ = zeros(size(model.shapeMatrix,1))
    initialξ[findfirst(==("(Intercept)"),coefnames(model.shapeTerm.rhs))] = univariateEstimate.θ̂.ξ

    return (σ = initialσ, ξ = initialξ)
end