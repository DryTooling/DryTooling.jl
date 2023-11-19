# Introduction to Advection in 1-D

Neste capítulo entramos no primeiro tópico ao qual o título deste livro se refere. A equação da advecção é parte constituinte das equações de Navier-Stokes que almejamos resolver numericamente antes do final da obra. Ela descreve o transporte de uma quantidade induzido por um campo vetorial através deste campo. A escolha de começar com este tópico ao invés de difusão ou a equação de Poisson se justifica principalmente pela implementação computacional extremamente simples na forma explícita desta equação. Poderia-se tentar uma outra explicação justificando que este termo é também o mais simples na equação de Navier-Stokes, mas o debate seria longo e eventualmente sem sentido, visto que muitas das principais dificuldades na resolução de campos de escoamento se originam justamente no termo advectivo. No que se segue abordaremos primeiro a forma linear e subsequentemente não-linear da advecção. Para concluir o capítulo realizaremos uma análise de estabilidade numérica do problema.

Advecção pura -- em uma dimensão -- é o fenômeno que descreve a evolução de uma quantidade $\gls{u}$  transportada através de um campo de velocidade constante $\gls{c}$. Note que a quantidade $\gls{u}$ pode, em um caso mais geral que veremos mais tarde, ser um vetor velocidade. O transporte é expresso como $\gls{u}(\gls{x}, \gls{t}+\gls{dt})=\gls{u}(\gls{x}-\gls{c}\gls{dt}, \gls{t})$, o que indica simplesmente que o estado na coordenada $\gls{x}-\gls{c}\Delta\gls{t}$ após um intervalo de tempo $\gls{dt}$ será deslocado a coordenada $\gls{x}$, ou seja, para um campo de velocidade $\gls{c}$ constante o perfil de $\gls{u}$ é invariante. Para um intervalo de tempo $\gls{dt}$ suficientemente curto em relação as dimensões do sistema e a velocidade $\gls{c}$, essa expressão pode ser expandida em uma série de Taylor, o que conduz a equação diferencial parcial provida na equação \eqref{eq:pde-taylor-advection}.

\begin{equation}
\gls{u}(\gls{x},\gls{t})+\gls{dt}\odiff{u}{t}
\simeq{}
\gls{u}(\gls{x},\gls{t})-\gls{c}\gls{dt}\odiff{u}{x}
\implies{}
\pdiff{u}{t}+\gls{c}\pdiff{u}{x}=0
\label{eq:pde-taylor-advection}
\end{equation}

Sob essas circunstâncias a equação \eqref{eq:pde-taylor-advection} possui uma solução analítica trivial, que pode ser desenvolvida através do método das características, mas isso encontra-se fora do presente escopo. Considere a condição inicial $\gls{u}_{0}:=\gls{u}(\gls{x},0)$, aonde o subscrito indica o instante inicial. O movimento descrito por $\gls{c}$ pode ser descrito em relação a essa condição inicial $\gls{u}(\gls{x},\gls{t})=\gls{u}_{0}(\gls{x}-\gls{c}\gls{t})$. No estudo de métodos numéricos é interessante partir de problemas que permitem uma forma analítica, o que é de grande ajuda para validar implementações e melhora o entendimento das equações.

\section{Advecção linear}

Diferentes estratégias de avaliação de derivadas espaciais foram apresentadas no capítulo \ref{ch:metodo-diferencas-finitas}. Para a formulação numérica por diferenças finitas da equação da advecção vamos prosseguir sem demonstrar que o esquema central no espaço não é adaptado para computar o termo advectivo por ser classificado neste caso como \emph{incondicionalmente instável}. Podemos, no entanto, compreender a origem física desta instabilidade pelo fato de que a \emph{informação} -- quantidade transportada -- viaja em conjunto com o campo advectivo. Não é possível na equação \eqref{eq:pde-taylor-advection} que um elemento em frente a quantidade propagada tenha \emph{conhecimento} da forma prévia da onda. É por essa razão que esquemas do tipo \emph{upwind} são aptos a avaliar numericamente o transporte advectivo. Nesta família de equemas, a \emph{informação} advinda da direção origem do fluxo advectivo é usada para avaliar as quantidades de interesse nas posições subsequentes. Por exemplo, para $\gls{c}>0$ a solução em $\gls{x}$ é avaliada à partir daquela em $\gls{x}-\gls{dx}$, logo a razão do nome \emph{upwind}. Vimos anteriormente que a aproximação desta derivada toma a forma da equação \eqref{eq:upwind-advection-term}.

