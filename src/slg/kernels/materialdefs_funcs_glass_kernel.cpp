#include <string>
namespace slg { namespace ocl {
std::string KernelSource_materialdefs_funcs_glass = 
"#line 2 \"materialdefs_funcs_glass.cl\"\n"
"\n"
"/***************************************************************************\n"
" * Copyright 1998-2017 by authors (see AUTHORS.txt)                        *\n"
" *                                                                         *\n"
" *   This file is part of LuxRender.                                       *\n"
" *                                                                         *\n"
" * Licensed under the Apache License, Version 2.0 (the \"License\");         *\n"
" * you may not use this file except in compliance with the License.        *\n"
" * You may obtain a copy of the License at                                 *\n"
" *                                                                         *\n"
" *     http://www.apache.org/licenses/LICENSE-2.0                          *\n"
" *                                                                         *\n"
" * Unless required by applicable law or agreed to in writing, software     *\n"
" * distributed under the License is distributed on an \"AS IS\" BASIS,       *\n"
" * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.*\n"
" * See the License for the specific language governing permissions and     *\n"
" * limitations under the License.                                          *\n"
" ***************************************************************************/\n"
"\n"
"//------------------------------------------------------------------------------\n"
"// Glass material\n"
"//------------------------------------------------------------------------------\n"
"\n"
"#if defined (PARAM_ENABLE_MAT_GLASS)\n"
"\n"
"BSDFEvent GlassMaterial_GetEventTypes() {\n"
"	return SPECULAR | REFLECT | TRANSMIT;\n"
"}\n"
"\n"
"bool GlassMaterial_IsDelta() {\n"
"	return true;\n"
"}\n"
"\n"
"float3 GlassMaterial_Evaluate(\n"
"		__global HitPoint *hitPoint, const float3 lightDir, const float3 eyeDir,\n"
"		BSDFEvent *event, float *directPdfW,\n"
"		const float3 ktTexVal, const float3 krTexVal,\n"
"		const float nc, const float nt) {\n"
"	return BLACK;\n"
"}\n"
"\n"
"float3 GlassMaterial_Sample(\n"
"		__global HitPoint *hitPoint, const float3 localFixedDir, float3 *localSampledDir,\n"
"		const float u0, const float u1,\n"
"#if defined(PARAM_HAS_PASSTHROUGH)\n"
"		const float passThroughEvent,\n"
"#endif\n"
"		float *pdfW, float *absCosSampledDir, BSDFEvent *event,\n"
"		const BSDFEvent requestedEvent,\n"
"		const float3 ktTexVal, const float3 krTexVal,\n"
"		const float nc, const float nt) {\n"
"	if (!(requestedEvent & SPECULAR))\n"
"		return BLACK;\n"
"\n"
"	const float3 kt = Spectrum_Clamp(ktTexVal);\n"
"	const float3 kr = Spectrum_Clamp(krTexVal);\n"
"\n"
"	const bool isKtBlack = Spectrum_IsBlack(kt);\n"
"	const bool isKrBlack = Spectrum_IsBlack(kr);\n"
"	if (isKtBlack && isKrBlack)\n"
"		return BLACK;\n"
"\n"
"	const bool entering = (CosTheta(localFixedDir) > 0.f);\n"
"	const float ntc = nt / nc;\n"
"	const float costheta = CosTheta(localFixedDir);\n"
"\n"
"	// Decide to transmit or reflect\n"
"	float threshold;\n"
"	if ((requestedEvent & REFLECT) && !isKrBlack) {\n"
"		if ((requestedEvent & TRANSMIT) && !isKtBlack)\n"
"			threshold = .5f;\n"
"		else\n"
"			threshold = 0.f;\n"
"	} else {\n"
"		if ((requestedEvent & TRANSMIT) && !isKtBlack)\n"
"			threshold = 1.f;\n"
"		else\n"
"			return BLACK;\n"
"	}\n"
"\n"
"	float3 result;\n"
"	if (passThroughEvent < threshold) {\n"
"		// Transmit\n"
"	\n"
"		// Compute transmitted ray direction\n"
"		const float sini2 = SinTheta2(localFixedDir);\n"
"		const float eta = entering ? (nc / nt) : ntc;\n"
"		const float eta2 = eta * eta;\n"
"		const float sint2 = eta2 * sini2;\n"
"\n"
"		// Handle total internal reflection for transmission\n"
"		if (sint2 >= 1.f)\n"
"			return BLACK;\n"
"\n"
"		const float cost = sqrt(fmax(0.f, 1.f - sint2)) * (entering ? -1.f : 1.f);\n"
"		*localSampledDir = (float3)(-eta * localFixedDir.x, -eta * localFixedDir.y, cost);\n"
"		*absCosSampledDir = fabs(CosTheta(*localSampledDir));\n"
"\n"
"		*event = SPECULAR | TRANSMIT;\n"
"		*pdfW = threshold;\n"
"\n"
"		//if (!hitPoint.fromLight)\n"
"			result = (1.f - FresnelCauchy_Evaluate(ntc, cost)) * eta2;\n"
"		//else\n"
"		//	result = (1.f - FresnelCauchy_Evaluate(ntc, costheta));\n"
"\n"
"		result *= kt;\n"
"	} else {\n"
"		// Reflect\n"
"		*localSampledDir = (float3)(-localFixedDir.x, -localFixedDir.y, localFixedDir.z);\n"
"		*absCosSampledDir = fabs(CosTheta(*localSampledDir));\n"
"\n"
"		*event = SPECULAR | REFLECT;\n"
"		*pdfW = 1.f - threshold;\n"
"\n"
"		result = kr * FresnelCauchy_Evaluate(ntc, costheta);\n"
"	}\n"
"\n"
"	return result / *pdfW;\n"
"}\n"
"\n"
"#endif\n"
; } }
