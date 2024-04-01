#
## makefile for libion and iontest
#
OUT_DIR ?= .
LIBION_OBJ = ion.o IONmem.o
CFLAGS += -I ./include/
CFLAGS += -I ./kernel-headers/
LIBION = libion.so

IONTEST_OBJ = ion_test.o
IONTEST = iontest

.PHONY: clean

# rules
all: $(LIBION) $(IONTEST)

%.o: %.c
	$(CC) -c -fPIC  $(CFLAGS) $^ -o $(OUT_DIR)/$@

$(LIBION): $(LIBION_OBJ)
	$(CC) -shared  -Wl,-soname,$(LIBION) -fPIC $(CFLAGS) $(patsubst %, $(OUT_DIR)/%, $^) -o $(OUT_DIR)/$(LIBION)

$(IONTEST): $(IONTEST_OBJ) $(LIBION)
	$(CC) $(CFLAGS) $(LDFLAGS) $(patsubst %, $(OUT_DIR)/%, $^) -o $(OUT_DIR)/$@

clean:
	rm -f $(OUT_DIR)/$(LIBION_OBJ) $(OUT_DIR)/$(LIBION) $(OUT_DIR)/$(IONTEST_OBJ) $(OUT_DIR)/$(IONTEST)
