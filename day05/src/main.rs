use std::fs::File;
use std::io::{self, prelude::*, BufReader};
use std::collections::HashSet;

fn get_seat(row: i32, col:i32) -> i32 {
  (row << 3) + col
}

fn calc_row_col(line: String) -> (i32, i32) {
  let mut rawbin = 0;

  for (i, c) in line.chars().enumerate() {
    // Each of the characters in the line are one bit
    // 'B' and 'R' are 1, 'F' and 'L' are 0
    // We need to insert the bits left to right as we read them
    // 1 << (position) * (1 or 0)
    rawbin |= (1 << (9 - i)) * (c == 'B' || c == 'R') as i32;
  }
  (rawbin >> 3, rawbin & 7)
}

fn get_my_seat(seats: HashSet<i32>, max: i32) -> i32 {
  let mut mine = -1;
  for seat in 0..max {
    if !seats.contains(&seat) && seats.contains(&(seat + 1)) && seats.contains(&(seat - 1)) { mine = seat; }
  }
  mine
}

fn main() -> io::Result<()> {
  let file = File::open("day5.input")?;
  let reader = BufReader::new(file);

  let mut seats = HashSet::new();
  let mut max = 0;

  for line in reader.lines().map(|l| l.unwrap()) {
    let (row, col) = calc_row_col(line);
    let seat = get_seat(row, col);
    if seat > max { max = seat; }
    seats.insert(seat);
  }

  let mine = get_my_seat(seats, max);

  println!("Challenge 1: {}", max);
  println!("Challenge 2: {}", mine);

  Ok(())
}
