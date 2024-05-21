#include <linux/kernel.h>
#include <linux/syscalls.h>
//#include <asm/uaccess.h>
SYSCALL_DEFINE2(my_syscall, int *, uarr, int, NSIZE)
{
	int * arr = kmalloc(sizeof(int) * NSIZE, GFP_KERNEL);
	int result = copy_from_user(arr, uarr, sizeof(int) * NSIZE);

    int prime_count;
	prime_count = 0;
    int i;
	int j;
    for(i=0;i<NSIZE;i++){
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

	kfree(arr);
    return prime_count;
}

