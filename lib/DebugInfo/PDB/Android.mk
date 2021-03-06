LOCAL_PATH:= $(call my-dir)

# No dia support
debuginfo_pdb_SRC_FILES := $(sort $(notdir $(wildcard $(LOCAL_PATH)/*.cpp)))

# lib/PDB/Raw is included into libLLVMDebugInfoPDB instead of as a separate module
debuginfo_pdb_raw_SRC_FILES = $(sort $(notdir $(wildcard $(LOCAL_PATH)/Raw/*.cpp)))
debuginfo_pdb_SRC_FILES += $(debuginfo_pdb_raw_SRC_FILES:%=Raw/%)

# For the host
# =====================================================
include $(CLEAR_VARS)

REQUIRES_RTTI := 1

LOCAL_SRC_FILES := $(debuginfo_pdb_SRC_FILES)

LOCAL_MODULE:= libLLVMDebugInfoPDB

LOCAL_MODULE_HOST_OS := darwin linux windows

include $(LLVM_HOST_BUILD_MK)
include $(LLVM_GEN_INTRINSICS_MK)
include $(BUILD_HOST_STATIC_LIBRARY)

# For the device
# =====================================================
ifneq (true,$(DISABLE_LLVM_DEVICE_BUILDS))
include $(CLEAR_VARS)

REQUIRES_RTTI := 1

LOCAL_SRC_FILES := $(debuginfo_pdb_SRC_FILES)

LOCAL_MODULE:= libLLVMDebugInfoPDB

include $(LLVM_DEVICE_BUILD_MK)
include $(LLVM_GEN_INTRINSICS_MK)
include $(BUILD_STATIC_LIBRARY)
endif
