#pragma once

#ifdef OMG_PLATFORM_WINDOWS
	#ifdef OMG_BUILD_DLL
		#define OMEGA_API __declspec(dllexport)
	#else
		#define OMEGA_API __declspec(dllimport)
	#endif
#else
	#error Omega only supports Windows!
#endif
