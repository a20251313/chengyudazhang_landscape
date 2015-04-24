#ifndef __LIBIDIOMWAR_INC_CVPROTOCOLHANDLER_H__
#define __LIBIDIOMWAR_INC_CVPROTOCOLHANDLER_H__

#include <string.h>
#include <string>
#include <iostream>
#include <sstream>
#include <list>
#include <vector>
#include <time.h>
#include <memory>

#include "sysutil.h"
#include "cvprotocoljob.h"
#include "sdstatus.h"
#include "easynet.h"
#include "easypacket.h"
#include "tcpclient.h"
#include "cvthread.h"
#include "mychallenge.h"
#include "mychallengekey.h"
#include "idiom_war_common_def.h"
#include "idiom_war_user_info.h"

using namespace std;

class CVThread;

class CVProtocolHandler
{
    enum
    {
        CV_PROTOCOL_FAILED_TIMES      = 4,
        CV_CONSTANT_RECONN_INTERVAL   = 1 // 1s
    };
    
    typedef enum
    {
        eCVPH_Protocol_Idle,
        eCVPH_Protocol_ProcessJob,
        eCVPH_Protocol_Connect,
        eCVPH_Protocol_Login,
        eCVPH_Protocol_Working
    }eCVPHProtocolStatus;

    typedef enum
    {
        eCVPH_Conn_Disconnected,            
        eCVPH_Conn_WaitToConnect,
        eCVPH_Conn_DoConnect,
        eCVPH_Conn_Connecting,
        eCVPH_Conn_Connected
    }eCVPHConnectStatus;

    typedef enum
    {
        eCVPH_Sub_Idle,
        eCVPH_Sub_Prepare,
        eCVPH_Sub_PreSend,
        eCVPH_Sub_Sending,
        eCVPH_Sub_RecvHandShake,
        eCVPH_Sub_Recv
    }eCVPHSubState;

public:
    CVProtocolHandler(CVThread *clthread);
    ~CVProtocolHandler();

public:
    void addJob(shared_ptr<CVProtocolJob> &job);    
    eSDStatus tickProtocol();

private:
    void reset();
    void getJob();
    void popJob();
    void initNet();
    void disconnect();
    eSDStatus tickConnect();
    eSDStatus tickLogin();
    eSDStatus tickWorking();
	eSDStatus createHandshakeMsg();
	eSDStatus analyzeHandshakeMsg();
    eSDStatus analyzeLoginResult();
    eSDStatus analyzeReceivedPacket();

private:
    CVThread*                               _cv_thread;

    string                                  _vs_server_ip;
    int                                     _vs_server_port;

    unique_ptr<MyChallenge>                 _challenge;

    EasyNet *                               _easy_net;
    shared_ptr<EasyPacket>                  _easy_pkt;
    
    TcpClient *                             _trans_conn;
    int                                     _failed_count;
    eCVPHConnectStatus                      _connect_state;
    std::time_t                             _next_connect_time;
    
    eCVPHSubState                           _protocol_sub_state;
    eCVPHProtocolStatus                     _protocol_status;

    shared_ptr<CVProtocolJob>               _curr_job;
    shared_ptr<CVProtocolJob>               _login_job;
    
    list<shared_ptr<CVProtocolJob> >        _job_list;

    string                                  _session_key;

    unique_ptr<char[]>                      _tmp_buffer;
    std::time_t                             _last_recv_send_time;
};

#endif
