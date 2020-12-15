#include <map>
#include <list>
#include <fstream>
#include <iostream>
#include <string>

unsigned long mask_value(std::string mask, unsigned long value) {
  // Apply mask to value
  for (std::string::size_type i = 0; i < mask.size(); i++) {
    if (mask[i] == '1') {
      // Set place to 1
      value |= 1UL << (mask.size() - i - 1);
    } else if (mask[i] == '0') {
      // Set place to 0
      value |= 1UL << (mask.size() - i - 1);
      value ^= 1UL << (mask.size() - i - 1);
    }
  }
  return value;
}

std::list<unsigned long> mask_addrs (std::string mask, unsigned long addr) {
  // List to hold each address that matches the mask
  std::list<unsigned long> addrs({addr});
  // Iterate over mask adding copies of addr to list for each X variation
  for (std::string::size_type i = 0; i < mask.size(); i++) {
    if (mask[i] == '1') {
      std::list<unsigned long>::iterator j;
      // Set current bit to 1
      for (j = addrs.begin(); j != addrs.end(); j++) { *j |= 1UL << (mask.size() - i - 1); }
    } else if (mask[i] == 'X') {
      // Make a new copy of everything in the list
      std::list<unsigned long> dup(addrs);
      // Flip the current bit of the copies
      std::list<unsigned long>::iterator j;                 // 3 xors between 1/0 and 1 = 0/1
      for (j = addrs.begin(); j != addrs.end(); j ++) { *j ^= *j ^ *j ^ 1UL << (mask.size() - i - 1); }
      // Splice the copies to the end of the list
      addrs.splice(addrs.end(), dup);
    }
  }
  return addrs;
}

int main() {
  std::map<unsigned long, unsigned long> memory_v1;
  std::map<unsigned long, unsigned long> memory_v2;
  unsigned long challenge1 = 0;
  unsigned long challenge2 = 0;
  unsigned long value = 0;
  unsigned long addr = 0;
  std::string mask;
  // Read input file line by line
  std::fstream data("day14.input", std::fstream::in);
  if (data.is_open()) {
    std::string line;
    while(getline(data, line) and line.size() > 1) {
      if (line.substr(0, 3) == "mem") {
        // Find bounds for addr and value in line
        int astart = line.find("[") + 1;
        int astop = line.find("]") + 1;
        int vstart = line.find("=") + 1;
        int vstop = line.size();
        // Pull addr and value from line
        addr = stol(line.substr(astart, astop));
        value = stol(line.substr(vstart,vstop));
        // Apply mask to value, assign masked value to memory_v1 addr
        unsigned long masked_value = mask_value(mask, value);
        memory_v1[addr] = masked_value;
        // Apply mask to addr, assign value to resulting masked memory_v2 addrs
        std::list<unsigned long> addrs = mask_addrs(mask, addr);
        std::list<unsigned long>::iterator i;
        for (i = addrs.begin(); i != addrs.end(); i++) { memory_v2[*i] = value; }
      } else {
        // Find bounds for mask in line
        int mstart = line.find("=") + 2;
        int mstop =  line.size();
        // Update mask
        mask = line.substr(mstart, mstop);
      }
    }
    data.close();
  }
  // Sum up memory values
  for (const auto& [a, v] : memory_v1) { challenge1 += v; }
  for (const auto& [a, v] : memory_v2) { challenge2 += v; }
  // Report results
  std::cout << "Challenge 1: " << challenge1 << "\n";
  std::cout << "Challenge 2: " << challenge2 << "\n";
  return 0;
}
