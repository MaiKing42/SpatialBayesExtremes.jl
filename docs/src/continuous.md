# [Continuous Extreme Value Models](@id continuous)

Contrary to the discrete extreme value models, continuous extreme value models require covariates and thus allow estimation of extreme events for evaluation sites with yet unobserved data.

```@docs
SpatialBayesExtremes.ContinuousExtremeValueModel
SpatialBayesExtremes.getDistribution(model::ContinuousExtremeValueModel, covariates::DataFrame, θ::NamedTuple)
