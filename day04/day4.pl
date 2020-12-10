#!/usr/bin/perl

use warnings;
use strict;
use feature "state";

sub validate_passport {
  my (%passport) = @_;
  
  # Check if anything is missing
  if (!exists($passport{"byr"})) { return 0; }
  else {
    my $byr = $passport{"byr"};
    if ($byr < 1920 or $byr > 2002) { return 0; }
  }
  if (!exists($passport{"iyr"})) { return 0; }
  else {
    my $iyr = $passport{"iyr"};
    if ($iyr < 2010 or $iyr > 2020) { return 0; }
  }
  if (!exists($passport{"eyr"})) { return 0; }
  else {
    my $eyr = $passport{"eyr"};
    if ($eyr < 2020 or $eyr > 2030) { return 0; }
  }
  if (!exists($passport{"hgt"})) { return 0; }
  else {
    my $hgt = $passport{"hgt"};
    for ($hgt) {
      if (/(\d+)cm/) {
        if ($1 < 150 or $1 > 193) { return 0; }
      } elsif (/(\d+)in/) {
        if ($1 < 59 or $1 > 76) { return 0; }
      }
    }
  }
  if (!exists($passport{"pid"})) { return 0; }
  else {
    my $pid = $passport{"pid"};
    if (length($pid) != 9) { return 0;}
  }
  if (!exists($passport{"hcl"})) { return 0; }
  if (!exists($passport{"ecl"})) { return 0; }
  #if (!exists($passport{"cid"})) { return 0; }

  # We have everything we need
  return 1;
}

open my $file, '<', "day4.input" or die $!;
our $counter = 0;

while (my $line = <$file>) {
  chomp($line);
  state %passport;


  for ($line) {
    if ($line eq '') {
      my $is_valid = validate_passport(%passport);
      if ($is_valid) { $counter ++; }
      %passport = ();
    } else {
      if (/byr:(\d{4})/) {
        $passport{'byr'} = $1;
      }
      if (/iyr:(\d{4})/) {
        $passport{'iyr'} = $1;
      }
      if (/eyr:(\d{4})/) {
        $passport{'eyr'} = $1;
      }
      if (/hgt:(\d+(in|cm))/) {
        $passport{'hgt'} = $1;
      }
      if (/hcl:(\#[0-9a-f]{6})/) {
        $passport{'hcl'} = $1;
      }
      if (/ecl:(amb|blu|brn|gry|grn|hzl|oth)/) {
        $passport{'ecl'} = $1;
      }
      if (/pid:(\d+)/) {
        $passport{'pid'} = $1;
      }
      #if (/cid:/) {
      #  $passport{'cid'} = $1;
      #}
    }
  }
}

close($file);
print "Challenge 1: $counter\n";
