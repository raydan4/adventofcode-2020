function calc_ones_and_threes(ints)
    # Requires sorted list of ints
    threes = 1      # to phone
    ones = 1        # to wall
    for (i, val) in enumerate(ints[2:end])
        if val - ints[i] == 1
            ones += 1
        elseif val - ints[i] == 3
            threes += 1
        end
    end
    threes * ones
end


function count_permutations(current, ints, memo)
    # Requires sorted list of ints
    if haskey(memo, current)
        return memo[current]
    end
    if isempty(ints)
        memo[current] = 1
    else
        add = 0
        for (i, val) in enumerate(ints)
            if val - current <= 3
                add += count_permutations(val, ints[i+1:end], memo)
            else
                break
            end
        end
        memo[current] = add
    end
    memo[current]
end


ints = zeros(Int64,0)
open("day10.input") do file
    for line in eachline(file)
        line = chomp(line)
        if !isempty(line)
            append!(ints, parse(Int64, line))
        end
    end
end
ints = sort(ints)
challenge1 = calc_ones_and_threes(ints)
challenge2 = count_permutations(0, ints, Dict{Int64, Int64}())

println("Challenge 1: $challenge1")
println("Challenge 2: $challenge2")

