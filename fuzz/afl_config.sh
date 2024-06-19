FUZZ_DIR=`dirname $(realpath -s $0)`

## Paths

export BASEPATH=`dirname $FUZZ_DIR`
echo "$BASEPATH"
export afl_path="$BASEPATH/AFLplusplus"
echo "$afl_path"
export corpus_path="$FUZZ_DIR/corpus_unique"
export output_path="$FUZZ_DIR/output"
export target_path="$BASEPATH/src/target"

## Debug

#export AFL_NO_UI=1
export AFL_DEBUG=1
export AFL_DEBUG_CHILD=1

## Run without afl-system-config for testing
#export AFL_SKIP_CPUFREQ=1
#export AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1

export AFL_AUTORESUME=1
export AFL_IMPORT_FIRST=1
export AFL_FINAL_SYNC=1

export AFL_INST_LIBS=1 #include all libs in instrumentation
export AFL_TESTCACHE_SIZE=500


## Frida

#export AFL_FRIDA_VERBOSE=1
#export AFL_FRIDA_INST_CACHE_SIZE=500 #not working as expacted not in MB
#export AFL_FRIDA_STATS_INTERVAL=60
#export AFL_FRIDA_STATS_FILE=./info/stats.txt
#export AFL_FRIDA_INST_DEBUG_FILE=./info/debug.txt
#export AFL_FRIDA_INST_COVERAGE_FILE=./info/coverage.drcov
export AFL_FRIDA_DEBUG_MAPS=1
export AFL_FRIDA_INST_INSN=1
#export AFL_FRIDA_INST_COVERAGE_ABSOLUTE=1
#export AFL_FRIDA_INST_NO_DYNAMIC_LOAD=1



#export AFL_BENCH_UNTIL_CRASH=1

#export AFL_ENTRYPOINT=0x401263

