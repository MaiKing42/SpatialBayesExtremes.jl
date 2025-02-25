function getInitialValues(model::ExtremeValueModel, estimator::Type{MaximumLikelihoodEstimator}) end

function fit(model::ExtremeValueModel, initialvalues::NamedTuple, estimator::Type{MaximumLikelihoodEstimator}) end

fit(model::ExtremeValueModel, estimator::Type{MaximumLikelihoodEstimator}) = fit(model, getInitialValues(model, estimator), estimator)