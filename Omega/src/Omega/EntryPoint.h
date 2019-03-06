#pragma once

#ifdef OMG_PLATFORM_WINDOWS

extern Omega::Application* Omega::CreateApplication();

int main(int argc, char** argv)
{
	Omega::Log::Init();
	OMG_CORE_WARN("Initialized Log!");
	OMG_INFO("Hello! Var={0}", 5);

	auto app = Omega::CreateApplication();
	app->Run();
	delete app;
}

#endif