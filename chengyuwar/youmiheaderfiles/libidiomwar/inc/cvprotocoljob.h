#ifndef __LIBIDIOMWAR_INC_CVPROTOCOLJOB_H__
#define __LIBIDIOMWAR_INC_CVPROTOCOLJOB_H__

#include <memory>
#include <cstdint>
#include <string>
#include "easypacket.h"
#include "idiom_war_common_def.h"
#include "idiom_war_user_info.h"

using namespace std;

class CVProtocolJob
{
public:
    typedef enum
    {
        eCVPJT_JoinGame,
        eCVPJT_PlayResult,
        eCVPJT_UseItem,
        eCVPJT_Reset,

        // Add before this line.
        eCVPJT_JobEnd
    }eCVPJobType;


public:
    CVProtocolJob();
    ~CVProtocolJob();

public:

    void createJoinGamePacket(uint32_t uid, const string &name, 
        uint32_t question_ver, uint32_t client_ver, eClientPlatform plat, 
        eIdiomWarPlayerRole role, const string &ip, uint16_t port);

    void createPlayResultPacket(eIdiomWarPlayResult result);

    void createUserItemPacket(eIdiomWarItemDef item);

  public:

    eCVPJobType                          _job_type;
    shared_ptr<EasyPacket>               _easy_pkt;
    shared_ptr<IdiomWarUserInfo>         _user_info;
    string                               _vs_server_ip;
    uint16_t                             _vs_server_port;
    bool                                 _game_over;
};

#endif
