################
# Division
################

"""
    Base.:/(a::AbstractUncertainValue, b::AbstractUncertainValue) -> UncertainValue

Division operator for pairs of uncertain values. 
    
Computes the element-wise quotients between for a default of `n = 10000` realizations of `a` and 
`b`, then returns an uncertain value based on a kernel density estimate to the distribution 
of the element-wise quotients.

Use the `/(a, b, n)` syntax to tune the number (`n`) of draws.
"""
function Base.:/(a::AbstractUncertainValue, b::AbstractUncertainValue; n::Int = 30000)
    UncertainValue(resample(a, n) ./ resample(b, n))
end

"""
    Base.:/(a::Real, b::AbstractUncertainValue) -> UncertainValue

Division operator for between scalars and uncertain values. 

Computes the element-wise quotients between `a` and `b` for a default of `n = 10000` realizations
of `b`, then returns an uncertain value based on a kernel density estimate to the 
distribution of the element-wise quotients.
    
Use the `/(a, b, n)` syntax to tune the number (`n`) of draws.
"""
Base.:/(a::Real, b::AbstractUncertainValue; n::Int = 30000) = 
    UncertainValue(a ./ resample(b, n))

"""
    Base.:/(a::AbstractUncertainValue, b::Real) -> UncertainValue

Division operator for between uncertain values and scalars. 

Computes the element-wise quotients between `a` and `b` for a default of `n = 10000` realizations
of `a`, then returns an uncertain value based on a kernel density estimate to the 
distribution of the element-wise quotients.
    
Use the `/(a, b, n)` syntax to tune the number (`n`) of draws.
"""
Base.:/(a::AbstractUncertainValue, b::Real; n::Int = 30000) = 
    UncertainValue(resample(a, n) ./ b)

"""
    Base.:/(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int) -> UncertainValue

Division operator for pairs of uncertain values. 

Computes the element-wise quotients between `a` and `b` for `n` realizations
of `a` and `b`, then returns an uncertain value based on a kernel density estimate to the 
distribution of the element-wise quotients.

Call this function using the `/(a, b, n)` syntax.
"""
function Base.:/(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int)
    UncertainValue(resample(a, n) ./ resample(b, n))
end
"""
    Base.:/(a::Real, b::AbstractUncertainValue, n::Int) -> UncertainValue

Division operator for scalar-uncertain value pairs. 

Computes the element-wise quotients between `a` and `b` for `n` realizations
of `b`, then returns an uncertain value based on a kernel density estimate to the 
distribution of the element-wise quotients.

Call this function using the `/(a, b, n)` syntax.
"""
Base.:/(a::Real, b::AbstractUncertainValue, n::Int) = 
    UncertainValue(a ./ resample(b, n))

"""
    Base.:/(a::AbstractUncertainValue, b::Real, n::Int) -> UncertainValue

Division operator for scalar-uncertain value pairs. 

Computes the element-wise quotients between `a` and `b` for `n` realizations
of `a`, then returns an uncertain value based on a kernel density estimate to the 
distribution of the element-wise quotients.

Call this function using the `/(a, b, n)` syntax.
"""
Base.:/(a::AbstractUncertainValue, b::Real, n::Int) = 
    UncertainValue(resample(a, n) ./ b)



#####################################################################################
# Special cases 
#####################################################################################

import ..UncertainValues: CertainScalar

##################
# `CertainScalar`s
#################
"""
    Base.:/(a::Union{CertainScalar, Real}, b::Union{CertainScalar, Real})

Division of certain values with themselves or scalars acts as regular division, but 
returns the result wrapped in a `CertainScalar` instance.
"""
Base.:/(a::Union{CertainScalar, Real}, b::Union{CertainScalar, Real}) 

Base.:/(a::CertainScalar, b::CertainScalar) = CertainScalar(a.value / b.value)
Base.:/(a::CertainScalar, b::Real) = CertainScalar(a.value / b)
Base.:/(a::Real, b::CertainScalar) = CertainScalar(a / b.value)

