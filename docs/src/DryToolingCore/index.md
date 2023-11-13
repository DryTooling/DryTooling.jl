# DryToolingCore

The core package of `DryTooling` ecosystem provides shared functionalities and types that are used in several other more specialized packages. This allows for standardization of interfaces, employed quantities, and avoid boilerplate code. Rather than documenting the exposed functionalities in implemented order, this page organizes everything to facilitate the understanding of the end-user. Here you find the constants by multi-purpose functionalities. All abstract types were grouped in a [dedicated page](abstract.md).

## Physical constants

```@docs
DryToolingCore.GAS_CONSTANT
DryToolingCore.ZERO_CELSIUS
DryToolingCore.ONE_ATM
DryToolingCore.STEFAN_BOLTZMANN
```

## Haskell-like array slicing

```jldoctest
julia> using DryToolingCore;

julia> v = collect(1:4);

julia> head(v) == [1; 2; 3]
true

julia> tail(v) == [2; 3; 4]
true

julia> body(v) == [2; 3]
true
```

```@docs
DryToolingCore.head
DryToolingCore.tail
DryToolingCore.body
```

## Handling of discontinuous functions

```jldoctest
julia> using DryToolingCore;

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
