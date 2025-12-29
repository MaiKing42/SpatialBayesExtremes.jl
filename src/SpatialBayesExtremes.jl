module SpatialBayesExtremes

using Distributions, DataFrames, StatsModels, ForwardDiff, SpecialFunctions, Roots, Optim, GLM, LineSearches, Turing, AbstractMCMC

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
    loglikelihoodDerivative,
    fitgumbelPWM,
    fitgevPWM,
    fitgpdPWM,
    fitgpdMeplot,
    fitgpdHill,
    fitgevMLE,
    fitgpdMLE

include("utils.jl")
include("extremevaluemodel.jl")
include("fittedestimator.jl")
include("parameterestimation.jl")
end
