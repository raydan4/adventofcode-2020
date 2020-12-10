#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TREE '#'

int get_index(int current, int step) {
  return (current + step) % 31;
}

int main() {
  FILE *fp = fopen("day3.input", "r");
  if (fp == NULL) {
    exit(1);
  }
  
  // Variables for getline and iteration counter
  char *line = NULL;
  size_t len = 0;
  size_t counter = 0;
  
  // Counters for each path's index
  size_t index_r1d1 = 0;
  size_t index_r3d1 = 0;
  size_t index_r5d1 = 0;
  size_t index_r7d1 = 0;
  size_t index_r1d2 = 0;

  // Counters for number of trees on each path
  size_t r1d1 = 0;
  size_t r3d1 = 0;
  size_t r5d1 = 0;
  size_t r7d1 = 0;
  size_t r1d2 = 0;

  while (getline(&line, &len, fp) != -1) {
    // Increment line counter first
    counter ++;

    r1d1 += (line[index_r1d1] == TREE);
    r3d1 += (line[index_r3d1] == TREE);
    r5d1 += (line[index_r5d1] == TREE);
    r7d1 += (line[index_r7d1] == TREE);
    // Only count trees for r1d2 every other row
    r1d2 += (line[index_r1d2] == TREE) * (counter % 2);
    
    index_r1d1 = get_index(index_r1d1, 1);
    index_r3d1 = get_index(index_r3d1, 3);
    index_r5d1 = get_index(index_r5d1, 5);
    index_r7d1 = get_index(index_r7d1, 7);
    // Only increment r1d2 index every other row
    index_r1d2 = get_index(index_r1d2, counter % 2);
  }

  // Print product of all tree counts
  printf("%ld\n", r1d1 * r3d1 * r5d1 * r7d1 * r1d2);

  fclose(fp);
  free(line);

  return 0;
}
