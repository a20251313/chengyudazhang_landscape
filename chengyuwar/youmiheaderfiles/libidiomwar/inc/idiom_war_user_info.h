#ifndef __COMMON_INC_IDIOM_WAR_USER_INFO_H__
#define __COMMON_INC_IDIOM_WAR_USER_INFO_H__

#include <cstdint>
#include <string>
#include "clientplatform.h"
#include "idiom_war_common_def.h"

using namespace std;

struct IdiomWarUserInfo
{
    IdiomWarUserInfo():
        user_id(0),
        user_name(),
        question_ver(0),
        client_ver(0),
        platform(eCP_None),
        role(eIWPR_RoleEnd),
        server_ip(),
        server_port(0)
    {
    }

    uint32_t              user_id;
    string                user_name;
    uint32_t              question_ver;
    uint32_t              client_ver;
    eClientPlatform       platform;
    eIdiomWarPlayerRole   role;
    string                server_ip;
    uint16_t              server_port;
};

#endif
