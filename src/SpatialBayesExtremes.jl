module SpatialBayesExtremes

using Distributions, DataFrames, StatsModels, ProgressMeter, ForwardDiff, SpecialFunctions, Roots, Optim, GLM, LineSearches

export 
    ExtremeValueModel,
    ContinuousExtremeValueModel,
    RegressionExtremeValueModel,
    RegressionGEVModel,
    RegressionGPDModel,
    DiscreteExtremeValueModel,
    UnivariateExtremeValueModel,
    UnivariateGEVModel,
    UnivariateGumbelModel,
    UnivariateGPDModel,
    FittedEstimator,
    PWMEstimator,
    MeanExcessEstimator,
    HillEstimator,
    MaximumLikelihoodEstimator,
    BayesianEstimator,
    getModelParameters,
    getDistribution,
    loglikelihood,
    likelihood,
    loglikelihoodDerivative

include("utils.jl")
include("extremevaluemodel.jl")
include("fittedestimator.jl")
include("parameterestimation.jl")
end
