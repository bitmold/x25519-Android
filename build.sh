#!/bin/bash

mode=debug

if [ "$1" = "release" ]; then
	mode=release
fi

BASE=`dirname "$0"`
HOST_OS=`uname -s | tr "[:upper:]" "[:lower:]"`
HOST_ARCH=`uname -m | tr "[:upper:]" "[:lower:]"`

android_tools="$NDK_HOME/toolchains/llvm/prebuilt/$HOST_OS-$HOST_ARCH/bin"
api=26
 
for target in x86_64-linux-android aarch64-linux-android i686-linux-android arm-linux-androideabi; do
    case $target in
        'x86_64-linux-android')
            export CC_x86_64_linux_android="$android_tools/${target}${api}-clang"
            export AR_x86_64_linux_android="$android_tools/${target}-ar"
            export CARGO_TARGET_X86_64_LINUX_ANDROID_AR="$android_tools/$target-ar"
            export CARGO_TARGET_X86_64_LINUX_ANDROID_LINKER="$android_tools/${target}${api}-clang"
            export PATH="$NDK_HOME/toolchains/llvm/prebuilt/$HOST_OS-$HOST_ARCH/bin/":$PATH
            echo $target
            echo $CC_x86_64_linux_android
            echo $AR_x86_64_linux_android
            echo $CARGO_TARGET_X86_64_LINUX_ANDROID_AR
            echo $CARGO_TARGET_X86_64_LINUX_ANDROID_LINKER
            mkdir -p "jniLibs/x86_64/"
			case $mode in
				'release')
					cargo build --target $target --manifest-path "$BASE/Cargo.toml" --release
					;;
				*)
					cargo build --target $target --manifest-path "$BASE/Cargo.toml"
					cp target/$target/debug/liborbotkeys.so jniLibs/x86_64/
					;;
			esac
            ;;
        'aarch64-linux-android')
            export CC_aarch64_linux_android="$android_tools/${target}${api}-clang"
            export AR_aarch64_linux_android="$android_tools/${target}-ar"
            export CARGO_TARGET_AARCH64_LINUX_ANDROID_AR="$android_tools/$target-ar"
            export CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER="$android_tools/${target}${api}-clang"
            export PATH="$NDK_HOME/toolchains/llvm/prebuilt/$HOST_OS-$HOST_ARCH/bin/":$PATH
            echo $target
            echo $CC_aarch64_linux_android
            echo $AR_aarch64_linux_android
            echo $CARGO_TARGET_AARCH64_LINUX_ANDROID_AR
            echo $CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER
            mkdir -p "jniLibs/arm64-v8a/"
			case $mode in
				'release')
					cargo build --target $target --manifest-path "$BASE/Cargo.toml" --release
					;;
				*)
					cargo build --target $target --manifest-path "$BASE/Cargo.toml" 
					cp target/$target/debug/liborbotkeys.so jniLibs/arm64-v8a/
					;;
			esac
			;;

		'i686-linux-android')
			export CC_i686_linux_android="$android_tools/${target}${api}-clang"
			export AR_i686_linux_android="$android_tools/${target}-ar"
			export CARGO_TARGET_I686_LINUX_ANDROID_AR="$android_tools/$target-ar"
			export CARGO_TARGET_I686_LINUX_ANDROID_LINKER="$android_tools/${target}${api}-clang"
            echo $target
            echo $CC_i686_linux_android
            echo $AR_i686_linux_android
            echo $CARGO_TARGET_I686_LINUX_ANDROID_AR
            echo $CARGO_TARGET_I686_LINUX_ANDROID_LINKER
            export PATH="$NDK_HOME/toolchains/llvm/prebuilt/$HOST_OS-$HOST_ARCH/bin/":$PATH
            mkdir -p "jniLibs/x86/"
			case $mode in
				'release')
					cargo build --target $target --manifest-path "$BASE/Cargo.toml" --release
					;;
				*)
					cargo build --target $target --manifest-path "$BASE/Cargo.toml" 
					cp target/$target/debug/liborbotkeys.so jniLibs/x86/
					;;
			esac
			;;


		'arm-linux-androideabi')
			export CC_ARM_LINUX_ANDROIDEABI="$android_tools/armv7a-linux-androideabi${api}-clang"
			export AR_ARM_LINUX_ANDROIDEABI="$android_tools/${target}-ar"
			export CARGO_TARGET_ARM_LINUX_ANDROIDEABI_AR="$android_tools/$target-ar"
			export CARGO_TARGET_ARM_LINUX_ANDROIDEABI_LINKER="$android_tools/armv7a-linux-androideabi${api}-clang"
			echo $target
			echo $CC_ARM_LINUX_ANDROIDEABI
			echo $AR_ARM_LINUX_ANDROIDEABI
			echo $CARGO_TARGET_ARM_LINUX_ANDROIDEABI_AR
			echo $CARGO_TARGET_ARM_LINUX_ANDROIDEABI_LINKER
			export PATH="$NDK_HOME/toolchains/llvm/prebuilt/$HOST_OS-$HOST_ARCH/bin/":$PATH
			mkdir -p "jniLibs/armeabi-v7a"
			case $mode in 
				'release')
					cargo build --target $target --manifest-path "$BASE/Cargo.toml" --release
					;;
				*)
					cargo build --target $target --manifest-path "$BASE/Cargo.toml" 
					cp target/$target/debug/liborbotkeys.so jniLibs/armeabi-v7a/
					;;
			esac
			;;
        *)
            echo "Unknown target $target"
            ;;
    esac
done
