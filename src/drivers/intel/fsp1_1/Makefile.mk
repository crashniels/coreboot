# SPDX-License-Identifier: GPL-2.0-only

ifeq ($(CONFIG_PLATFORM_USES_FSP1_1),y)

bootblock-$(CONFIG_USE_GENERIC_FSP_CAR_INC) += cache_as_ram.S
bootblock-y += fsp_util.c
bootblock-y += ../../../cpu/intel/microcode/microcode_asm.S
bootblock-y += fsp_report.c

romstage-y += car.c
romstage-y += fsp_util.c
romstage-y += hob.c
romstage-y += raminit.c
romstage-y += romstage.c

ramstage-y += fsp_relocate.c
ramstage-y += fsp_util.c
ramstage-y += hob.c
ramstage-y += ramstage.c
ramstage-$(CONFIG_INTEL_GMA_ADD_VBT) += vbt.c

CPPFLAGS_common += -Isrc/drivers/intel/fsp1_1/include

ifneq ($(CONFIG_SKIP_FSP_CAR),y)
postcar-y += temp_ram_exit.c
postcar-y += exit_car.S
endif
postcar-y += fsp_util.c

# Add the FSP binary to the cbfs image
ifeq ($(CONFIG_HAVE_FSP_BIN),y)
cbfs-files-y += fsp.bin
fsp.bin-file := $(call strip_quotes,$(CONFIG_FSP_FILE))
fsp.bin-type := fsp
fsp.bin-options := --xip $(TXTIBB)
fsp.bin-COREBOOT-position := $(CONFIG_FSP_LOC)
endif

endif
