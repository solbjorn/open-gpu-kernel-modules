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
NV_KERNEL_MODULES = nvidia nvidia-common nvidia-drm nvidia-modeset nvidia-peermem nvidia-uvm

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

subdir-ccflags-y += -DNV_VERSION_STRING=$(call stringify,530.41.03)

COMMON_CFLAGS += -I$(src)/common/inc
COMMON_CFLAGS += -DNVRM

COMMON_CFLAGS += -Wuninitialized

COMMON_CFLAGS += -DNV_UVM_ENABLE
COMMON_CFLAGS += $(call cc-option,-Werror=undef,)
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
#
# The conftest machinery below will run the requested tests and
# generate the appropriate header files.
#

NV_CONFTEST_SCRIPT := $(src)/conftest.sh
NV_CONFTEST_HEADER := $(obj)/conftest/headers.h

NV_CONFTEST_CMD := /bin/sh $(NV_CONFTEST_SCRIPT) \
 "$(CC)" $(ARCH) $(NV_KERNEL_SOURCES) $(NV_KERNEL_OUTPUT)

____NV_CONFTEST_CFLAGS = $(c_flags) $(filter-out -I%, $(COMMON_CFLAGS))
___NV_CONFTEST_CFLAGS = $(patsubst -I./%,-I$(abspath $(srctree))/%,$(____NV_CONFTEST_CFLAGS))
__NV_CONFTEST_CFLAGS = $(patsubst ./%,$(abspath $(srctree))/%,$(___NV_CONFTEST_CFLAGS))
_NV_CONFTEST_CFLAGS = $(patsubst -Wp$(comma)-MMD$(comma)%,-Wp$(comma)-MMD$(comma)$(abspath $(srctree))/%,$(__NV_CONFTEST_CFLAGS))
NV_CONFTEST_CFLAGS = $(patsubst -frandomize-layout-seed-file=./%,\
		       -frandomize-layout-seed-file=$(abspath $(srctree))/%,\
		       $(_NV_CONFTEST_CFLAGS))

NV_CONFTEST_CFLAGS += -Wno-error=implicit-function-declaration # relies to test args
NV_CONFTEST_CFLAGS += -Wno-error=missing-prototypes

NV_CONFTEST_COMPILE_TEST_HEADERS := $(obj)/conftest/functions.h
NV_CONFTEST_COMPILE_TEST_HEADERS += $(obj)/conftest/generic.h
NV_CONFTEST_COMPILE_TEST_HEADERS += $(obj)/conftest/macros.h
NV_CONFTEST_COMPILE_TEST_HEADERS += $(obj)/conftest/symbols.h
NV_CONFTEST_COMPILE_TEST_HEADERS += $(obj)/conftest/types.h

NV_CONFTEST_HEADERS := $(obj)/conftest/headers.h
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

# Each of these headers is checked for presence with a test #include; a
# corresponding #define will be generated in conftest/headers.h.
NV_HEADER_PRESENCE_TESTS = $(sort \
 asm/system.h \
 drm/drmP.h \
 drm/drm_auth.h \
 drm/drm_gem.h \
 drm/drm_crtc.h \
 drm/drm_atomic.h \
 drm/drm_atomic_helper.h \
 drm/drm_encoder.h \
 drm/drm_atomic_uapi.h \
 drm/drm_drv.h \
 drm/drm_framebuffer.h \
 drm/drm_connector.h \
 drm/drm_probe_helper.h \
 drm/drm_blend.h \
 drm/drm_fourcc.h \
 drm/drm_prime.h \
 drm/drm_plane.h \
 drm/drm_vblank.h \
 drm/drm_file.h \
 drm/drm_ioctl.h \
 drm/drm_device.h \
 drm/drm_mode_config.h \
 drm/drm_modeset_lock.h \
 dt-bindings/interconnect/tegra_icc_id.h \
 generated/autoconf.h \
 generated/compile.h \
 generated/utsrelease.h \
 linux/efi.h \
 linux/kconfig.h \
 linux/platform/tegra/mc_utils.h \
 linux/semaphore.h \
 linux/printk.h \
 linux/ratelimit.h \
 linux/prio_tree.h \
 linux/log2.h \
 linux/of.h \
 linux/bug.h \
 linux/sched.h \
 linux/sched/mm.h \
 linux/sched/signal.h \
 linux/sched/task.h \
 linux/sched/task_stack.h \
 xen/ioemu.h \
 linux/fence.h \
 linux/dma-resv.h \
 soc/tegra/chip-id.h \
 soc/tegra/fuse.h \
 soc/tegra/tegra_bpmp.h \
 video/nv_internal.h \
 linux/platform/tegra/dce/dce-client-ipc.h \
 linux/nvhost.h \
 linux/nvhost_t194.h \
 linux/host1x-next.h \
 asm/book3s/64/hash-64k.h \
 asm/set_memory.h \
 asm/prom.h \
 asm/powernv.h \
 linux/atomic.h \
 asm/barrier.h \
 asm/opal-api.h \
 sound/hdaudio.h \
 asm/pgtable_types.h \
 linux/stringhash.h \
 linux/dma-map-ops.h \
 rdma/peer_mem.h \
 sound/hda_codec.h \
 linux/dma-buf.h \
 linux/time.h \
 linux/platform_device.h \
 linux/mutex.h \
 linux/reset.h \
 linux/of_platform.h \
 linux/of_device.h \
 linux/of_gpio.h \
 linux/gpio.h \
 linux/gpio/consumer.h \
 linux/interconnect.h \
 linux/pm_runtime.h \
 linux/clk.h \
 linux/clk-provider.h \
 linux/ioasid.h \
 linux/stdarg.h \
 linux/iosys-map.h \
 asm/coco.h \
 linux/vfio_pci_core.h \
 soc/tegra/bpmp-abi.h \
 soc/tegra/bpmp.h \
)

