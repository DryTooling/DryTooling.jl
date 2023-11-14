# DryToolingCore

```@meta
CurrentModule = DryToolingCore
DocTestSetup  = quote
    using DryToolingCore
end
```

The core package of `DryTooling` ecosystem provides shared functionalities and types that are used in several other more specialized packages. This allows for standardization of interfaces, employed quantities, and avoid boilerplate code. Rather than documenting the exposed functionalities in implemented order, this page organizes everything to facilitate the understanding of the end-user. Here you find the constants by multi-purpose functionalities. All abstract types were grouped in a [dedicated page](abstract.md).

## Physical constants

```@docs
DryToolingCore.GAS_CONSTANT
DryToolingCore.ZERO_CELSIUS
DryToolingCore.ONE_ATM
DryToolingCore.STEFAN_BOLTZMANN
```

## Haskell-like array slicing

Those who know Haskell probably started learning it by manipulating lists with `head` and `tail`. Those functionalities are not available in Julia *by default* and array slicing - with an ugly syntax - is required. Since this is done often in the fields of application of `DryTooling`, both [`head`](@ref) and [`tail`](@ref) together with a [`body`](@ref) functions are available in its core. They are simple wrapers over the `@view` macro and work with both iterable types and arrays. The following snippet illustrates their usage.

```jldoctest
julia> v = collect(1:4);

julia> head(v) == [1; 2; 3]
true

julia> tail(v) == [2; 3; 4]
true

julia> body(v) == [2; 3]
true
```

More examples are provided in the following documentation ahead of each of the functions.

```jldoctest
julia> head(1:4)
1:3

julia> head([1, 2, 3, 4])
3-element view(::Vector{Int64}, 1:3) with eltype Int64:
 1
 2
 3

```

```@docs
DryToolingCore.head
```

```jldoctest
julia> tail([1, 2, 3, 4])
3-element view(::Vector{Int64}, 2:4) with eltype Int64:
 2
 3
 4
julia> tail(1:4)
2:4
```

```@docs
DryToolingCore.tail
```

```jldoctest
julia> body([1, 2, 3, 4])
2-element view(::Vector{Int64}, 2:3) with eltype Int64:
 2
 3
julia> body(1:4)
2:3
```

```@docs
DryToolingCore.body
```

## Handling of discontinuous functions

Discontinuous functions are all over in real world applications. Whether they handle discrete signals sent to controllers or represent a material property change in the solution domain of a heat transfer simulation, they are often represented by a single or a composition of [Heaviside step](https://en.wikipedia.org/wiki/Heaviside_step_function) functions. Again, because its implementation is pretty simple and optimization routines require a differentiable form of this function, `DryTooling` implements [`heaviside`](@ref) and [`interval`](@ref) as proposed in this [StackOverflow answer](https://stackoverflow.com/a/27677532/11987084).

```jldoctest
julia> heaviside(-1) == 0
true

julia> heaviside(-1.0) == 0.0
true

julia> heaviside(0.0) == 0.5
true

julia> heaviside(1.0) == 1.0
true

julia> interval(10; a = 0, b = 10) == 0.5
true
```

We see below that [`heaviside`](@ref) also works on ranges

```jldoctest
julia> heaviside(-2:2)
5-element Vector{Float64}:
 0.0
 0.0
 0.5
 1.0
 1.0
```    

```@docs
DryToolingCore.heaviside
```
By implementation inheritance that is also the case for [`interval`](@ref):

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

```@docs
DryToolingCore.interval
```

As it is the case for representation of specific heats using NASA7/NASA9 or Shomate polynomials, functions defined by parts with an specific change point are also required in physical modeling. To this end, a stepwise function can be established with [`makestepwise1d`](@ref). If keyword `differentialble = true`, then the function makes use of the above [`interval`](@ref) and remains compatible with `ModelingToolkit`, for instance.

```jldoctest
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

julia> f(x); # Output is too long, try by yourself.
```

```@docs
DryToolingCore.makestepwise1d
```

## Rounding numbers and automatic axes

!!! danger

    This section documents functions that are used in a very unstable context and might evolve in the next commits until an stable interface is established.

Simple rounding is not enough. Getting values that are rounded close to a power of a given number and rounded to floor or ceil is often the case. This is standardized in `DryTooling` through [`closestpowerofx`](@ref):

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

```@docs
DryToolingCore.closestpowerofx
```

Below we illustrate the usage of [`axesunitscaler`](@ref).

**NOTE:** this function is not yet stable. In the future it will instead return labels using symbols like `k`, `M`, `G`, etc., for the units through a flag provided by the user.

```jldoctest
julia> axesunitscaler(1)
("", 1)

julia> axesunitscaler(1000)
("[×1000]", 1000)

julia> axesunitscaler(1000000)
("[×1000000]", 1000000)
```

```@docs
DryToolingCore.axesunitscaler
```

## Computation of changes and residuals

!!! danger

    This section documents functions that are used in a very unstable context and might evolve in the next commits until an stable interface is established.

```@docs
DryToolingCore.maxabsolutechange
DryToolingCore.maxrelativechange
```

## Index

```@index
```
