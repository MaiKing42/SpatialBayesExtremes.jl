module SpatialBayesExtremes

using Distributions, DataFrames, StatsModels, ProgressMeter, ForwardDiff, SpecialFunctions, Roots, Optim

export 
    ExtremeValueModel,
    ContinuousExtremeValueModel,
    RegressionExtremeValueModel,
    RegressionGEVModel,
    RegressionGPDModel,
    UnivariateExtremeValueModel,
    UnivariateGEVModel,
    UnivariateGPDModel,
    get_parameters,
    get_distribution,
    loglikelihood,
    likelihood,
    loglikelihood_derivative

include("utils.jl")
include("extremevaluemodel.jl")
include("fittedestimator.jl")
include("parameterestimation.jl")
end
