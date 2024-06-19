#!/bin/bash
FUZZ_DIR=`dirname $(realpath -s $0)`
source "$FUZZ_DIR/afl_config.sh"

if [[ $# < 1 ]] ; then
  echo >&2 "Usage: $0 <workerid>"
  exit 1
fi

NUM=$1
if [[ $NUM == 1 ]]; then
  echo Running master
  #export AFL_FRIDA_INST_COVERAGE_FILE=./info/"$NUM"_master_coverage.drcov
  export AFL_FRIDA_INST_UNSTABLE_COVERAGE_FILE=./info/"$NUM"_master_unstable_coverage.drcov
  "$afl_path"/afl-fuzz  -m 2048 -O -e vpk -i "$corpus_path" -o "$output_path" -M fuzzerMaster -- "$target_path" @@
elif [[ $NUM == 2 ]]; then
  echo Running default
  #export AFL_FRIDA_INST_COVERAGE_FILE=./info/"$NUM"_master_coverage.drcov
  export AFL_FRIDA_INST_UNSTABLE_COVERAGE_FILE=./info/"$NUM"_master_unstable_coverage.drcov
  "$afl_path"/afl-fuzz  -m 2048 -O -e vpk -i "$corpus_path" -o "$output_path" -M default -- "$target_path" @@
elif [[ $NUM == 3 ]]; then
  echo Running FASAN
  export AFL_FRIDA_INST_COVERAGE_FILE=./info/"$NUM"_FASAN_coverage.drcov
  export AFL_USE_FASAN=1
  export AFL_INST_LIBS=1
  export AFL_PRELOAD=/usr/lib/clang/17/lib/linux/libclang_rt.asan-x86_64.so
  "$afl_path"/afl-fuzz -O -e vpk -i "$corpus_path" -o "$output_path" -S fuzzerFASAN -- "$target_path" @@
  export AFL_USE_FASAN=
  export AFL_PRELOAD=
  export AFL_COMPCOV_LEVEL=
elif [[ $NUM == 4 ]]; then
  echo Running MOpt
  export AFL_FRIDA_INST_COVERAGE_FILE=./info/"$NUM"_MOpt_coverage.drcov
  //"$afl_path"/afl-fuzz -O -m 2048 -L 0  -e vpk -i "$corpus_path" -o "$output_path" -S fuzzerMOpt -- "$target_path" @@
else
  echo NUM=$NUM
  echo 'Running slave (no affinity)'
#  export AFL_NO_AFFINITY=1
#  screen -dmS afl$NUM "$afl_path"/afl-fuzz  -m 2048 -O -e vpk -i "$corpus_path" -o "$output_path" -S fuzzer$NUM -- "$target_path" @@
fi

  #####
  #echo Running FASAN
  #export AFL_FRIDA_INST_COVERAGE_FILE=./info/"$NUM"_FASAN_coverage.drcov
  #export AFL_USE_FASAN=1
  #export AFL_INST_LIBS=0
  #export AFL_PRELOAD=/usr/lib/clang/17/lib/linux/libclang_rt.asan-x86_64.so
  #"$afl_path"/afl-fuzz -O -e vpk -i "$corpus_path" -o "$output_path" -S fuzzerFASAN -- "$target_path" @@
  #export AFL_USE_FASAN=
  #export AFL_PRELOAD=
  #########
