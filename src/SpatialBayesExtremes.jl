module SpatialBayesExtremes

using Distributions, DataFrames, StatsModels, ProgressMeter, ForwardDiff, SpecialFunctions, Roots, Optim, GLM, LineSearches

export 
    ExtremeValueModel,
    ContinuousExtremeValueModel,
    RegressionExtremeValueModel,
    RegressionGEVModel,
    RegressionGPDModel,
    UnivariateExtremeValueModel,
    UnivariateGEVModel,
    UnivariateGPDModel,
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
