#ifndef __LIBIDIOMWAR_INC_API_IDIOMWAR_H__
#define __LIBIDIOMWAR_INC_API_IDIOMWAR_H__

#include <stdint.h>
#include "mydll.h"
#include "sdstatus.h"
#include "languagedef.h"
#include "clientplatform.h"
#include "idiom_war_common_def.h"

#ifdef __cplusplus
extern "C" {
#endif

/**
 *  FUNCTION NAME:
 *    IdiomWarInit
 * 
 *  FUNCTION TYPE:
 *    Synchronous.
 *  
 *  USAGE:
 *    Initialize the IdiomWar library.
 * 
 *  DESCRIPTION:
 *    This function must be used before any use of the below API.
 *
 *  PARAMETERS:
 *    None.
 *
 *  RETURN VALUE:
 *    * eSDS_Ok: Initialization succeed.
 *    
 *    * eSDS_OutOfMemoryError: Initialization failed due to lack 
 *        of memory. Application should stop here as it is 
 *        impossible to continue.
 *
 *    * eSDS_AppLogicalError: You need to call IdiomWarDeinit() 
 *        before call this API again.
 */
eSDStatus EXPORT_DLL IdiomWarInit();

/**
 *  FUNCTION NAME:
 *    IdiomWarDeinit
 * 
 *  FUNCTION TYPE:
 *    Synchronous.
 *  
 *  USAGE:
 *    Shut down the lib and free all the memory.
 * 
 *  DESCRIPTION:
 *    This function stops all the threads and free all the memory.
 *
 *  PARAMETERS:
 *    None.
 *
 *  RETURN VALUE:
 *    None.
 */
void EXPORT_DLL IdiomWarDeinit();

/**
 *  FUNCTION NAME:
 *    IdiomWarConfigLog
 * 
 *  FUNCTION TYPE:
 *    Synchronous.
 *  
 *  USAGE:
 *    Config the log file in debug mode. In release mode, this 
 *    API will do nothing.
 * 
 *  DESCRIPTION:
 *    If enable_screen_log is true, the log will be print in the
 *    debug window. Or it will be saved to file log_path/log_name.
 *    If the log_path is NULL, The lib will use current folder.
 *    If the log_name is NULL, The lib will use the name 
 *    "api_idiomwar.log". The value of log_level can be 0 to 5.
 *    If log_level is 0, the system will generate the log which 
 *    log_level is equal or greater than 0. Here is the definination
 *    of the log level:
 *      LOG_LEVEL_DEBUG  = 0
 *      LOG_LEVEL_INFO   = 1
 *      LOG_LEVEL_WARN   = 2
 *      LOG_LEVEL_ERROR  = 3
 *      LOG_LEVEL_FATAL  = 4
 *      LOG_LEVEL_STATE  = 5
 *
 *  PARAMETERS:
 *    * enable_screen_log (IN): If true, the lib will printf the log
 *        on screen.
 *
 *    * log_path (IN): The path to save log file.
 *
 *    * log_name (IN): The log file name.
 *
 *    * log_level (IN): How detail you want the log to be. 0 is the 
 *        most detail. 5 is the most less detail.
 *
 *  RETURN VALUE:
 *    None.
 */
void EXPORT_DLL IdiomWarConfigLog(bool enable_screen_log, 
    const char * log_path, const char* log_name, int log_level);


/**
 *  FUNCTION NAME:
 *    IdiomWarReset
 * 
 *  FUNCTION TYPE:
 *    Synchronous.
 *  
 *  USAGE:
 *    Call this API to reset the API.
 * 
 *  DESCRIPTION:
 *    The API will delete the protocol used to chat with server.
 *    And create a new one.
 *
 *  PARAMETERS:
 *    None.
 *
 *  RETURN VALUE:
 *    * eSDS_AppLogicalError: You haven't called IdiomWarInit() yet.
 *    
 *    * eSDS_Ok: reset successfully completed.
 */
eSDStatus EXPORT_DLL IdiomWarReset();

/**
 *  FUNCTION NAME:
 *    IdiomWarJoinGame
 * 
 *  FUNCTION TYPE:
 *    Asynchronous.
 *  
 *  USAGE:
 *    Call this API to play the online game.
 * 
 *  DESCRIPTION:
 *    The API will create a request to the server. Server will check
 *    whether the client can play the online game or not. A success
 *    return doesn't mean you have connected to the server. You need
 *    to call IdiomWarGetLibStatus() to get response of the server.
 *
 *  PARAMETERS:
 *    * uid (IN): The id of the player.
 *
 *    * name (IN): The name of the player.
 *
 *    * question_ver (IN): The version of the question database.
 *
 *    * client_ver (IN): The version of the client application.
 *
 *    * plat (IN): The client platform. Currently, I only support
 *        Android/iOS/iOS_JailBreak.
 *    
 *    * role (IN): The role of the player.
 *    
 *    * ip (IN): The IP address of the server.
 *    
 *    * port (IN): The PORT of the server.
 *
 *  RETURN VALUE:
 *    * eSDS_AppLogicalError: You haven't called IdiomWarInit() yet.
 *    
 *    * eSDS_ParameterError: There's something wrong with your 
 *        parameter. Please check them.
 *
 *    * eSDS_Ok: Succeeded to create a request to server.
 */
eSDStatus EXPORT_DLL IdiomWarJoinGame(uint32_t uid, const char* name, 
    uint32_t question_ver, uint32_t client_ver, eClientPlatform plat, 
    eIdiomWarPlayerRole role, const char* ip, uint16_t port);

/**
 *  FUNCTION NAME:
 *    IdiomWarGetLibStatus
 * 
 *  FUNCTION TYPE:
 *    Synchronous.
 *  
 *  USAGE:
 *    Call this API to get the status of the lib.
 * 
 *  DESCRIPTION:
 *    You need to continue calling this API to get the status of the
 *    lib. If return eSDS_Complete, server must have send a json. You
 *    need to parse the json to get the game match result. If you get
 *    any errors, the lib will reset itself, or, you can call the 
 *    reset() to reset the lib.
 *
 *  PARAMETERS:
 *    None.
 *
 *  RETURN VALUE:
 *    * eSDS_Connecting: The lib is connecting to the VS server.
 *
 *    * eSDS_ConnectError: The lib failed to connect to the VS 
 *        server.
 *    
 *    * eSDS_Connected: The lib connected to the VS server.
 *        
 *    * eSDS_QuestionVersionTooLowError: The client question version 
 *        is too low.
 *    
 *    * eSDS_VersionTooLowError: The version of the client is too 
 *        low.
 *
 *    * eSDS_BadUserIdError: Can not find the user in database. Client
 *        bad logic?
 *
 *    * eSDS_Error: Unknown error.
 *
 *    * eSDS_DatabaseQueryError: Database error. Wanna make a call 
 *        to DBA? Here is his number... I'm just kidding.
 *
 *    * eSDS_NoSessionError: The client disconnected from server. 
 *        After that the lib reconnected to the server, but the server 
 *        cannot find the game the user played before.
 *
 *    * eSDS_UserReloginError: Server find same user id. Maybe someone
 *        copied the game from one phone to another phone.
 *
 *    * eSDS_Complete: The game is over.
 *
 *    * eSDS_AppLogicalError: You haven't called IdiomWarInit() yet.
 */
eSDStatus EXPORT_DLL IdiomWarGetLibStatus();
 
/**
 *  FUNCTION NAME:
 *    IdiomWarGetJson
 * 
 *  FUNCTION TYPE:
 *    Synchronous.
 *  
 *  USAGE:
 *    Call this API to get the response of the server.
 * 
 *  DESCRIPTION:
 *    You need to continue calling this API to get the json from
 *    server and decode the json. The update the logic according
 *    the json.
 *    You need to manage the memory.
 *
 *  PARAMETERS:
 *    * json_arr (OUT): The 2d array pointer of json. The lib will
 *        store the json in the array. The max length of array is 
 *        IDIOM_WAR_MAX_JSON_ARRAY_LEN. The max length of singal
 *        json is IDIOM_WAR_MAX_JSON_LEN.
 *    
 *    * got_num (OUT): The number of json returned.
 *
 *  RETURN VALUE:
 *    * eSDS_AppLogicalError: You haven't called IdiomWarInit() yet.
 *    
 *    * eSDS_Ok: Success.
 */
eSDStatus EXPORT_DLL IdiomWarGetJson(char **json_arr, uint32_t *got_num);


/**
 *  FUNCTION NAME:
 *    IdiomWarPlayResult
 * 
 *  FUNCTION TYPE:
 *    Asynchronous.
 *  
 *  USAGE:
 *    Call this API to send the result to server.
 * 
 *  DESCRIPTION:
 *    This API a request to server. And if the result is not 
 *    eIDWPR_CorrectAnswer. The lib will disconnect from server
 *    after the lib sent the packet to server.
 *
 *  PARAMETERS:
 *    * result (IN): The result.
 *    
 *  RETURN VALUE:
 *    * eSDS_AppLogicalError: You haven't called IdiomWarInit() yet.
 *
 *    * eSDS_ParameterError: Bad result. you can only send four 
 *        results:
 *        - eIDWPR_CorrectAnswer
 *        - eIDWPR_WrongAnswer
 *        - eIDWPR_TimeOut
 *        - eIDWPR_Quit
 *
 *    * eSDS_Ok: Success.
 */
eSDStatus EXPORT_DLL IdiomWarPlayResult(eIdiomWarPlayResult result);

/**
 *  FUNCTION NAME:
 *    IdiomWarUseItem
 * 
 *  FUNCTION TYPE:
 *    Asynchronous.
 *  
 *  USAGE:
 *    Call this API to tell the server that the player had used 
 *      an item.
 * 
 *  DESCRIPTION:
 *    This API will create a user item request to server.
 *
 *  PARAMETERS:
 *    * item (IN): The item.
 *    
 *  RETURN VALUE:
 *    * eSDS_AppLogicalError: You haven't called IdiomWarInit() yet.
 *
 *    * eSDS_ParameterError: Bad result. you can only send five 
 *        items:
 *        - eIWID_ItemTrash
 *        - eIWID_ItemTimeMachine
 *        - eIWID_ItemHint
 *        - eIWID_ItemInvincible
 *        - eIWID_ItemTransfer
 *
 *    * eSDS_Ok: Success.
 */
eSDStatus EXPORT_DLL IdiomWarUseItem(eIdiomWarItemDef item);

#ifdef __cplusplus
}
#endif

#endif
