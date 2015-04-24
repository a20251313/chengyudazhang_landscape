#ifndef __NET_INC_UDPCLIENT_H__
#define __NET_INC_UDPCLIENT_H__

#include <string>

#if defined(WIN32)
#include <Winsock2.h>
#include <Windows.h>
#include <Ws2tcpip.h>
#include <process.h>
#else
#include <errno.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <netdb.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/poll.h>
#include <unistd.h>
#include <string.h>
#endif
#include <stdint.h>


using namespace std;

class UDPClient
{
public:
    UDPClient();
    ~UDPClient();

public:

    bool initNet(const string &server_ip, uint16_t server_port);
    int receive(char* buffer, size_t buffer_size);
    int send(const char* buffer, size_t buffer_size);
    
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

private:
    string                    _udp_server_ip;
    uint16_t                  _udp_server_port;
    int                       _fd;
    struct sockaddr_in        _server_addr;
    socklen_t                 _addr_len;
};


#endif /* __NET_INC_UDPCLIENT_H__ */
