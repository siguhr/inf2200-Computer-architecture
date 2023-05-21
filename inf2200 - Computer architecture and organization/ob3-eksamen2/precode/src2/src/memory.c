/** @file memory.c
 *  @brief Implements starting point for a memory hierarchy with caching and RAM.
 *  @see memory.h
 */

#include "memory.h"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>

double TIME;
struct timeval  tv1, tv2;

double TIME2;
struct timeval  tv3, tv4;

double TIME3;
struct timeval  tv5, tv6;

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

  int hit;
  int miss;

  char *name;

  int read_hit;
  int read_miss;

  int write_hit;
  int write_miss;

  int block_miss;
  int tot_set_miss;

  int wb_indicator;
  int replaced;

  float timer_read;
  float timer_write;
  float timer_fetch;

  int clock_cycles;



};
typedef struct cache cache_c;

static unsigned long instr_count;
cache_c *L1_inst_cache;             // read only
cache_c *L1_data_cache;             // reads and writes
cache_c *L2_unif_cache;             // reads and writes 

block_c *make_block(int block_size)
{
  block_c *block = malloc(sizeof(block_c));
  if (block == NULL)
  {
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
    exit(1);
  }

  

  cache->cache_size = cache_size;                                                         //Cache size in kilo bytes
  cache->block_size = block_size;                                                         //Block size in bytes
  cache->assoc = assoc;                                                                   //Number of blocks in a set
  cache->set_number = (cache->cache_size)/(cache->block_size*cache->assoc);               //Number of sets in cache
  cache->hit = 0;
  cache->miss = 0;
  cache->name = name;

  cache->read_hit = 0;
  cache->read_miss = 0;

  cache->write_hit = 0;
  cache->write_miss = 0;

  cache->block_miss = 0;
  cache->tot_set_miss = 0;

  cache->wb_indicator = 0;
  cache->replaced = 0;

  cache->timer_read = 0;
  cache->timer_write = 0;
  cache->timer_fetch = 0;

  cache->clock_cycles = 0;



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


// write-through
void memory_write(unsigned int address, data_t *data )
{
  printf("memory: write 0x%08x\n", address);


  cache_write(address, L1_data_cache);
  cache_write(address, L2_unif_cache);
  
  instr_count++;
}

//write back

// void memory_write(unsigned int address, data_t *data )
// {
//   printf("memory: write 0x%08x\n", address);

//   if (cache_write(address, L1_data_cache) == 1)
//     cache_write(address, L2_unif_cache);
//   else
//   cache_write(address, L1_data_cache);
  
  
//   instr_count++;
// }





int cache_write(unsigned int address, cache_c *cache)
{
  gettimeofday(&tv3, NULL);

  int index = address_bitstring(cache, address, "index");
  int tag = address_bitstring (cache, address, "tag");


  cache->block_miss = 0;
  set_c *set = cache->set[index];

  int n = 0;
  int old = 0;

  for (int i = 0; i < cache->assoc; i++) 
  {
    if (set->block[i]->age > n)
    {
      old = i;
      n = set->block[i]->age;
      // printf("oldest: %d\n", i);
      // printf("age: %d\n", n);
    }

    if (set->block[i]->tag == tag)
    {
      if (set->block[i]->valid == 1)                              //cache hit
      {                                                           //
        //printf("______Wrote data(%s)_______\n", cache->name);
        set->block[i]->age = 0;
        cache->hit++;
        cache->write_hit++;
        cache->clock_cycles++;

        gettimeofday(&tv4, NULL);
        TIME2 += ((double) (tv4.tv_usec - tv3.tv_usec) / 1000000 + (double) (tv4.tv_sec - tv3.tv_sec));
        cache->timer_write += TIME2; 

        return 0;
      }
      else if(set->block[i]->valid == 0)                           //cache miss
      {                                                             //new data is written to cache block 
      //printf("______Wrote new data(%s)_______\n", cache->name);
        set->block[i]->tag = tag;
        set->block[i]->valid = 1;
        cache->miss++;
        cache->write_miss++;
        return 0;
      }
    
    
    }
    else
      {
        set->block[i]->age++;
        cache->block_miss++;
        // printf("block miss: %d\n", cache->block_miss);
        // printf("number of blocks: %d\n", cache->assoc);

        if (cache->block_miss == cache->assoc)
      
        {
          cache->miss++;
          cache->write_miss++;
          cache->tot_set_miss++;
        // printf("total set miss: %d\n", cache->assoc);
        }

      }

  }
                                                            
  // printf("______Replace data(%s)_______\n", cache->name);   //no space for nev data, needs to be replaced and write LRU to lower memory

  cache->wb_indicator = 2;
  cache->replaced++;

  set->block[old]->age = 0;
  set->block[old]->tag = tag;
  cache->miss++;
  cache->write_miss++;

  

  return 1;

}

int cache_read(unsigned int address, cache_c *cache)
{
  gettimeofday(&tv1, NULL);

  int index = address_bitstring(cache, address, "index");
  int tag = address_bitstring(cache, address, "tag");

  // int read_hit = cache->hit;
  // int read_miss = cache->miss;


  cache->block_miss = 0;

  set_c *set = cache->set[index];
  for (int i = 0; i < cache->assoc; i++)
  {
    if (set->block[i]->tag == tag)
    {
      if (set->block[i]->valid == 1)
      {
        set->block[i]->age = 0;
        cache->hit++;
        cache->read_hit++;
        cache->clock_cycles++;
        //printf("______ Read data(%s)_______\n", cache->name);

        gettimeofday(&tv2, NULL);
        TIME += ((double) (tv2.tv_usec - tv1.tv_usec) / 1000000 + (double) (tv2.tv_sec - tv1.tv_sec));
        cache->timer_read += TIME; 

        return 1;
      }

      else
      {
        set->block[i]->valid = 1;
        set->block[i]->age = 0;
        cache->miss++;
        cache->read_miss++;
        //printf("______Read data from lower memory(%s)_______\n", cache->name);
        return 1;
      }
    }
    else
    {
      set->block[i]->age++;
      cache->block_miss++;
      // printf("block miss: %d\n", cache->block_miss);
      // printf("number of blocks: %d\n", cache->assoc);

      if (cache->block_miss == cache->assoc)
      // printf("set miss: %d\n", cache->set_miss); 
      {
        cache->miss++;
        cache->read_miss++;
        cache->tot_set_miss++;
        // printf("total set miss: %d\n", cache->assoc);
      }
      

    }

  }

  //printf("______Miss (read)(%s)_______\n", cache->name);
  cache->miss++;
  cache->read_miss++;
  
  //printf("T1: %lf\n", TIME);
  return 0;
  
}

int cache_fetch(unsigned int address, cache_c *cache)
{
  gettimeofday(&tv5, NULL);

  int index = address_bitstring(cache, address, "index");
  int tag = (address_bitstring(cache, address, "tag"));

  cache->block_miss = 0;

  set_c *set = cache->set[index];

  for (int i = 0; i < cache->assoc; i++)
  {
    if (set->block[i]->tag == tag)          // check for correct tag
    {
      if (set->block[i]->valid == 1)        // check if block is valid
      {
        set->block[i]->age = 0;             // set age
        cache->hit++;
        cache->clock_cycles++;
        //printf("______Fetche data(%s)_______\n\n", cache->name);

        gettimeofday(&tv6, NULL);
        TIME3 += ((double) (tv6.tv_usec - tv5.tv_usec) / 1000000 + (double) (tv6.tv_sec - tv5.tv_sec));
        cache->timer_fetch += TIME3; 
        return 1;
      }
      else                                  // correct tag but not data, fetche from L2
      {
        set->block[i]->valid = 1;
        set->block[i]->age = 0;
        cache->miss++;
        //printf("______Fetche data from lower memory(%s)_______\n\n", cache->name);
        return 1;
      }
    }
    else 
    {
      set->block[i]->age++;
      cache->block_miss++;
      // printf("block miss: %d\n", cache->block_miss);
      // printf("number of blocks: %d\n", cache->assoc);

      if (cache->block_miss == cache->assoc)
      {
        cache->miss++;
        cache->write_miss++;
        cache->tot_set_miss++;
        // printf("total set miss: %d\n", cache->assoc);
      }
    }
  }
  // printf("______Miss (fetch)(%s)_______\n\n", cache->name);
  cache->miss++;

  


  return 0;
}

void memory_finish(void)
{
  fprintf(stdout, "Executed %lu instructions.\n\n", instr_count);

  printf("Hit and miss total\n");

  float L1_inst_hit = (float)L1_inst_cache->hit * 100 / (L1_inst_cache->miss + L1_inst_cache->hit);
  printf ("L1_inst_cache hit/miss: %d/%d\n", L1_inst_cache->hit, L1_inst_cache->miss);

  float L1_data_hit = (float)L1_data_cache->hit * 100 / (L1_data_cache->miss + L1_data_cache->hit);
  printf ("L1_data_cache hit/miss: %d/%d\n", L1_data_cache->hit, L1_data_cache->miss);

  float L2_unif_hit = (float)L2_unif_cache->hit * 100 / (L2_unif_cache->miss + L2_unif_cache->hit);
  printf ("L2_unif_cache hit/miss: %d/%d\n\n", L2_unif_cache->hit, L2_unif_cache->miss);

  
  // hit ratio
  printf("Hit and miss total ratio\n");

  if (L1_inst_cache->hit > 0 || L1_inst_cache->miss > 0)       // (||) Logical OR. True only if either one operand is true
    printf("L1_inst_cache hit ratio: %f\n", (float)L1_inst_hit);

  if (L1_data_cache->hit > 0 || L1_data_cache->miss > 0)
  {
    printf("L1_data_cache hit ratio: %f\n", (float)L1_data_hit);
  }
    else printf("L1_data_cache not accessed\n");

  if (L2_unif_cache->hit > 0 || L2_unif_cache->miss > 0)
  {
    printf("L2_unif_cache hit ratio: %f\n", (float)L2_unif_hit);
  }
    else printf("L2_unif_cache not accessed");

  float hit_ratio_total = (float) (L1_inst_hit + L1_data_hit + L2_unif_hit) / 3;
  printf("Hit total ratio: %f\n", (float)hit_ratio_total);

  float miss_rate = (float) 100 - hit_ratio_total;
  printf("Miss ratio total: %f\n\n", (float) miss_rate);


  //read hit/miss and ratio
  printf("Read hit/miss and ratio\n");

  float L1_data_hit_read = (float)L1_data_cache->read_hit * 100 / (L1_data_cache->read_miss + L1_data_cache->read_hit);
  printf ("L1_data_cache read hit/miss: %d/%d\n", L1_data_cache->read_hit, L1_data_cache->read_miss);

  float L2_unif_hit_read = (float)L2_unif_cache->read_hit * 100 / (L2_unif_cache->read_miss + L2_unif_cache->read_hit);
  printf ("L2_unif_cache read hit/miss: %d/%d\n", L2_unif_cache->read_hit, L2_unif_cache->read_miss);

  if (L1_data_cache->read_hit > 0 || L1_data_cache->read_miss > 0)
  {
    printf("L1_data_cache read hit ratio: %f\n", (float)L1_data_hit_read);
  }
    else printf("L1_data_cache not accessed\n");
  
  if (L2_unif_cache->read_hit > 0 || L2_unif_cache->read_miss > 0)
  {
    printf("L2_unif_cache read hit ratio: %f\n\n", (float)L2_unif_hit_read);
  }
    else printf("L2_unif_cache not accessed");
  
  


  //write hit/miss and ratio
  printf("Write hit/miss and ratio\n");

  float L1_data_hit_write = (float)L1_data_cache->write_hit * 100 / (L1_data_cache->write_miss + L1_data_cache->write_hit);
  printf ("L1_data_cache write hit/miss: %d/%d\n", L1_data_cache->write_hit, L1_data_cache->write_miss);
  
  float L2_unif_hit_write = (float)L2_unif_cache->write_hit * 100 / (L2_unif_cache->write_miss + L2_unif_cache->write_hit);
  printf ("L2_unif_cache write hit/miss: %d/%d\n", L2_unif_cache->write_hit, L2_unif_cache->write_miss);

   if (L1_data_cache->write_hit > 0 || L1_data_cache->write_miss > 0)
  {
    printf("L1_data_cache write hit ratio: %f\n", (float)L1_data_hit_write);
  }
    else printf("L1_data_cache not accessed\n");
  
   if (L2_unif_cache->write_hit > 0 || L2_unif_cache->write_miss > 0)
  {
    printf("L2_unif_cache write hit ratio: %f\n\n", (float)L2_unif_hit_write);
  }
    else printf("L2_unif_cache not accessed");

  //Total set miss
  printf("Total set misses\n");
  printf("L1_data_cache total set miss: %d\n", L1_data_cache->tot_set_miss);
  printf("L2_unif_cache total set miss: %d\n\n", L2_unif_cache->tot_set_miss);

  //Total replace  cache->replaced++;
  printf("Total removed blocks\n");
  printf("L1_data_cache removed blocks: %d\n", L1_data_cache->replaced);
  printf("L2_unif_cache removed blocks: %d\n\n", L2_unif_cache->replaced);  

  printf("Time for a hit\n");
  float L1_inst_cache_time = (float) (L1_inst_cache->timer_read + L1_inst_cache->timer_write + L1_inst_cache->timer_fetch) / 1000;
  printf("L1 inst cache time: %f\n", L1_inst_cache_time);

  // printf("L1 data read time: %f\n", L1_data_cache->timer_read);
  // printf("L1 data write time: %f\n", L1_data_cache->timer_write);
  // printf("L1 data fetch time: %f\n", L1_data_cache->timer_fetch);

  float L1_data_cache_time = (float) (L1_data_cache->timer_read + L1_data_cache->timer_write + L1_data_cache->timer_fetch) /1000;
  printf("L1 data cache time: %f\n", L1_data_cache_time);

  float L2_unif_cache_time = (float) (L2_unif_cache->timer_read + L2_unif_cache->timer_write + L2_unif_cache->timer_fetch) / 1000;
  printf("L2 unif cache time: %f\n\n", L2_unif_cache_time);

  printf("AMAT\n");
  int miss_penalty1 = 20;
  int miss_penalty2 = 50;

  float L1_inst_miss_rate = 100 - L1_inst_hit;
  printf("L1 inst miss rate: %f\n", L1_inst_miss_rate);
  
  float L1_data_miss_rate = 100 - L1_data_hit;
  printf("L1 data miss rate: %f\n", L1_data_miss_rate);
  
  float L2_unif_miss_rate = 100 - L2_unif_hit;
  printf("L2 unif miss rate: %f\n\n", L2_unif_miss_rate);

  float L1_inst_amat = (float) L1_inst_cache->clock_cycles* 5  + (((100 - L1_inst_hit) / instr_count) * miss_penalty1);
  printf("L1 inst AMAT cycles: %f\n", L1_inst_amat);
  float L1_inst_amat_ratio = (float) L1_inst_amat / instr_count;
  printf("L1 inst AMAT ratio: %f\n\n", L1_inst_amat_ratio);

  float L1_data_amat = (float) L1_data_cache->clock_cycles * 5  + (((100 - L1_data_hit) / instr_count) * miss_penalty1);
  printf("L1 data AMAT cycles: %f\n", L1_data_amat);
  float L1_data_amat_ratio = (float) L1_data_amat / instr_count;
  printf("L1 data AMAT ratio: %f\n\n", L1_data_amat_ratio);
  
  float L2_unif_amat = (float) L2_unif_cache->clock_cycles * 50 + (((100 - L2_unif_hit) / instr_count) * miss_penalty2);
  printf("L2 unif AMAT cycles: %f\n", L2_unif_amat);
  float L2_unif_amat_ratio = (float) L2_unif_amat / instr_count;
  printf("L2 unif AMAT ratio: %f\n\n", L2_unif_amat_ratio);



  float L1_inst_amat2 = (float) L1_inst_cache_time + (((100 - L1_inst_hit) / instr_count) * miss_penalty1);
  printf("L1 inst AMAT: %f\n", L1_inst_amat2);

  float L1_data_amat2 = (float) L1_data_cache_time + (((100 - L1_data_hit) / instr_count) * miss_penalty1);
  printf("L1 data AMAT: %f\n", L1_data_amat2);
  
  float L2_unif_amat2 = (float) L2_unif_cache_time  + (((100 - L2_unif_hit) / instr_count) * miss_penalty2);
  printf("L2 unif AMAT: %f\n\n", L2_unif_amat2);

  float total_amat = (float) (L1_data_amat + L1_inst_amat + L2_unif_amat) / instr_count;
  printf("Total AMAT: %f\n", total_amat);

  
  printf("Hit total ratio: %f\n", (float)hit_ratio_total);
  float total_amat2 = (float) (L1_data_amat2 + L1_inst_amat2 + L2_unif_amat2);
  printf("Total AMAT time: %f\n\n", total_amat2);

  clear_cache(L1_data_cache);
  clear_cache(L1_inst_cache);
  clear_cache(L2_unif_cache);


  
  /* Deinitialize memory subsystem here */
}

void clear_cache(cache_c *cache)
{
  for (int i = 0; i<cache->set_number; i++)
  {
    for (int q = 0; q<cache->assoc; q++)
      free (cache->set[i]->block[q]);     //clear block
    free(cache->set[i]);
  }
  free(cache);

}

unsigned int my_log2(unsigned int y)
{
  unsigned int x = 0;
  while (y>>=1)
  {
    x++;
  }
  return x;

}

unsigned int address_bitstring(cache_c *cache, unsigned int address, char *command)
{
  int bits_offset;
  int bits_index;
  int none_tag;

  bits_index = my_log2(cache->set_number);
  bits_offset = my_log2(cache->block_size);

  none_tag = (bits_offset + bits_index);

  unsigned int tag, index, offset;
  tag = address >> none_tag;                // bitshift right address with bits offset + index to find tag
  index = address - (tag << none_tag);      // leftshift to get 32 bits
  index = index >> bits_offset;             // bitshift offset to find index

  offset = address - (tag << none_tag) - (index << bits_offset);

  // printf ("None tag: %d\n", none_tag);
  // printf ("Tag: %d\n", tag);
  // printf ("Bits index: %d\n", bits_index);
  // printf ("Index: %d\n", index);
  // printf ("Offset: %d\n", offset);

  if (strcmp(command, "tag") == 0)
  {
    return tag;
  }
  if (strcmp(command, "index") == 0)
  {
    return index;
  }
  
  return 0;

}



//sudo snap install valgrind