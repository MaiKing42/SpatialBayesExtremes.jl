function pwm(x::Vector{<:Real},p::Int,r::Int,s::Int)::Real

    @assert sign(p)>=0 "p should be a non-negative integer."
    @assert sign(r)>=0 "r should be a non-negative integer."
    @assert sign(s)>=0 "s should be a non-negative integer."
   
    y = sort(x)
    n = length(y)
   
    m = 1/n*sum( y[i]^p * binomial(i-1,r)/binomial(n-1,r) * binomial(n-i,s)/binomial(n-1,s) for i=1:n )
   
    return m
   
   end