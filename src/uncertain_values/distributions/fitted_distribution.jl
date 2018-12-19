import Distributions.Distribution
import Distributions.rand
import Distributions.support
import StatsBase.quantile
import StatsBase.mean
import StatsBase.median
import StatsBase.middle
import StatsBase.quantile

import Distributions.pdf

abstract type AbstractEmpiricalDistribution end

struct FittedDistribution{D <: Distribution} <: AbstractEmpiricalDistribution
    distribution::D
end

Broadcast.broadcastable(fd::FittedDistribution) = Ref(fd)

Distributions.rand(fd::FittedDistribution) = rand(fd.distribution)
Distributions.rand(fd::FittedDistribution, n::Int) = rand(fd.distribution, n)
Distributions.support(fd::FittedDistribution) = support(fd.distribution)
Distributions.pdf(fd::FittedDistribution, x) = pdf(fd.distribution, x)
StatsBase.mean(fd::FittedDistribution) = mean(fd.distribution)
StatsBase.median(fd::FittedDistribution) = median(fd.distribution)
StatsBase.middle(fd::FittedDistribution) = middle(fd.distribution)
StatsBase.quantile(fd::FittedDistribution, q) = quantile(fd.distribution, q)

export
AbstractEmpiricalDistribution,
FittedDistribution
