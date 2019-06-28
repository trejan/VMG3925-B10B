#
#   source code makefile
#
LIB_NAME    = libzlog
OBJS        = zlog_api.o
CURRENT_DIR = $(shell pwd)

#LINK_LIB = -lpthread
#LIBS_PATH =
LDFLAGS += $(LIBS_PATH) $(LINK_LIB)

#zlog
ifeq ($(CONFIG_ZLOG_USE_DEBUG),y)
CFLAGS += -DCONFIG_ZLOG_USE_DEBUG
endif

#CFLAGS += -I$(TOOLCHAIN)/include -I. -std=gnu99
CFLAGS += -I. -std=gnu99

.PHONY : $(LIB_NAME)

all: clean $(LIB_NAME)

.c.o:
	$(CC) $(CFLAGS) -Wall -Werror -fPIC -c $< -o $@

$(LIB_NAME) : $(OBJS)
	$(CC) $(LDFLAGS) -shared -o $(LIB_NAME).so $(OBJS)

clean:
	rm -rf *.o
	rm -rf *.so
