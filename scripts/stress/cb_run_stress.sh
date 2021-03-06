#!/usr/bin/env bash

#/*******************************************************************************
# Copyright (c) 2012 IBM Corp.

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#/*******************************************************************************

cd ~
source $(echo $0 | sed -e "s/\(.*\/\)*.*/\1.\//g")/cb_common.sh

set_load_gen $@
   

CMDLINE="stress-ng --cpu ${LOAD_LEVEL}--cpu-method ${LOAD_PROFILE} --metrics-brief --perf -t ${LOAD_DURATION}"

execute_load_generator "${CMDLINE}" ${RUN_OUTPUT_FILE} ${LOAD_DURATION}

tp=$(cat ${RUN_OUTPUT_FILE} | grep cpu[[:space:]] | awk '{ print $10 }')

~/cb_report_app_metrics.py \
throughput:$tp:tps \
$(common_metrics)    

unset_load_gen

exit 0
