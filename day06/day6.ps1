$count1 = 0
$count2 = 0
$groupc = @()
$groupl = @()

foreach($line in Get-Content ./day6.input) {
  IF([string]::IsNullOrWhiteSpace($line)) {
    # Get unique chars in groups chars
    $unique = $groupc | Sort-Object -Unique
    
    # Make a list of all possible chars (kinda gross not using PS6 sorry)
    $all = (97..(97+25)).ForEach({ [char]$_ }) 
    
    # Find intersection of all lines
    foreach ($item in $groupl) {
      $all = $all | ? { $item.ToCharArray() -contains $_ }
    }

    # Add to counters
    $count1 += $unique.count
    $count2 += $all.count
    
    # Clear lists
    $groupc = @()
    $groupl = @()
  } else {
    $groupl += $line
    foreach($char in $line.ToCharArray()) {
      $groupc += $char      
    }
  }
}

echo "Challenge 1: $count1"
echo "Challenge 2: $count2"
