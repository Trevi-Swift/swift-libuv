## LOCATIONS ##
ROOT_DIR     = $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
BUILD_DIR    = $(ROOT_DIR)/.build
UV_PATH      = $(BUILD_DIR)/libuv
UV_LIB_OUT   = $(UV_PATH)/out/Debug/libuv.a
UV_LIB_DIR   = $(ROOT_DIR)/lib
UV_INC_DIR   = $(ROOT_DIR)/include

define UV_MMAP_STR
module Libuv [system] {
    header "include/uv.h"
    link "uv"
    export *
}
endef
export UV_MMAP_STR

## BUILD TARGETS ##
all: clean libuv

libuv:
	@echo "\n\033[1;33m>>> Download\033[0m"
	$(shell mkdir -p $(BUILD_DIR))
	$(shell mkdir -p $(UV_LIB_DIR))
	$(shell mkdir -p $(UV_INC_DIR))
	git clone "https://github.com/libuv/libuv.git" $(UV_PATH) && \
		test -d $(UV_PATH)/build/gyp || \
			(mkdir -p $(UV_PATH)/build && git clone https://chromium.googlesource.com/external/gyp.git $(UV_PATH)/build/gyp) && \
		cd $(UV_PATH) && \
		./gyp_uv.py -f make && \
		$(MAKE) -C ./out && \
		cp "$(UV_LIB_OUT)" $(UV_LIB_DIR) && \
		cp $(UV_PATH)/include/uv*.h $(UV_INC_DIR) && \
		echo "$$UV_MMAP_STR" > $(ROOT_DIR)/module.modulemap
	@echo "\n\033[1;33m<<<\033[0m\n"

clean:
	@echo "\n\033[1;33m>>> Clean\033[0m"
	rm -rf $(BUILD_DIR)
	rm -rf $(UV_LIB_DIR)
	rm -rf $(UV_INC_DIR)
	@echo "\n\033[1;33m<<<\033[0m\n"

.PHONY:
