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

More examples are provided in the following documentation.

```@docs
DryToolingCore.head
DryToolingCore.tail
DryToolingCore.body
```

## Handling of discontinuous functions


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
