#include <linux/module.h> /* Needed by all modules */
#include <linux/kernel.h> /* KERN_INFO */
#include <linux/init.h> /* Init and exit macros */

#include <linux/random.h>
#include <linux/slab.h>
#include <linux/ktime.h>

#define MAX_NUM 100000

static int n = 1;
//static char *string_param = "default value";

module_param(n, int, 0);
MODULE_PARM_DESC(n, "A sample integer kernel module parameter");
//module_param(string_param, charp, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH); 
//MODULE_PARM_DESC(string_param, "Another parameter, a string");

void array_init_rand(int * matrix, int size){
    int i;
    int temprand;

    //get_random_bytes(matrix, sizeof(int) * size);  
	for(i=0;i<size;i++){
        get_random_bytes(&temprand, sizeof(int));
        matrix[i] = temprand % (MAX_NUM-1) + 2;
	}
}

static int __init lkp_init(void)
{
    int * arr;
    ktime_t start;
    ktime_t end;
    ktime_t diffTime;
    //struct timeval start;
    //struct timeval end;
    //double diffTime;
    int prime_count;
    int i;
	int j;

    printk(KERN_INFO "Int param: %d\n", n);

    arr = kmalloc(sizeof(int)*n, GFP_KERNEL);
    array_init_rand(arr, n);


    //gettimeofday(&start, NULL); //-----------------------------
    start = ktime_get_real();
	prime_count = 0;
    for(i=0;i<n;i++){
        int isPrime=1;
        int n = arr[i];
        for(j = 2; j*j < n; j++){
            if(n % j == 0){
                isPrime =0;
                break;
            }
        }
        if(isPrime) prime_count ++;
    }
    end = ktime_get_real();
    //gettimeofday(&end, NULL); //-----------------------------

    printk(KERN_INFO "The number of total random numbers: %d\n", n);
    printk(KERN_INFO "The number of Prime number %d\n", prime_count);
    
    diffTime = (end - start) / 1000;
    printk(KERN_INFO "Processing time: %lld usec \n", diffTime);

    //diffTime = ( end.tv_sec - start.tv_sec ) +(( end.tv_usec - start.tv_usec ));
    //printk(KERN_INFO "Processing time: %.0lf\n", diffTime);

    kfree(arr);
    return 0; /* return 0 on success, something else on error */
}


static void __exit lkp_exit(void)
{
    printk(KERN_INFO "Module exiting ...\n");
}
module_init(lkp_init); /* lkp_init() will be called at loading the module */
module_exit(lkp_exit); /* lkp_exit() will be called at unloading the module */
MODULE_LICENSE("GPL"); 