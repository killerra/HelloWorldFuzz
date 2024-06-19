#include <bits/stdc++.h>

#include <dlfcn.h>
#include <link.h>
#include <unistd.h>
#include <fcntl.h>
#include <string>
#include <limits.h>

using namespace std;

void forkserver() {
    fprintf(stderr, "forkserver()\n");
}

char *vpkPath;

std::string get_cmdline() {
    std::ifstream cmdline;
    cmdline.open("/proc/self/cmdline", std::ios::binary);
    if (cmdline.is_open()) {
        std::string output;
        cmdline >> output;
        std::cout << "cmdline length: " << output.length() << std::endl;
        cmdline.close();
        return output;
    } else {
        std::cout << "unable to read file /proc/self/cmdlie" << "(" << dlerror() << ")" << std::endl;
        return "";
    }
}

// https://stackoverflow.com/questions/143174/how-do-i-get-the-directory-that-a-program-is-running-from
std::string get_exe_path() {
    char result[PATH_MAX];
    ssize_t count = readlink("/proc/self/exe", result, PATH_MAX);
    return std::string(result, (count > 0) ? count : 0);
}

std::string get_exe_dir() {
    auto exe_path = get_exe_path();
    return exe_path.substr(0, exe_path.find_last_of("\\/"));
}

void *load_library(std::string path) {
    auto lib = dlopen(path.c_str(), RTLD_NOW);
    if (lib != NULL) {
        std::cout << "library loaded: " << path << std::endl;
        return lib;
    } else {
        std::cout << "unable to load library " << path << "(" << dlerror() << ")" << std::endl;
        return NULL;
    }
}

int main(int argc, char** argv) {
    if (argc < 2) {
        cerr << "Usage: " << argv[0] << " file [--dbg]" << endl;
        return EXIT_FAILURE;
    }
    //}
    cout << "Reading from " << argv[0] << endl;

    // retrieve cmdline
    auto cmdline = get_cmdline();
    cout << "cmdline: " << cmdline << endl;

    // retrieve current binary path
    auto exe_dir = get_exe_dir();
    cout << "binary dir: " << exe_dir << endl;

    exit(EXIT_SUCCESS);
}