\begin{equation}
\pdiff{u}{x}\approx
\frac{\gls{u}(\gls{x})-\gls{u}(\gls{x}-\gls{dx})}{\gls{dx}}+\orderof{\gls{dx}}
\label{eq:upwind-advection-term}
\end{equation}

A nota \ref{note:upwind-julia}...

\begin{notebox}{Esquema \emph{upwind} em Julia.}{note:upwind-julia}

Suponha que dispomos de um vetor \lstinline{u} contendo valores da solução do problema em um dado instante, com cada elemento de \lstinline{u} correspondendo a uma coordenada espacial $\gls{x}$. Para implementar a equação \eqref{eq:upwind-advection-term} em Julia podemos utilizar o seguinte código \emph{vetorizado}. Lembre-se que a base de indexação -- indice do primeiro elemento em vetores -- de Julia é 1 e não 0 como em Python ou C++. Nesta expressão a palavra-chave \lstinline{end} indica o último elemento do vetor.

\begin{lstlisting}[language = julia, numbers = none]
dudx = (u[2:end] - u[1:end-1]) / dx;
\end{lstlisting}
\end{notebox}

---


Vamos abordar neste tutorial a implementação de um integrador para a equação de
advecção nas suas formas linear e não linear. Como este é o primeiro *bloco* da
construção da equação de Navier-Stokes que almejamos alcançar ao final do livro
texto, vamos clarificar alguns pontos sobre a metodologia que será empregada.

