# ------------------------------------------------------------
# ugBASIC Makefile for macOS using Docker (cbegin/ugbasic:main)
# ------------------------------------------------------------

# Default settings
FILE ?= test.bas
COMPILER ?= c64
OUTPUT_FILE := $(basename $(FILE)).$(COMPILER).prg

# Path to VICE emulator (adjust if installed elsewhere)
VICE_PATH=/opt/homebrew/bin
EMULATOR=x64sc

# ------------------------------------------------------------
# Generic compile and run targets
# ------------------------------------------------------------

compile:
	docker run --rm -v $(PWD):/src -w /src cbegin/ugbasic:main /app/ugbc.$(COMPILER) $(FILE) -o $(OUTPUT_FILE)

run:
	$(VICE_PATH)/$(EMULATOR) $(OUTPUT_FILE)

all: compile run

# ------------------------------------------------------------
# Commodore platform shortcuts
# ------------------------------------------------------------
# Usage examples:
#   make c64 FILE=mygame.bas
#   make vic20 FILE=mygame.bas
#   make plus4 FILE=mygame.bas
#   make pet FILE=mygame.bas   (alias to c64 until native pet available)

c64:
	docker run --rm -v $(PWD):/src -w /src cbegin/ugbasic:main /app/ugbc.c64 $(FILE) -o $(basename $(FILE)).c64.prg
	$(VICE_PATH)/x64sc $(basename $(FILE)).c64.prg

c64reu:
	docker run --rm -v $(PWD):/src -w /src cbegin/ugbasic:main /app/ugbc.c64reu $(FILE) -o $(basename $(FILE)).c64reu.prg
	$(VICE_PATH)/x64sc $(basename $(FILE)).c64reu.prg

c128:
	docker run --rm -v $(PWD):/src -w /src cbegin/ugbasic:main /app/ugbc.c128 $(FILE) -o $(basename $(FILE)).c128.prg
	$(VICE_PATH)/x128 $(basename $(FILE)).c128.prg

plus4:
	docker run --rm -v $(PWD):/src -w /src cbegin/ugbasic:main /app/ugbc.plus4 $(FILE) -o $(basename $(FILE)).plus4.prg
	$(VICE_PATH)/xplus4 $(basename $(FILE)).plus4.prg

vic20:
	docker run --rm -v $(PWD):/src -w /src cbegin/ugbasic:main /app/ugbc.vic20 $(FILE) -o $(basename $(FILE)).vic20.prg
	$(VICE_PATH)/xvic $(basename $(FILE)).vic20.prg

pet:
	docker run --rm -v $(PWD):/src -w /src cbegin/ugbasic:main /app/ugbc.c64 $(FILE) -o $(basename $(FILE)).pet.prg
	$(VICE_PATH)/xpet $(basename $(FILE)).pet.prg

# ------------------------------------------------------------
# Maintenance and cleanup
# ------------------------------------------------------------

clean:
	rm -f *.prg *.lst

list:
	docker run --rm cbegin/ugbasic:main ls -1 /app | grep ugbc.

