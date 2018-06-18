// C++ version (for POSIX systems):
#include <iostream>
#include <sstream>
#include <pthread.h>

class Buffer
{
public:
    Buffer()
    {
        pthread_mutex_init(&mtx_, NULL);
        pthread_cond_init(&full_, NULL);
        pthread_cond_init(&empty_, NULL);

        is_full_ = false;
    }

    ~Buffer()
    {
        pthread_mutex_destroy(&mtx_);
        pthread_cond_destroy(&full_);
        pthread_cond_destroy(&empty_);
    }

    void put(bool x)
    {
        pthread_mutex_lock(&mtx_);
        while (is_full_)
        {
            pthread_cond_wait(&empty_, &mtx_);
        }

        value_ = x;
        is_full_ = true;

        pthread_cond_signal(&full_);
        pthread_mutex_unlock(&mtx_);
    }

    void get(bool & x)
    {
        pthread_mutex_lock(&mtx_);
        while (not is_full_)
        {
            pthread_cond_wait(&full_, &mtx_);
        }

        x = value_;
        is_full_ = false;

        pthread_cond_signal(&empty_);
        pthread_mutex_unlock(&mtx_);
    }

private:
    bool value_;
    bool is_full_;

    pthread_mutex_t mtx_;
    pthread_cond_t full_;
    pthread_cond_t empty_;
};

Buffer buf;

int iterations;

void * producer(void *)
{
    for (int i = 0; i != iterations - 1; ++i)
    {
        buf.put(false);
    }
    buf.put(true);

    return NULL;
}

void * consumer(void *)
{
    int count = 0;
    bool x;
    while (true) {
        buf.get(x);
        ++count;
        if (x)
        {
            break;
        }
    }

    std::cout << "Executed " << count
        << " iterations" << std::endl;

    return NULL;
}

int main(int argc, char * argv[])
{
    std::istringstream ss(argv[1]);
    ss >> iterations;

    pthread_t producer_th;
    pthread_t consumer_th;

    pthread_create(&producer_th, NULL, producer, NULL);
    pthread_create(&consumer_th, NULL, consumer, NULL);

    pthread_join(producer_th, NULL);
    pthread_join(consumer_th, NULL);
}
