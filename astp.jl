using JuMP
using GLPK
using GraphRecipes, Plots 

function find_distances()

    distances = rand(100:300, num_cities,num_cities)

    for j in 1:num_cities
        distances[j,j]= 0
    end

    println(distances)
    return distances
end

function solve_astp(distances)
    model = Model(GLPK.Optimizer)

    @variable(model, x[1:num_cities, 1:num_cities], Bin) # Binary variable indicating the path

    @objective(model, Min, sum(distances[i, j] * x[i, j] for i in 1:num_cities for j in 1:num_cities))

    @constraint(model, [i in 1:num_cities], sum(x[i, j] for j in 1:num_cities) == 1)
    @constraint(model, [j in 1:num_cities], sum(x[i, j] for i in 1:num_cities) == 1)

    @constraint(model, [i in 1:num_cities], x[i, i] == 0)

    #subtour 
    @variable(model, u[1:num_cities])
    @constraint(model, u[1] == 1)
    @constraint(model, [i in 2:num_cities], u[i] >= 2)
    @constraint(model, [i in 2:num_cities], u[i] <= num_cities)
    @constraint(model, [i in 2:num_cities, j in 2:num_cities; i != j], u[i] - u[j] + (num_cities - 1) * x[i, j] <= num_cities - 2)

    optimize!(model)

    if termination_status(model) == MOI.OPTIMAL
        println("Optimal tour found:")
        tour = zeros(Int, num_cities, num_cities)
        for i in 1:num_cities
            for j in 1:num_cities
                if value(x[i, j]) > 0.5
                    tour[i, j] = 1
                end
            end
        end
        println(tour)
        println("Total distance: ", objective_value(model))
    else
        println("No optimal solution found.")
    end
    return tour
end

function draw_solution(distances,tour)

    edgelabel_mat = Array{String}(undef, num_cities, num_cities)
    for i in 1:num_cities
        for j in 1:num_cities
            edgelabel_mat[i, j] =  string(distances[i,j], " km ")
        end
    end
    graphplot(tour,markersize = 0.2, fontsize = 8,curves=false, names=1:num_cities,edgelabel=edgelabel_mat )
end

num_cities = 5
distances =find_distances() 
tour = solve_astp(distances)
draw_solution(distances,tour)
