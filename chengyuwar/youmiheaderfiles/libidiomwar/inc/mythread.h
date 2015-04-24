#ifndef __SYS_INC_MYTHREAD_H__
#define __SYS_INC_MYTHREAD_H__

#include <thread>
#include <cstdint>
#include <cstddef>
#include <atomic>
#include <mutex>

class MyThread
{
  private:
	enum class MyThreadState : int
	{
		ENUM_THREAD_INIT,
		ENUM_THREAD_STARTED,
		ENUM_THREAD_STOPPED,
		ENUM_THREAD_JOINED
	};

	static void runWrapper(MyThread* arg);

  public:
	MyThread();
	virtual ~MyThread();
	MyThread(const MyThread &) = delete;
	MyThread & operator=(const MyThread &) = delete;
	
  public:
	virtual void start();
	virtual void stop();
	virtual void wakeUp();
	void sleepMS(uint32_t ms);
	void yield();
	void detach();
	void join();
	bool isStop();
	std::thread::id getThreadId();

  private:
	MyThread::MyThreadState getThreadState();
	void updateThreadState(MyThreadState state);

  protected:
	virtual void run() = 0;

  private:
    std::atomic<MyThreadState>    _thread_state;
	std::thread*                  _thread;
	std::atomic_bool              _stop;
};

#endif /* __SYS_INC_MYTHREAD_H__ */
