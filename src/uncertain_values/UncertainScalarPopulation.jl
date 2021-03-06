
import IntervalArithmetic: interval
import Distributions 
import StatsBase

const POTENTIAL_UVAL_TYPES = Union{T1, T2} where {T1<:Number, T2} where  T2 <: AbstractUncertainValue

"""
    UncertainScalarPopulation(values, probs)
    UncertainScalarPopulation(values, probs::Vector{Number})
    UncertainScalarPopulation(values, probs::Statsbase.AbstractWeights)


An `UncertainScalarPopulation`, which consists of some population members (`values`)
and some weights (`probs`) that indicate the relative importance of the 
population members (for example during resampling). 

## Fields

- **`values`**: The members of the population. Can be either numerical values, any
    type of uncertain value defined in this package (including populations), and
    `Measurement` instances from Measurements.jl.
- **`probs`**: The probabilities of sampling each member of the population.

## Constructors 

- If `values` contains only scalar numeric values, then the `values` field 
    will be of type `Vector{Number}`.
- If `values` contains one or more uncertain values, then the `values` field 
    will be of type `Vector{AbstractUncertainValue}`

## Example 

```julia

# Uncertain population consisting of CertainValues (scalars get promoted to 
# CertainValue), theoretical distributions and KDE distributions
pop1 = UncertainScalarPopulation(
    [3.0, UncertainValue(Normal, 0, 1), UncertainValue(Gamma, 2, 3), 
    UncertainValue(Uniform, rand(1000))], [0.5, 0.5, 0.5, 0.5])

# Uncertain population consisting of scalar values
pop2 = UncertainScalarPopulation([1, 2, 3], rand(3))
pop3 = UncertainScalarPopulation([1, 2, 3], Weights(rand(3)))

# Uncertain population consisting of uncertain populations
pop4 = UncertainScalarPopulation([pop1, pop2], [0.1, 0.5])

# Uncertain population consisting of uncertain populations, a scalar and 
# a normal distribution. Assign random weights.
vals = [pop1, pop2, 2, UncertainValue(Normal, 0.3, 0.014)]
pop5 = UncertainScalarPopulation(vals, Weights(rand(4)))
```
"""
struct UncertainScalarPopulation{T, PW <: StatsBase.AbstractWeights} <: AbstractScalarPopulation{T, PW}
    values::Vector{T}
    probs::PW
end

"""
    UncertainScalarPopulation(values::Vector, probabilities::Vector{Float64})

Construct a population from a vector of values and a vector of probabilities associated 
to those values."""
function UncertainScalarPopulation(values::Vector{T1}, probabilities::Vector{T2}) where {T1 <: Number, T2 <: Number}
    if length(values) != length(probabilities)
        throw(ArgumentError("Lengths of values and probability vectors do not match."))
    end
    UncertainScalarPopulation(values, StatsBase.weights(probabilities))
end
function UncertainScalarPopulation(values::VT, probabilities) where VT <: Vector{ELTYPE} where {ELTYPE<:POTENTIAL_UVAL_TYPES}
    if length(values) != length(probabilities)
        throw(ArgumentError("Lengths of values and probability vectors do not match."))
    end
    UncertainScalarPopulation(UncertainValue.(values), StatsBase.weights(probabilities))
end


"""
    ConstrainedUncertainScalarPopulation(values, probs)
    ConstrainedUncertainScalarPopulation(values, probs::Vector{Number})
    ConstrainedUncertainScalarPopulation(values, probs::Statsbase.AbstractWeights)

A `ConstrainedUncertainScalarPopulation`, which consists of some population 
members (`values`)and some weights (`probs`) that indicate the relative importance of 
the population members (for example during resampling). The uncertain values 
for this type is meant to consist of constrained uncertain values 
(generated by calling `constrain(uval, sampling_constraint`) on them.

This is just a convenience type to indicate that the population has been 
constrained. It behaves identically to `UncertainScalarPopulation`.

There are different constructors for different types of `values`:

- If `values` contains only scalar numeric values, then the `values` field 
    will be of type `Vector{Number}`.
- If `values` contains one or more uncertain values, then the `values` field 
    will be of type `Vector{AbstractUncertainValue}`

"""
struct ConstrainedUncertainScalarPopulation{T, PW <: StatsBase.AbstractWeights} <: AbstractScalarPopulation{T, PW}
    values::Vector{T}
    probs::PW
end

"""
    ConstrainedUncertainScalarPopulation(values::Vector, probabilities::Vector{Float64})

Construct a constrained population from a vector of values and a vector of 
probabilities associated to those values.
"""
function ConstrainedUncertainScalarPopulation(values::Vector{T1}, probabilities::Vector{T2}) where {T1 <: Number, T2 <: Number}
    if length(values) != length(probabilities)
        throw(ArgumentError("Lengths of values and probability vectors do not match."))
    end
    ConstrainedUncertainScalarPopulation(float.(values), StatsBase.weights(probabilities))
end
function ConstrainedUncertainScalarPopulation(values::VT, probabilities) where VT <: Vector{ELTYPE} where {ELTYPE<:POTENTIAL_UVAL_TYPES}
    if length(values) != length(probabilities)
        throw(ArgumentError("Lengths of values and probability vectors do not match."))
    end
    ConstrainedUncertainScalarPopulation(UncertainValue.(values), StatsBase.weights(probabilities))
end

export 
UncertainScalarPopulation,
ConstrainedUncertainScalarPopulation