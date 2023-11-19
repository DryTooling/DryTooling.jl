\section{Introduction}

This sample program has been conceived for didactic purposes of teaching Fick's second law in its linear form (constant diffusion coefficient). In is conceived as a dummy example for asking students to provide the required modifications to reach generality in non-linear form as exercise. Introduction to Finite Volume Method (FVM) is supposed to have already been done in such a way that this tutorial goes directly to the details of the equation discretization. Numerical analysis and stability conditions are not provided.

\section{Equation in Cartesian coordinates}

For a constant density medium, the diffusion of a species is modeled in two steps: \begin{inparaenum}[(i)] \item the constitutive relationship of the flux under a composition (or chemical potential) gradient, and \item the balance provided by a divergent operation.\end{inparaenum} Assuming Fick's first law as the constitutive relationship one can derive the model partial differential equation as provided in \eqref{eq:cartesian-form}, where $C$ gives the concentration of the diffusing species and $x$ and $t$ take the usual spacial and time coordinates convention.

\begin{equation}
\frac{\partial{}C}{\partial{}t}=D\frac{\partial^{2}C}{\partial{}x^{2}}
\label{eq:cartesian-form}
\end{equation}

Before proceeding with the numerical formulation one must establish the convention for spacial discretization so that equations can be written in terms of the node indexing system. Figure~\ref{fig:discretization-scheme} represents a finite volume one-dimensional space of equally sized nodes\footnote{Although we could have worked out the problem for the case of any spacial grid, such as a geometric series expansion of node sizes, this would only impact on the coefficients that will be produced once we discretized the equation and would make the code more difficult to read (implementation would not be much more complex, but certainly more verbose and we would loose the focus on the mathematical formulation).}. In what follows we start by integrating the problem around node $P$ by computing fluxes through edges $w$ and $e$ between $P$ and its neighbors $W$ and $E$.  Boundaries will be discussed later.


\caption{\label{fig:discretization-scheme}Discretization around node $P$ and ghost boundaries. Dashed nodes represent an indefinite number of nodes in the system up to the boundaries.}

A first general step in obtaining a discrete form of the model PDE is to provide spacial and temporal integration over a node. Equation~\eqref{eq:cartesian-form-integral} provide such integration over the domain of node $P$ between the current time and a future instant $t+\delta{}t$. In what follows we assume that time-step $\delta{}t$ is constant but nothing would change in the formulation with a varying time-step, except that problem coefficients would need to be recomputed after each step.

\begin{equation}
\int_{w}^{e}\int_{t}^{t+\delta{}t}\frac{\partial{}C_{P}}{\partial{}t}\mathrm{d}t\mathrm{d}x=\int_{w}^{e}\int_{t}^{t+\delta{}t}D\frac{\partial^{2}C_{P}}{\partial{}x^{2}}\mathrm{d}t\mathrm{d}x
\label{eq:cartesian-form-integral}
\end{equation}

Integration over time of \eqref{eq:cartesian-form-integral} right-hand side is straightforward since it is the integral of a differential of time: we just compute the difference of local concentrations $C_{P}$ between the instants. In \eqref{eq:cartesian-form-first-step} we denote the instant by using parenthesized superscripts. Since the left-hand side of \eqref{eq:cartesian-form-integral} does not depend on time, integration is simply the multiplication of the integrand by time-step $\delta{}t$.

\begin{equation}
\int_{w}^{e}\left[C^{(t+\delta{}t)}_{P}-C^{(t)}_{P}\right]\mathrm{d}x=
\int_{w}^{e}D\frac{\partial^{2}C}{\partial{}x^{2}}\delta{}t\mathrm{d}x
\label{eq:cartesian-form-first-step}
\end{equation}

Spacial integration is then performed in \eqref{eq:cartesian-form-second-step}. Left-hand side is trivial since it is independent of spacial coordinate. For right-hand side we perform the integration of a derivative what corresponds to decreasing its degree by one and computing difference between evaluations of remaining derivatives over the node boundaries $w$ and $e$. Notice here the introduction of superscripts $(m)$ on the right-hand side representing an arbitrary instant. Up to this step we have not select the kind of time-stepping we will apply and thus we leave it there for now.

\begin{equation}
\left[C^{(t+\delta{}t)}_{P}-C^{(t)}_{P}\right]\frac{\delta{}x}{\delta{}t}=
\left(D\frac{\partial{}C}{\partial{}x}\right)^{(m)}_{e}-\left(D\frac{\partial{}C}{\partial{}x}\right)^{(m)}_{w}
\label{eq:cartesian-form-second-step}
\end{equation}

