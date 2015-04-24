#ifndef __NET_INC_TCPCLIENT_H__
#define __NET_INC_TCPCLIENT_H__

#include <stdint.h>
#include "datachannel.h"
#include <string>
using namespace std;

class TcpClient
{
    typedef enum
    {
        eConn_Disconnected         = 0,
        eConn_Connecting           = 1,
        eConn_Connected            = 2
    }eConnectState;

public:
    TcpClient();
    virtual ~TcpClient();

public:

#if defined(WIN32)
    static void init_winsock();
    static void deinit_winsock();
#endif

public:
    string get_peer_ip() const;
    uint16_t get_peer_port() const;
	void set_peer_ip(const string & ip);
	void set_peer_port(uint16_t port);
    int receive(char* buffer, size_t buffer_size, int &err);
    int send(const char* buffer, size_t buffer_size, int &err);
	bool is_connect_established() const;
    bool is_connect_establishing() const;
    int async_connect(int &err);
    int is_connection_completed();
    DataChannel* get_data_channel();
    
    /**
     * is_ready_to_read:
     *
     * Return value:
     * < 0: Error
     * = 0: Nothing to read.
     * > 0: Ready to read.
     */
    int is_ready_to_read();

    
    /**
     * is_ready_to_write:
     *
     * Return value:
     * < 0: Error
     * = 0: cannot write now.
     * > 0: Ready to write.
     */
    int is_ready_to_write();
    
public: // override
    virtual void close();
    
private:

    /*
     * -2: Unrecovered error.
     * -1: blocked error.
     * 0: connected.
     */
    int do_connect(int& fd, bool nonblock, int &err);

private:
    string         _peer_ip;
    uint16_t       _peer_port;
    DataChannel*   _data_channel;
    eConnectState  _connect_state;
    int            _socket;
};


#endif /* __NET_INC_TCPCLIENT_H__ */
