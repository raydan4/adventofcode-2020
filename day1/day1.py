FILE = 'day1.input'


def part1(numset):
  for i in numset:
    if j := 2020 - i in numset:
      return i * j
  return None


def part2(numset):
  for i in numset:
    val = 2020 - i
    for j in numset:
      if k := val - j in numset:
        return i * j * k
  return None


if __name__ == '__main__':
  numset = set()
  with open(FILE) as f:
    for line in f:
      numset.add(int(line))

  print(f'challenge 1: {part1(numset)}')
  print(f'challenge 2: {part2(numset)}')