For the evaluation of the resulting fluxes in the right-hand side of \eqref{eq:cartesian-form-second-step} we adopt a first order\footnote{Higher order schemes would not impact the general procedure of deriving the numerical model but would again be more verbose and require more complex solving routines for the linear system that will be derived.} upwind differencing scheme (UDS), in which a derivative at an interface is computed by taking the difference between concentrations in the neighbor nodes in the positive direction of the spacial coordinate\footnote{If using other space discretization scheme, the upwind derivative would need to be pondered by the lengths of the neighbor nodes.}

Following the proposed scheme, derivative on edge $e$ of node $P$ is computed by taking the difference of concentrations between $E$ and $P$, as given by \eqref{eq:difference-east}. Notice here that $E$ is the \emph{next} node after $P$ in increasing $x$ coordinate.

\begin{equation}
\left(D\frac{\partial{}C}{\partial{}x}\right)^{(m)}_{e}=D\frac{C^{(m)}_{E}-C^{(m)}_{P}}{\delta{x}}
\label{eq:difference-east}
\end{equation}

Similarly, for $w$ we take the difference between $P$ and $W$, as given by \eqref{eq:difference-west}. Again notice the upwind ordering of the terms in the difference equation.

\begin{equation}
\left(D\frac{\partial{}C}{\partial{}x}\right)^{(m)}_{w}=D\frac{C^{(m)}_{P}-C^{(m)}_{W}}{\delta{x}}
\label{eq:difference-west}
\end{equation}

Multiplying both sides of \eqref{eq:cartesian-form-second-step} by $\sfrac{\delta{}t}{\delta{}x}$ we see appear on the right-hand side the multiplier given by \eqref{eq:cfl-number}, also known as Courant–Friedrichs–Lewy number, which can be used for studying the numerical stability of the system.

\begin{equation}
\beta=D\frac{\delta{t}}{\delta{}x^{2}}
\label{eq:cfl-number}
\end{equation}

Applying equations \eqref{eq:cfl-number}, \eqref{eq:difference-east}, and \eqref{eq:difference-west} to \eqref{eq:cartesian-form-second-step} we derive the general model given by \eqref{eq:base-model}. This equation still needs the time-stepping scheme to be defined. Several options are possible, such as replacing $(m)$ by the current or next time-step, leading to explicit and implicit problems, respectively. Another alternative would be to use an interpolated intermediate instant, what is known as the family of Crank-Nicolson schemes. Higher order time-stepping is also possible, with the exception of the first one, but again we skip this possibility to make the implementation as simple as possible.

\begin{equation}
C^{(t+\delta{}t)}_{P}-C^{(t)}_{P}=
\beta{}C^{(m)}_{W}-2\beta{}C^{(m)}_{P}+\beta{}C^{(m)}_{E}
\label{eq:base-model}
\end{equation}

The simplest solution is to apply the current instant as a replacement to $(m)$ in \eqref{eq:base-model}, what leads to \eqref{eq:explicit-model} after rearranging the terms. Notice that the integration is straightforward in this case once the next solution is computed directly from the current state of the system for each node. Due to extreme simplicity and stability issues that arise from this approach, we leave it for the interested reader to implement and experiment with the scheme.

\begin{equation}
C^{(t+\delta{}t)}_{P}=
C^{(t)}_{P}+\beta{}\left(C^{t}_{W}-2C^{t}_{P}+C^{t}_{E}\right)
\label{eq:explicit-model}
\end{equation}

Since the target of this paper is not the comparison of different time-stepping methods, we skip Crank-Nicolson schemes due to its verbose implementation when compared to the simpler implicit scheme. Real world problems would generally use a Crank-Nicolson or higher order schemes due to precision aspects of such methods. By replacing $(m)$ by $(t+\delta{}t)$ in \eqref{eq:base-model} and rearranging terms we produce \eqref{eq:implicit-model}, which is a linear system of equations.

\begin{equation}
-\beta{}C^{(t+\delta{}t)}_{W} + \left(1+2\beta{}\right) C^{(t+\delta{}t)}_{P} -\beta{}C^{(t+\delta{}t)}_{E}=C^{(t)}_{P}
\label{eq:implicit-model}
\end{equation}

