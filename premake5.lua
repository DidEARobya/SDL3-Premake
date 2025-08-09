workspace "NoctalEngine"
	architecture "x64"
	startproject "Sandbox"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

	outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "NoctalEngine"
	location "NoctalEngine"
	kind "SharedLib"
	language "C++"
	buildoptions{"/utf-8"}

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("int/" .. outputdir .. "/%{prj.name}")

	pchheader "nepch.h"
	pchsource "NoctalEngine/src/nepch.cpp"

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
		cppdialect "C++latest"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"NE_PLATFORM_WINDOWS",
			"NE_BUILD_DLL"
		}

		postbuildcommands
		{
			("{COPYFILE} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
		}

	filter "configurations.Debug"
		defines "NE_DEBUG"
		symbols "On"

	filter "configurations.Release"
		defines "NE_RELEASE"
		optimize "On"

	filter "configurations.Dist"
		defines "NE_DIST"
		optimize "On"


project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"
	buildoptions{"/utf-8"}

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"NoctalEngine/src",
		"NoctalEngine/vendor/spdlog/include"
	}

	links
	{
		"NoctalEngine"
	}

	filter "system:windows"
		cppdialect "C++latest"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"NE_PLATFORM_WINDOWS"
		}

	filter "configurations.Debug"
		defines "NE_DEBUG"
		symbols "On"

	filter "configurations.Release"
		defines "NE_RELEASE"
		optimize "On"

	filter "configurations.Dist"
		defines "NE_DIST"
		optimize "On"
