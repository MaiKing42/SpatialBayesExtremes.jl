struct MeanExcessEstimator <: FittedEstimator{UnivariateGPDModel}
    model::UnivariateGPDModel
    θ̂::NamedTuple
end