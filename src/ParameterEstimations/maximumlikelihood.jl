function getInitialValues(model::ExtremeValueModel, estimator::Type{MaximumLikelihoodEstimator}) end

function fit(model::ExtremeValueModel, initialvalues::NamedTuple, estimator::Type{MaximumLikelihoodEstimator})
    flatInitialValues, unflatten = flatten(initialvalues)

    objective(θ) = -loglikelihood(model, unflatten(θ))

    function derivative(θ)
        derivativeTuple = -loglikelihoodDerivative(model, unflatten(θ))
        return flatten(derivativeTuple)[1]
    end

    opt = optimize(objective, derivative, flatInitialValues, BFGS(linesearch = LineSearches.BackTracking()))

    return MaximumLikelihoodEstimator(model, unflatten(opt.minimizer))
end

fit(model::ExtremeValueModel, estimator::Type{MaximumLikelihoodEstimator}) = fit(model, getInitialValues(model, estimator), estimator)