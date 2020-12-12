import streams, strutils, strformat, sequtils, sugar


func count_occupied(state: seq[string]): int =
  var count = 0
  for row in state:
    count += len(row.filter(x => x == '#'))
  count


func in_range(pos: int, min: int, max: int): bool =
  min <= pos and max >= pos


proc next_seat_full(state: seq[string], i: int, j: int, h: int, w: int, limit: bool): bool =
  let rmax = len(state) - 1
  let cmax = len(state[i]) - 1

  var row = i + h
  var col = j + w

  while in_range(row, 0, rmax) and in_range(col, 0, cmax):
    let c = state[row][col]
    if c == '#': return true
    if c == 'L': return false
    if limit: break
    row += h
    col += w
  false 


proc count_adjacent(state: seq[string], i: int, j: int, limit: bool): int =
  var count  = 0
  for h in -1..1:
    for w in -1..1:
      if h == 0 and w == 0: continue
      count += int(next_seat_full(state, i, j, h, w, limit))
  count


proc calc_round(state: seq[string], maxadjacent: int, limit: bool): seq[string] =
  var new = state
  
  for i, row in state:
    for j, col in row:
      let sum = count_adjacent(state, i, j, limit)
      if col == '#' and sum >= maxadjacent: new[i][j] = 'L'
      if col == 'L' and sum == 0: new[i][j] = '#'
  new


proc simulate(state: seq[string], maxadjacent: int, limit: bool): int =
  var new = state
  var curr = newSeq[string]()

  while new != curr:
    curr = new
    new = calc_round(curr, maxadjacent, limit)
  count_occupied(curr)


# Main
var strm = newFileStream("day11.input", fmRead)
var line = ""
var start = newSeq[string]()

if not isNil(strm):
  while strm.readLine(line):
    if not isEmptyOrWhitespace(line): start.add(line.strip())
  strm.close()

let challenge1 = simulate(start, 4, true)
echo "Challenge 1: ", challenge1

let challenge2 = simulate(start, 5, false)
echo "Challenge 2: ", challenge2
