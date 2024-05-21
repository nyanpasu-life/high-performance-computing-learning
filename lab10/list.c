/*
 * list.c - Linux kernel list API
 *
 * TODO 1/0: Fill in name / email
 * Author: Han TeaHui <xotpqnd@ajou.ac.kr>
 */
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/slab.h>
#include <linux/list.h>
#include <linux/proc_fs.h>
#include <linux/seq_file.h>
#include <linux/uaccess.h>
#include <linux/string.h>

#define PROCFS_MAX_SIZE		1024

#define procfs_dir_name		"list"
#define procfs_file_read	"preview"
#define procfs_file_write	"management"

#define ADDF 1
#define ADDE 2
#define DELF 3
#define DELA 4

struct proc_dir_entry *proc_list;
struct proc_dir_entry *proc_list_read;
struct proc_dir_entry *proc_list_write;

const int sizeofchar = sizeof(char);

/* TODO 2/0: define your list! */
struct name_list {
	char * name;
	struct list_head list;
};

LIST_HEAD(my_list);

/*
static void simnle_gets(char * str){
	char * pointer;
	pointer = str;

	while(*pointer != '\n' && *pointer != '\0'){
		pointer = pointer + sizeofchar;
	}
	*pointer = '\0';
}
*/

static void addf_name(char * name)
{
	struct name_list *nle = kmalloc(sizeof *nle, GFP_KERNEL);\
	nle->name = kmalloc(sizeof(char) * strlen(name), GFP_KERNEL);
	strcpy(nle->name, name);
	list_add(&nle->list, &my_list);

}

static void adde_name(char * name)
{
	struct name_list *nle = kmalloc(sizeof *nle, GFP_KERNEL);\
	nle->name = kmalloc(sizeof(char) * strlen(name), GFP_KERNEL);
	strcpy(nle->name, name);
	list_add_tail(&nle->list, &my_list);

}

static int delf_name(char * name)
{
	struct list_head *i, *tmp;
	struct name_list *nle;

	list_for_each_safe(i, tmp, &my_list) {
		nle = list_entry(i, struct name_list, list);
		if (strcmp(nle->name,name) == 0) {
			list_del(i);
			kfree(nle->name);
			kfree(nle);
			return 0;
		}
	}

	return -EINVAL;
}

static int dela_name(char * name)
{
	struct list_head *i, *tmp;
	struct name_list *nle;

	list_for_each_safe(i, tmp, &my_list) {
		nle = list_entry(i, struct name_list, list);
		if (strcmp(nle->name,name) == 0) {
			list_del(i);
			kfree(nle->name);
			kfree(nle);
		}
	}

	return 0;
}


static int list_proc_show(struct seq_file *m, void *v)
{
	/* TODO 3/0: print your list. One element / line. */
	//seq_puts(m, "Remove this line\n");
	struct name_list *entry;

	list_for_each_entry(entry, &my_list, list) {
		seq_puts(m, entry->name);
	}

	return 0;
}

static int list_read_open(struct inode *inode, struct  file *file)
{
	return single_open(file, list_proc_show, NULL);
}

static int list_write_open(struct inode *inode, struct  file *file)
{
	return single_open(file, list_proc_show, NULL);
}

static ssize_t list_write(struct file *file, const char __user *buffer,
			  size_t count, loff_t *offs)
{
	char local_buffer[PROCFS_MAX_SIZE];
	unsigned long local_buffer_size = 0;
	char * ptr =NULL;
	char * tmp;
	int word_count = 0;

	int inst=0;
	char * name;

	local_buffer_size = count;
	if (local_buffer_size > PROCFS_MAX_SIZE)
		local_buffer_size = PROCFS_MAX_SIZE;

	memset(local_buffer, 0, PROCFS_MAX_SIZE);
	if (copy_from_user(local_buffer, buffer, local_buffer_size))
		return -EFAULT;

	/* local_buffer contains your command written in /proc/list/management
	 * TODO 4/0: parse the command and add/delete elements.
	 */

	// parsing local_buffer
	tmp = local_buffer;
	while((ptr = strsep(&tmp, " ")) != NULL) {
		if(word_count ==0){
			//printk(KERN_INFO "word1: %s\n", ptr);
			if(strcmp(ptr,"addf") == 0){ inst = ADDF;   }
			else if(strcmp(ptr,"adde") == 0) { inst =ADDE; }
			else if(strcmp(ptr,"delf") == 0) { inst =DELF; }
			else if(strcmp(ptr,"dela") == 0) { inst =DELA; }
		}
		else if(word_count ==1){
			//simnle_gets(ptr);
			name = ptr;
		}
		word_count ++;
	}

	//printk(KERN_INFO "inst: %d   name:%s\n", inst, name);

	switch(inst){
		case ADDF:
			addf_name(name);
			break;

		case ADDE:
			adde_name(name);
			break;

		case DELF:
			delf_name(name);
			break;

		case DELA:
			dela_name(name);
			break;

	}

	return local_buffer_size;
}

static const struct proc_ops r_pos = {
	//.owner		= THIS_MODULE,
	.proc_open		= list_read_open,
	.proc_read		= seq_read,
	.proc_release		= single_release,
};

static const struct proc_ops w_pos = {
	//.owner		= THIS_MODULE,
	.proc_open		= list_write_open,
	.proc_write		= list_write,
	.proc_release		= single_release,
};

static int list_init(void)
{
	proc_list = proc_mkdir(procfs_dir_name, NULL);
	if (!proc_list)
		return -ENOMEM;

	proc_list_read = proc_create(procfs_file_read, 0000, proc_list,
				     &r_pos);
	if (!proc_list_read)
		goto proc_list_cleanup;

	proc_list_write = proc_create(procfs_file_write, 0000, proc_list,
				      &w_pos);
	if (!proc_list_write)
		goto proc_list_read_cleanup;

	return 0;

proc_list_read_cleanup:
	proc_remove(proc_list_read);
proc_list_cleanup:
	proc_remove(proc_list);
	return -ENOMEM;
}

static void list_exit(void)
{
	proc_remove(proc_list);
}

module_init(list_init);
module_exit(list_exit);

MODULE_DESCRIPTION("Linux kernel list API");
/* TODO 5/0: Fill in your name / email address */
MODULE_AUTHOR("FirstName LastName <your@email.com");
MODULE_LICENSE("GPL v2");
