using DataStructures,Interpolations,CircularArrayBuffers

Nsteps = 100
nSolSize = 20
cb = CircularArrayBuffer{Float64}(nSolSize,Nsteps)


for i = 1:Nsteps
push!(cb,rand(nSolSize))
end

function f!(du,u,t)
    du[1] = (sin(t)^2)*u[1]
end

function f(du,u,t)
    du[1] = (sin(t)^2)*u[1]
    return du 
end

function eulerStep!(du,u,t,dt)
    f!(du,u,t)
    u[1] = u[1] + dt*du[1]
end

function rungekuttaStep!(du,u,t,dt)
    k1 = f(du,u,t)
    k2 = f(du,u+dt*(k1/2),t+(dt/2) )
    k3 = f(du,u+dt*(k2/2),t+(dt/2) )
    k4 = f(du,u+(dt*k3),t+dt)

    u[1] = u[1] + (dt/6)*(k1 + 2*k2 + 2*k3 + k4)    
end

dt = 0.01
tspan = collect(0:dt:5)
sole = zeros(length(tspan))
solrk = zeros(length(tspan))
u0e = [1.]
due = similar(u0)
u0rk = [1.]
durk = similar(u0)
for i in 1:length(tspan)
    println(i)
    sole[i] = eulerStep!(due,u0e,tspan[i],dt)
    solrk[i] = eulerStep!(durk,u0rk,tspan[i],dt)
end

