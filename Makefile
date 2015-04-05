#
# LIBSTLINKY
#
# Variables
#   - CROSS_COMPILE: path/prefix of cross-toolchain
#   - TARGET: target platform identifier to add to library name
#   - PLT_FLAGS: platform-specific compile flags, e.g. -mcpu=...
#   - CFG_FLAGS: libstlinky configuration switches
#     -- CONFIG_LIB_STLINKY_NLIB
#     -- CONFIG_LIB_PRINTF
#

LIBNAME = libstlinky
TARGET ?= stm32f4

#

CROSS_COMPILE ?= arm-none-linux-gnueabi

CC = $(CROSS_COMPILE)-gcc
LD = $(CROSS_COMPILE)-ld
AR = $(CROSS_COMPILE)-ar

#

ARFLAGS	= rcs

CFLAGS = -O2 -Wall $(PLT_FLAGS) $(CFG_FLAGS)

#

INC_DIR = include
SRC_DIR = src

CFLAGS += -I$(INC_DIR)

#

OBJS += $(SRC_DIR)/stlinky.o

#

all: $(LIBNAME)_$(TARGET).a

$(LIBNAME)_$(TARGET).a: $(OBJS)
	$(AR) $(ARFLAGS) "$@" $(OBJS)

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $<

clean:
	rm -f $(SRC_DIR)/*.o
	rm -f $(LIBNAME)_$(TARGET).a

.PHONY: clean
