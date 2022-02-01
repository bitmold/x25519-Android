Demo project, experimenting with Rust, JNI and NDK in the context of <a href ="https://github.com/guardianproject/orbot">Orbot</a>.

This isn't practical, but shows how a Rust library could be integrated into this specific android project. This wraps <a href="https://github.com/dalek-cryptography/x25519-dalek">x25519-dalek</a> so that Orbot could host v3 Onion Services that provide client authentication. 

Running `./build.sh debug` generates a `liborbotkeys.so` for each ABI that the application supports.  

# Building 
*keeping these instructions here in case I'm trying to integrate an arbitrary rust project into Orbot...*

```bash
# install rust, ANDROID NDK, Android build tools

rustup target add aarch64-linux-android
rustup target add arm-linux-androideabi
rustup target add armv7-linux-androideabi
rustup target add i686-linux-android

# set NDK path
export NDK_HOME = ~/Android/Sdk/ndk/20.1.5948944

./build.sh debug
```

In the build script, different environment variables are set for each ABI target

| Rust Target      | LLVM Compiler Prefix | Linker Prefix     | Android JNI Library ABI Dir Name (for `*.so` file) |
| :---        |    :----:   |          ---: |           ---: |
| `aarch64-linux-android`      | `aarch64-linux-android`       | `aarch64-linux-android`   | `arm64-v8a` |
| `x86_64-linux-android`   | `x86_64-linux-android`        | `x86_64-linux-android`      |`x86_64` |
| `i686-linux-android` | `i686-linux-android` | `i686-linux-android` | `x86` |
| `arm-linux-androideabi` | `armv7a-linux-androideabi` | `arm-linux-androideabi` | `armeabi-v7a` |

According to this <a href="https://developer.android.com/ndk/guides/other_build_systems">guide from Google</a>, on 32bit ARM ABis the compiler prefix differs from the prefix for all other binary utilities (including the linker).  