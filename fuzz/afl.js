Afl.print('******************');
Afl.print('* AFL FRIDA MODE *');
Afl.print('******************');
Afl.print('');

Afl.print(`PID: ${Process.id}`);

//const persistent_addr = DebugSymbol.fromName('_Z12CPackedStorePKcPm');
const persistent_addr = DebugSymbol.fromName('main');
Afl.print(`persistent_addr: ${persistent_addr.address}`);

if (persistent_addr.address.equals(ptr(0))) {
    Afl.error('Cannot find symbol main');
}

//Afl.setPersistentAddress(persistent_addr.address);

const mod_linux = Process.findModuleByName("ld-linux-x86-64.so.2")
Afl.addExcludedRange(mod_linux.base, mod_linux.size);
const mod_libc = Process.findModuleByName("libc.so.6")
Afl.addExcludedRange(mod_libc.base, mod_libc.size);
const mod_libstdc = Process.findModuleByName("libstdc++.so.6.0.33")
Afl.addExcludedRange(mod_libstdc.base, mod_libstdc.size);
const mod_steam = Process.findModuleByName("libsteam_api.so")
//Afl.addIncludedRange(mod_steam.base, mod_steam.size);

Afl.done();
Afl.print("done");