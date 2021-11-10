#
## makefile for libion and iontest
#
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
	$(CC) -c -fPIC  $(CFLAGS) $^ -o $@

$(LIBION): $(LIBION_OBJ)
	$(CC) -shared  -Wl,-soname,$(LIBION) -fPIC $(CFLAGS) $^ -o $(LIBION)

$(IONTEST): $(IONTEST_OBJ) $(LIBION)
	$(CC) $^ $(CFLAGS)  -o $@

clean:
	rm -f $(LIBION_OBJ) $(LIBION) $(IONTEST_OBJ) $(IONTEST)

