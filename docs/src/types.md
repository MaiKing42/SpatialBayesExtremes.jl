# Type Hierarchy

The extreme value models and fitted models are organized into a type hierarchy as follows:

## Extreme Value Models

An extreme value model provides all the information and metadata necessary to apply an estimation method, such as the parametric family, the data and covariates.

### ExtremeValueModel

The abstract type `ExtremeValueModel` subsumes any types of objects which specify a parametric family meant for estimation of extremes and all necessary sample information.

```@doc
SpatialBayesExtremes.ExtremeValueModel
SpatialBayesExtremes.getdistribution
SpatialBayesExtremes.likelihood
SpatialBayesExtremes.loglikelihood
```

