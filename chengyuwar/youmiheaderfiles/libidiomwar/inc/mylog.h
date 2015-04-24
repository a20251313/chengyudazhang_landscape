#ifndef __SYS_INC_MYLOG_H__
#define __SYS_INC_MYLOG_H__

#include <stdio.h>
#include "mylogimpl.h"

extern SysUtil::MyLogImpl* g_logger;

#if defined(DEBUG)

#if defined(ANDROID)

#include <android/log.h>
#define  LOG_TAG    "LibIdiomWarAPI"
#define  MYLOG_INFO(...)   __android_log_print(ANDROID_LOG_INFO,LOG_TAG,__VA_ARGS__)
#define  MYLOG_WARN(...)   __android_log_print(ANDROID_LOG_WARN,LOG_TAG,__VA_ARGS__)
#define  MYLOG_DEBUG(...)  __android_log_print(ANDROID_LOG_DEBUG,LOG_TAG,__VA_ARGS__)
#define  MYLOG_ERROR(...)  __android_log_print(ANDROID_LOG_ERROR,LOG_TAG,__VA_ARGS__)
#define  MYLOG_FATAL(...)  __android_log_print(ANDROID_LOG_FATAL,LOG_TAG,__VA_ARGS__)

#else /* ANDROID */

#define __MYLOG_DETAIL(logger, format, ...) \
do { \
    if (logger) \
		logger->logDetail(format, ##__VA_ARGS__); \
} while(false)

#define __MYLOG_DEBUG(logger, format, ...) \
do { \
    if (logger) \
		logger->logDebug(format, ##__VA_ARGS__); \
} while(false)

#define __MYLOG_INFO(logger, format, ...) \
do { \
    if (logger) \
		logger->logInfo(format, ##__VA_ARGS__); \
} while(false)

#define __MYLOG_WARN(logger, format, ...) \
do { \
    if (logger) \
		logger->logWarn(format, ##__VA_ARGS__); \
} while(false)

#define __MYLOG_ERROR(logger, format, ...) \
do { \
    if (logger) \
		logger->logError(format, ##__VA_ARGS__); \
} while(false)

#define __MYLOG_FATAL(logger, format, ...) \
do { \
    if (logger) \
		logger->logFatal(format, ##__VA_ARGS__); \
} while(false)

#define __MYLOG_STATE(logger, format, ...) \
do { \
    if (logger) \
		logger->logState(format, ##__VA_ARGS__); \
} while(false)

#define __MYLOG_TRACE(logger, format, ...) \
do { \
    if (logger) \
		logger->logTrace(format, ##__VA_ARGS__); \
} while(false)

#define MYLOG_TRACE(format, ...)     __MYLOG_TRACE(g_logger, format, ##__VA_ARGS__)
#define MYLOG_STATE(format, ...)     __MYLOG_STATE(g_logger, format, ##__VA_ARGS__)
#define MYLOG_FATAL(format, ...)     __MYLOG_FATAL(g_logger, format, ##__VA_ARGS__)
#define MYLOG_ERROR(format, ...)     __MYLOG_ERROR(g_logger, format, ##__VA_ARGS__)
#define MYLOG_WARN(format, ...)      __MYLOG_WARN(g_logger, format, ##__VA_ARGS__)
#define MYLOG_INFO(format, ...)      __MYLOG_INFO(g_logger, format, ##__VA_ARGS__)
#define MYLOG_DEBUG(format, ...)     __MYLOG_DEBUG(g_logger, format, ##__VA_ARGS__)

#endif /* ANDROID */
#endif /* DEBUG */
#endif /* __SYS_INC_MYLOGIMPL_H__ */
