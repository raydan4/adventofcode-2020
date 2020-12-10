#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TREE '#'

typedef struct Sled {
  size_t right;
  size_t down;
  size_t count;
} sled;
typedef sled *sledp;

void make_sleds(sledp sleds, size_t sled_steps[], size_t numsleds) {
  // Number of sleds will be half number of sled dimensions
  size_t numsledsteps = numsleds * 2;

  sleds = (sledp)realloc(sleds, numsleds * sizeof(sled));
  // Parse each pair of sled steps into a sled
  for (size_t i = 0; i < numsledsteps; i+=2) {
    sleds[i/2].right  = sled_steps[i];
    sleds[i/2].down = sled_steps[i+1];
  }
}

void count_trees(FILE *fp, sled *sleds, size_t numsleds) {
  char *line = NULL;
  size_t len = 0;
  size_t counter = 0;

  while (getline(&line, &len, fp) != -1) {
    for (size_t i = 0; i < numsleds; i++) {
      // index is right step * row / down step mod 31
      size_t index = sleds[i].right * counter / sleds[i].down % 31;
      // row is only counted if column is divisible by down step
      size_t iscounted = (counter % sleds[i].down == 0);
      // check if row[index] is a tree
      size_t istree = (line[index] == TREE);
      sleds[i].count += istree * iscounted;
    }
    counter ++;
  }
  free(line);
  fclose(fp);
}

int main() {
  FILE *fp = fopen("day3.input", "r");
  if (fp == NULL) {
    exit(1);
  }
  
  // Setup vars
  size_t result = 1;
  size_t sled_steps[] = {1, 1, 3, 1, 5, 1, 7, 1, 1, 2};
  size_t numsleds = 5;

  // Make sleds and count trees
  sledp sleds = malloc(1);
  make_sleds(sleds, sled_steps, numsleds);
  count_trees(fp, sleds, numsleds);

  // Calculate and display results
  for (size_t i = 0; i < numsleds; i++) result *= sleds[i].count;
  printf("Challenge 1: %ld\n", sleds[1].count);
  printf("Challenge 2: %ld\n", result);
 
  free(sleds);

  return 0;
}
