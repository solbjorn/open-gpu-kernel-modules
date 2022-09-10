###########################################################################
# Kbuild file for NVIDIA Linux GPU driver kernel modules
###########################################################################

#
# The parent makefile is expected to define:
#
# NV_KERNEL_SOURCES : The root of the kernel source tree.
# NV_KERNEL_OUTPUT : The kernel's output tree.
# NV_KERNEL_MODULES : A whitespace-separated list of modules to build.
# ARCH : The target CPU architecture: x86_64|arm64|powerpc
#
# Kbuild provides the variables:
#
# $(src) : The directory containing this Kbuild file.
# $(obj) : The directory where the output from this build is written.
#
NV_KERNEL_SOURCES = $(abspath $(srctree))
NV_KERNEL_OUTPUT = $(abspath $(objtree))
NV_KERNEL_MODULES = nvidia nvidia-drm nvidia-modeset nvidia-peermem nvidia-uvm

ifdef CONFIG_RETPOLINE
NV_SPECTRE_V2 = 1
else
NV_SPECTRE_V2 = 0
endif

ifdef CONFIG_DRM_NVIDIA_DEBUG
NV_BUILD_TYPE = debug
endif
ifdef CONFIG_DRM_NVIDIA_DEVELOP
NV_BUILD_TYPE = develop
endif
ifndef NV_BUILD_TYPE
NV_BUILD_TYPE = release
endif

#
# Utility macro ASSIGN_PER_OBJ_CFLAGS: to control CFLAGS on a
# per-object basis, Kbuild honors the 'CFLAGS_$(object)' variable.
# E.g., "CFLAGS_nv.o" for CFLAGS that are specific to nv.o. Use this
# macro to assign 'CFLAGS_$(object)' variables for multiple object
# files.
#
# $(1): The object files.
# $(2): The CFLAGS to add for those object files.
#
# With kernel git commit 54b8ae66ae1a3454a7645d159a482c31cd89ab33, the
# handling of object-specific CFLAGs, CFLAGS_$(object) has changed. Prior to
# this commit, the CFLAGS_$(object) variable was required to be defined with
# only the the object name (<CFLAGS_somefile.o>). With the aforementioned git
# commit, it is now required to give Kbuild relative paths along-with the
# object name (CFLAGS_<somepath>/somefile.o>). As a result, CFLAGS_$(object)
# is set twice, once with a relative path to the object files and once with
# just the object files.
#
ASSIGN_PER_OBJ_CFLAGS = \
 $(foreach _cflags_variable, \
 $(notdir $(1)) $(1), \
 $(eval $(addprefix CFLAGS_,$(_cflags_variable)) += $(2)))


#
# Include the specifics of the individual NVIDIA kernel modules.
#
# Each of these should:
# - Append to 'obj-m', to indicate the kernel module that should be built.
# - Define the object files that should get built to produce the kernel module.
# - Tie into conftest (see the description below).
#

NV_UNDEF_BEHAVIOR_SANITIZER ?=
ifeq ($(NV_UNDEF_BEHAVIOR_SANITIZER),1)
 UBSAN_SANITIZE := y
endif

#
# Define CFLAGS that apply to all the NVIDIA kernel modules. EXTRA_CFLAGS
# is deprecated since 2.6.24 in favor of ccflags-y, but we need to support
# older kernels which do not have ccflags-y. Newer kernels append
# $(EXTRA_CFLAGS) to ccflags-y for compatibility.
#

COMMON_CFLAGS += -I$(abspath $(src))/common/inc
COMMON_CFLAGS += -I$(abspath $(src))
#EXTRA_CFLAGS += -Wall -MD $(DEFINES) $(INCLUDES) -Wno-cast-qual -Wno-error -Wno-format-extra-args
#EXTRA_CFLAGS += -D__KERNEL__ -DMODULE -DNVRM
#EXTRA_CFLAGS += -DNV_VERSION_STRING=\"515.65.01\"
COMMON_CFLAGS += -DNVRM -DNV_VERSION_STRING=$(call stringify,515.65.01)

#EXTRA_CFLAGS += -Wno-unused-function

#ifneq ($(NV_BUILD_TYPE),debug)
 COMMON_CFLAGS += -Wuninitialized
#endif

