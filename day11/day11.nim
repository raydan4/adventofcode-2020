import streams, strutils, strformat, sequtils, sugar


func count_occupied(state: seq[string]): int =
  for row in state:
    result += len(row.filter(x => x == '#'))


proc next_seat_full(state: seq[string], rcenter: int, ccenter: int, rdelta: int, cdelta: int, limit: bool): bool =
  let rmax = len(state) - 1
  let cmax = len(state[rcenter]) - 1

  var row = rcenter + rdelta
  var col = ccenter + cdelta

  while row in 0..rmax and col in 0..cmax:
    let c = state[row][col]
    if c == '#': return true
    if c == 'L': return false
    if limit: break
    row += rdelta
    col += cdelta
  false 


proc count_adjacent(state: seq[string], rcenter: int, ccenter: int, limit: bool): int =
  for h in -1..1:
    for w in -1..1:
      if h == 0 and w == 0: continue
      result += int(next_seat_full(state, rcenter, ccenter, h, w, limit))


proc calc_round(state: seq[string], maxadjacent: int, limit: bool): seq[string] =
  result = state
  
  for i, row in state:
    for j, col in row:
      let sum = count_adjacent(state, i, j, limit)
      if col == '#' and sum >= maxadjacent: result[i][j] = 'L'
      if col == 'L' and sum == 0: result[i][j] = '#'


proc simulate(state: seq[string], maxadjacent: int, limit: bool): int =
  var new = state
  var curr = newSeq[string]()

  while new != curr:
    curr = new
    new = calc_round(curr, maxadjacent, limit)
  count_occupied(curr)


when isMainModule:
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
