# Settings for Espressif ESP32
# Current file in tf 2.4.2 is wrong

ifeq ($(TARGET), esp32)
  TARGET_ARCH := xtensa-esp32
  CCFLAGS := $(filter-out -std=c11,$(CCFLAGS))
  CFLAGS += -std=c11
endif