function getInitialValue(model::ExtremeValueModel, estimator::Type{MaximumLikelihoodEstimator}) end

function fit(model::ExtremeValueModel, initialvalue::NamedTuple, estimator::Type{MaximumLikelihoodEstimator})
    all(insupport.(getDistribution(model, initialvalue), model.data)) || throw(ArgumentError("Data is not in the support of the initial distribution"))

    flatInitialValues, unflatten = value_flatten(initialvalue)

    objective(θ) = -loglikelihood(model, unflatten(θ))

    function derivative(θ)
        derivativeTuple = -loglikelihoodDerivative(model, unflatten(θ))
        return value_flatten(derivativeTuple)[1]
    end

    opt = optimize(objective, derivative, flatInitialValues, BFGS(linesearch = LineSearches.BackTracking()))

    converged(opt) || warn("Optimization did not converge")

    return MaximumLikelihoodEstimator(model, unflatten(opt.minimizer), converged(opt))
end

fit(model::ExtremeValueModel, estimator::Type{MaximumLikelihoodEstimator}) = fit(model, getInitialValue(model, estimator), estimator)

include(joinpath("MaximumLikelihood", "ml_gev_univ.jl"))
include(joinpath("MaximumLikelihood", "ml_gev_regr.jl"))
include(joinpath("MaximumLikelihood", "ml_gpd_univ.jl"))
include(joinpath("MaximumLikelihood", "ml_gpd_regr.jl"))