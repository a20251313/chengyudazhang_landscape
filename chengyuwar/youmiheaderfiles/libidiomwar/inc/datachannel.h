#ifndef __NET_INC_DATACHANNEL_H__
#define __NET_INC_DATACHANNEL_H__

#include <stddef.h>

class DataChannel
{
public:
    DataChannel();
    ~DataChannel();

public:
    void attach(int fd);

    /**
     * receive:
     *
     * return values:
     * > 0: bytes of recieved data.
     * = 0: peer shutdown.
     * -1 : blocked.
     * -2 : err, we need to close the socket.
     */
    int receive(char* buffer, size_t buffer_size, int &err);

    
    /**
     * send:
     *
     * return values:
     * > 0: bytes of sent data.
     * -1 : blocked.
     * -2 : err, we need to close the socket.
     */
    int send(const char* buffer, size_t buffer_size, int &err);
    
private:
    int _fd;
};

#endif /* __NET_INC_DATACHANNEL_H__ */
