/* file: echocli.c

   Bare-bones TCP client with commmand-line argument to specify
   port number to use to connect to server.  Server hostname is
   specified by environment variable "SERVERHOST".

   This started out with an example in W. Richard Stevens' book
   "Advanced Programming in the Unix Environment".  I have
   modified it quite a bit, including changes to make use of my
   own re-entrant version of functions in echolib.
   
   Ted Baker
   February 2015

 */

#include "config.h"
#include "echolib.h"
#include "checks.h"
#include <sys/time.h>
#include <stdlib.h>
#include <time.h>

#define MAX_NUM 1000
int iteration = 100000;
int N=50, port;
/* the main service loop of the client; assumes sockfd is a
   connected socket */
void
client_work (int sockfd) {
  connection_t conn;
  connection_init (&conn);
  conn.sockfd = sockfd;

  for(int i=0;i<iteration;i++) {
    int ACK=0;
    int * input_arr = malloc(sizeof(int)*N);
    int * output_arr = malloc(sizeof(int)*N);
    for(int i=0;i<N;i++) input_arr[i] = rand()%MAX_NUM;

    printf("generated :");
    for(int i=0;i<N;i++) printf("%d ", input_arr[i]);
    printf("\n");

    if (write(sockfd, (void*)&N, sizeof(int)) <=0) goto quit;
    if (shutting_down) goto quit;
    
    if (read (sockfd, (void*)&ACK, sizeof(int)) <=0) goto quit;
    if (shutting_down) goto quit;

    if (write(sockfd, (void*)input_arr, sizeof(int) * N ) <=0) goto quit;
    if (shutting_down) goto quit;

    if (read (sockfd, (void*)output_arr, sizeof(int) * N ) <=0) goto quit;
    if (shutting_down) goto quit;

    printf("received : ");
    for(int j=0;j<N;j++){
      printf("%d ", output_arr[j]);
    }
    printf("\n\n");
    free(input_arr);
    free(output_arr);
  }

  quit:
    CHECK (close (conn.sockfd));
}

/* fetch server port number from main program argument list */
int
get_server_port (int argc, char **argv) {
  int val;
  char * endptr;
  // if (argc != 2) goto fail;
  errno = 0;
  val = (int) strtol (argv [1], &endptr, 10);
  // if (*endptr) goto fail;
  printf("val : %d\n", val);
  if ((val < 0) || (val > 0xffff)) goto fail;
#ifdef DEBUG
  fprintf (stderr, "port number = %d\n", val);
#endif
  return val;
fail:
   fprintf (stderr, "usage: echosrv [port number]\n");
   exit (-1);
}

/* set up IP address of host, using DNS lookup based on SERVERHOST
   environment variable, and port number provided in main program
   argument list. */
void
set_server_address (struct sockaddr_in *servaddr, int argc, char **argv) {
  struct hostent *hosts;
  char *server;
  // const int server_port = get_server_port (argc, argv);
  const int server_port = port;
  if ( !(server = getenv ("SERVERHOST"))) {
    QUIT ("usage: SERVERHOST undefined.  Set it to name of server host, and export it.");
  }
  memset (servaddr, 0, sizeof(struct sockaddr_in));
  servaddr->sin_family = AF_INET;
  servaddr->sin_port = htons (server_port);
  if ( !(hosts = gethostbyname (server))) {
    ERR_QUIT ("usage: gethostbyname call failed");
  }
  servaddr->sin_addr = *(struct in_addr *) (hosts->h_addr_list[0]);
}

int
main (int argc, char **argv) {
   int sockfd;
   struct sockaddr_in servaddr;
   struct timeval start, stop;

    char * endptr;
   int param_opt;
   port = (int)strtol(argv[1], &endptr, 10);
    while(-1 !=(param_opt = getopt(argc, argv, "n:"))){
		switch(param_opt){
			//case 'k' : accpetorThreadSzie = atoi(optarg);
      case 'n' : N = atoi(optarg);
		}
	}

  //  srand((unsigned int)time(NULL));
   /* time how long we have to wait for a connection */
   CHECK (gettimeofday (&start, NULL));
   set_server_address (&servaddr, argc, argv);
   if ( (sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0){
    ERR_QUIT ("usage: socket call failed");
   }
   CHECK (connect(sockfd, (struct sockaddr *) &servaddr, sizeof(servaddr)));
   CHECK (gettimeofday (&stop, NULL));
   fprintf (stderr, "connection wait time = %ld microseconds\n",
            (stop.tv_sec - start.tv_sec)*1000000 + (stop.tv_usec - start.tv_usec));

   CHECK (gettimeofday (&start, NULL));
   client_work (sockfd);
   CHECK (gettimeofday (&stop, NULL));
   printf ("N : %d, iter : %d, client work time = %ld ms\n", N, iteration,
            ((stop.tv_sec - start.tv_sec)*1000000 + (stop.tv_usec - start.tv_usec))/1000);
   exit (0);
}