# Filename to store the define for the header in $(1); this is only consumed by
# the rule below that concatenates all of these together.
NV_HEADER_PRESENCE_PART = $(addprefix $(obj)/conftest/header_presence/,$(addsuffix .part,$(1)))

# Define a rule to check the header $(1).
define NV_HEADER_PRESENCE_CHECK
 $$(call NV_HEADER_PRESENCE_PART,$(1)): $$(NV_CONFTEST_SCRIPT)
	@mkdir -p $$(dir $$@)
	@echo "  HDRTEST $(1)"
	@$$(NV_CONFTEST_CMD) test_kernel_header '$$(NV_CONFTEST_CFLAGS)' '$(1)' > $$@
endef

# Evaluate the rule above for each header in the list.
$(foreach header,$(NV_HEADER_PRESENCE_TESTS),$(eval $(call NV_HEADER_PRESENCE_CHECK,$(header))))

# Concatenate all of the parts into headers.h.
$(obj)/conftest/headers.h: $(call NV_HEADER_PRESENCE_PART,$(NV_HEADER_PRESENCE_TESTS))
	@cat $^ > $@

define NV_CONFTEST_SYNC_CHECK
$(obj)/conftest/.checked-$(1).h: $(obj)/conftest/$(1).h
	@echo "  CHK     conftest/$(1).h"
	@! diff -Naurp $(src)/common/inc/conftest/$(1).h $$< | grep -q . || ( \
		echo >&2 "  ERROR: $(1).h is out of sync";		      \
		/bin/false						      \
	)
	@touch $$@
endef

$(eval $(call NV_CONFTEST_SYNC_CHECK,functions))
$(eval $(call NV_CONFTEST_SYNC_CHECK,generic))
$(eval $(call NV_CONFTEST_SYNC_CHECK,headers))
$(eval $(call NV_CONFTEST_SYNC_CHECK,macros))
$(eval $(call NV_CONFTEST_SYNC_CHECK,symbols))
$(eval $(call NV_CONFTEST_SYNC_CHECK,types))

always-$(CONFIG_DRM_NVIDIA) += conftest/.checked-functions.h
always-$(CONFIG_DRM_NVIDIA) += conftest/.checked-generic.h
always-$(CONFIG_DRM_NVIDIA) += conftest/.checked-headers.h
always-$(CONFIG_DRM_NVIDIA) += conftest/.checked-macros.h
always-$(CONFIG_DRM_NVIDIA) += $(if $(wildcard $(objtree)/Module.symvers), \
				 conftest/.checked-symbols.h)
always-$(CONFIG_DRM_NVIDIA) += conftest/.checked-types.h

clean-dirs := $(obj)/conftest

# Sanity checks of the build environment and target system/kernel

BUILD_SANITY_CHECKS = \
 cc_sanity_check \
 cc_version_check \
 dom0_sanity_check \
 xen_sanity_check \
 preempt_rt_sanity_check \
 vgpu_kvm_sanity_check \
 $(if $(wildcard $(objtree)/Module.symvers), \
   module_symvers_sanity_check)

.PHONY: $(BUILD_SANITY_CHECKS)

$(BUILD_SANITY_CHECKS):
	@$(NV_CONFTEST_CMD) $@ full_output

# Perform all sanity checks before generating the conftest headers

$(NV_CONFTEST_HEADERS): | $(BUILD_SANITY_CHECKS)
