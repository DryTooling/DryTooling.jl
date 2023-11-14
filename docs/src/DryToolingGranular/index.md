# DryToolingGranular

```@meta
CurrentModule = DryToolingGranular
DocTestSetup  = quote
    using DryToolingGranular
end
```

## General porous media

```@docs
DryToolingGranular.PackedBedPorosityDescriptor
```

## Rotary kiln models

The structure `SymbolicLinearKramersModel` implements the Kramers' ordinary differential equation for prediction of bed height profile in a rotary kiln. This equation is implemented under the formalism of `ModelingToolkit`.

```@docs
DryToolingGranular.SymbolicLinearKramersModel
```

Description of a rotary kiln bed geometry computed from the solution of bed height along the kiln length. The main goal of the quantities computed here is their use with heat and mass transfer models for the simulation of rotary kiln process.

```@docs
DryToolingGranular.RotaryKilnBedSolution
DryToolingGranular.plotlinearkramersmodel
```

Finally a set of basic equations provided for process analysis.

```@docs
DryToolingGranular.sullivansηₘ
DryToolingGranular.dimlessNΦ
DryToolingGranular.dimlessNₖ
DryToolingGranular.perrayresidence
DryToolingGranular.kramersnlapprox
```

## Theory guide

Please go to the module theory guide [page](theory.md).

## Models validation

- [Kramers' model](validation/kramers-model.md)
