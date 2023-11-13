module DryToolingCore

"Base type for linear algebra problems."
abstract type AbstractMatrixProblem end
export AbstractMatrixProblem

"Base type for physical models."
abstract type AbstractPhysicalModel end
export AbstractPhysicalModel

"Base type for transport models."
abstract type AbstractTransportModel end
export AbstractTransportModel

"Base type for thermodynamic models."
abstract type AbstractGasThermo end
export AbstractGasThermo

"Base type for thermodynamic models."
abstract type AbstractSolidThermo end
export AbstractSolidThermo

"Base type for transport models."
abstract type AbstractSolidTransport end
export AbstractSolidTransport

"Base type for solid materials."
abstract type AbstractSolidMaterial end
export AbstractSolidMaterial

"Base type for simplified mixture substances."
abstract type AbstractMixtureSubstance end
export AbstractMixtureSubstance

"Base type for simplified mixture phases."
abstract type AbstractMixturePhase end
export AbstractMixturePhase

"Base type for coded kinetics mechanisms."
abstract type AbstractKineticsMechanism end
export AbstractKineticsMechanism

"Base type of one-dimensional grids."
abstract type AbstractGrid1D end
export AbstractGrid1D

"Base type for diffusion (heat, species, ...) models."
abstract type AbstractDiffusionModel1D <: AbstractPhysicalModel end
export  AbstractDiffusionModel1D

"Base type for (nonlinear) iterative solvers."
abstract type AbstractIterativeSolver end
export AbstractIterativeSolver

"Base type for storing simulation solution."
abstract type AbstractSolutionStorage end
export AbstractSolutionStorage

"Ideal gas constant [$(GAS_CONSTANT) ``J mol^{-1} K^{-1}``]."
const GAS_CONSTANT::Float64 = 8.314_462_618_153_24
export GAS_CONSTANT

"Zero degrees Celsius in Kelvin [$(ZERO_CELSIUS) ``K``]."
const ZERO_CELSIUS::Float64 = 273.15
export ZERO_CELSIUS

"Atmospheric pressure at sea level [$(ONE_ATM) ``Pa``]."
const ONE_ATM::Float64 = 101325.0
export ONE_ATM

"Stefan-Boltzmann constant [$(STEFAN_BOLTZMANN) ``W m^{-2} K^{-4}``]"
const STEFAN_BOLTZMANN::Float64 = 5.670374419e-08
export STEFAN_BOLTZMANN

export closestpowerofx
export axesunitscaler
export head, tail, body
export heaviside
export interval
export makestepwise1d
export maxabsolutechange
export maxrelativechange

"""
    closestpowerofx(
        v::Number;
        x::Number = 10,
        roundf::Function = ceil
    )::Int64

Compute the integer power of `x` closest to `v` using `roundf` as
rouding method. This might be useful for automatic setting more
reasonable limits to plot axis or similar applications. Changing
the rouding method through `roundf` is also possible.

```jldoctest
julia> closestpowerofx(10)
10

julia> closestpowerofx(11)
20

julia> closestpowerofx(11, roundf = floor)
10

julia> closestpowerofx(11, x = 5, roundf = floor)
10

julia> closestpowerofx(12.0; x = 10)
20

julia> closestpowerofx(12.0; x = 10, roundf = floor)
10

julia> closestpowerofx(12.0; x = 10, roundf = round)
10
```
"""
function closestpowerofx(
        v::Number;
        x::Number = 10,
        roundf::Function = ceil
    )::Int64
    rounder = x^floor(log(x, v))
    return convert(Int64, rounder * roundf(v / rounder))
end

