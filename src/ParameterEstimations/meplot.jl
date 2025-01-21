function empirical_mean_excess(data::Vector{T},threshold::T) where {T<:Real}
    return mean(data[data .> threshold] .- threshold)
end

function empirical_mean_excess_plot(data::Vector{T}) where {T<:Real}
    n = length(data)
    return [mean_excess(data,data[i]) for i in 1:n-1]
end