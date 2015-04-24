#ifndef __LIBIDIOMWAR_INC_CVTHREAD_H__
#define __LIBIDIOMWAR_INC_CVTHREAD_H__

#include <list>
#include <map>
#include <set>
#include <atomic>
#include <mutex>
#include <string>

#include "sdstatus.h"
#include "mythread.h"
#include "cvprotocoljob.h"
#include "cvprotocolhandler.h"

using namespace std;

class CVProtocolHandler;

class CVThread : public MyThread
{
public:
    CVThread();
    virtual ~CVThread();
    
	CVThread(const CVThread &) = delete;
	CVThread & operator=(const CVThread &) = delete;

public:
    void reset();
    void addJson(const string &json);
    void getJson(list<string> &json_list);
    void updateProtocolStatus(eSDStatus status);
    eSDStatus getProtocolStatus();
    void addJob(shared_ptr<CVProtocolJob> &job);

private:
    void dispatchJob();

private:

    void run() override;

private:
    list<shared_ptr<CVProtocolJob>>            _job_list;
    mutex                                      _job_list_protector;

    list<string>                               _json_list;
    mutex                                      _json_list_protector;

    eSDStatus                                  _protocol_status;
    mutex                                      _status_protector;

    CVProtocolHandler *                        _protocol;

    atomic_bool                                _reset_flag;
};

#endif
