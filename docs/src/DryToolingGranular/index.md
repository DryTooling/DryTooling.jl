# DryToolingGranular

```@meta
CurrentModule = DryToolingGranular
DocTestSetup  = quote
    using DryToolingGranular
end
```

For the theory guide, please go to the following [page](theory.md).

## General porous media

[`PackedBedPorosityDescriptor`](@ref) can be used to describe the geometry
of exchange section of a packed bed for a single set of arguments.

```jldoctest
julia> PackedBedPorosityDescriptor(; ϕ = 0.65, l = 0.10, area = 1.0)
PackedBedPorosityDescriptor(P = 21.000000 m, D = 0.123810 m)
```

It can also be used to describe randomly varying reactors, what is
a more realistic thing to do when using this structure to simulate
real world systems.

```jldoctest
julia> PackedBedPorosityDescriptor(;
            ϕ  = 0.65, l  = 0.10,
            σϕ = 0.03, σl = 0.01,
            N = 2,
            ϕlims = (0.4, 0.8),
            llims = (0.0, 0.3),
            seed = 42,
            area = 1.0
        )
PackedBedPorosityDescriptor(
    P from  21.455749 m to  24.370742 m
    D from   0.125589 m to   0.102353 m
)
```

```@docs
DryToolingGranular.PackedBedPorosityDescriptor
```

## Rotary kiln models

The structure `SymbolicLinearKramersModel` implements the Kramers' ordinary differential equation for prediction of bed height profile in a rotary kiln. This equation is implemented under the formalism of `ModelingToolkit`.

```@docs
DryToolingGranular.SymbolicLinearKramersModel
```

Description of a rotary kiln bed geometry computed from the solution of bed height along the kiln length. The main goal of the quantities computed here is their use with heat and mass transfer models for the simulation of rotary kiln process.

Data in next example is an SI conversion of an example from Kramers (1952).

```jldoctest
julia> L = 13.715999999999998;  # Kiln length [m]

julia> D = 1.8897599999999999;  # Kiln diameter [m]

julia> β = 2.3859440303888126;  # Kiln slope [°]

julia> γ = 45.0;                # Repose angle [°]

julia> d = 1.0;                 # Particle/dam size [mm]

julia> Φ = 10.363965852671996;  # Feed rate [m³/h]

julia> ω = 3.0300000000000002;  # Rotation rate [rev/min]

julia> bed = RotaryKilnBedSolution(;
            model = SymbolicLinearKramersModel(),
            L     = L,
            R     = D / 2.0,
            Φ     = Φ / 3600.0,
            ω     = ω / 60.0,
            β     = deg2rad(β),
            γ     = deg2rad(γ),
            d     = d / 1000.0
        );

julia> bed
RotaryKilnBedSolution(τ = 13.169938 min, ηₘ = 5.913271 %)

julia> bed.τ
790.1963002204092
```

```@docs
DryToolingGranular.RotaryKilnBedSolution
DryToolingGranular.plotlinearkramersmodel
```

Validation of Kramers' model is provided [here](validation/kramers-model.md).

Finally a set of basic equations provided for process analysis.

```@docs
DryToolingGranular.sullivansηₘ
DryToolingGranular.dimlessNΦ
DryToolingGranular.dimlessNₖ
DryToolingGranular.perrayresidence
DryToolingGranular.kramersnlapprox
```
