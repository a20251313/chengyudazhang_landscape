#ifndef __SYS_INC_SYS_UTIL_H__
#define __SYS_INC_SYS_UTIL_H__

#include <chrono>
#include <string>
#include <ctime>

namespace SysUtil
{
    namespace FileSystem
    {
        bool folder_exists(const std::string &foldername);
		int  my_mkdir(const char *path);
    }

    namespace MyTimeUtil
    {
    	typedef std::chrono::time_point<std::chrono::system_clock>  
            system_time_point;
     
    	tm localtime(const std::time_t& time);
    	std::string get_current_datetime(const std::tm* date_time);
    	std::time_t systemtime_now();
    	std::string put_time(const std::tm* date_time, 
            const char* c_time_format);
        void sleepMS(uint32_t ms);
    }

	namespace System
	{
		bool set_nonblock(int fd, bool yes);
	}
}

#endif /* __SYS_INC_SYS_UTIL_H__ */
