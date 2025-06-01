# ASTP-Solver in Julia

This project provides a simple implementation of the **Travelling Salesman Problem (TSP)** using the **JuMP** optimization framework and the **GLPK** solver in Julia. 
It generates a random distance matrix between cities and finds the optimal tour that minimizes total travel distance.

 - **Generates random city distances

![image](https://github.com/user-attachments/assets/7a2d3fac-d34d-4558-80e7-032e4bbf927c)

 - **Solves the TSP using MILP with JuMP + GLPK
 - **Displays the optimal tour and its total distance

![image](https://github.com/user-attachments/assets/657b1876-3912-4cfc-b46c-63cf3148f89d)

 - **Visualizes the route using a graph plot
   
![julia_ss_drogi](https://github.com/user-attachments/assets/93e8bc1a-5f68-4581-ac31-3b59e1ab0621)

## Requirements

Before running the script, install Julia and the necessary packages:

```julia
using Pkg
Pkg.add("JuMP")
Pkg.add("GLPK")
Pkg.add("Plots")
Pkg.add("GraphRecipes")
