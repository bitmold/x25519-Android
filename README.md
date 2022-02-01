Demo project, experimenting with Rust, JNI and NDK

Probably not practical, but could be used to generate a X25519 keys for use in Orbot. Based on <a href="https://github.com/dalek-cryptography/x25519-dalek">x25519-dalek</a>. With this function, it would be trivial for Orbot to host v3 Onion Services that provide client authentication. 

Running `./build.sh debug` generates a `liborbotkeys.so` for each ABI that the application supports.  