#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>  
#include <sys/time.h>

int OPTION;
double TIME;

struct timeval  tv1, tv2;

// Declaring that assembly function is provided elsewhere
extern void asm_function();

// Merges two subarrays of arr[].
// First subarray is arr[l..m]
// Second subarray is arr[m+1..r]
// This is the C equivalent to the assembly implementation
void c_function(int n1, int n2, int L[], int R[], int arr[], int l)
{
    int i = 0; 
    int j = 0; 
    int k = l; 

    while (i < n1 && j < n2) 
    {
        if (L[i] <= R[j]) {
            arr[k] = L[i];
            i++;
        }
        else {
            arr[k] = R[j];
            j++;
        }
        k++;
    }

    /* Copy the remaining elements of L[], if there
    are any */
    while (i < n1) {
        arr[k] = L[i];
        i++;
        k++;
    }
 
    /* Copy the remaining elements of R[], if there
    are any */
    while (j < n2) {
        arr[k] = R[j];
        j++;
        k++;
    }
}

//Sort and merge array
void merge(int arr[], int l, int m, int r)
{
    int i, j;
    int n1 = m - l + 1;
    int n2 = r - m;
 
    /* create temp arrays */
    int L[n1], R[n2];
 
    /* Copy data to temp arrays L[] and R[] */
    for (i = 0; i < n1; i++)
        L[i] = arr[l + i];
    for (j = 0; j < n2; j++)
        R[j] = arr[m + 1 + j];

    gettimeofday(&tv1, NULL);

    if (OPTION == 1)
        asm_function(n1, n2, L, R, arr, l);

    else if (OPTION == 2)
        c_function(n1, n2, L, R, arr, l);

    gettimeofday(&tv2, NULL);
    TIME += ((double) (tv2.tv_usec - tv1.tv_usec) / 1000000 + (double) (tv2.tv_sec - tv1.tv_sec));
}
 
/* l is for left index and r is right index of the
sub-array of arr to be sorted */
void mergeSort(int arr[], int l, int r)
{
    if (l < r) {
        // Same as (l+r)/2, but avoids overflow for
        // large l and h
        int m = l + (r - l) / 2;
 
        // Sort first and second halves
        mergeSort(arr, l, m);
        mergeSort(arr, m + 1, r);
 
        merge(arr, l, m, r);
    }
}
 
/* UTILITY FUNCTIONS */
/* Function to print an array */
void printArray(int A[], int size)
{
    int i;
    for (i = 0; i < size; i++)
        printf("%d ", A[i]);
    printf("\n");
}

/*Function to create an array*/
void CreateArray(int arr[], int size){
    for (int i= 0; i < size ; i++)
    {
        arr[i] = rand() % 2000000;
    }
}
 
/* Driver code */
int main(int argc, char **argv)
{
    if (argc != 2)
    {
        printf("Usage: %s assembly or %s c\n", argv[0], argv[0]);
        return 1;
    }

    char *assembly = "assembly";
    char *c = "c";

    char *split = argv[1];

    if (!strcmp(split, assembly))
        OPTION = 1;

    else if (!strcmp(split, c))
        OPTION = 2;

    else {
        printf("No valid option picked!\n");
        return 1;
    }

    //Array size and empty array
    int n = 1000000;
    int arr[n];
    int x = 5;
    while (x != 0){

    //Create and print the array
    printf("Given array is \n");
    CreateArray(arr, n);
    printArray(arr, n);
    
    //Sort the array then print it
    mergeSort(arr, 0, n - 1);

    printf("\n\nSorted array is \n");
    printArray(arr, n);
    x--;
    }
    printf("%lf\n", TIME);
    return 0;
}