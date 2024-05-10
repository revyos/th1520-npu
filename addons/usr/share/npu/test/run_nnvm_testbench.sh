#!/bin/sh
BASE_PATH=.
TEST_PATH=${BASE_PATH}
RES_PATH=${TEST_PATH}/resource/nnvm_testbench
OUT_PATH=${TET_PATH}/out/nnvm

#export LD_LIBRARY_PATH=${BASE_PATH}/lib/:$LD_LIBRARY_PATH
rm -rf ${OUT_PATH}; mkdir -p ${OUT_PATH}

${TEST_PATH}/nnvm_testbench \
  -i data \
  -d data:${RES_PATH}/m1.tensor.bin \
  -o relu1 \
  -m ${RES_PATH}/light_mapconfig.json \
  -c ${RES_PATH}/light_hw_config.json \
  -n ${RES_PATH}/m1_hist.imgir \
  -p ${RES_PATH}/m1_hist.imgir.params
mv ./output_* ${OUT_PATH}/
