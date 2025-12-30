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

Currently, we distinguish between two subtypes of `ExtremeValueModel`, depending on whether the model includes covariates and allows for exrapolation beyond the sample covariates ([continuous](@ref continuous)) or not ([discrete](@ref discrete)).

```julia
abstract type DiscreteExtremeValueModel <: ExtremeValueModel end
abstract type ContinuousExtremeValueModel <: ExtremeValueModel end
```