O leitor que já tenha estudado o tópico através de outras fontes, como
[CFDPython](https://github.com/barbagroup/CFDPython), mais conhecido como *12
passos para Navier Stokes* vai observar que nossos códigos são mais estruturados
e menos explícitos. Isso vem da nossa observação de que existe uma pletora de
fontes instruindo o básico de programação científica, mas faltam fontes aonde
não somente as equações são abordadas. É de nossa experiência o excesso de
cientistas e engenheiros que vieram a aprender a estruturar um programa
tardivamente, o que resulta em uma infinidade de repositórios com código que,
embora às vezes funcional, é praticamente impossível de se realizar a manutenção
ou mesmo utilizar.

Dessa crítica ao *status quo*, vamos ao longo desta série não somente resolver
os problemas de uma ótica numérica, mas também progressivamente *pensar antes de
programar* a forma do programa que desejamos conceber. O estudante que se
engajar nessas práticas sem a menor dúvida terá uma carreira técnica de maior
sucesso e performance que os demais.

Aqui nos deparamos com um primeiro *conundrum*: uma interface interativa como
Pluto não é o meio ideal para se conceber um programa a ser mantido ao longo dos
anos. Esse tipo de documento é perfeito para realizar demonstrações e usar
interfaces de implementações mais complexas fornecidas através de pacotes. Vamos
nesse primeiro momento ignorar esse fato porque, embora buscamos transmitir o
conhecimento de como conceber um programa de qualidade, seríamos frustrados por
uma tentativa de ensinar isso diretamente com a concepção de pacotes, tema que é
abordado anexamente ao livro texto.

No que se segue neste *notebook* (vamos aceitar este anglicismo eventual ao
longo do texto) e nos subsequentes adotaremos uma estrutura típica. Começamos
com uma descrição do problema que desejamos resolver a as funcionalidades
almejadas. Com isso podemos pensar nas ferramentas que vamos necessitar e como
dita a boa prática importá-las logo no início do programa. Em seguida provemos
todo o código que é auxiliar ao problema numérico, como por exemplo a geração de
gráficos, de maneira a eliminar suas interferências na leitura do código
principal. Finalmente concebemos o código com o conteúdo matemático abordado e
seguimos com um programa de aplicação. Essa forma será empregada nos demais
*notebooks* sem que tenhamos que repetir essa descrição.

## Required tools

```@example global
using Unitful
using CairoMakie
```

## Shared utilities

```@example global
abstract type AbstractAdvection end
```

```@example global
function integrate!(p::AbstractAdvection)::Nothing
    for (k, t) in enumerate(p.t[1:end-1])
        # Uncomment below to check correct stepping:
        # @info "Advancing from $t to $(p.t[k+1])"
        p.M[k, :] = copy(ustrip(p.u))
        step!(p)
    end

    p.M[end, :] = copy(ustrip(p.u))
    return nothing
end
```

```@example global
function plotstate(p::AbstractAdvection)::Figure
    x = ustrip(p.x)
    u₀ = p.M[1, 1:end]
    u₁ = p.M[end, 1:end]

    fig = Figure(resolution = (700, 500))
    ax = Axis(fig[1, 1])
    l1 = lines!(ax, x, u₀; linewidth = 3)
    l2 = lines!(ax, x, u₁; linewidth = 3)
    ax.title = "Initial and final states of problem"
    ax.xlabel = "Coordinate [m]"
    ax.ylabel = "Velocity [m/s]"
    xlims!(ax, extrema(x))
    axislegend(ax, [l1, l2], ["Initial", "Final"], "States",
               position = :lt, orientation = :vertical)
    return fig
end
```

It is also interesting to provide a function to visualize space solution over
time. This is the job of a [kymograph](https://en.wikipedia.org/wiki/Kymograph),
which is provided below.

```@example global
function kymograph(p::AbstractAdvection; xticks, yticks, zticks)::Figure
    colormap = :gnuplot2
    colorrange = extrema(zticks)

    x = ustrip(p.x)
    y = ustrip(p.t)
    z = transpose(p.M)

    fig = Figure(resolution = (700, 600))
    ax = Axis(fig[2, 1], xlabel = "Coordinate [m]", ylabel = "Time [s]")
    hm = heatmap!(ax, x, y, z; colormap, interpolate = true, colorrange)
    cb = Colorbar(fig[1, 1], hm, vertical = false, label = "Velocity [m/s]")

    ax.xticks = xticks
    ax.yticks = yticks
    xlims!(ax, extrema(ax.xticks.val))
    ylims!(ax, extrema(ax.yticks.val))

    cb.ticks = zticks
    cb.limits = extrema(zticks)
    return fig
end
```

## Linear advection

```@example global
struct LinearAdvection1D <: AbstractAdvection
    t::Vector{Unitful.Time}
    x::Vector{Unitful.Length}
    u::Vector{Unitful.Velocity}
    c::Unitful.Velocity
    δ::Unitful.Length
    τ::Unitful.Time
    M::Matrix{Float64}

    function LinearAdvection1D(L, T, c, nₓ, nₜ; init, integ = true)
        δ = L / (nₓ - 1)
        τ = T / (nₜ - 1)
        t = collect(0.0u"s":τ:T)
        x = collect(0.0u"m":δ:L)
        u = 0u"m/s" * zeros(Float64, nₓ)
        M = zeros(Float64, (nₜ, nₓ))

        init(x, u)

        obj = new(t, x, u, c, δ, τ, M)
        integ && integrate!(obj)
        return obj
    end
end
```

```@example global
function step!(p::LinearAdvection1D)::Nothing
    α = p.c * (p.τ / p.δ)
    p.u[2:end] = (1 - α) * p.u[2:end] + α * p.u[1:end-1]
    return nothing
end
```

## Problem statement

Considere um domínio hipotético de comprimento $L=2.5\:\mathrm{m}$ na direção do
eixo $x$ sobre o qual temos uma *onda de uma substância insolúvel* localizada
nas coordenadas $x\in[0.5;1.0]\:\mathrm{m}$ movendo-se a
$u=1\:\mathrm{m\cdotp{}s^{-1}}$ e sendo a metade deste valor no restante do
espaço. No instante inicial $t=0\:\mathrm{s}$ um fluxo de fluido com velocidade
constante $c=1\:\mathrm{m\cdotp{}s^{-1}}$ é força através do domínio, o qual já
se encontra imerso no fluido.

---

Determine a posição e velocidade $u(x,t)$ da substância no intervalo de
$T=1.0\:\mathrm{s}$ que se segue.

---

Com esses elementos temos a descrição suficiente do problema para iniciar a sua
tranposição na forma de código com Julia. Para asseguramos a consistência física
do problema vamos utilizar valores numéricos acompanhados de unidades providas
pelo pacote [Unitful](https://painterqubits.github.io/Unitful.jl/stable/).

**Nota:** em problemas de larga escala essa abordagem talvez traga
inconvenientes de sobrecarga computacional, no entanto é recomendado que se
concebam programas compatíveis com `Unitful` para a verificação de consistência
em casos de teste.

Na próxima célula provemos todos os elementos numéricos presentes na descrição
do problema.

```@example global
# Domain length.
L = 2.5u"m"

# Time domain.
T = 1.0u"s"

# Fluid velocity.
c = 1.0u"m/s"

# Wave velocity.
u₀ = 1.0u"m/s"

# Initialization function.
init(x, u) = let
    hump = (0.5u"m" .< x) .& (x .< 1.0u"m")
    u[:]    .= u₀ / 2.0
    u[hump] .= u₀
end
nothing # hide
```

## Solve linear advection

To remain within the region where the error introduced by the discretization
scheme remains *small*, we need to *think* what would be a good number of steps
and nodes to split our system. Thinking physically, we would not want the
density $u$ to be transported by more than one node distance $\delta$ in a time
step $\tau$, otherwise we would be *skipping* information transfer. Thus, there
is some logic constraining $\delta\le{}c\tau$ to be respected here. We also have
infinite gradients in the specified square wave of mass density, so space step
should not be too small otherwise it would lead to a overflow error..., well,
there are many other aspects to be considered, but we did not introduce them
yet. So let's just assume that as a rule of thumb *both space and time
discretization must be reasonably smaller than the integration domains*.

Below we assume this *reasonably small* criterium is 1/500 the size of the
system and compute the required nodal distance and time step. Notice the `- 1`
in the denominator, because the number of intervals between $k$ nodes is $k-1$.
The computed values are displayed with their respective units.

```@example global
nₓ = 101
nₜ = 101
p1 = LinearAdvection1D(L, T, c, nₓ, nₜ; init)
nothing # hide
```

```@example global
plotstate(p1) # hide
```

```@example global
kymograph(p1; xticks = 0.0:0.5:ustrip(L), # hide
              yticks = 0.0:0.2:ustrip(T), # hide
              zticks = 0.5:0.1:1.0)  # hide
```

## Nonlinear advection

```@example global
struct NonlinearAdvection1D <: AbstractAdvection
    t::Vector{Unitful.Time}
    x::Vector{Unitful.Length}
    u::Vector{Unitful.Velocity}
    δ::Unitful.Length
    τ::Unitful.Time
    M::Matrix{Float64}

    function NonlinearAdvection1D(L, T, nₓ, nₜ; init, integ = true)
        p = LinearAdvection1D(L, T, 1.0u"m/s", nₓ, nₜ; init, integ = false)
        obj = new(p.t, p.x, p.u, p.δ, p.τ, p.M)
        integ && integrate!(obj)
        return obj
    end
end
```

```@example global
function step!(p::NonlinearAdvection1D)::Nothing
    α = p.u[2:end] .* (p.τ / p.δ)
    p.u[2:end] = @. (1 - α) * p.u[2:end] + α * p.u[1:end-1]
    return nothing
end
```

## Solve nonlinear advection

```@example global
nₓ = 101
nₜ = 101
p2 = NonlinearAdvection1D(L, T, nₓ, nₜ; init)
nothing # hide
```

```@example global
plotstate(p2) # hide
```

```@example global
kymograph(p2; xticks = 0.0:0.5:ustrip(L), # hide
              yticks = 0.0:0.2:ustrip(T), # hide
              zticks = 0.5:0.1:1.0) # hide
```
