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

```@docs
DryToolingCore.heaviside
DryToolingCore.interval
DryToolingCore.makestepwise1d
```

## Rounding numbers and automatic axes

```@docs
DryToolingCore.closestpowerofx
DryToolingCore.axesunitscaler
```

## Computation of changes and residuals

```@docs
DryToolingCore.maxabsolutechange
DryToolingCore.maxrelativechange
```

## Index

```@index
```
