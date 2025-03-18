fitGEVML(data::Vector{<:Real}) = fit(UnivariateGEVModel(data), MaximumLikelihoodEstimator)

fitGEVML(data::Vector{<:Real}, initialvalue::NamedTuple) = fit(UnivariateGEVModel(data), initialvalue, MaximumLikelihoodEstimator)

function getInitialValue(model::UnivariateGEVModel, estimator::Type{MaximumLikelihoodEstimator})
    initialGuess = fitgevPWM(model.data).θ̂
    flatInitialGuess, unflatten = value_flatten(initialGuess)
    objective(θ::NamedTuple) = sum(-min.(0, 1.0 + θ.ξ*(model.data - θ.μ)/exp(θ.σ) + exp(θ.λ)))
    opt = optimize(objective ∘ unflatten,θ -> only(Zygote.gradient(objective ∘ unflatten, θ)), flatInitialGuess, BFGS(linesearch = LineSearches.BackTracking()))
    return unflatten(opt.minimizer)
end