"""
    axesunitscaler(x::Number)::Tuple{String, Int64}

Find scaling factor for multiples of 1000 units. Together with
`closestpowerofx` this can be used to produce better automatic
plot axes limits. The returned values provide the string for
modifying the axis label and the associated scaling factor.

**NOTE:** this function is not yet stable. In the future it will
instead return labels using symbols like `k`, `M`, `G` for the
units through a flag provided by the user.

```jldoctest
julia> axesunitscaler(1)
("", 1)
julia> axesunitscaler(1000)
("[×1000]", 1000)
julia> axesunitscaler(1000000)
("[×1000000]", 1000000)
```
"""
function axesunitscaler(x::Number)::Tuple{String, Int64}
	# Find the floor of log10 of number.
	m = convert(Int64, x |> log10 |> floor)

	# Get the order of magnitude number.
	n = div(m, 3)

	# Find scaling factor.
	p = 1000^(n)

	return (n == 0) ? ("", 1) : ("[×$(1000^n)]", p)
end

"""
    head(z)

Access view of array head. See also ``tail`` and ``body``.

```jldoctest
julia> head(1:4)
1:3

julia> head([1, 2, 3, 4])
3-element view(::Vector{Int64}, 1:3) with eltype Int64:
 1
 2
 3

```
"""
head(z) = @view z[1:end-1]

"""
    tail(z)

Access view of array tail. See also `head` and `body`.

```jldoctest
julia> tail([1, 2, 3, 4])
3-element view(::Vector{Int64}, 2:4) with eltype Int64:
 2
 3
 4
julia> tail(1:4)
2:4
```
"""
tail(z) = @view z[2:end-0]

"""
    body(z)

Access view of array body. See also `head` and `tail`.

```jldoctest
julia> body([1, 2, 3, 4])
2-element view(::Vector{Int64}, 2:3) with eltype Int64:
 2
 3
julia> body(1:4)
2:3
```
"""
body(z) = @view z[2:end-1]

""" 
    heaviside(t)

Provides a Heaviside function compatible with automatic differentiation.
This is a requirement for conceiving, *e.g.*, model predictive controls
with discontinuous functions under `ModelingToolkit`.

# Usage
    
```jldoctest
julia> heaviside(-2:2)
5-element Vector{Float64}:
 0.0
 0.0
 0.5
 1.0
 1.0
```    
"""
heaviside(t) = @. 0.5 * (sign(t) + 1.0)

"""
    interval(x; a=-Inf, b=Inf)

Returns 1 if ``x ∈ (a, b)``, 1/2 for `` x = a || x = b``, or 0 .

# Usage

```jldoctest
julia> interval(0:6; a = 2, b = 5)
7-element Vector{Float64}:
 0.0
 0.0
 0.5
 1.0
 1.0
 0.5
 0.0
```
"""
interval(x; a=-Inf, b=Inf) = @. heaviside(x - a) - heaviside(x - b)

"""
    makestepwise1d(lo, hi, xc)

Creates an univariate function that is composed of two parts, the first
evaluated before a critical domain point `xc`, and the second above that
value. This is often required, for instance, for the evaluation of NASA
polynomials for thermodynamic properties. If `differentiable`, then the
returned function is compatible with symbolic argument as required when
using package `ModelingToolkit`, etc.

# Usage

```
julia> f = makestepwise1d(x->x, x->x^2, 1.0; differentiable = true);

julia> f(0:0.2:2.0)
11-element Vector{Float64}:
 0.0
 0.2
 0.4
 0.6
 0.8
 1.0
 1.44
 1.9599999999999997
 2.5600000000000005
 3.24
 4.0

julia> using ModelingToolkit

julia> @variables x
1-element Vector{Num}:
 x

julia> h(x); # Output is too long, try by yourself.
```
"""
function makestepwise1d(lo, hi, xc; differentiable = true)
    if differentiable
        f = @. x -> lo(x) * interval(x, b=xc) + hi(x) * interval(x, a=xc)
    else
        f = @. x -> (x < xc) ? lo(x) : hi(x)
    end
    return f
end

"Maximum relative change in a solution array."
function maxrelativechange(x::Vector{Float64}, Δx::Vector{Float64})::Float64
    return maximum(abs.(Δx ./ x))
end

"Maximum absolute change in a solution array."
function maxabsolutechange(x::Vector{Float64}, Δx::Vector{Float64})::Float64
    return maximum(abs.(Δx))
end

end # module DryToolingCore
