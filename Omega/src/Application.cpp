#include <stdio.h>

#include "Omega/Log.h"

int main()
{
	Omega::Log::Init();
	OMG_CORE_WARN("Initialized Log!");
	OMG_INFO("Hello! Var={0}", 5);

	return 0;
}