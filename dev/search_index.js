var documenterSearchIndex = {"docs":
[{"location":"toc/#Table-of-contents","page":"Table of contents","title":"Table of contents","text":"","category":"section"},{"location":"toc/","page":"Table of contents","title":"Table of contents","text":"Depth = 4","category":"page"},{"location":"references/#References","page":"References","title":"References","text":"","category":"section"},{"location":"references/","page":"References","title":"References","text":"","category":"page"},{"location":"api/#Reference-API","page":"Reference API","title":"Reference API","text":"","category":"section"},{"location":"api/","page":"Reference API","title":"Reference API","text":"In this page you find a list of all documented functions of DryTooling. Rather than being organized in a logical way as the main documentation, we chose (except for the root DryTooling that comes first) to list them in alphabetical order of folders in source directory.","category":"page"},{"location":"api/#DryToolingCore.jl","page":"Reference API","title":"DryToolingCore.jl","text":"","category":"section"},{"location":"api/","page":"Reference API","title":"Reference API","text":"Modules = [ DryToolingCore ]","category":"page"},{"location":"DryToolingCore/abstract/#Abstract-types","page":"Abstract types","title":"Abstract types","text":"","category":"section"},{"location":"DryToolingCore/abstract/#Problem-solving-and-physical-models","page":"Abstract types","title":"Problem solving and physical models","text":"","category":"section"},{"location":"DryToolingCore/abstract/","page":"Abstract types","title":"Abstract types","text":"DryToolingCore.AbstractMatrixProblem\nDryToolingCore.AbstractIterativeSolver\nDryToolingCore.AbstractSolutionStorage\nDryToolingCore.AbstractPhysicalModel","category":"page"},{"location":"DryToolingCore/abstract/#DryToolingCore.AbstractMatrixProblem","page":"Abstract types","title":"DryToolingCore.AbstractMatrixProblem","text":"Base type for linear algebra problems.\n\n\n\n\n\n","category":"type"},{"location":"DryToolingCore/abstract/#DryToolingCore.AbstractIterativeSolver","page":"Abstract types","title":"DryToolingCore.AbstractIterativeSolver","text":"Base type for (nonlinear) iterative solvers.\n\n\n\n\n\n","category":"type"},{"location":"DryToolingCore/abstract/#DryToolingCore.AbstractSolutionStorage","page":"Abstract types","title":"DryToolingCore.AbstractSolutionStorage","text":"Base type for storing simulation solution.\n\n\n\n\n\n","category":"type"},{"location":"DryToolingCore/abstract/#DryToolingCore.AbstractPhysicalModel","page":"Abstract types","title":"DryToolingCore.AbstractPhysicalModel","text":"Base type for physical models.\n\n\n\n\n\n","category":"type"},{"location":"DryToolingCore/abstract/#Transport,-thermodynamics,-and-kinetics","page":"Abstract types","title":"Transport, thermodynamics, and kinetics","text":"","category":"section"},{"location":"DryToolingCore/abstract/","page":"Abstract types","title":"Abstract types","text":"DryToolingCore.AbstractTransportModel\nDryToolingCore.AbstractSolidTransport\nDryToolingCore.AbstractGasThermo\nDryToolingCore.AbstractSolidThermo\nDryToolingCore.AbstractSolidMaterial\nDryToolingCore.AbstractMixtureSubstance\nDryToolingCore.AbstractMixturePhase\nDryToolingCore.AbstractKineticsMechanism","category":"page"},{"location":"DryToolingCore/abstract/#DryToolingCore.AbstractTransportModel","page":"Abstract types","title":"DryToolingCore.AbstractTransportModel","text":"Base type for transport models.\n\n\n\n\n\n","category":"type"},{"location":"DryToolingCore/abstract/#DryToolingCore.AbstractSolidTransport","page":"Abstract types","title":"DryToolingCore.AbstractSolidTransport","text":"Base type for transport models.\n\n\n\n\n\n","category":"type"},{"location":"DryToolingCore/abstract/#DryToolingCore.AbstractGasThermo","page":"Abstract types","title":"DryToolingCore.AbstractGasThermo","text":"Base type for thermodynamic models.\n\n\n\n\n\n","category":"type"},{"location":"DryToolingCore/abstract/#DryToolingCore.AbstractSolidThermo","page":"Abstract types","title":"DryToolingCore.AbstractSolidThermo","text":"Base type for thermodynamic models.\n\n\n\n\n\n","category":"type"},{"location":"DryToolingCore/abstract/#DryToolingCore.AbstractSolidMaterial","page":"Abstract types","title":"DryToolingCore.AbstractSolidMaterial","text":"Base type for solid materials.\n\n\n\n\n\n","category":"type"},{"location":"DryToolingCore/abstract/#DryToolingCore.AbstractMixtureSubstance","page":"Abstract types","title":"DryToolingCore.AbstractMixtureSubstance","text":"Base type for simplified mixture substances.\n\n\n\n\n\n","category":"type"},{"location":"DryToolingCore/abstract/#DryToolingCore.AbstractMixturePhase","page":"Abstract types","title":"DryToolingCore.AbstractMixturePhase","text":"Base type for simplified mixture phases.\n\n\n\n\n\n","category":"type"},{"location":"DryToolingCore/abstract/#DryToolingCore.AbstractKineticsMechanism","page":"Abstract types","title":"DryToolingCore.AbstractKineticsMechanism","text":"Base type for coded kinetics mechanisms.\n\n\n\n\n\n","category":"type"},{"location":"DryToolingCore/abstract/#Finite-volume-method-and-relatives","page":"Abstract types","title":"Finite volume method and relatives","text":"","category":"section"},{"location":"DryToolingCore/abstract/","page":"Abstract types","title":"Abstract types","text":"DryToolingCore.AbstractDiffusionModel1D\nDryToolingCore.AbstractGrid1D","category":"page"},{"location":"DryToolingCore/abstract/#DryToolingCore.AbstractDiffusionModel1D","page":"Abstract types","title":"DryToolingCore.AbstractDiffusionModel1D","text":"Base type for diffusion (heat, species, ...) models.\n\n\n\n\n\n","category":"type"},{"location":"DryToolingCore/abstract/#DryToolingCore.AbstractGrid1D","page":"Abstract types","title":"DryToolingCore.AbstractGrid1D","text":"Base type of one-dimensional grids.\n\n\n\n\n\n","category":"type"},{"location":"#DryTooling.jl","page":"Home","title":"DryTooling.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for DryTooling.","category":"page"},{"location":"#Why?","page":"Home","title":"Why?","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"I am often faced with using the same approach for different engineering and scientific problems, but I don't like repeating the same task again and again. This is where DryTooling.jl comes in. By adopting some principles of DRY in Julia, to a larger extent than its definition, it packages together models and workflows that are not available or validated elsewhere - and in some cases adapts existing models. The tools will progressively cover a broad range of numerical applications and data treatment, this package is in its early days from the migration of my old Python scripts and packages.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Also dry tooling is my favorite sport!","category":"page"},{"location":"#Usage","page":"Home","title":"Usage","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"The base case for using DryTooling is calling a pre-built model for solving a specific problem. Several sub-modules handle different Physics and find them in the side-bar. Most models are provided under structures that are already solved during construction or provide a solve! method. In an ideal world they should all be documented, but since this package is still in its early days, some experimental features are not yet documented.","category":"page"},{"location":"","page":"Home","title":"Home","text":"For extending existing models and preferrably contributing to the package's growth, it is possible to use some functionalities provided in the bare DryTooling module, i.e. those made available when calling using DryTooling. They include physical constants, abstract types used all across the package, and some simple functions of general use.","category":"page"},{"location":"#Citing","page":"Home","title":"Citing","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Found it useful? See CITATION.bib for the relevant reference.","category":"page"},{"location":"DryToolingCore/#DryToolingCore","page":"DryToolingCore","title":"DryToolingCore","text":"","category":"section"},{"location":"DryToolingCore/","page":"DryToolingCore","title":"DryToolingCore","text":"The core package of DryTooling ecosystem provides shared functionalities and types that are used in several other more specialized packages. This allows for standardization of interfaces, employed quantities, and avoid boilerplate code. Rather than documenting the exposed functionalities in implemented order, this page organizes everything to facilitate the understanding of the end-user. Here you find the constants by multi-purpose functionalities. All abstract types were grouped in a dedicated page.","category":"page"},{"location":"DryToolingCore/#Physical-constants","page":"DryToolingCore","title":"Physical constants","text":"","category":"section"},{"location":"DryToolingCore/","page":"DryToolingCore","title":"DryToolingCore","text":"DryToolingCore.GAS_CONSTANT\nDryToolingCore.ZERO_CELSIUS\nDryToolingCore.ONE_ATM\nDryToolingCore.STEFAN_BOLTZMANN","category":"page"},{"location":"DryToolingCore/#DryToolingCore.GAS_CONSTANT","page":"DryToolingCore","title":"DryToolingCore.GAS_CONSTANT","text":"Ideal gas constant [8.31446261815324 J mol^-1 K^-1].\n\n\n\n\n\n","category":"constant"},{"location":"DryToolingCore/#DryToolingCore.ZERO_CELSIUS","page":"DryToolingCore","title":"DryToolingCore.ZERO_CELSIUS","text":"Zero degrees Celsius in Kelvin [273.15 K].\n\n\n\n\n\n","category":"constant"},{"location":"DryToolingCore/#DryToolingCore.ONE_ATM","page":"DryToolingCore","title":"DryToolingCore.ONE_ATM","text":"Atmospheric pressure at sea level [101325.0 Pa].\n\n\n\n\n\n","category":"constant"},{"location":"DryToolingCore/#DryToolingCore.STEFAN_BOLTZMANN","page":"DryToolingCore","title":"DryToolingCore.STEFAN_BOLTZMANN","text":"Stefan-Boltzmann constant [5.670374419e-8 W m^-2 K^-4]\n\n\n\n\n\n","category":"constant"},{"location":"DryToolingCore/#Haskell-like-array-slicing","page":"DryToolingCore","title":"Haskell-like array slicing","text":"","category":"section"},{"location":"DryToolingCore/","page":"DryToolingCore","title":"DryToolingCore","text":"julia> using DryToolingCore;\n\njulia> v = collect(1:4);\n\njulia> head(v) == [1; 2; 3]\ntrue\n\njulia> tail(v) == [2; 3; 4]\ntrue\n\njulia> body(v) == [2; 3]\ntrue","category":"page"},{"location":"DryToolingCore/","page":"DryToolingCore","title":"DryToolingCore","text":"DryToolingCore.head\nDryToolingCore.tail\nDryToolingCore.body","category":"page"},{"location":"DryToolingCore/#DryToolingCore.head","page":"DryToolingCore","title":"DryToolingCore.head","text":"head(z)\n\nAccess view of array head. See also tail and body.\n\njulia> head(1:4)\n1:3\n\njulia> head([1, 2, 3, 4])\n3-element view(::Vector{Int64}, 1:3) with eltype Int64:\n 1\n 2\n 3\n\n\n\n\n\n\n","category":"function"},{"location":"DryToolingCore/#DryToolingCore.tail","page":"DryToolingCore","title":"DryToolingCore.tail","text":"tail(z)\n\nAccess view of array tail. See also head and body.\n\njulia> tail([1, 2, 3, 4])\n3-element view(::Vector{Int64}, 2:4) with eltype Int64:\n 2\n 3\n 4\njulia> tail(1:4)\n2:4\n\n\n\n\n\n","category":"function"},{"location":"DryToolingCore/#DryToolingCore.body","page":"DryToolingCore","title":"DryToolingCore.body","text":"body(z)\n\nAccess view of array body. See also head and tail.\n\njulia> body([1, 2, 3, 4])\n2-element view(::Vector{Int64}, 2:3) with eltype Int64:\n 2\n 3\njulia> body(1:4)\n2:3\n\n\n\n\n\n","category":"function"},{"location":"DryToolingCore/#Handling-of-discontinuous-functions","page":"DryToolingCore","title":"Handling of discontinuous functions","text":"","category":"section"},{"location":"DryToolingCore/","page":"DryToolingCore","title":"DryToolingCore","text":"julia> using DryToolingCore;\n\njulia> heaviside(-1) == 0\ntrue\n\njulia> heaviside(-1.0) == 0.0\ntrue\n\njulia> heaviside(0.0) == 0.5\ntrue\n\njulia> heaviside(1.0) == 1.0\ntrue\n\njulia> interval(10; a = 0, b = 10) == 0.5\ntrue","category":"page"},{"location":"DryToolingCore/","page":"DryToolingCore","title":"DryToolingCore","text":"DryToolingCore.heaviside\nDryToolingCore.interval\nDryToolingCore.makestepwise1d","category":"page"},{"location":"DryToolingCore/#DryToolingCore.heaviside","page":"DryToolingCore","title":"DryToolingCore.heaviside","text":"heaviside(t)\n\nProvides a Heaviside function compatible with automatic differentiation. This is a requirement for conceiving, e.g., model predictive controls with discontinuous functions under ModelingToolkit.\n\nUsage\n\njulia> heaviside(-2:2)\n5-element Vector{Float64}:\n 0.0\n 0.0\n 0.5\n 1.0\n 1.0\n\n\n\n\n\n","category":"function"},{"location":"DryToolingCore/#DryToolingCore.interval","page":"DryToolingCore","title":"DryToolingCore.interval","text":"interval(x; a=-Inf, b=Inf)\n\nReturns 1 if x  (a b), 1/2 for x = a  x = b, or 0 .\n\nUsage\n\njulia> interval(0:6; a = 2, b = 5)\n7-element Vector{Float64}:\n 0.0\n 0.0\n 0.5\n 1.0\n 1.0\n 0.5\n 0.0\n\n\n\n\n\n","category":"function"},{"location":"DryToolingCore/#DryToolingCore.makestepwise1d","page":"DryToolingCore","title":"DryToolingCore.makestepwise1d","text":"makestepwise1d(lo, hi, xc)\n\nCreates an univariate function that is composed of two parts, the first evaluated before a critical domain point xc, and the second above that value. This is often required, for instance, for the evaluation of NASA polynomials for thermodynamic properties. If differentiable, then the returned function is compatible with symbolic argument as required when using package ModelingToolkit, etc.\n\nUsage\n\njulia> f = makestepwise1d(x->x, x->x^2, 1.0; differentiable = true);\n\njulia> f(0:0.2:2.0)\n11-element Vector{Float64}:\n 0.0\n 0.2\n 0.4\n 0.6\n 0.8\n 1.0\n 1.44\n 1.9599999999999997\n 2.5600000000000005\n 3.24\n 4.0\n\njulia> using ModelingToolkit\n\njulia> @variables x\n1-element Vector{Num}:\n x\n\njulia> h(x); # Output is too long, try by yourself.\n\n\n\n\n\n","category":"function"},{"location":"DryToolingCore/#Rounding-numbers-and-automatic-axes","page":"DryToolingCore","title":"Rounding numbers and automatic axes","text":"","category":"section"},{"location":"DryToolingCore/","page":"DryToolingCore","title":"DryToolingCore","text":"DryToolingCore.closestpowerofx\nDryToolingCore.axesunitscaler","category":"page"},{"location":"DryToolingCore/#DryToolingCore.closestpowerofx","page":"DryToolingCore","title":"DryToolingCore.closestpowerofx","text":"closestpowerofx(\n    v::Number;\n    x::Number = 10,\n    roundf::Function = ceil\n)::Int64\n\nCompute the integer power of x closest to v using roundf as rouding method. This might be useful for automatic setting more reasonable limits to plot axis or similar applications. Changing the rouding method through roundf is also possible.\n\njulia> closestpowerofx(10)\n10\n\njulia> closestpowerofx(11)\n20\n\njulia> closestpowerofx(11, roundf = floor)\n10\n\njulia> closestpowerofx(11, x = 5, roundf = floor)\n10\n\njulia> closestpowerofx(12.0; x = 10)\n20\n\njulia> closestpowerofx(12.0; x = 10, roundf = floor)\n10\n\njulia> closestpowerofx(12.0; x = 10, roundf = round)\n10\n\n\n\n\n\n","category":"function"},{"location":"DryToolingCore/#DryToolingCore.axesunitscaler","page":"DryToolingCore","title":"DryToolingCore.axesunitscaler","text":"axesunitscaler(x::Number)::Tuple{String, Int64}\n\nFind scaling factor for multiples of 1000 units. Together with closestpowerofx this can be used to produce better automatic plot axes limits. The returned values provide the string for modifying the axis label and the associated scaling factor.\n\nNOTE: this function is not yet stable. In the future it will instead return labels using symbols like k, M, G for the units through a flag provided by the user.\n\njulia> axesunitscaler(1)\n(\"\", 1)\njulia> axesunitscaler(1000)\n(\"[×1000]\", 1000)\njulia> axesunitscaler(1000000)\n(\"[×1000000]\", 1000000)\n\n\n\n\n\n","category":"function"},{"location":"DryToolingCore/#Computation-of-changes-and-residuals","page":"DryToolingCore","title":"Computation of changes and residuals","text":"","category":"section"},{"location":"DryToolingCore/","page":"DryToolingCore","title":"DryToolingCore","text":"DryToolingCore.maxabsolutechange\nDryToolingCore.maxrelativechange","category":"page"},{"location":"DryToolingCore/#DryToolingCore.maxabsolutechange","page":"DryToolingCore","title":"DryToolingCore.maxabsolutechange","text":"Maximum absolute change in a solution array.\n\n\n\n\n\n","category":"function"},{"location":"DryToolingCore/#DryToolingCore.maxrelativechange","page":"DryToolingCore","title":"DryToolingCore.maxrelativechange","text":"Maximum relative change in a solution array.\n\n\n\n\n\n","category":"function"}]
}
