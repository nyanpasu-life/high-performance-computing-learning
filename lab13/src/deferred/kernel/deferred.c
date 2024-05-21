/*
 * SCE394 - Lab 13 - Deferred Work
 *
 * Exercises #3, #4, #5: deferred work
 *
 * Code skeleton.
 */

#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/fs.h>
#include <linux/cdev.h>
#include <linux/sched.h>
#include <linux/slab.h>
#include <linux/uaccess.h>
#include <linux/sched/task.h>
#include "../include/deferred.h"

#define MY_MAJOR		42
#define MY_MINOR		0
#define MODULE_NAME		"deferred"

#define TIMER_TYPE_NONE		-1
#define TIMER_TYPE_SET		0
#define TIMER_TYPE_ALLOC	1
#define TIMER_TYPE_MON		2

MODULE_DESCRIPTION("Deferred work character device");
MODULE_AUTHOR("SCE394");
MODULE_LICENSE("GPL");

unsigned long seconds = 1;

struct mon_proc {
	struct task_struct *task;
	struct list_head list;
};

static struct my_device_data {
	struct cdev cdev;
	/* TODO 1: add timer */
	struct timer_list timer;

	/* TODO 2: add flag */
	int timer_type_flag;

	/* TODO 3: add work */
	struct workqueue_struct * my_workqueue;

	/* TODO 4: add list for monitored processes */
	struct list_head process_list;
	//INIT_LIST_HEAD(dev.process_list);

	/* TODO 4: add spinlock to protect list */
	spinlock_t Llock;
} dev;

static void alloc_io(void)
{
	set_current_state(TASK_INTERRUPTIBLE);
	schedule_timeout(5 * HZ);
	pr_info("Yawn! I've been sleeping for 5 seconds.\n");
}

static struct mon_proc *get_proc(pid_t pid)
{
	struct task_struct *task;
	struct mon_proc *p;

	rcu_read_lock();
	task = pid_task(find_vpid(pid), PIDTYPE_PID);
	rcu_read_unlock();
	if (!task)
		return ERR_PTR(-ESRCH);

	p = kmalloc(sizeof(*p), GFP_ATOMIC);
	if (!p)
		return ERR_PTR(-ENOMEM);

	get_task_struct(task);
	p->task = task;

	return p;
}


/* TODO 3: define work handler for alloc_io() */
void my_work_handler(struct work_struct * work){
	alloc_io();
}
struct work_struct my_work;
DECLARE_WORK(my_work, my_work_handler);

//#define ALLOC_IO_DIRECT
/* TODO 3: undef ALLOC_IO_DIRECT*/

static void timer_handler(struct timer_list *tl)
{
	/* TODO 1: implement timer handler */
	
	/* TODO 2: check flags: TIMER_TYPE_SET or TIMER_TYPE_ALLOC */
	if(dev.timer_type_flag==TIMER_TYPE_SET){
		pr_info("TIMER_TYPE_SET Handler is activated.\n");
	}
	else if(dev.timer_type_flag==TIMER_TYPE_ALLOC){
		//alloc_io(); //TODO 2 : 이 코드는 에러를 발생시킵니다.
		
		/* TODO 3: schedule work */
		queue_work(dev.my_workqueue, &my_work);
	}
	else if(dev.timer_type_flag==TIMER_TYPE_MON){
		struct list_head *i, *tmp;
		struct mon_proc *mp;
		/* TODO 4: iterate the list and check the proccess state */

		spin_lock (&dev.Llock);
		list_for_each_safe(i, tmp, &dev.process_list) {
			mp = list_entry(i, struct mon_proc, list);
			/* TODO 4: if task is dead print info ... */
			//if ((mp->task->__state | EXIT_DEAD) & (mp->task->__state | TASK_DEAD)) {
			if ((mp->task->__state == 128)) {
				printk(KERN_INFO "monitored task pid:%d is dead!!!\n", mp->task->pid);
				/* TODO 4: ... remove it from the list ... */
				list_del(i);
				/* TODO 4: ... free the struct mon_proc */
				kfree(mp);
			}
		}
		spin_unlock (&dev.Llock);
		mod_timer(&dev.timer, jiffies + seconds * HZ);
	}
}

