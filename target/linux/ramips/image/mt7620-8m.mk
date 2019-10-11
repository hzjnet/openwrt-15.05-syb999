#
# MT7620A Profiles
#

DEVICE_VARS += TPLINK_FLASHLAYOUT TPLINK_HWID TPLINK_HWREV TPLINK_HWREVADD TPLINK_HVERSION \
	DLINK_ROM_ID DLINK_FAMILY_MEMBER DLINK_FIRMWARE_SIZE

define Build/elecom-header
	cp $@ $(KDIR)/v_0.0.0.bin
	( \
		mkhash md5 $(KDIR)/v_0.0.0.bin && \
		echo 458 \
	) | mkhash md5 > $(KDIR)/v_0.0.0.md5
	$(STAGING_DIR_HOST)/bin/tar -c \
		$(if $(SOURCE_DATE_EPOCH),--mtime=@$(SOURCE_DATE_EPOCH)) \
		-f $@ -C $(KDIR) v_0.0.0.bin v_0.0.0.md5
endef

define Build/zyimage
	$(STAGING_DIR_HOST)/bin/zyimage $(1) $@
endef

define Device/ai-br100
  DTS := AIBR100
  DEVICE_TITLE := Aigale Ai-BR100
  DEVICE_PACKAGES:= kmod-usb2 kmod-usb-ohci
endef
TARGET_DEVICES += ai-br100

define Device/e1700
  DTS := E1700
  IMAGES += factory.bin
  DEVICE_TITLE := Linksys E1700
endef
TARGET_DEVICES += e1700

define Device/mt7620a
  DTS := MT7620a
  DEVICE_TITLE := MediaTek MT7620a EVB
endef
TARGET_DEVICES += mt7620a

define Device/rt-n14u
  DTS := RT-N14U
  IMAGE_SIZE := $(ralink_default_fw_size_8M)
  DEVICE_TITLE := Asus RT-N14u
endef
TARGET_DEVICES += rt-n14u

define Device/psg1208
  DTS := PSG1208
  IMAGE_SIZE := $(ralink_default_fw_size_8M)
  DEVICE_TITLE := Phicomm PSG1208
endef
TARGET_DEVICES += psg1208

define Device/psg1218
  DTS := PSG1218
  IMAGE_SIZE := $(ralink_default_fw_size_8M)
  DEVICE_TITLE := Phicomm PSG1218
endef
TARGET_DEVICES += psg1218


