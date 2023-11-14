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
"""
function closestpowerofx(v::Number; x::Number = 10, roundf::Function = ceil)::Int64
    rounder = x^floor(log(x, v))
    return convert(Int64, rounder * roundf(v / rounder))
end

"""
    axesunitscaler(x::Number)::Tuple{String, Int64}

Find scaling factor for multiples of 1000 units. Together with
`closestpowerofx` this can be used to produce better automatic
plot axes limits. The returned values provide the string for
modifying the axis label and the associated scaling factor.
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

Access view of array head. See also [`tail`](@ref) and [`body`](@ref).
"""
head(z) = @view z[1:end-1]

"""
    tail(z)

Access view of array tail. See also [`head`](@ref) and [`body`](@ref).
"""
tail(z) = @view z[2:end-0]

"""
    body(z)

Access view of array body. See also  [`head`](@ref) and [`tail`](@ref).
"""
body(z) = @view z[2:end-1]

""" 
    heaviside(t)

Provides a Heaviside function compatible with automatic differentiation.
This is a requirement for conceiving, *e.g.*, model predictive controls
with discontinuous functions under `ModelingToolkit`.
"""
heaviside(t) = @. 0.5 * (sign(t) + 1.0)

"""
    interval(x; a=-Inf, b=Inf)

Returns 1 if ``x ∈ (a, b)``, 1/2 for `` x = a || x = b``, or 0.
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