static int deferred_open(struct inode *inode, struct file *file)
{
	struct my_device_data *my_data =
		container_of(inode->i_cdev, struct my_device_data, cdev);
	file->private_data = my_data;
	pr_info("[deferred_open] Device opened\n");
	return 0;
}

static int deferred_release(struct inode *inode, struct file *file)
{
	pr_info("[deferred_release] Device released\n");
	return 0;
}

static long deferred_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
{
	struct my_device_data *my_data = (struct my_device_data*) file->private_data;
	unsigned long flags;

	pr_info("[deferred_ioctl] Command: %s\n", ioctl_command_to_string(cmd));

	switch (cmd) {
		case MY_IOCTL_TIMER_SET:
			/* TODO 2: set flag */
			my_data->timer_type_flag=TIMER_TYPE_SET;
			
			/* TODO 1: schedule timer */
			seconds = arg;
			mod_timer(&(my_data->timer), jiffies + seconds * HZ);

			break;
		case MY_IOCTL_TIMER_CANCEL:
			/* TODO 1: cancel timer */
			del_timer_sync(&(my_data->timer)); //임시
			break;
		case MY_IOCTL_TIMER_ALLOC: // invoke alloc_io()
			/* TODO 2: set flag and schedule timer */
			my_data->timer_type_flag=TIMER_TYPE_ALLOC;
			seconds = arg;
			mod_timer(&(my_data->timer), jiffies + seconds * HZ);
			break;
		case MY_IOCTL_TIMER_MON:
		{
			/* TODO 4: use get_proc() and add task to list */
			/* TODO 4: protect access to list */
			pid_t pid = (pid_t) arg;
			struct mon_proc * mp = get_proc(pid);
			spin_lock_irqsave (&my_data->Llock, flags);
			list_add(&(mp->list), &(my_data->process_list));
			spin_unlock_irqrestore(&my_data->Llock, flags);

			/* TODO 4: set flag and schedule timer */
			my_data->timer_type_flag=TIMER_TYPE_MON;
			mod_timer(&(my_data->timer), jiffies + seconds * HZ);

			break;
		}
		default:
			return -ENOTTY;
	}
	return 0;
}

struct file_operations my_fops = {
	.owner = THIS_MODULE,
	.open = deferred_open,
	.release = deferred_release,
	.unlocked_ioctl = deferred_ioctl,
};

static int deferred_init(void)
{
	int err;

	pr_info("[deferred_init] Init module\n");
	err = register_chrdev_region(MKDEV(MY_MAJOR, MY_MINOR), 1, MODULE_NAME);
	if (err) {
		pr_info("[deffered_init] register_chrdev_region: %d\n", err);
		return err;
	}

	/* TODO 2: Initialize flag. */
	dev.timer_type_flag=TIMER_TYPE_NONE;

	/* TODO 3: Initialize work. */
	dev.my_workqueue = create_workqueue("my_workqueue");
	INIT_WORK(&my_work, my_work_handler);


	/* TODO 4: Initialize lock and list. */
	INIT_LIST_HEAD(&(dev.process_list));
	spin_lock_init(&dev.Llock);

	cdev_init(&dev.cdev, &my_fops);
	cdev_add(&dev.cdev, MKDEV(MY_MAJOR, MY_MINOR), 1);

	/* TODO 1: Initialize timer. */
	timer_setup(&(dev.timer), timer_handler, 0);


	return 0;
}

static void deferred_exit(void)
{
	struct mon_proc *p, *n;

	pr_info("[deferred_exit] Exit module\n" );

	cdev_del(&dev.cdev);
	unregister_chrdev_region(MKDEV(MY_MAJOR, MY_MINOR), 1);

	/* TODO 1: Cleanup: make sure the timer is not running after exiting. */
	del_timer_sync(&(dev.timer));

	/* TODO 3: Cleanup: make sure the work handler is not scheduled. */
	flush_workqueue(dev.my_workqueue);
	destroy_workqueue(dev.my_workqueue);


	/* TODO 4: Cleanup the monitered process list */
		/* TODO 4: ... decrement task usage counter ... */
		/* TODO 4: ... remove it from the list ... */
		/* TODO 4: ... free the struct mon_proc */
}

module_init(deferred_init);
module_exit(deferred_exit);
