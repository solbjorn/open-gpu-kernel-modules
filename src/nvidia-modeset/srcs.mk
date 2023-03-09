NVIDIA_MODESET_API_SRCS ?=
NVIDIA_MODESET_API_SRCS_CXX ?=

NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/8086-SSE/s_commonNaNToF16UI.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/8086-SSE/s_commonNaNToF32UI.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/8086-SSE/s_commonNaNToF64UI.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/8086-SSE/s_f32UIToCommonNaN.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/8086-SSE/s_f64UIToCommonNaN.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/8086-SSE/s_propagateNaNF32UI.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/8086-SSE/s_propagateNaNF64UI.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/8086-SSE/softfloat_raiseFlags.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_add.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_div.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_eq.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_eq_signaling.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_isSignalingNaN.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_le.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_le_quiet.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_lt.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_lt_quiet.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_mul.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_mulAdd.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_rem.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_roundToInt.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_sqrt.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_sub.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_to_f16.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_to_f64.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_to_i32.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_to_i32_r_minMag.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_to_i64.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_to_i64_r_minMag.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_to_ui32.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_to_ui32_r_minMag.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_to_ui64.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f32_to_ui64_r_minMag.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_add.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_div.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_eq.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_eq_signaling.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_isSignalingNaN.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_le.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_le_quiet.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_lt.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_lt_quiet.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_mul.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_mulAdd.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_rem.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_roundToInt.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_sqrt.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_sub.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_to_f32.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_to_i32.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_to_i32_r_minMag.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_to_i64.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_to_i64_r_minMag.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_to_ui32.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_to_ui32_r_minMag.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_to_ui64.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/f64_to_ui64_r_minMag.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/i32_to_f32.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/i32_to_f64.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/i64_to_f32.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/i64_to_f64.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_addMagsF32.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_addMagsF64.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_approxRecipSqrt32_1.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_approxRecipSqrt_1Ks.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_countLeadingZeros64.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_countLeadingZeros8.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_mul64To128.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_mulAddF32.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_mulAddF64.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_normRoundPackToF32.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_normRoundPackToF64.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_normSubnormalF32Sig.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_normSubnormalF64Sig.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_roundPackToF16.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_roundPackToF32.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_roundPackToF64.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_roundToI32.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_roundToI64.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_roundToUI32.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_roundToUI64.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_shiftRightJam128.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_subMagsF32.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/s_subMagsF64.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/softfloat_state.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/ui32_to_f32.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/ui32_to_f64.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/ui64_to_f32.c
NVIDIA_MODESET_API_SRCS += src/common/softfloat/source/ui64_to_f64.c
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_auxretry.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_bitstream.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_buffer.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_configcaps.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_connectorimpl.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_crc.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_deviceimpl.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_discovery.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_edid.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_evoadapter.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_groupimpl.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_guid.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_list.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_merger.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_messagecodings.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_messageheader.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_messages.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_mst_edid.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_splitter.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_sst_edid.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_timer.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_vrr.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_wardatabase.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dp_watermark.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/common/displayport/src/dptestutil/dp_testmessage.cpp
NVIDIA_MODESET_API_SRCS += src/common/modeset/hdmipacket/nvhdmipkt.c
NVIDIA_MODESET_API_SRCS += src/common/modeset/hdmipacket/nvhdmipkt_0073.c
NVIDIA_MODESET_API_SRCS += src/common/modeset/hdmipacket/nvhdmipkt_9171.c
NVIDIA_MODESET_API_SRCS += src/common/modeset/hdmipacket/nvhdmipkt_9271.c
NVIDIA_MODESET_API_SRCS += src/common/modeset/hdmipacket/nvhdmipkt_9471.c
NVIDIA_MODESET_API_SRCS += src/common/modeset/hdmipacket/nvhdmipkt_9571.c
NVIDIA_MODESET_API_SRCS += src/common/modeset/hdmipacket/nvhdmipkt_C371.c
NVIDIA_MODESET_API_SRCS += src/common/modeset/hdmipacket/nvhdmipkt_C671.c
NVIDIA_MODESET_API_SRCS += src/common/modeset/hdmipacket/nvhdmipkt_C771.c
NVIDIA_MODESET_API_SRCS += src/common/modeset/timing/nvt_cvt.c
NVIDIA_MODESET_API_SRCS += src/common/modeset/timing/nvt_displayid20.c
NVIDIA_MODESET_API_SRCS += src/common/modeset/timing/nvt_dmt.c
NVIDIA_MODESET_API_SRCS += src/common/modeset/timing/nvt_dsc_pps.c
NVIDIA_MODESET_API_SRCS += src/common/modeset/timing/nvt_edid.c
NVIDIA_MODESET_API_SRCS += src/common/modeset/timing/nvt_edidext_861.c
NVIDIA_MODESET_API_SRCS += src/common/modeset/timing/nvt_edidext_displayid.c
NVIDIA_MODESET_API_SRCS += src/common/modeset/timing/nvt_edidext_displayid20.c
NVIDIA_MODESET_API_SRCS += src/common/modeset/timing/nvt_gtf.c
NVIDIA_MODESET_API_SRCS += src/common/modeset/timing/nvt_tv.c
NVIDIA_MODESET_API_SRCS += src/common/modeset/timing/nvt_util.c
NVIDIA_MODESET_API_SRCS += src/common/unix/common/utils/nv_memory_tracker.c
NVIDIA_MODESET_API_SRCS += src/common/unix/common/utils/nv_mode_timings_utils.c
NVIDIA_MODESET_API_SRCS += src/common/unix/common/utils/unix_rm_handle.c
NVIDIA_MODESET_API_SRCS += src/common/unix/nvidia-3d/src/nvidia-3d-core.c
NVIDIA_MODESET_API_SRCS += src/common/unix/nvidia-3d/src/nvidia-3d-fermi.c
NVIDIA_MODESET_API_SRCS += src/common/unix/nvidia-3d/src/nvidia-3d-hopper.c
NVIDIA_MODESET_API_SRCS += src/common/unix/nvidia-3d/src/nvidia-3d-init.c
NVIDIA_MODESET_API_SRCS += src/common/unix/nvidia-3d/src/nvidia-3d-kepler.c
NVIDIA_MODESET_API_SRCS += src/common/unix/nvidia-3d/src/nvidia-3d-maxwell.c
NVIDIA_MODESET_API_SRCS += src/common/unix/nvidia-3d/src/nvidia-3d-pascal.c
NVIDIA_MODESET_API_SRCS += src/common/unix/nvidia-3d/src/nvidia-3d-surface.c
NVIDIA_MODESET_API_SRCS += src/common/unix/nvidia-3d/src/nvidia-3d-turing.c
NVIDIA_MODESET_API_SRCS += src/common/unix/nvidia-3d/src/nvidia-3d-vertex-arrays.c
NVIDIA_MODESET_API_SRCS += src/common/unix/nvidia-3d/src/nvidia-3d-volta.c
NVIDIA_MODESET_API_SRCS += src/common/unix/nvidia-push/src/nvidia-push-init.c
NVIDIA_MODESET_API_SRCS += src/common/unix/nvidia-push/src/nvidia-push.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/kapi/src/nvkms-kapi-notifiers.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/kapi/src/nvkms-kapi-sync.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/kapi/src/nvkms-kapi.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/lib/nvkms-format.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/lib/nvkms-sync.c
NVIDIA_MODESET_API_SRCS_CXX += src/nvidia-modeset/src/dp/nvdp-connector-event-sink.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/nvidia-modeset/src/dp/nvdp-connector.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/nvidia-modeset/src/dp/nvdp-device.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/nvidia-modeset/src/dp/nvdp-evo-interface.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/nvidia-modeset/src/dp/nvdp-host.cpp
NVIDIA_MODESET_API_SRCS_CXX += src/nvidia-modeset/src/dp/nvdp-timer.cpp
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/g_nvkms-evo-states.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-3dvision.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-attributes.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-conf.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-console-restore.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-cursor.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-cursor2.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-cursor3.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-difr.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-dma.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-dpy-override.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-dpy.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-event.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-evo.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-evo1.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-evo2.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-evo3.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-flip.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-framelock.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-hal.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-hdmi.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-hw-flip.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-headsurface-3d.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-headsurface-config.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-headsurface-ioctl.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-headsurface-matrix.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-headsurface-swapgroup.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-headsurface.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-hw-states.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-lut.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-modepool.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-modeset.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-pow.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-prealloc.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-push.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-rm.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-rmapi-dgpu.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-stereo.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-surface.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-utils-flip.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-utils.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms-vrr.c
NVIDIA_MODESET_API_SRCS += src/nvidia-modeset/src/nvkms.c
