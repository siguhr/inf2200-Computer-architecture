/** @file memory.c
 *  @brief Implements starting point for a memory hierarchy with caching and RAM.
 *  @see memory.h
 */

#include "memory.h"

#include <stdio.h>



struct block
{
  int valid;
  int tag;
  int age;
};

typedef struct block block_c;

struct set
{
  block_c **block;
};

typedef struct set set_c;

struct cache
{
  set_c **set;
  int cache_size;     // chache size is 2^n blocks..
  int cache_index;    // .. so n bits is used for the index.
  int block_size;     // block size is 2^m words (2(^m + 5) words)
  int set_number;
  int assoc;

  char *name;


};
typedef struct cache cache_c;

static unsigned long instr_count;
cache_c *L1_inst_cache;      // read only
cache_c *L1_data_cache;             // reads and writes
cache_c *L2_unif_cache;          // reads and writes 

block_c *make_block(int block_size)
{
  block_c *block = malloc(sizeof(block_c));
  if (block == NULL)
  {
    printf("Block error\n");
    exit(1);
  }
  
  block->valid = 0;
  block->tag = 0;
  block->age = 0;
  return block; 

}

set_c *make_set(int set_number, int assoc, int block_size)
{
  set_c *set = malloc(sizeof(set_c));
  set->block = malloc(sizeof (block_c) *assoc);

  for (int i = 0; i < assoc; i++)
  {
    set->block[i] = make_block(block_size);
  }
  return set;

}

cache_c *make_cache(int cache_size, int block_size, int assoc, char *name)
{
  cache_c *cache = malloc(sizeof(cache_c)*cache_size);
  if(cache == NULL)
  {
    printf("make_cache error\n");
    exit(1);
  }

  cache->cache_size = cache_size;                                                         //Cache size in kilo bytes
  cache->block_size = block_size;                                                         //Block size in bytes
  cache->assoc = assoc;                                           //Calculates the number of blocks in a set
  cache->set_number = (cache->cache_size)/(cache->block_size*cache->assoc);   //Number of sets in cache
  //cache->hit = 0;
  //cache->miss = 0;
  //cache->name = name;

  cache->set = malloc(sizeof(set_c)*cache->set_number);
  for (int i = 0; i < cache->set_number; i++)
  {
    cache->set[i] = make_set(cache->set_number, cache->assoc, cache->block_size);
  }
  
  //cache->hit = 0;
  //cache->miss = 0;

  return cache;

}

void memory_init(int cache_size1, int block_size1, int assoc1, int cache_size2, int block_size2, int assoc2, int cache_size3, int block_size3, int assoc3)
{
  /* Initialize memory subsystem here. */
  L1_inst_cache = make_cache(cache_size1 * 1024, block_size1, assoc1, "L1_instruction_cache");
  L1_data_cache = make_cache(cache_size2 * 1024, block_size2, assoc2, "L1_data_cache");
  L2_unif_cache = make_cache(cache_size3 * 1024, block_size3, assoc3, "L2_unified_cache");
  
  instr_count = 0;
}

void memory_fetch(unsigned int address, data_t *data)
{
  printf("memory: fetch 0x%08x\n", address);
  if (data)
    *data = (data_t) 0;
  
  if (cache_fetch(address, L1_inst_cache) != 1) 
  {
    if (cache_read(address, L2_unif_cache) != 1)
    {
      cache_write(address, L2_unif_cache);
      cache_write(address, L1_inst_cache);
    }
    else
    {
      cache_write(address, L1_inst_cache);
    }
  }
  
  instr_count++;
}

void memory_read(unsigned int address, data_t *data)
{
  printf("memory: read 0x%08x\n", address);
  if (data)
    *data = (data_t) 0;

  if (cache_read(address, L1_data_cache) != 1)      //if not found in L1 data cache
  {
    if (cache_read(address, L2_unif_cache) != 1)    //if not found in L2
    {                                               //read from RAM
      cache_write(address, L2_unif_cache);          //write to L2 
      cache_write(address, L1_data_cache);          //write to L1 data cache
    }
    else
    {                                               // if found in L2
      cache_write(address, L1_data_cache);          // write to L1 data cache
    }
  }
  
  instr_count++;
}

void memory_write(unsigned int address, data_t *data)
{
  printf("memory: write 0x%08x\n", address);
  cache_write(address, L1_data_cache);
  cache_write(address, L2_unif_cache);
  
  instr_count++;
}

void memory_finish(void)
{
  fprintf(stdout, "Executed %lu instructions.\n\n", instr_count);
  
  /* Deinitialize memory subsystem here */
}
