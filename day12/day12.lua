traveled1 = {
  [0] = 0,
  [1] = 0,
  [2] = 0,
  [3] = 0
}

traveled2 = {
  [0] = 0,
  [1] = 0,
  [2] = 0,
  [3] = 0
}

waypoint = {
  [0] = 10,
  [1] = 1,
  [2] = 0,
  [3] = 0
}


dirton = {
  ["E"] = 0,
  ["N"] = 1,
  ["W"] = 2,
  ["S"] = 3
}

local dirswitch = {
  ["R"] = -1,
  ["L"] = 1
}


function calcfacing(dir, amt, facing)
  return (facing + (amt / 90) * dirswitch[dir]) % 4
end


function rotate_waypoint(dir, amt)
  local holder = {
    [0] = waypoint[0],
    [1] = waypoint[1],
    [2] = waypoint[2],
    [3] = waypoint[3]
  }
  shift = amt / 90 * dirswitch[dir]
  for i=0,3 do waypoint[(i + shift) % 4] = holder[i] end
end


-- Open a file for read an test that it worked
fh,err = io.open("day12.input")
if err then print("Oops"); return; end

facing = 0


-- line by line
while true do
  line = fh:read()
  if line == nil then break end
  for dir, val in string.gmatch(line, "(%a)(%d+)") do
    val = tonumber(val)
    if dir == 'R' or dir == 'L' then
      -- CHALLENGE ONE: Make right or left turn
      facing = calcfacing(dir, val, facing)
      -- CHALLENGE TWO: Rotate waypoint
      rotate_waypoint(dir, val)
    elseif dir == 'F' then
      -- CHALLENGE ONE: Travel forward
      traveled1[facing] = traveled1[facing] + val
      -- CHALLENGE TWO: Move to waypoint val times
      for i=0,3 do traveled2[i] = traveled2[i] + waypoint[i] * val end
    else
      dir = dirton[dir]
      -- CHALLENGE ONE: Travel in cardinal direction
      traveled1[dir] = traveled1[dir] + val
      -- CHALLENGE TWO: Move waypoint in cardinal direction
      waypoint[dir] = waypoint[dir] + val
    end
  end
end

-- Following are good form
fh:close()

-- Report
print("Challenge 1: ", math.abs(traveled1[0] - traveled1[2]) + math.abs(traveled1[1] - traveled1[3]))
print("Challenge 2: ", math.abs(traveled2[0] - traveled2[2]) + math.abs(traveled2[1] - traveled2[3]))
