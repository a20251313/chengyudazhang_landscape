#ifndef __COMMON_INC_MYDLL_H__
#define __COMMON_INC_MYDLL_H__

#if defined(WIN32)
#define EXPORT_DLL __declspec(dllexport)
#else
#define EXPORT_DLL
#endif


#endif
