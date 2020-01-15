
// 1000000000  (2)

// cyclic str queue
#define MAX_QUEUE_SIZE		500

#define MAX_STR_LEN			6999//1999//499	// give a bound

#define MUTEX	1

//  111111111  (2)
// #define MAX_MASK		1023
#include <mutex>

typedef struct queue_struct
{
    char *queue[MAX_QUEUE_SIZE];
    
    unsigned int tail;
    unsigned int head;
    
    std::condition_variable cond;
    std::mutex condmutex;
    std::mutex mutexlock;
} QUEUE_T;


int str_queue_init(QUEUE_T *pq);

// add the str to the string queue, when
// if str == NULL, it is not added, return -3
// if queue is full, str is not added, return -2
// other error return -1
// the str is duplicated using strdup
// normal: return 0
int str_queue_add(QUEUE_T *pq, const char *str);

// return NULL if there is nothing to
// return the str in head and remove this str from queue
// caller MUST free the return pointer!!
char * str_queue_get(QUEUE_T *pq);
// caller can modify the str up to its original len

// empty the queue and free all memory inside the queue
int str_queue_clean(QUEUE_T *pq);

// read-only print
int str_queue_print(QUEUE_T *pq);

// condition timed wait and signal pair
int str_queue_add_signal(QUEUE_T *pq, const char * str);
char * str_queue_get_wait(QUEUE_T *pq);

