/*
 * Deferred Work
 *
 * Exercise #1, #2: simple timer
 */

#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/sched.h>

MODULE_DESCRIPTION("Simple kernel timer");
MODULE_AUTHOR("SCE394");
MODULE_LICENSE("GPL");

#define TIMER_TIMEOUT	1
unsigned long seconds = 1;

static struct timer_list timer;

static void timer_handler(struct timer_list *tl)
{
	/* TODO 1: print a message(printk or pr_info) */
	printk(KERN_INFO "This is TODO 1 complete message!");

	/* TODO 2: rechedule timer */
	mod_timer(&timer, jiffies + seconds * HZ);
}	

static int __init timer_init(void)
{

	pr_info("[timer_init] Init module\n");

	/* TODO 1: initialize timer */
	timer_setup(&timer, timer_handler, 0);

	/* TODO 1: schedule timer for the first time */
	mod_timer(&timer, jiffies + seconds * HZ);

	return 0;
}

static void __exit timer_exit(void)
{
	pr_info("[timer_exit] Exit module\n");

	/* TODO 1: cleanup; make sure the timer is not running after we exit */
	del_timer_sync(&timer);
}

module_init(timer_init);
module_exit(timer_exit);
