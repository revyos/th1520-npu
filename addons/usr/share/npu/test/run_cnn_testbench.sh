#!/bin/sh
BASE_PATH=.
TEST_PATH=${BASE_PATH}
RES_PATH=${TEST_PATH}/resource/cnn_testbench
OUT_PATH=${TEST_PATH}/out/cnn

#export LD_LIBRARY_PATH=${BASE_PATH}/lib/:$LD_LIBRARY_PATH

REPEAT_COUNT=1
TIMEOUT=2000 # // 2000ms
TASK_COUNT=1
MODEL=lenet
OCM_SIZE=OCM_1M5
TOP_NUM=0
VERBOSE=0
while getopts ":r:t:m:o:p:v:" opt
do
  case $opt in
    r)
    REPEAT_COUNT=$OPTARG
    ;;
    t)
    TIMEOUT=$OPTARG
    ;;
    m)
    MODEL=$OPTARG
    ;;
    o)
    OCM_SIZE=$OPTARG
    ;;
    p)
    TOP_NUM=$OPTARG
    ;;
    v)
    VERBOSE=$OPTARG
    ;;
    ?)
    echo "unsupport parameter!!!"
    exit 1;;
  esac
done
echo "MODEL="${MODEL}, "OCM="${OCM_SIZE}, "REPEAT_COUNT="${REPEAT_COUNT}

rm -rf ${OUT_PATH}/${MODEL}/${OCM_SIZE}; mkdir -p ${OUT_PATH}/${MODEL}/${OCM_SIZE}

if [ "${VERBOSE}" == "1" ]; then
echo "Usage: ./run_cnn_testbench.sh [-m model_name] [-r repeat_cnt]"
${TEST_PATH}/cnn_testbench --unpacked_in --unpacked_out \
  -m ${RES_PATH}/${MODEL}/${OCM_SIZE}/model.mbs.bin \
  -o ${OUT_PATH}/${MODEL}/${OCM_SIZE} \
  -t ${TIMEOUT} \
  --repeat_count ${REPEAT_COUNT} \
  --task_count ${TASK_COUNT} \
  ${RES_PATH}/${MODEL}/m1.tensor.bin
else
${TEST_PATH}/cnn_testbench --unpacked_in --unpacked_out \
  -m ${RES_PATH}/${MODEL}/${OCM_SIZE}/model.mbs.bin \
  -o ${OUT_PATH}/${MODEL}/${OCM_SIZE} \
  -t ${TIMEOUT} \
  --repeat_count ${REPEAT_COUNT} \
  --task_count ${TASK_COUNT} \
  ${RES_PATH}/${MODEL}/m1.tensor.bin > test.log
fi

if [ "${TOP_NUM}" != "0" ]; then
  ${TEST_PATH}/bin/print_top_label.sh \
    ${OUT_PATH}/${MODEL}/${OCM_SIZE} \
    ${RES_PATH}/${MODEL}/label.txt \
    ${TOP_NUM}
fi

