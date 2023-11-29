"""
    ExtremeValueModel

Abstract type for extreme value models.
"""
abstract type ExtremeValueModel end

"""
    init_distribution(model::ExtremeValueModel, θ::Vector{<:Real})
Returns the distribution corresponding to the model at all evalueation sites for the
for the parameter vector θ.
"""
function init_distribution end

"""
    loglikelihood(model::ExtremeValueModel, θ::Vector{<:Real})

Returns the log-likelihood of the data associated with the model under the assumption
of the parameter vector θ.
"""
function loglikelihood(model::ExtremeValueModel, θ::Vector{<:Real})
    values = model.data
    distribution = init_distribution(model, θ)
    return sum(logpdf.(distribution, values))
end