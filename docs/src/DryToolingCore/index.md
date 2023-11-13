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

```@docs
DryToolingCore.head
DryToolingCore.tail
DryToolingCore.body
```

## Handling of discontinuous functions

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
