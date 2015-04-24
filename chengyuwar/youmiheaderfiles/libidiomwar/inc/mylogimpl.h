#ifndef __SYS_INC_MYLOGIMPL_H__
#define __SYS_INC_MYLOGIMPL_H__

#include "mythread.h"
#include <cstdint>
#include <mutex>
#include <string>
#include <list>
#include <fstream>
#include <condition_variable>

namespace SysUtil
{
    class MyLogImpl : public MyThread
    {
    	enum MyLogConstant
    	{
    		LOG_BUFFER_LIST_SIZE          = 40,
    		LOG_MAX_LINE_SIZE             = 32768,
    		LOG_FILE_MAX_SIZE             = 104857600,
    	    LOG_FILE_PATH_LEN             = 2048,
    	    LOG_FILE_NAME_LEN             = 256,
    	 	LOG_FILE_BACKUP_NUM           = 10
    	};

      public:
    	enum class LogLevel
    	{
    		LOG_LEVEL_DEBUG,
    		LOG_LEVEL_INFO,
    		LOG_LEVEL_WARN,
    		LOG_LEVEL_ERROR,
    	    LOG_LEVEL_FATAL,
    		LOG_LEVEL_STATE,
    	    LOG_LEVEL_TRACE
    	};

      private:
    	MyLogImpl();	
    	static MyLogImpl * _instance_ptr;

      public:
    	virtual ~MyLogImpl();
    	static MyLogImpl* instance();
    	static void release();

      public:
    	virtual void wakeUp() override;

      public:
    	void init(const std::string &log_path, const std::string &log_name);
    	void setLogLevel(LogLevel level);
    	void enableTraceLog(bool enabled);
    	void enableScreen(bool enabled);
    	void logDebug(const char *format, ...);
    	void logInfo(const char *format, ...);
    	void logWarn(const char *format, ...);
    	void logError(const char *format, ...);
    	void logFatal(const char *format, ...);
    	void logState(const char *format, ...);
    	void logTrace(const char *format, ...);

      private:
    	bool enabledDebug();
    	bool enabledInfo();
    	bool enabledWarn();
    	bool enabledError();
    	bool enabledFatal();
    	bool enabledState();
    	bool enabledTrace();

      private:
    	void closeLogFile();
    	void createLogFile();
    	bool needRotateLogFile();
    	void rotateLogFile();

    	void doLog(LogLevel level, const char *format, va_list& args);

    	void createHeader(char *line, uint32_t max_len, uint32_t &line_len, 
    					  LogLevel level);
    	std::string getLogLevelName(LogLevel);

      protected:
    	virtual void run() override;

      private:
    	std::mutex                   _buff_list_protector;
    	std::condition_variable      _log_signal;
    	std::list<char *>            _buff_list;
    	std::list<char *>            _log_list;

    	std::string                  _log_path;
    	std::string                  _log_name;

    	LogLevel                     _log_level;
    	bool                         _trace_log_enabled;

    	bool                         _screen_enable;
    	uint16_t                     _backup_number;


    	uint32_t                     _curr_file_size;

        std::ofstream                _log_file;
    };
}

#endif

