fitgp_pwm(data::Vector{<:Real}) = fit(UnivariateGEVModel(data), typeof(PWMestimator))

fitgp_pwm(data::DataFrame, column::Symbol) = fit(UnivariateGEVModel(data[:,column]), typeof(PWMestimator))