The only missing element now are the boundary conditions (BC). In what follows we assume that our space in Figure~\ref{fig:discretization-scheme} represents the thickness of a plate, which can be submitted to different conditions on each side. Common cases are \begin{inparaenum}[(i)] \item the constant BC (also known as Dirichlet BC), \item the constant flux BC (known as Neumman BC), \item and variable flux BC (known as Fourier or Robin BC).\end{inparaenum} Here we will consider the later due to its generality. In its purely mathematical form, a Fourier BC writes:

\begin{equation}
au + \frac{\partial{}u}{\partial{}x}=g
\label{eq:fourier-bc}
\end{equation}

For practical purposes, when modeling diffusion it can be rewritten as \eqref{eq:fourier-bc-1}. In this equation we introduce the mass transfer coefficient $h$, which in related to a resistance of mass transfer between environment of concentration $C_{\infty}$ and the studied medium. Physically this is generally introduced due to reaction rates in environment or the establishment of a chemical boundary layer.

\begin{equation}
\frac{\partial{}C}{\partial{}x}=h\left(C_{\infty}-C\right)
\label{eq:fourier-bc-1}
\end{equation}

This boundary condition has to be replaced in \eqref{eq:cartesian-form-second-step} for both sides of the plate. This will provide us the modified terms for the first and last rows of the linear system modeled internally by \eqref{eq:implicit-model}. Replacing $W$ by ghost node $B_w$ and thus computing the flow across $bw$ instead of $w$ one determines the first row of the linear system to solve. Notice here that we made use of $C_{\infty}^{(t+\delta{}t)}$ which should be provided as an analytical function of time, allowing the computation of this additional term to right-hand side.

\begin{equation}
\left(1+\beta-\gamma_{e}\right)C^{(t+\delta{}t)}_{P}-\beta{}C^{(t+\delta{}t)}_{E} =
C^{(t)}_{P}-\gamma_{e}C_{\infty,e}^{(t+\delta{}t)}
\label{eq:cartesian-form-second-step-bw}
\end{equation}

\noindent{}where we introduced the symbol $\gamma$ analogous to CFL number for the environment-medium transfer coefficient, where $h$ has units of $\sfrac{D}{\delta{}x}$.

\begin{equation}
\gamma = h\frac{\delta{}t}{\delta{}x}
\end{equation}

Performing the analogous substitutions for the boundary $B_e$ we can show that the last row of the linear problem is given by:

\begin{equation}
-\beta{}C^{(t+\delta{}t)}_{W}\left(1+\beta-\gamma_{w}\right)C^{(t+\delta{}t)}_{P} =
C^{(t)}_{P}-\gamma_{w}C_{\infty,w}^{(t+\delta{}t)}
\label{eq:cartesian-form-second-step-be}
\end{equation}

This way the numerical formulation of the problem is complete, only an initial state being necessary to compute its time-evolution.

\section{Equation in cylindrical coordinates}

To be done in next version.

\section{Implementation}

For the construction of the program to solve this model we can start by listing all the required physical constants and parameters. Starting by the space discretization we should provide the \begin{inparaenum}[(i)] \item length $L$ of the medium and \item the number of nodes $N_{nodes}$\end{inparaenum}, the cell length $\delta{}x$ being computed as $\sfrac{L}{(N_{nodes}-1)}$. Similarly we provide \begin{inparaenum}[(i)] \item the total integration time $T$ and \item the number of time-steps $N_{steps}$\end{inparaenum}, the time-step $\delta{}t$ being computed as $\sfrac{T}{(N_{steps}-1)}$.

Storage of local composition of each node requires an array $C$ of length $N_{nodes}$. The initialization of $C$ can be done by an user defined function that sets the value of each node in $C$. Next, the transport coefficients $D$ and $h$ must be provided as constants, what allows for the computation of parameters $\beta$ and $\gamma$, both held constant in this study. Boundary conditions on both sides are treated independently, thus two values of $h$, leading to $\gamma_{w}$ and $\gamma_{e}$. Once we assumed the environment concentration $C_{\infty}$ can vary in time, two functions must be provided, say $C_{\infty,w}$ and $C_{\infty,e}$.

The matrix describing the system of equations is tridiagonal. Storing it as three arrays for the diagonals is convenient for the solution with use of Thomas algorithm. Thus, the main diagonal is stored in array $d$ of length $N_{nodes}$, the upper and lower diagonals of length $N_{nodes}-1$ are stored in $u$ and $l$, respectively. An implementation of Thomas algorithm must be provided.

Once all these features are available, a method providing the management of time-stepping and output of results to a file must be conceived. The problem solver will be provided in a dynamically linked library programmed in C\# and the application program will be conceived in Python so that ease of change of parameters and post-processing is achieved.
