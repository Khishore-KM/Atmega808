#####################
# Variables  : edit this section accordingly

DEVICE = atmega808
F_CPU = 16000000 #20MHz
OUT = "ATMEGA808_blink"
SRC = 808led.c
COM = COM5
AVR_BASE_PATH = D:\avr-gcc-8.5.0-1-x64-windows

#####################

INC = -I $(AVR_BASE_PATH)/avr/include
CFLAGS = -Os $(INC) -mmcu=$(DEVICE) -DF_CPU=$(F_CPU) -Wall 
LDFLAGS = -mmcu=$(DEVICE)
CC = $(AVR_BASE_PATH)/bin/avr-gcc
OBJCPY = $(AVR_BASE_PATH)/bin/avr-objcopy
SIZE = $(AVR_BASE_PATH)/bin/avr-size
OBJS = $(SRC:.c=.o)

$(OUT).hex: $(OUT).elf
	$(OBJCPY) -O ihex $(OUT).elf $(OUT).hex
	$(SIZE) $(OUT).hex

$(OUT).elf: $(OBJS)
	$(CC) $(LDFLAGS) -o $(OUT).elf $(OBJS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

.phony: clean
clean:
	del *.o *.hex *.elf

.phony: ping
ping:
	pymcuprog ping -t uart -u $(COM) -d $(DEVICE)

.phony: erase
erase:
	pymcuprog erase -t uart -u $(COM) -d $(DEVICE)

.phony: flash
flash: $(OUT).hex
	pymcuprog write -t uart -u $(COM) -d $(DEVICE) -f $<
