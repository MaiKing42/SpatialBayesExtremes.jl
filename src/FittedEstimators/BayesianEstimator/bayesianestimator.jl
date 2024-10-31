struct BayesianEstimator{M<:ExtremeValueModel} <: FittedEstimator{M}
    model::M
    posterior::AbstractArray
end