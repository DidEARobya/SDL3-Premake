project "SDL3"
	kind "SharedLib"
	language "C++"
	staticruntime "off"
	warnings "off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"include/SDL3/SDL.h",
		"src/audio",
		"src/events",
		"src/gpu",
		"src/render",
		"src/video"
	}

	filter "system:windows"
		runtime "Debug"
		symbols "On"
		sanitize {"Address"}
		flags {"NoRuntimeChecks", "NoIncrementalLink"}


	filter "configurations.Debug"
		defines "Debug"
		symbols "On"

	filter "configurations.Release"
		defines "NE_RELEASE"
		optimize "On"

	filter "configurations.Dist"
		defines "NE_DIST"
		optimize "On"
