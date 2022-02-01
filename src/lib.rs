
use jni::{
    objects::JClass,
    JNIEnv
};

extern crate x25519_dalek;
extern crate base32;
extern crate rand_core;
use std::ffi::CString;
use jni::sys::{jstring};


use rand_core::OsRng;
use x25519_dalek::{StaticSecret, PublicKey};


#[allow(non_snake_case)]
#[no_mangle]
pub unsafe extern "C" fn Java_org_torproject_android_X25519_generatePair(env: JNIEnv,_: JClass) -> jstring{

    let alice_secret = StaticSecret::new(OsRng);
    let alice_public = PublicKey::from(&alice_secret);


    let b32_priv = base32::encode(base32::Alphabet::RFC4648 { padding: false }, &alice_secret.to_bytes()).to_owned()    ;
    let b32_public = base32::encode(base32::Alphabet::RFC4648 { padding: false }, alice_public.as_bytes());


    let pair = b32_priv + &b32_public;
    println!("{:?}", pair);

    let cStr = CString::new(pair.to_owned()).unwrap().into_raw();
    let output = env.new_string(CString::from_raw(cStr).to_str().unwrap()).expect("couldn't create java string");
    return output.into_inner();
}
