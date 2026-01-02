# [Continuous Extreme Value Models](@id continuous)

Contrary to the discrete extreme value models, continuous extreme value models require covariates and thus allow estimation of extreme events for evaluation sites with yet unobserved data.

```@docs
SpatialBayesExtremes.ContinuousExtremeValueModel
SpatialBayesExtremes.getDistribution(model::ContinuousExtremeValueModel, covariates::DataFrame, θ::NamedTuple)
```

Currently, the only available class of continuous extreme value models are regression extreme value models.

## Regression Extreme Value Models

As in the univariate case, we assume that the response variable can be modeled using a univariate extreme value model, but its parameters are allowed to vary with covariates through regression representations:

### Model setting

Conditional on the covariates, each observation is assumed to follow an extreme value distribution (e.g. GEV, GPD). All observations are assumed to be independent, irrespective of the covariates.

In contrast to stationary models with constant parameters, we allow each model parameter to depend on covariates. For a generic parameter $θ$, we assume
$$
\theta = f(x)
$$
where $x$ denotes a covariate vector (e.g. the covariates associated with some observation), and $f$ belongs to a user-specified function class as follows:
Although th dependence on the covariates may be nonlinear, the model is linear in its unknown parameters. More precisely, each parameter function can is represented as
$$
    \theta = \sum_{i = 1}^{m} \beta_{j} \, \phi_{j}(x)
$$
where:
* $\beta = (\beta_{1}, \dots, \beta_{m})$ are regression coefficients
* $\phi_{j}$ are functions of the covariates

The basis functions $\phi_{j}(\cdot)$ may include:
* raw covariates
* transformations such as powers or interactions
* user-defined functions of covariates

Each model parameter of the univariate extreme value model has its own set of basis functions and coefficients.

### Representation in Julia

In Julia, observations and covariates are stored in one `DataFrame`. The functional form of each parameter is specified using the `@formula` interface from [`StatsModels.jl`](https://juliastats.org/StatsModels.jl/stable/). The formula defines how the transformed covariates enter the linear predictor for a given parameter. For example,

```julia
@formula(μ ~ 1 + x + log(z))
```

corresponds to a parameter function of the form
$$
\mu = \beta_{0} + \beta_{1}x + \beta_{2}\log(z).
$$

```@docs
SpatialBayesExtremes.RegressionExtremeValueModel
```

We consider the following regression models:

```@docs
RegressionGEVModel
```

```@docs
RegressionGPDModel
```