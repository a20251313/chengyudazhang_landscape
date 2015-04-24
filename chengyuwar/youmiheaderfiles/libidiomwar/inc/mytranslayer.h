#ifndef __EASYNET_INC_MYTRANSLAYER_H__
#define __EASYNET_INC_MYTRANSLAYER_H__

#include "sdstatus.h"
#include "datachannel.h"
#include "myencryptor.h"
#include <random>


/////////////////////////////////////////////////////////////////
/// Header definition:
/// Total header size: 20 Bytes.
/// 0-3    bytes: Identifer.
/// 4-7    bytes: Trans layer Protocol version. 
/// 8-11  bytes: The length of data.
/// 12-15 bytes: Key ID.
/// 16-19 bytes: Reserved for future usage.
////////////////

class MyTransLayer
{
private:

    typedef enum
    {
        eMTL_V20120710 = 20120710,

        // Add before this line.
        eMTL_END
    }eMTLProtocolVer;

    // Define contants here.
    enum
    {
        eMTLC_HeaderLength = 32,
        eMTLC_AlignLength = 8,

        // Add before this line.
        eMTLC_End
    };

    typedef enum
    {
        eMTS_RecvIdle,
        eMTS_PrepareToRecv,
        eMTS_RecvingHead,
        eMTS_RecvingBody
    }eMTRecvStatus;

    typedef enum
    {
        eMTS_SendIdle,
            
        eMTS_PrepareToSend,
        eMTS_Sending
    }eMTSendStatus;

public:

    MyTransLayer(DataChannel*, unsigned int maxbuffsize);
    ~MyTransLayer();

private:
    MyTransLayer(const MyTransLayer &);

private:
    void createHeader(unsigned int datalen);
    bool checkHeader();

public:
    eSDStatus sendBuff(unsigned int bufflen);
    eSDStatus recvBuff();
    eSDStatus getSendBuff(unsigned char ** buff, unsigned int &bufflen);
    eSDStatus getRecvdBuff(const unsigned char ** buff, unsigned int &bufflen) const;

private:
    DataChannel*     _remote;

    MyEncryptor*     _send_encryptor;

    MyEncryptor*     _recv_decryptor;

    std::mt19937     _generator;

    // The max size of buffer.
    unsigned int     _max_buff_len;

    // The size of data has been sent.
    unsigned int     _sent_buff_len;

    // The size of data has been reveived.
    unsigned int     _recved_buff_len;

    // The total size of buff which need to be sent.
    unsigned int     _send_buff_len;

    // The total size of buff which need to be received.
    unsigned int     _recv_buff_len;

    // Actual data size.
    unsigned int     _data_size;

    unsigned int     _protocol_ver;
    
    unsigned int     _remote_key_id;
    unsigned int     _local_key_id;

    eMTSendStatus    _send_status;
    eMTRecvStatus    _recv_status;
    
    unsigned char*   _send_buff;
    unsigned char*   _recv_buff;
};


#endif /* __EASYNET_INC_MYTRANSLAYER_H__ */
