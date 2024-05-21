obj-m := my_cdev.o
# obj-m += lkp2.o # add multiple files if necessary
CONFIG_MODULE_SIG=n
KDIR := ../../src/linux-5.15.4/
# KDIR := /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)
all: my_cdev.c
	make -C $(KDIR) M=$(PWD) modules
clean:
	make -C $(KDIR) M=$(PWD) clean