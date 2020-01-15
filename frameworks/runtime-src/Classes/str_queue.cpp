#include "cocos2d.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)

#else
#include <unistd.h>
#endif
#include <thread>
#include <assert.h>

extern "C"
{
    
#include "str_queue.h"
    
    
    /**
     *
     * it is a cyclic queue, when init, all queue[x] are NULL.
     * We do not allow NULL to be added to the queue.
     * queue_tail is the only marker of where the next add will
     * be placed, when placed a new control, the queue[queue_tail] position
     * will be freed (if not NULL).
     */
    //static char *g_queue[MAX_QUEUE_SIZE];
    //
    //
    //unsigned int g_tail = 0;
    //unsigned int g_head = 0;
    //
    ///** #ifdef USE_MUTEX **/
    //pthread_mutex_t	g_mutex;
    
    
    /**
     * we must call queue_init before the first time usage of the queue
     */
    int str_queue_init(QUEUE_T *pq)
    {
        int i;
//        int rc;
        for (i=0; i<MAX_QUEUE_SIZE; i++) {
            pq->queue[i] = NULL;
        }
        
        pq->tail = 0;
        pq->head = 0;
        
#ifdef MUTEX
//        rc = pthread_mutex_init(&(pq->mutexlock), NULL);
//        if (rc < 0) {
//            printf("ERROR: str_queue_init mutex init %d\n", rc);
//            return rc;
//        }
//        rc = pthread_cond_init(&(pq->cond), NULL);
//        if (rc < 0) {
//            printf("FATAL: str_queue_init cond init %d\n", rc);
//            return rc;
//        }
#endif
        return 0;
    }
    
    
    /**
     * first remove the old_control from queue_tail position,
     * and free it, then add the new_control to queue_tail,
     * after that update the queue_tail position (+1 cyclic).
     *
     * it is not thread-safe, need lock to avoid re-entrance.
     */
    int str_queue_add(QUEUE_T *pq, const char * str)
    {
        int tail;
        if (str==NULL) {
            printf("ERROR null string\n");
            return -3; // null pointer error
        }
        // this is arguable, can empty string be accepted?
        if (str[0]==0) {
            printf("ERROR empty string\n");
            return -6;  // empty string not accepted
        }
        if (pq->head == ((pq->tail+1) % MAX_QUEUE_SIZE)) {
            printf("ERROR queue full!!! head %d  tail %d\n", pq->head, pq->tail);
            return -2;
        }
        
        /** critical section START **/
        char *sss;
        char *should_null;
        //    printf("C:  before strndup: [%s]\n", str);
        //sss = strndup(str, MAX_STR_LEN);
#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
        sss = _strdup(str);
#else
        sss = strdup(str);
#endif
        //    printf("C:  after strndup: [%s]\n", sss);
        
        
#ifdef	MUTEX
        pq->mutexlock.lock();
#endif
        //////////////
        tail = pq->tail;
        pq->tail = (pq->tail + 1) % MAX_QUEUE_SIZE;
        should_null = pq->queue[tail];
        pq->queue[tail] = sss;
        //////////////
#ifdef	MUTEX
        pq->mutexlock.unlock();
#endif
        
        if (tail < 0 || tail >= MAX_QUEUE_SIZE) {
            printf("BUG tail = %d\n", tail);
            return -17;
        }
        // TODO report error if exceed MAX_STR_LEN
        if (should_null!=NULL) {
            printf("BUG add queue[%d] is not null\n", tail);
            free(should_null);
            return -7;
        }
        
        return 0;
    }
    
    
    char * str_queue_get(QUEUE_T *pq)
    {
        char * str;
        int head;
        // empty queue
        if (pq->tail==pq->head) {
            return NULL;
        }
        
#ifdef MUTEX
        pq->mutexlock.lock();
#endif
        ////////////////
        head = pq->head;
        pq->head = (pq->head + 1) % MAX_QUEUE_SIZE;
        str = pq->queue[head];
        pq->queue[head] = NULL;
        ////////////////
#ifdef MUTEX
        pq->mutexlock.unlock();
#endif
        //    printf("C:  after get: [%s]\n", str);
        
        if (str==NULL) {
            printf("BUG str_queue_get NULL %d\n", head);
        }
        return str;
    }
    
    /**
     * if the queue is original empty, signal the condition
     * variable after add, else do not signal
     * use with str_queue_get_cond
     *
     * first remove the old_control from queue_tail position,
     * and free it, then add the new_control to queue_tail,
     * after that update the queue_tail position (+1 cyclic).
     *
     * it is not thread-safe, need lock to avoid re-entrance.
     */
    int str_queue_add_signal(QUEUE_T *pq, const char * str)
    {
        int tail;
        if (str==NULL) {
            printf("ERROR null string\n");
            return -3; // null pointer error
        }
        // this is arguable, can empty string be accepted?
        if (str[0]==0) {
            printf("ERROR empty string\n");
            return -6;  // empty string not accepted
        }
        if (pq->head == ((pq->tail+1) % MAX_QUEUE_SIZE)) {
            printf("ERROR queue full!!! head %d  tail %d\n", pq->head, pq->tail);
            return -2;
        }
        
        // question: this lock avoid conflict with get_wait ?
        std::unique_lock<std::mutex> lck(pq->condmutex);
        
        /** critical section START **/
        char *sss;
        char *should_null;
        //    printf("C:  before strndup: [%s]\n", str);
        //sss = strndup(str, MAX_STR_LEN);
#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
        sss = _strdup(str);
#else
		sss = strdup(str);
#endif
        //    printf("C:  after strndup: [%s]\n", sss);
        
        tail = pq->tail;
        pq->tail = (pq->tail + 1) % MAX_QUEUE_SIZE;
        should_null = pq->queue[tail];
        pq->queue[tail] = sss;
        //////////////
        pq->cond.notify_all();
        
        if (tail < 0 || tail >= MAX_QUEUE_SIZE) {
            printf("BUG tail = %d\n", tail);
            return -17;
        }
        // TODO report error if exceed MAX_STR_LEN
        if (should_null!=NULL) {
            printf("BUG add queue[%d] is not null\n", tail);
            free(should_null);
            return -7;
        }
        
        return 0;
    }
    
    // condition wait if the str queue is empty
    // use with str_queue_add_cond
    char * str_queue_get_wait(QUEUE_T *pq)
    {
        //    if (true) {
        //        return str_queue_get(pq);
        //    }
        char * str;
        int head;
        
        //???
        std::unique_lock<std::mutex> lock(pq->condmutex);
        
        // empty queue
        while (pq->tail==pq->head) {
            pq->cond.wait(lock);
        }
        ////////////////
        head = pq->head;
        pq->head = (pq->head + 1) % MAX_QUEUE_SIZE;
        str = pq->queue[head];
        pq->queue[head] = NULL;
        ////////////////
        
        if (str==NULL) {
            printf("BUG str_queue_get NULL %d\n", head);
        }
        return str;
    }
    
    int str_queue_clean(QUEUE_T *pq)
    {
        unsigned int i;
        if (pq->head==pq->tail) {
            printf("GOOD empty queue\n");
            for (i=0; i<MAX_QUEUE_SIZE; i++) {
                assert(pq->queue[i]==NULL);
            }
            return 0;
        }
        
        if (pq->head < pq->tail) {
            for (i=pq->head; i<pq->tail; i++) {
                free(pq->queue[i]);
                pq->queue[i] = NULL;
            }
        } else {
            for (i=pq->head; i<MAX_QUEUE_SIZE; i++) {
                free(pq->queue[i]);
                pq->queue[i] = NULL;
            }
            for (i=0; i<pq->tail; i++) {
                free(pq->queue[i]);
                pq->queue[i] = NULL;
            }
        }
        
        for (i=0; i<MAX_QUEUE_SIZE; i++) {
            assert(pq->queue[i]==NULL);
        }
        pq->head = 0;
        pq->tail = 0;
        return 0;
    }
    
    // read-only print
    int str_queue_print(QUEUE_T *pq)
    {
        unsigned int i;
        printf("----- MAX %d   head %d  tail %d -----\n",
               MAX_QUEUE_SIZE, pq->head, pq->tail);
        for (i=0; i<MAX_QUEUE_SIZE; i++) {
            const char *str = pq->queue[i];
            const char * tag = "  ";
            if (str==NULL) str = "__NULL__";
            if (i==pq->head) tag = "H ";
            if (i==pq->tail) tag = " T";
            if (i==pq->head && i==pq->tail) tag = "HT";
            
            printf ("%s (%-2d) [%s]\n", tag, i, str);
        }
        printf("===========================\n");
        return 0;
    }
    
    
    
#ifdef TTT
    
    
    
    // MAX_QUEUE_SIZE must > add, get
#define MAX_ADD	50000
#define MAX_GET	50000
    
    void * get_callback(void* ptr)
    {
        int i;
        char *str;
        int count = 0;
        QUEUE_T *pq = (QUEUE_T *)ptr;
        
        usleep(100);  // add is slow
        for (i=0; i<MAX_GET; i++) {
            str = str_queue_get(pq);
            if (str!=NULL) {
                count++;
                free(str);
            }
        }
        
        printf("#get_callback  count %d\n", count);
        
        return (void*)(long)count;
    }
    
    void * add_callback(void* ptr)
    {
        int i;
        int ret;
        int count = 0;
        QUEUE_T *pq = (QUEUE_T *)ptr;
        
        for (i=0; i<MAX_ADD; i++) {
            char str[100];
            sprintf(str, "AA%dBB", i);
            ret = str_queue_add(pq, str);
            if (ret == 0) {
                count++;
            }
        }
        
        printf("#add_callback  count %d\n", count);
        
        return (void*) (long)count;
    }
    
    
    int two_thread_test()
    {
        int ret;
        long add_count = 0;
        long get_count = 0;
        pthread_t get_thread;
        pthread_t add_thread;
        QUEUE_T q;
        // need to setup a large MAX_QUEUE_SIZE, e.g. 100000
        printf("TWO thread test:  one for add, one for get\n");
        
        ret = str_queue_init(&q);
        assert(ret == 0);
        
        ret = pthread_create(&add_thread, NULL, add_callback, &q);
        assert(ret==0);
        ret = pthread_create(&get_thread, NULL, get_callback, &q);
        assert(ret==0);
        
        pthread_join(get_thread, (void**)&get_count);
        pthread_join(add_thread, (void**)&add_count);
        
        ret = str_queue_clean(&q);
        assert(ret == 0);
        printf("DONE: two_thread_test add %ld  get %ld \n", 
               add_count, get_count);
        return 0;  // this never run
    }
    
    int main()
    {
        
        two_thread_test();
        exit(0);  // early exit for two thread test
        
        // this test need to set MAX_QUEUE_SIZE = 5;
        QUEUE_T q;
        
        str_queue_init(&q); // AAAAA
        
        int i;
        char *str;
        
        str_queue_add(&q, "000");
        str_queue_add(&q, "111");
        str_queue_add(&q, "222");
        str_queue_add(&q, "333");
        str_queue_add(&q, "444");
        
        str_queue_print(&q);
        
        
        for (i=0; i<3; i++) {
            str = str_queue_get(&q);
            printf("HEAD: [%s]\n", str);
            free(str);
        }
        
        str_queue_print(&q);
        
        str_queue_add(&q, "55555");
        str_queue_add(&q, "66666");
        str_queue_add(&q, "77777");
        
        str_queue_print(&q);
        
        str_queue_add(&q, "bug"); // full queue
        
        
        str_queue_clean(&q);
        
        str_queue_print(&q);
    }
    
#endif
    
    
}