#EXTRA_CFLAGS += -fno-strict-aliasing

#ifeq ($(ARCH),arm64)
# EXTRA_CFLAGS += -mstrict-align
#endif

#ifeq ($(NV_BUILD_TYPE),debug)
# EXTRA_CFLAGS += -g -gsplit-dwarf
#endif

#EXTRA_CFLAGS += -ffreestanding

#ifeq ($(ARCH),arm64)
# EXTRA_CFLAGS += -mgeneral-regs-only -march=armv8-a
# EXTRA_CFLAGS += $(call cc-option,-mno-outline-atomics,)
#endif

#ifeq ($(ARCH),x86_64)
# EXTRA_CFLAGS += -mno-red-zone -mcmodel=kernel
#endif

#ifeq ($(ARCH),powerpc)
# EXTRA_CFLAGS += -mlittle-endian -mno-strict-align -mno-altivec
#endif

COMMON_CFLAGS += -DNV_UVM_ENABLE
COMMON_CFLAGS += $(call cc-option,-Werror=undef,)
COMMON_CFLAGS += -DNV_SPECTRE_V2=$(NV_SPECTRE_V2)
COMMON_CFLAGS += -DNV_KERNEL_INTERFACE_LAYER

#
# Detect SGI UV systems and apply system-specific optimizations.
#

ifneq ($(wildcard /proc/sgi_uv),)
 COMMON_CFLAGS += -DNV_CONFIG_X86_UV
endif

$(foreach _module, $(NV_KERNEL_MODULES), \
 $(eval include $(src)/$(_module)/$(_module).Kbuild))

#
# The conftest.sh script tests various aspects of the target kernel.
# The per-module Kbuild files included above should:
#
# - Append to the NV_CONFTEST_*_COMPILE_TESTS variables to indicate
# which conftests they require.
# - Append to the NV_OBJECTS_DEPEND_ON_CONFTEST variable any object files
# that depend on conftest.
#
# The conftest machinery below will run the requested tests and
# generate the appropriate header files.
#

CC ?= cc
LD ?= ld

NV_CONFTEST_SCRIPT := $(src)/conftest.sh
NV_CONFTEST_HEADER := $(obj)/conftest/headers.h

NV_CONFTEST_CMD := /bin/sh $(NV_CONFTEST_SCRIPT) \
 "$(CC)" $(ARCH) $(NV_KERNEL_SOURCES) $(NV_KERNEL_OUTPUT)

____NV_CONFTEST_CFLAGS = $(c_flags) $(COMMON_CFLAGS)
___NV_CONFTEST_CFLAGS = $(patsubst -I./%,-I$(abspath $(srctree))/%,$(____NV_CONFTEST_CFLAGS))
__NV_CONFTEST_CFLAGS = $(patsubst ./%,$(abspath $(srctree))/%,$(___NV_CONFTEST_CFLAGS))
_NV_CONFTEST_CFLAGS = $(patsubst -Wp$(comma)-MMD$(comma)%,-Wp$(comma)-MMD$(comma)$(abspath $(srctree))/%,$(__NV_CONFTEST_CFLAGS))
NV_CONFTEST_CFLAGS = $(patsubst -frandomize-layout-seed-file=./%,\
		       -frandomize-layout-seed-file=$(abspath $(srctree))/%,\
		       $(_NV_CONFTEST_CFLAGS))

NV_CONFTEST_CFLAGS += -Wno-error=implicit-function-declaration # relies to test args

NV_CONFTEST_COMPILE_TEST_HEADERS := $(obj)/conftest/macros.h
NV_CONFTEST_COMPILE_TEST_HEADERS += $(obj)/conftest/functions.h
NV_CONFTEST_COMPILE_TEST_HEADERS += $(obj)/conftest/symbols.h
NV_CONFTEST_COMPILE_TEST_HEADERS += $(obj)/conftest/types.h
NV_CONFTEST_COMPILE_TEST_HEADERS += $(obj)/conftest/generic.h

NV_CONFTEST_HEADERS := $(obj)/conftest/patches.h
NV_CONFTEST_HEADERS += $(obj)/conftest/headers.h
NV_CONFTEST_HEADERS += $(NV_CONFTEST_COMPILE_TEST_HEADERS)


