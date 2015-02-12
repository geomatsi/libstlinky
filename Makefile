#
#
#

LIBNAME = libstlinky
TARGET ?= stm32f4

#

CROSS_COMPILE ?= /home/matsi/devel/tools/Sourcery_CodeBench_Lite_for_ARM_GNU_Linux-2013.11-33/bin/arm-none-linux-gnueabi

CC = $(CROSS_COMPILE)-gcc
LD = $(CROSS_COMPILE)-ld
AR = $(CROSS_COMPILE)-ar

#

ARFLAGS	= rcs

CFLAGS = -g -O2 -Wall
CFLAGS += -mcpu=cortex-m4 -mthumb -mthumb-interwork
CFLAGS += -mfpu=fpv4-sp-d16 -mfloat-abi=softfp

#

INC_DIR = include
SRC_DIR = src

CFLAGS += -I$(INC_DIR)

#

OBJS += $(SRC_DIR)/stlinky.o

#

all: $(LIBNAME)_$(TARGET).a

$(LIBNAME)_$(TARGET).a: $(LIBNAME)_$(TARGET).ld $(OBJS)
	$(AR) $(ARFLAGS) "$@" $(OBJS)

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $<

clean:
	rm -f $(SRC_DIR)/*.o
	rm -f $(LIBNAME)_$(TARGET).a

.PHONY: clean
