obj-m := prime_module.o
# obj-m += lkp2.o # add multiple files if necessary
CONFIG_MODULE_SIG=n
KDIR := ../../src/linux-5.15.4/
# KDIR := /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)

module: prime_module.c  # active this in host OS.
	make -C $(KDIR) M=$(PWD) modules

exe: prime_user prime_sys # active this in Virtual Enviroment.
	gcc -o prime_user prime_user.c
	gcc -o prime_sys prime_sys.c

clean: 
	make -C $(KDIR) M=$(PWD) clean ; rm prime_user prime_sys