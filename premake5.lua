workspace "Omega"
	architecture "x64"
	startproject "Sandbox"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories relative to root folder
IncludeDir = {}
IncludeDir["GLFW"] = "Omega/vendor/GLFW/include"

include  "Omega/vendor/GLFW"

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
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}"
	}

	links
	{
		"GLFW",
		"opengl32.lib"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"OMG_PLATFORM_WINDOWS",
			"OMG_BUILD_DLL",
			"GLFW_INCLUDE_NONE"
		}

		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
		}

	filter "configurations:Debug"
		defines "OMG_DEBUG"
		runtime "Debug"
		symbols "On"

	filter "configurations:Release"
		defines "OMG_RELEASE"
		runtime "Release"
		optimize "On"

	filter "configurations:Dist"
		defines "OMG_DIST"
		runtime "Release"
		optimize "On"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"
	staticruntime "off"

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
