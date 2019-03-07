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


#ifdef OMG_DEBUG
	#define OMG_ENABLE_ASSERTS
#endif


#ifdef OMG_ENABLE_ASSERTS
	#define OMG_ASSERT(x, ...) { if(!(x)) { OMG_ERROR("Assertion Failed: {0}", __VA_ARGS__); __debugbreak(); } }
	#define OMG_CORE_ASSERT(x, ...) { if(!(x)) { OMG_CORE_ERROR("Assertion Failed: {0}", __VA_ARGS__); __debugbreak(); } }
#else
	#define OMG_ASSERT(x, ...)
	#define OMG_CORE_ASSERT(x, ...)
#endif


#define BIT(x) (1 << x)