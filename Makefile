CUDA_PATH=/usr/local/cuda
HOST_COMPILER ?= g++
NVCC=${CUDA_PATH}/bin/nvcc -ccbin ${HOST_COMPILER}
TARGET=train convolution

INCLUDES = -I${CUDA_PATH}/samples/common/inc -I$(CUDA_PATH)/include
NVCC_FLAGS=-G --resource-usage -Xcompiler -rdynamic -Xcompiler -fopenmp -rdc=true -lnvToolsExt

IS_CUDA_11:=$(shell echo `nvcc --version | grep compilation | grep -Eo -m 1 '[0-9]+.[0-9]' | head -1` \>= 11.0 | bc)

# Gencode argumentes
SMS = 35 37 50 52 60 61 70 75
ifeq "$(IS_CUDA_11)" "1"
SMS = 52 60 61 70 75 80
endif
$(foreach sm, ${SMS}, $(eval GENCODE_FLAGS += -gencode arch=compute_$(sm),code=sm_$(sm)))

LIBRARIES += -L/usr/local/cuda/lib -lcublas -lcudnn -lgomp -lcurand
ALL_CCFLAGS += -m64 -g -std=c++11 $(NVCC_FLAGS) $(INCLUDES) $(LIBRARIES)

LIB_DIR = lib
BIN_DIR = bin
SRC_DIR = src

all : ${TARGET}

LIBS = ${LIB_DIR}/helper.h ${LIB_DIR}/blob.h ${LIB_DIR}/blob.h ${LIB_DIR}/layer.h

${BIN_DIR}/%.o: ${LIB_DIR}/%.cpp ${LIBS}
	$(NVCC) $(INCLUDES) $(ALL_CCFLAGS) $(GENCODE_FLAGS) -c $< -o $@
${BIN_DIR}/%.o: ${LIB_DIR}/%.cu ${LIBS}
	$(NVCC) $(INCLUDES) $(ALL_CCFLAGS) $(GENCODE_FLAGS) -c $< -o $@

${BIN_DIR}/train.o: $(SRC_DIR)/train.cpp ${LIBS}
	@mkdir -p $(@D)
	$(NVCC) $(INCLUDES) $(ALL_CCFLAGS) $(GENCODE_FLAGS) -c $< -o $@

BINS = ${BIN_DIR}/train.o ${BIN_DIR}/mnist.o ${BIN_DIR}/loss.o ${BIN_DIR}/layer.o ${BIN_DIR}/network.o 

train: $(BINS)
	$(EXEC) $(NVCC) $(ALL_CCFLAGS) $(GENCODE_FLAGS) -o $(BIN_DIR)/$@ $+

convolution: $(SRC_DIR)/convolution.cu
	$(EXEC) $(NVCC) $(ALL_CCFLAGS) $(GENCODE_FLAGS) -o $(BIN_DIR)/$@ $+

run:
	./$(BIN_DIR)/train > output.txt

.PHONY: clean
clean:
	rm -f ${BIN_DIR}/${TARGET} ${BIN_DIR}/*.o
	rm -f *.txt

