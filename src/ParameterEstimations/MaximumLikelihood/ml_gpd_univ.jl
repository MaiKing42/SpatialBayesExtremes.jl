fitgpdML(data::Vector{<:Real}, threshold::Real) = fit(UnivariateGPDModel(data, threshold), MaximumLikelihoodEstimator)

fitgpdML(data::DataFrame, column::Symbol, threshold::Real) = fit(UnivariateGPDModel(data[:,column], threshold), MaximumLikelihoodEstimator)

fitgpdML(data::Vector{<:Real}, threshold::Real, initialvalue::NamedTuple) = fit(UnivariateGPDModel(data, threshold), initialvalue, MaximumLikelihoodEstimator)

fitgpdML(data::DataFrame, column::Symbol, threshold::Real, initialvalue::NamedTuple) = fit(UnivariateGPDModel(data[:,column], threshold), initialvalue, MaximumLikelihoodEstimator)

getInitialValue(model::UnivariateGPDModel, estimator::Type{MaximumLikelihoodEstimator}) = fitgpdHill(model.data).θ̂