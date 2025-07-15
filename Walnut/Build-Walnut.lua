project "Walnut"
   kind "StaticLib"
   language "C++"
   cppdialect "C++20"
   targetdir "bin/%{cfg.buildcfg}"
   staticruntime "off"

   files
   {
       "Source/**.h",
       "Source/**.cpp",

       "Platform/GUI/**.h",
       "Platform/GUI/**.cpp",
   }

   includedirs
   {
      "Source",
      "Platform/GUI",

      "../vendor/imgui",
      "../vendor/glfw/include",
      "../vendor/stb_image",
      "../vendor/static-bin2header/src",
      "../vendor/yaml-cpp/include",
      "../vendor/nativefiledialog/src/include",

      "%{IncludeDir.VulkanSDK}",
      "%{IncludeDir.glm}",
      "%{IncludeDir.spdlog}",
   }

   links
   {
       "ImGui",
       "GLFW",
       "Bin2Header",

       "%{Library.Vulkan}",

       "yaml-cpp",
       "nfd"
   }

   defines
	{
		"YAML_CPP_STATIC_DEFINE"
	}

   targetdir ("../../bin/" .. outputdir .. "/%{prj.name}")
   objdir ("../../bin-int/" .. outputdir .. "/%{prj.name}")

   filter "system:windows"
      systemversion "latest"
      defines { "WL_PLATFORM_WINDOWS" }
      buildoptions { "/utf-8" }

   filter "configurations:Debug"
      defines { "WL_DEBUG" }
      runtime "Debug"
      symbols "On"

   filter "configurations:Release"
      defines { "WL_RELEASE" }
      runtime "Release"
      optimize "On"
      symbols "On"

   filter "configurations:Dist"
      defines { "WL_DIST" }
      runtime "Release"
      optimize "On"
      symbols "Off"