workspace "Omega"
	architecture "x64"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "Omega"
	location "Omega"
	kind "SharedLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "omgpch.h"
	pchsource "Omega/src/omgpch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"OMG_PLATFORM_WINDOWS",
			"OMG_BUILD_DLL"
		}

		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
		}

	filter "configurations:Debug"
		defines "OMG_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "OMG_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "OMG_DIST"
		optimize "On"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"Omega/vendor/spdlog/include",
		"Omega/src"
	}

	links
	{
		"Omega"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"OMG_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines "OMG_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "OMG_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "OMG_DIST"
		optimize "On"
