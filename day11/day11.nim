import streams, strutils, sequtils, sugar

func count_occupied(rows: seq[string]): int =
  var count = 0
  for row in rows:
    count += len(row.filter(x => x == '#'))
  count

var strm = newFileStream("day11.input", fmRead)
var line = ""
var rows = newSeq[string]()
var prev = newSeq[string]()

if not isNil(strm):
  while strm.readLine(line):
    if not isEmptyOrWhitespace(line): rows.add(line.strip())
  strm.close()
  
let maxh = len(rows) - 1
let maxw = len(rows[0]) - 1
let minh = 0
let minw = 0

while prev != rows:
  prev = rows

  for i, row in prev:
    for j, chr in row:
      var sum  = 0

      if              j > minw and prev[i  ][j-1] == '#': sum += 1  # left
      if i > minh and j > minw and prev[i-1][j-1] == '#': sum += 1  # upper left
      if i > minh              and prev[i-1][j  ] == '#': sum += 1  # upper
      if i > minh and j < maxw and prev[i-1][j+1] == '#': sum += 1  # upper right
      if              j < maxw and prev[i  ][j+1] == '#': sum += 1  # right
      if i < maxh and j < maxw and prev[i+1][j+1] == '#': sum += 1  # lower right
      if i < maxh              and prev[i+1][j  ] == '#': sum += 1  # lower
      if i < maxh and j > minw and prev[i+1][j-1] == '#': sum += 1  # lower left

      if chr == '#' and sum >= 4: rows[i][j] = 'L'
      if chr == 'L' and sum == 0: rows[i][j] = '#'

let challenge1 = count_occupied(rows)

echo "Challenge 1: ", challenge1
