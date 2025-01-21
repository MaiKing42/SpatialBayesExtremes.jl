struct MeanExcessEstimator{M<:ExtremeValueModel} <: FittedEstimator{M}
    model::M
    θ̂::NamedTuple
end