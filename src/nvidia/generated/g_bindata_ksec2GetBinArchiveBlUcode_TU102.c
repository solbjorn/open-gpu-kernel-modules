/*
 * SPDX-FileCopyrightText: Copyright (c) 2016-2022 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 * SPDX-License-Identifier: MIT
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

#include "core/bin_data.h"
#include "g_kernel_sec2_nvoc.h"

/* THIS FILE IS AUTOMATICALLY GENERATED, DO NOT EDIT! */

static const BINDATA_ARCHIVE
__ksec2GetBinArchiveBlUcode_TU102 = BINDATA_ARCHIVE_INIT(
	BINDATA_ENTRY("ucode_image", "g_sec2_bl_gp10x_ucode_image.bin", 768),
	BINDATA_ENTRY("ucode_desc", "g_sec2_bl_gp10x_ucode_desc.bin", 24),
);

const BINDATA_ARCHIVE *ksec2GetBinArchiveBlUcode_TU102(struct OBJGPU *pGpu, struct KernelSec2 *pKernelSec2)
{
    return &__ksec2GetBinArchiveBlUcode_TU102;
}
