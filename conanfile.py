from conan import ConanFile
from conan.tools.cmake import cmake_layout, CMakeToolchain, CMakeDeps

class ShareWaveRecipe(ConanFile):
    settings = "os", "compiler", "build_type", "arch"
    
    def requirements(self):
        self.requires("boost/1.91.0")
        self.requires("openssl/4.1.0")
        self.requires("libsodium/1.0.22")
        self.requires("gtest/1.18.0")
    
    def generate(self):
        deps = CMakeDeps(self)
        deps.generate()
        
        tc = CMakeToolchain(self)
        tc.user_presets_path = False
        tc.generate()
    
    def layout(self):
        cmake_layout(self)
