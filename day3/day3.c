#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int get_index(int current, int step) {
  return (current + step) % 31;
}

int main() {
  FILE *fp = fopen("day3.input", "r");
  if (fp == NULL) {
    exit(1);
  }

  char *line = NULL;
  size_t len = 0;
  size_t counter = 0;
  
  size_t index_r1d1 = 0;
  size_t index_r3d1 = 0;
  size_t index_r5d1 = 0;
  size_t index_r7d1 = 0;
  size_t index_r1d2 = 0;
  size_t r1d1 = 0;
  size_t r3d1 = 0;
  size_t r5d1 = 0;
  size_t r7d1 = 0;
  size_t r1d2 = 0;

  while (getline(&line, &len, fp) != -1) {
    counter ++;

    r1d1 += (line[index_r1d1] == '#');
    r3d1 += (line[index_r3d1] == '#');
    r5d1 += (line[index_r5d1] == '#');
    r7d1 += (line[index_r7d1] == '#');
    r1d2 += (line[index_r1d2] == '#') * (counter % 2);
    
    index_r1d1 = get_index(index_r1d1, 1);
    index_r3d1 = get_index(index_r3d1, 3);
    index_r5d1 = get_index(index_r5d1, 5);
    index_r7d1 = get_index(index_r7d1, 7);
    index_r1d2 = get_index(index_r1d2, counter % 2);
  }

  printf("%ld\n", r1d1 * r3d1 * r5d1 * r7d1 * r1d2);

  fclose(fp);
  free(line);

  return 0;
}
