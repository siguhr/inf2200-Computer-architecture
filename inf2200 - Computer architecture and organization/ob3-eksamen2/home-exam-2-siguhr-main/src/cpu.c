/** @file cpu.c
 *  @brief This code simulates a system with caching between the CPU and the
 *  main memory.
 */

#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include "memory.h"
#include "byutr.h"

/*
 * Command line argument: Trace file.
 */
// double TIME;
// struct timeval  tv1, tv2;



int main(int argc, char *argv[])
{
  
  //gettimeofday(&tv1, NULL);

  FILE *tracef;
  p2AddrTr tr;

  if (argc < 2)
  {
    printf("Usage: %s filename\n", argv[0]);
    exit(1);
  }

  /* fopen(argv[1], "r") -> fopen(argv[1], "rb")
   * Windows doesn't follow POSIX here and fopen needs the 'b' to function
   * properly.
   */
  if ((tracef = fopen(argv[1], "rb")) == NULL)
  {
    printf("Could not open file: %s\n", argv[1]);
    exit(1);
  }
  /* Initialize the memory subsystem */
  memory_init(atoi(argv[2]), atoi(argv[3]), atoi(argv[4]), atoi(argv[5]), atoi(argv[6]), atoi(argv[7]), atoi(argv[8]), atoi(argv[9]), atoi(argv[10]), atoi(argv[11])); // converts the n-th command-line argument to an integer

  /* Loop through the trace file and simulate memory accesses */
  while (!feof(tracef))
  {
    if (fread(&tr, sizeof(p2AddrTr), 1, tracef) == 1)
    {
      switch(tr.reqtype)
      {
      case FETCH:    memory_fetch(tr.addr, NULL); break;
      case MEMREAD:  memory_read(tr.addr, NULL); break;
      case MEMWRITE: memory_write(tr.addr, NULL, atoi(argv[11])); break;
      default: printf("Ignoring trace record with type %d\n", tr.reqtype);
      }
    }
  }

  fclose(tracef);

  memory_finish(); /* Deinitialize the memory subsystem */

  // gettimeofday(&tv2, NULL);
  // TIME += ((double) (tv2.tv_usec - tv1.tv_usec) / 1000000 + (double) (tv2.tv_sec - tv1.tv_sec)); 
  // printf("Time: %lf\n", TIME);

  return 0;

   
}