#
# Generate a header file for a single conftest compile test. Each compile test
# header depends on conftest.sh, as well as the generated conftest/headers.h
# file, which is included in the compile test preamble.
#

$(obj)/conftest/compile-tests/%.h: $(NV_CONFTEST_SCRIPT) $(NV_CONFTEST_HEADER)
	@mkdir -p $(obj)/conftest/compile-tests
	@echo "  CFGTEST $(notdir $*)"
	@$(NV_CONFTEST_CMD) compile_tests '$(NV_CONFTEST_CFLAGS)' \
	 $(notdir $*) > $@

#
# Concatenate a conftest/*.h header from its constituent compile test headers
#
# $(1): The name of the concatenated header
# $(2): The list of compile tests that make up the header
#

define NV_GENERATE_COMPILE_TEST_HEADER
 $(obj)/conftest/$(1).h: $(addprefix $(obj)/conftest/compile-tests/,$(addsuffix .h,$(2)))
	@mkdir -p $(obj)/conftest
	@# concatenate /dev/null to prevent cat from hanging when $$^ is empty
	@cat $$^ /dev/null > $$@
endef

#
# Generate the conftest compile test headers from the lists of compile tests
# provided by the module-specific Kbuild files.
#

NV_CONFTEST_FUNCTION_COMPILE_TESTS ?=
NV_CONFTEST_GENERIC_COMPILE_TESTS ?=
NV_CONFTEST_MACRO_COMPILE_TESTS ?=
NV_CONFTEST_SYMBOL_COMPILE_TESTS ?=
NV_CONFTEST_TYPE_COMPILE_TESTS ?=

$(eval $(call NV_GENERATE_COMPILE_TEST_HEADER,functions,$(NV_CONFTEST_FUNCTION_COMPILE_TESTS)))
$(eval $(call NV_GENERATE_COMPILE_TEST_HEADER,generic,$(NV_CONFTEST_GENERIC_COMPILE_TESTS)))
$(eval $(call NV_GENERATE_COMPILE_TEST_HEADER,macros,$(NV_CONFTEST_MACRO_COMPILE_TESTS)))
$(eval $(call NV_GENERATE_COMPILE_TEST_HEADER,symbols,$(NV_CONFTEST_SYMBOL_COMPILE_TESTS)))
$(eval $(call NV_GENERATE_COMPILE_TEST_HEADER,types,$(NV_CONFTEST_TYPE_COMPILE_TESTS)))

$(obj)/conftest/patches.h: $(NV_CONFTEST_SCRIPT)
	@mkdir -p $(obj)/conftest
	@$(NV_CONFTEST_CMD) patch_check > $@

$(obj)/conftest/headers.h: $(NV_CONFTEST_SCRIPT)
	@mkdir -p $(obj)/conftest
	@$(NV_CONFTEST_CMD) test_kernel_headers '$(NV_CONFTEST_CFLAGS)' > $@

clean-dirs := $(obj)/conftest


# For any object files that depend on conftest, declare the dependency here.
$(addprefix $(obj)/,$(NV_OBJECTS_DEPEND_ON_CONFTEST)): | $(NV_CONFTEST_HEADERS)

# Sanity checks of the build environment and target system/kernel

BUILD_SANITY_CHECKS = \
 cc_sanity_check \
 cc_version_check \
 dom0_sanity_check \
 xen_sanity_check \
 preempt_rt_sanity_check \
 vgpu_kvm_sanity_check \
 module_symvers_sanity_check

.PHONY: $(BUILD_SANITY_CHECKS)

$(BUILD_SANITY_CHECKS):
	@$(NV_CONFTEST_CMD) $@ full_output

# Perform all sanity checks before generating the conftest headers

$(NV_CONFTEST_HEADERS): | $(BUILD_SANITY_CHECKS)

# Make the conftest headers depend on the kernel version string

targets += conftest/uts_release.h

filechk_uts_release = $(NV_CONFTEST_CMD) compile_tests "$(NV_CONFTEST_CFLAGS)" uts_release

$(obj)/conftest/uts_release.h: FORCE
	@mkdir -p $(dir $@)
	$(call filechk,uts_release)

$(NV_CONFTEST_HEADERS): $(obj)/conftest/uts_release.h
