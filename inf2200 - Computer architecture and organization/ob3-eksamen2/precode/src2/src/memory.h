/** @file memory.h
 *  @brief Public API of memory hierarchy.
 *  @see memory.c
 */

#ifndef MEMORY_H
#define MEMORY_H

/* data_t can be any 32-bit type, such as (unsigned long), (void *) or size_t
 * (on 32-bit x86).
 */

struct block;
typedef struct block block_c;

struct set;
typedef struct set set_c;

struct cache;
typedef struct cache cache_c;


typedef unsigned long data_t;

/*
* Initialize block 
*/
block_c *make_block(int block_size);

/*
* Initialize set 
*/
set_c *make_set(int set_number, int assoc, int block_size);

/*
* Initialize cache 
*/
cache_c *create_cache(int cache_size, int block_size, int assoc, char *name);

/** Initialize memory hierarchy.
 */
void memory_init(int cache_size1, int block_size1, int assoc1, int cache_size2, int block_size2, int assoc2, int cache_size3, int block_size3, int assoc3);

/** Fetch instruction at given memory address.
 *
 *  @param[in] address Memory address of instruction.
 *  @param[out] data Instruction data returned by reference.
 */
void memory_fetch(unsigned int address, data_t *data);

/** Read data from memory at given memory address.
 *
 *  @param[in] address Memory address to read from.
 *  @param[out] data Memory data returned by reference.
 */
void memory_read(unsigned int address, data_t *data);

/** Write to memory at given memory address.
 *
 *  @param[in] address Memory address to write to.
 *  @param[in] data Data to write to memory.
 */
void memory_write(unsigned int address, data_t *data);



/*
*
*   write to cache
*
*/
int cache_write(unsigned int address, cache_c *cache);

/*
*
*   read from cache
*
*/
int cache_read(unsigned int address, cache_c *cache);
/*
 *  Fetch from cache.
 */
int cache_fetch(unsigned int address, cache_c *cache);

/** Clean up and deinitialize memory hierarchy.
 */
void memory_finish (void);

void clear_cache(cache_c *cache);

/*
 *  Function to take log2 of input integer.
 */
unsigned int my_log2(unsigned int y);

/*
 *  Returns index and tag (bits) of input address.
 */
unsigned int address_bitstring(cache_c *cache, unsigned int address, char *command);

#endif
