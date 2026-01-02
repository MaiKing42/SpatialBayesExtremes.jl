# [Discrete Extreme Value Models](@id discrete)

Any extreme value model that does not require any covariates and is thus restricted to extrapolation at the observation sites is considered a subtype of `DiscreteExtremeValueModel`.

```@docs
SpatialBayesExtremes.DiscreteExtremeValueModel
```

Currently, the only available class of discrete extreme value models are univariate extreme value models.

## Univariate Extreme Value Models

The abstract type `UnivariateExtremeValueModel` subsumes different parametric families of univariate distributions suitable to model univariate extremes.

```@docs
SpatialBayesExtremes.UnivariateExtremeValueModel
```
We consider the following classes of distributions:

```@docs
UnivariateGumbelModel
```

```@docs
UnivariateGEVModel
```

