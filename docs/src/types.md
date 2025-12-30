# Type Hierarchy

The extreme value models and fitted models are organized into a type hierarchy as follows:

## Extreme Value Models

An extreme value model provides all the information and metadata necessary to apply an estimation method, such as the parametric family, the data and covariates.

### ExtremeValueModel

The abstract type `ExtremeValueModel` subsumes any types of objects which specify a parametric family meant for estimation of extremes and all necessary sample information.

```@docs
SpatialBayesExtremes.ExtremeValueModel
SpatialBayesExtremes.getDistribution
SpatialBayesExtremes.likelihood
SpatialBayesExtremes.loglikelihood
```

Currently, we distinguish between two subtypes of `ExtremeValueModel`, depending on whether the model includes covariates and allows for extrapolation beyond the sample covariates ([continuous](@ref continuous)) or not ([discrete](@ref discrete)).

```julia
abstract type DiscreteExtremeValueModel <: ExtremeValueModel end
abstract type ContinuousExtremeValueModel <: ExtremeValueModel end
```

## Fitted Estimators

The fitted estimator yields the connection between statistical model and the estimation method generating the parameter estimate.

### FittedEstimator

Any type of object linking a `ExtremeValueModel` to a estimation method and the parameter estimates is a subtype of the abstract type `FittedEstimator`.

```julia
abstract type FittedEstimator{M<:ExtremeValueModel} end
```

It has one parameter that specifies the statistical model it is the parameter estimates correspond to.

```@docs
SpatialBayesExtremes.FittedEstimator
```

