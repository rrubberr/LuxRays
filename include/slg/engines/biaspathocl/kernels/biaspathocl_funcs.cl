#line 2 "biaspatchocl_funcs.cl"

/***************************************************************************
 *   Copyright (C) 1998-2013 by authors (see AUTHORS.txt)                  *
 *                                                                         *
 *   This file is part of LuxRays.                                         *
 *                                                                         *
 *   LuxRays is free software; you can redistribute it and/or modify       *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 3 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   LuxRays is distributed in the hope that it will be useful,            *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>. *
 *                                                                         *
 *   LuxRays website: http://www.luxrender.net                             *
 ***************************************************************************/

void SR_RadianceClamp(__global SampleResult *sampleResult) {
	// Initialize only Spectrum fields

#if defined(PARAM_FILM_RADIANCE_GROUP_0)
	sampleResult->radiancePerPixelNormalized[0].r = clamp(sampleResult->radiancePerPixelNormalized[0].r, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
	sampleResult->radiancePerPixelNormalized[0].g = clamp(sampleResult->radiancePerPixelNormalized[0].g, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
	sampleResult->radiancePerPixelNormalized[0].b = clamp(sampleResult->radiancePerPixelNormalized[0].b, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_1)
	sampleResult->radiancePerPixelNormalized[1].r = clamp(sampleResult->radiancePerPixelNormalized[1].r, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
	sampleResult->radiancePerPixelNormalized[1].g = clamp(sampleResult->radiancePerPixelNormalized[1].g, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
	sampleResult->radiancePerPixelNormalized[1].b = clamp(sampleResult->radiancePerPixelNormalized[1].b, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_2)
	sampleResult->radiancePerPixelNormalized[2].r = clamp(sampleResult->radiancePerPixelNormalized[2].r, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
	sampleResult->radiancePerPixelNormalized[2].g = clamp(sampleResult->radiancePerPixelNormalized[2].g, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
	sampleResult->radiancePerPixelNormalized[2].b = clamp(sampleResult->radiancePerPixelNormalized[2].b, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_3)
	sampleResult->radiancePerPixelNormalized[3].r = clamp(sampleResult->radiancePerPixelNormalized[3].r, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
	sampleResult->radiancePerPixelNormalized[3].g = clamp(sampleResult->radiancePerPixelNormalized[3].g, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
	sampleResult->radiancePerPixelNormalized[3].b = clamp(sampleResult->radiancePerPixelNormalized[3].b, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_4)
	sampleResult->radiancePerPixelNormalized[4].r = clamp(sampleResult->radiancePerPixelNormalized[4].r, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
	sampleResult->radiancePerPixelNormalized[4].g = clamp(sampleResult->radiancePerPixelNormalized[4].g, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
	sampleResult->radiancePerPixelNormalized[4].b = clamp(sampleResult->radiancePerPixelNormalized[4].b, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_5)
	sampleResult->radiancePerPixelNormalized[5].r = clamp(sampleResult->radiancePerPixelNormalized[5].r, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
	sampleResult->radiancePerPixelNormalized[5].g = clamp(sampleResult->radiancePerPixelNormalized[5].g, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
	sampleResult->radiancePerPixelNormalized[5].b = clamp(sampleResult->radiancePerPixelNormalized[5].b, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_6)
	sampleResult->radiancePerPixelNormalized[6].r = clamp(sampleResult->radiancePerPixelNormalized[6].r, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
	sampleResult->radiancePerPixelNormalized[6].g = clamp(sampleResult->radiancePerPixelNormalized[6].g, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
	sampleResult->radiancePerPixelNormalized[6].b = clamp(sampleResult->radiancePerPixelNormalized[6].b, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_7)
	sampleResult->radiancePerPixelNormalized[7].r = clamp(sampleResult->radiancePerPixelNormalized[7].r, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
	sampleResult->radiancePerPixelNormalized[7].g = clamp(sampleResult->radiancePerPixelNormalized[7].g, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
	sampleResult->radiancePerPixelNormalized[7].b = clamp(sampleResult->radiancePerPixelNormalized[7].b, 0.f, PARAM_RADIANCE_CLAMP_MAXVALUE);
#endif
}

void SR_Accumulate(__global SampleResult *src, SampleResult *dst) {
#if defined(PARAM_FILM_RADIANCE_GROUP_0)
	dst->radiancePerPixelNormalized[0].r += src->radiancePerPixelNormalized[0].r;
	dst->radiancePerPixelNormalized[0].g += src->radiancePerPixelNormalized[0].g;
	dst->radiancePerPixelNormalized[0].b += src->radiancePerPixelNormalized[0].b;
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_1)
	dst->radiancePerPixelNormalized[1].r += src->radiancePerPixelNormalized[1].r;
	dst->radiancePerPixelNormalized[1].g += src->radiancePerPixelNormalized[1].g;
	dst->radiancePerPixelNormalized[1].b += src->radiancePerPixelNormalized[1].b;
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_2)
	dst->radiancePerPixelNormalized[2].r += src->radiancePerPixelNormalized[2].r;
	dst->radiancePerPixelNormalized[2].g += src->radiancePerPixelNormalized[2].g;
	dst->radiancePerPixelNormalized[2].b += src->radiancePerPixelNormalized[2].b;
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_3)
	dst->radiancePerPixelNormalized[3].r += src->radiancePerPixelNormalized[3].r;
	dst->radiancePerPixelNormalized[3].g += src->radiancePerPixelNormalized[3].g;
	dst->radiancePerPixelNormalized[3].b += src->radiancePerPixelNormalized[3].b;
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_4)
	dst->radiancePerPixelNormalized[4].r += src->radiancePerPixelNormalized[4].r;
	dst->radiancePerPixelNormalized[4].g += src->radiancePerPixelNormalized[4].g;
	dst->radiancePerPixelNormalized[4].b += src->radiancePerPixelNormalized[4].b;
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_5)
	dst->radiancePerPixelNormalized[5].r += src->radiancePerPixelNormalized[5].r;
	dst->radiancePerPixelNormalized[5].g += src->radiancePerPixelNormalized[5].g;
	dst->radiancePerPixelNormalized[5].b += src->radiancePerPixelNormalized[5].b;
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_6)
	dst->radiancePerPixelNormalized[6].r += src->radiancePerPixelNormalized[6].r;
	dst->radiancePerPixelNormalized[6].g += src->radiancePerPixelNormalized[6].g;
	dst->radiancePerPixelNormalized[6].b += src->radiancePerPixelNormalized[6].b;
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_7)
	dst->radiancePerPixelNormalized[7].r += src->radiancePerPixelNormalized[7].r;
	dst->radiancePerPixelNormalized[7].g += src->radiancePerPixelNormalized[7].g;
	dst->radiancePerPixelNormalized[7].b += src->radiancePerPixelNormalized[7].b;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_ALPHA)
	dst->alpha += dst->alpha + src->alpha;
#endif

#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_DIFFUSE)
	dst->directDiffuse.r += src->directDiffuse.r;
	dst->directDiffuse.g += src->directDiffuse.g;
	dst->directDiffuse.b += src->directDiffuse.b;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_GLOSSY)
	dst->directGlossy.r += src->directGlossy.r;
	dst->directGlossy.g += src->directGlossy.g;
	dst->directGlossy.b += src->directGlossy.b;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_EMISSION)
	dst->emission.r += src->emission.r;
	dst->emission.g += src->emission.g;
	dst->emission.b += src->emission.b;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_DIFFUSE)
	dst->indirectDiffuse.r += src->indirectDiffuse.r;
	dst->indirectDiffuse.g += src->indirectDiffuse.g;
	dst->indirectDiffuse.b += src->indirectDiffuse.b;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_GLOSSY)
	dst->indirectGlossy.r += src->indirectGlossy.r;
	dst->indirectGlossy.g += src->indirectGlossy.g;
	dst->indirectGlossy.b += src->indirectGlossy.b;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SPECULAR)
	dst->indirectSpecular.r += src->indirectSpecular.r;
	dst->indirectSpecular.g += src->indirectSpecular.g;
	dst->indirectSpecular.b += src->indirectSpecular.b;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_SHADOW_MASK)
	dst->directShadowMask += src->directShadowMask;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SHADOW_MASK)
	dst->indirectShadowMask += src->indirectShadowMask;
#endif

	bool depthWrite = true;
#if defined(PARAM_FILM_CHANNELS_HAS_DEPTH)
	const float srcDepthValue = src->depth;
	if (srcDepthValue <= dst->depth)
		dst->depth = srcDepthValue;
	else
		depthWrite = false;
#endif
	if (depthWrite) {
#if defined(PARAM_FILM_CHANNELS_HAS_POSITION)
		dst->position = src->position;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_GEOMETRY_NORMAL)
		dst->geometryNormal = src->geometryNormal;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_SHADING_NORMAL)
		dst->shadingNormal = src->shadingNormal;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_MATERIAL_ID)
		// Note: MATERIAL_ID_MASK is calculated starting from materialID field
		dst->materialID = src->materialID;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_UV)
		dst->uv = src->uv;
#endif
	}

#if defined(PARAM_FILM_CHANNELS_HAS_RAYCOUNT)
	dst->rayCount += src->rayCount;
#endif
}

void SR_Normalize(SampleResult *dst, const float k) {
#if defined(PARAM_FILM_RADIANCE_GROUP_0)
	dst->radiancePerPixelNormalized[0].r *= k;
	dst->radiancePerPixelNormalized[0].g *= k;
	dst->radiancePerPixelNormalized[0].b *= k;
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_1)
	dst->radiancePerPixelNormalized[1].r *= k;
	dst->radiancePerPixelNormalized[1].g *= k;
	dst->radiancePerPixelNormalized[1].b *= k;
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_2)
	dst->radiancePerPixelNormalized[2].r *= k;
	dst->radiancePerPixelNormalized[2].g *= k;
	dst->radiancePerPixelNormalized[2].b *= k;
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_3)
	dst->radiancePerPixelNormalized[3].r *= k;
	dst->radiancePerPixelNormalized[3].g *= k;
	dst->radiancePerPixelNormalized[3].b *= k;
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_4)
	dst->radiancePerPixelNormalized[4].r *= k;
	dst->radiancePerPixelNormalized[4].g *= k;
	dst->radiancePerPixelNormalized[4].b *= k;
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_5)
	dst->radiancePerPixelNormalized[5].r *= k;
	dst->radiancePerPixelNormalized[5].g *= k;
	dst->radiancePerPixelNormalized[5].b *= k;
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_6)
	dst->radiancePerPixelNormalized[6].r *= k;
	dst->radiancePerPixelNormalized[6].g *= k;
	dst->radiancePerPixelNormalized[6].b *= k;
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_7)
	dst->radiancePerPixelNormalized[7].r *= k;
	dst->radiancePerPixelNormalized[7].g *= k;
	dst->radiancePerPixelNormalized[7].b *= k;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_ALPHA)
	dst->alpha *= k;
#endif

#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_DIFFUSE)
	dst->directDiffuse.r *= k;
	dst->directDiffuse.g *= k;
	dst->directDiffuse.b *= k;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_GLOSSY)
	dst->directGlossy.r *= k;
	dst->directGlossy.g *= k;
	dst->directGlossy.b *= k;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_EMISSION)
	dst->emission.r *= k;
	dst->emission.g *= k;
	dst->emission.b *= k;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_DIFFUSE)
	dst->indirectDiffuse.r *= k;
	dst->indirectDiffuse.g *= k;
	dst->indirectDiffuse.b *= k;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_GLOSSY)
	dst->indirectGlossy.r *= k;
	dst->indirectGlossy.g *= k;
	dst->indirectGlossy.b *= k;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SPECULAR)
	dst->indirectSpecular.r *= k;
	dst->indirectSpecular.g *= k;
	dst->indirectSpecular.b *= k;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_SHADOW_MASK)
	dst->directShadowMask *= k;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SHADOW_MASK)
	dst->indirectShadowMask *= k;
#endif
}

void SampleGrid(Seed *seed, const uint size,
		const uint ix, const uint iy, float *u0, float *u1) {
	*u0 = Rnd_FloatValue(seed);
	*u1 = Rnd_FloatValue(seed);

	if (size > 1) {
		const float idim = 1.f / size;
		*u0 = (ix + *u0) * idim;
		*u1 = (iy + *u1) * idim;
	}
}

typedef struct {
	uint depth, diffuseDepth, glossyDepth, specularDepth;
} PathDepthInfo;

void PathDepthInfo_Init(PathDepthInfo *depthInfo, const uint val) {
	depthInfo->depth = val;
	depthInfo->diffuseDepth = val;
	depthInfo->glossyDepth = val;
	depthInfo->specularDepth = val;
}

void PathDepthInfo_IncDepths(PathDepthInfo *depthInfo, const BSDFEvent event) {
	++(depthInfo->depth);
	if (event & DIFFUSE)
		++(depthInfo->diffuseDepth);
	if (event & GLOSSY)
		++(depthInfo->glossyDepth);
	if (event & SPECULAR)
		++(depthInfo->specularDepth);
}

bool PathDepthInfo_CheckDepths(PathDepthInfo *depthInfo) {
	return ((depthInfo->depth <= PARAM_DEPTH_MAX) &&
			(depthInfo->diffuseDepth <= PARAM_DEPTH_DIFFUSE_MAX) &&
			(depthInfo->glossyDepth <= PARAM_DEPTH_GLOSSY_MAX) &&
			(depthInfo->specularDepth <= PARAM_DEPTH_SPECULAR_MAX));
}

//------------------------------------------------------------------------------

void GenerateCameraRay(
		Seed *seed,
		__global GPUTask *task,
		__global SampleResult *sampleResult,
		__global Camera *camera,
		__global float *pixelFilterDistribution,
		const uint sampleX, const uint sampleY, const int sampleIndex,
		const uint tileStartX, const uint tileStartY, 
		const uint engineFilmWidth, const uint engineFilmHeight,
		Ray *ray) {
	//if (get_global_id(0) == 0)
	//	printf("tileSampleIndex: %d (%d, %d)\n", sampleIndex, sampleIndex % PARAM_AA_SAMPLES, sampleIndex / PARAM_AA_SAMPLES);

	float u0, u1;
	SampleGrid(seed, PARAM_AA_SAMPLES,
			sampleIndex % PARAM_AA_SAMPLES, sampleIndex / PARAM_AA_SAMPLES,
			&u0, &u1);

	float2 xy;
	float distPdf;
	Distribution2D_SampleContinuous(pixelFilterDistribution, u0, u1, &xy, &distPdf);

	const float filmX = sampleX + .5f + (xy.x - .5f) * PARAM_IMAGE_FILTER_WIDTH_X;
	const float filmY = sampleY + .5f + (xy.y - .5f) * PARAM_IMAGE_FILTER_WIDTH_Y;
	sampleResult->filmX = filmX;
	sampleResult->filmY = filmY;

#if defined(PARAM_CAMERA_HAS_DOF)
	const float dofSampleX = Rnd_FloatValue(seed);
	const float dofSampleY = Rnd_FloatValue(seed);
#endif

	Camera_GenerateRay(camera, engineFilmWidth, engineFilmHeight, ray, tileStartX + filmX, tileStartY + filmY
#if defined(PARAM_CAMERA_HAS_DOF)
			, dofSampleX, dofSampleY
#endif
			);	
}

#if defined(PARAM_HAS_SKYLIGHT) || defined(PARAM_HAS_INFINITELIGHT) || defined(PARAM_HAS_SUNLIGHT)
void DirectHitInfiniteLight(
		const bool firstPathVertex,
		const BSDFEvent lastBSDFEvent,
		const BSDFEvent pathBSDFEvent,
		__global BSDFEvent *lightVisibility,
		__global float *lightsDistribution,
#if defined(PARAM_HAS_INFINITELIGHT)
		__global InfiniteLight *infiniteLight,
		__global float *infiniteLightDistribution,
#endif
#if defined(PARAM_HAS_SUNLIGHT)
		__global SunLight *sunLight,
#endif
#if defined(PARAM_HAS_SKYLIGHT)
		__global SkyLight *skyLight,
#endif
		__global const Spectrum *pathThroughput,
		const float3 eyeDir, const float lastPdfW,
		__global SampleResult *sampleResult
		IMAGEMAPS_PARAM_DECL) {
	const float3 throughput = VLOAD3F(&pathThroughput->r);

#if defined(PARAM_HAS_INFINITELIGHT)
	{
		const uint infiniteLightIndex = PARAM_TRIANGLE_LIGHT_COUNT
#if defined(PARAM_HAS_SUNLIGHT)
			+ 1
#endif
		;

		if (firstPathVertex || (lightVisibility[infiniteLightIndex] & (pathBSDFEvent & (DIFFUSE | GLOSSY | SPECULAR)))) {
			float directPdfW;
			const float3 infiniteLightRadiance = InfiniteLight_GetRadiance(infiniteLight,
					infiniteLightDistribution, eyeDir, &directPdfW
					IMAGEMAPS_PARAM);
			if (!Spectrum_IsBlack(infiniteLightRadiance)) {
				// MIS between BSDF sampling and direct light sampling
				const float lightPickProb = Scene_SampleAllLightPdf(lightsDistribution, infiniteLight->lightSceneIndex);
				const float weight = ((lastBSDFEvent & SPECULAR) ? 1.f : PowerHeuristic(lastPdfW, directPdfW * lightPickProb));
				const float3 lightRadiance = weight * throughput * infiniteLightRadiance;

				const uint lightID = min(infiniteLight->lightID, PARAM_FILM_RADIANCE_GROUP_COUNT - 1u);
				AddEmission(firstPathVertex, pathBSDFEvent, lightID, sampleResult, lightRadiance);
			}
		}
	}
#endif
#if defined(PARAM_HAS_SKYLIGHT)
	{
		const uint skyLightIndex = PARAM_TRIANGLE_LIGHT_COUNT
#if defined(PARAM_HAS_SUNLIGHT)
			+ 1
#endif
		;

		if (firstPathVertex || (lightVisibility[skyLightIndex] & (pathBSDFEvent & (DIFFUSE | GLOSSY | SPECULAR)))) {
			float directPdfW;
			const float3 skyRadiance = SkyLight_GetRadiance(skyLight, eyeDir, &directPdfW);
			if (!Spectrum_IsBlack(skyRadiance)) {
				// MIS between BSDF sampling and direct light sampling
				const float lightPickProb = Scene_SampleAllLightPdf(lightsDistribution, skyLight->lightSceneIndex);
				const float weight = ((lastBSDFEvent & SPECULAR) ? 1.f : PowerHeuristic(lastPdfW, directPdfW * lightPickProb));
				const float3 lightRadiance = weight * throughput * skyRadiance;

				const uint lightID = min(skyLight->lightID, PARAM_FILM_RADIANCE_GROUP_COUNT - 1u);
				AddEmission(firstPathVertex, pathBSDFEvent, lightID, sampleResult, lightRadiance);
			}
		}
	}
#endif
#if defined(PARAM_HAS_SUNLIGHT)
	{
		const uint sunLightIndex = PARAM_TRIANGLE_LIGHT_COUNT;

		if (firstPathVertex || (lightVisibility[sunLightIndex] & (pathBSDFEvent & (DIFFUSE | GLOSSY | SPECULAR)))) {
			float directPdfW;
			const float3 sunRadiance = SunLight_GetRadiance(sunLight, eyeDir, &directPdfW);
			if (!Spectrum_IsBlack(sunRadiance)) {
				// MIS between BSDF sampling and direct light sampling
				const float lightPickProb = Scene_SampleAllLightPdf(lightsDistribution, sunLight->lightSceneIndex);
				const float weight = ((lastBSDFEvent & SPECULAR) ? 1.f : PowerHeuristic(lastPdfW, directPdfW * lightPickProb));
				const float3 lightRadiance = weight * throughput * sunRadiance;

				const uint lightID = min(sunLight->lightID, PARAM_FILM_RADIANCE_GROUP_COUNT - 1u);
				AddEmission(firstPathVertex, pathBSDFEvent, lightID, sampleResult, lightRadiance);
			}
		}
	}
#endif
}
#endif

#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
void DirectHitFiniteLight(
		const bool firstPathVertex,
		const BSDFEvent lastBSDFEvent,
		const BSDFEvent pathBSDFEvent,
		__global BSDFEvent *lightVisibility,
		__global float *lightsDistribution,
		__global TriangleLight *triLightDefs,
		__global const Spectrum *pathThroughput, const float distance, __global BSDF *bsdf,
		const float lastPdfW, __global SampleResult *sampleResult
		MATERIALS_PARAM_DECL) {
	if (firstPathVertex || (lightVisibility[bsdf->triangleLightSourceIndex] & (pathBSDFEvent & (DIFFUSE | GLOSSY | SPECULAR)))) {
		float directPdfA;
		const float3 emittedRadiance = BSDF_GetEmittedRadiance(bsdf,
				triLightDefs, &directPdfA
				MATERIALS_PARAM);

		if (!Spectrum_IsBlack(emittedRadiance)) {
			// Add emitted radiance
			float weight = 1.f;
			if (!(lastBSDFEvent & SPECULAR)) {
				const float lightPickProb = Scene_SampleAllLightPdf(lightsDistribution,
						triLightDefs[bsdf->triangleLightSourceIndex].lightSceneIndex);
				const float directPdfW = PdfAtoW(directPdfA, distance,
					fabs(dot(VLOAD3F(&bsdf->hitPoint.fixedDir.x), VLOAD3F(&bsdf->hitPoint.shadeN.x))));

				// MIS between BSDF sampling and direct light sampling
				weight = PowerHeuristic(lastPdfW, directPdfW * lightPickProb);
			}
			const float3 lightRadiance = weight * VLOAD3F(&pathThroughput->r) * emittedRadiance;

			const uint lightID =  min(BSDF_GetLightID(bsdf
					MATERIALS_PARAM), PARAM_FILM_RADIANCE_GROUP_COUNT - 1u);
			AddEmission(firstPathVertex, pathBSDFEvent, lightID, sampleResult, lightRadiance);
		}
	}
}
#endif

bool DirectLightSampling(
		const uint lightIndex,
		const float lightPickPdf,
#if defined(PARAM_HAS_INFINITELIGHT) || defined(PARAM_HAS_SKYLIGHT)
		const float worldCenterX,
		const float worldCenterY,
		const float worldCenterZ,
		const float worldRadius,
#endif
#if defined(PARAM_HAS_INFINITELIGHT)
		__global InfiniteLight *infiniteLight,
		__global float *infiniteLightDistribution,
#endif
#if defined(PARAM_HAS_SUNLIGHT)
		__global SunLight *sunLight,
#endif
#if defined(PARAM_HAS_SKYLIGHT)
		__global SkyLight *skyLight,
#endif
#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
		__global TriangleLight *triLightDefs,
		__global HitPoint *directLightHitPoint,
#endif
		__global float *lightsDistribution,
		const float u0, const float u1, const float u2,
		__global const Spectrum *pathThroughput, __global BSDF *bsdf,
		Ray *shadowRay, __global Spectrum *radiance, __global uint *ID
		MATERIALS_PARAM_DECL) {
	float3 lightRayDir;
	float distance, directPdfW;
	float3 lightRadiance;
	uint lightID;

#if defined(PARAM_HAS_INFINITELIGHT)
	const uint infiniteLightIndex = PARAM_TRIANGLE_LIGHT_COUNT
#if defined(PARAM_HAS_SUNLIGHT)
		+ 1
#endif
	;

	if (lightIndex == infiniteLightIndex) {
		lightRadiance = InfiniteLight_Illuminate(
			infiniteLight,
			infiniteLightDistribution,
			worldCenterX, worldCenterY, worldCenterZ, worldRadius,
			u0, u1,
			VLOAD3F(&bsdf->hitPoint.p.x),
			&lightRayDir, &distance, &directPdfW
			IMAGEMAPS_PARAM);
		lightID = infiniteLight->lightID;
	}
#endif

#if defined(PARAM_HAS_SKYLIGHT)
	const uint skyLightIndex = PARAM_TRIANGLE_LIGHT_COUNT
#if defined(PARAM_HAS_SUNLIGHT)
		+ 1
#endif
	;

	if (lightIndex == skyLightIndex) {
		lightRadiance = SkyLight_Illuminate(
			skyLight,
			worldCenterX, worldCenterY, worldCenterZ, worldRadius,
			u0, u1,
			VLOAD3F(&bsdf->hitPoint.p.x),
			&lightRayDir, &distance, &directPdfW);
		lightID = skyLight->lightID;
	}
#endif

#if defined(PARAM_HAS_SUNLIGHT)
	const uint sunLightIndex = PARAM_TRIANGLE_LIGHT_COUNT;
	if (lightIndex == sunLightIndex) {
		lightRadiance = SunLight_Illuminate(
			sunLight,
			u0, u1,
			&lightRayDir, &distance, &directPdfW);
		lightID = sunLight->lightID;
	}
#endif

#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
	if (lightIndex < PARAM_TRIANGLE_LIGHT_COUNT) {
		lightRadiance = TriangleLight_Illuminate(
			&triLightDefs[lightIndex], directLightHitPoint,
			VLOAD3F(&bsdf->hitPoint.p.x),
			u0, u1, u2,
			&lightRayDir, &distance, &directPdfW
			MATERIALS_PARAM);
		lightID = mats[triLightDefs[lightIndex].materialIndex].lightID;
	}
#endif

	// Setup the shadow ray
	const float cosThetaToLight = fabs(dot(lightRayDir, VLOAD3F(&bsdf->hitPoint.shadeN.x)));
	if (((Spectrum_Y(lightRadiance) * cosThetaToLight / directPdfW) > PARAM_LOW_LIGHT_THREASHOLD) &&
			(distance > PARAM_NEAR_START_LIGHT)) {
		BSDFEvent event;
		float bsdfPdfW;
		const float3 bsdfEval = BSDF_Evaluate(bsdf,
				lightRayDir, &event, &bsdfPdfW
				MATERIALS_PARAM);

		if (!Spectrum_IsBlack(bsdfEval)) {
			const float directLightSamplingPdfW = directPdfW * lightPickPdf;
			const float factor = cosThetaToLight / directLightSamplingPdfW;

			// MIS between direct light sampling and BSDF sampling
			const float weight = PowerHeuristic(directLightSamplingPdfW, bsdfPdfW);

			VSTORE3F((weight * factor) * VLOAD3F(&pathThroughput->r) * bsdfEval * lightRadiance, &radiance->r);
			*ID = min(lightID, PARAM_FILM_RADIANCE_GROUP_COUNT - 1u);

			// Setup the shadow ray
			const float3 hitPoint = VLOAD3F(&bsdf->hitPoint.p.x);
			const float epsilon = fmax(MachineEpsilon_E_Float3(hitPoint), MachineEpsilon_E(distance));

			Ray_Init4_Private(shadowRay, hitPoint, lightRayDir,
				epsilon,
				distance - epsilon);

			return true;
		}
	}

	return false;
}

bool DirectLightSampling_ONE(
		const bool firstPathVertex,
		Seed *seed,
#if defined(PARAM_HAS_INFINITELIGHT) || defined(PARAM_HAS_SKYLIGHT)
		const float worldCenterX,
		const float worldCenterY,
		const float worldCenterZ,
		const float worldRadius,
#endif
#if defined(PARAM_HAS_INFINITELIGHT)
		__global InfiniteLight *infiniteLight,
		__global float *infiniteLightDistribution,
#endif
#if defined(PARAM_HAS_SUNLIGHT)
		__global SunLight *sunLight,
#endif
#if defined(PARAM_HAS_SKYLIGHT)
		__global SkyLight *skyLight,
#endif
#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
		__global TriangleLight *triLightDefs,
		__global HitPoint *directLightHitPoint,
#endif
		__global float *lightsDistribution,
		__global const Spectrum *pathThroughput, __global BSDF *bsdf,
		__global SampleResult *sampleResult,
		Ray *shadowRay, __global Spectrum *radiance, __global uint *ID
		MATERIALS_PARAM_DECL) {
	// Pick a light source to sample
	float lightPickPdf;
	const uint lightIndex = Scene_SampleAllLights(lightsDistribution, Rnd_FloatValue(seed), &lightPickPdf);

	const bool illuminated = DirectLightSampling(
		lightIndex,
		lightPickPdf,
#if defined(PARAM_HAS_INFINITELIGHT) || defined(PARAM_HAS_SKYLIGHT)
		worldCenterX,
		worldCenterY,
		worldCenterZ,
		worldRadius,
#endif
#if defined(PARAM_HAS_INFINITELIGHT)
		infiniteLight,
		infiniteLightDistribution,
#endif
#if defined(PARAM_HAS_SUNLIGHT)
		sunLight,
#endif
#if defined(PARAM_HAS_SKYLIGHT)
		skyLight,
#endif
#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
		triLightDefs,
		directLightHitPoint,
#endif
		lightsDistribution,
		Rnd_FloatValue(seed), Rnd_FloatValue(seed), Rnd_FloatValue(seed),
		pathThroughput, bsdf,
		shadowRay, radiance, ID
		MATERIALS_PARAM);

#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_SHADOW_MASK)
	if (firstPathVertex && !illuminated)
		sampleResult->directShadowMask += 1.f;
#endif

	return illuminated;
}

#if defined(PARAM_DIRECT_LIGHT_ALL_STRATEGY)
bool DirectLightSampling_ALL(
		__global uint *currentLightIndex,
		__global uint *currentLightSampleIndex,
		__global int *lightSamples,
		Seed *seed,
#if defined(PARAM_HAS_INFINITELIGHT) || defined(PARAM_HAS_SKYLIGHT)
		const float worldCenterX,
		const float worldCenterY,
		const float worldCenterZ,
		const float worldRadius,
#endif
#if defined(PARAM_HAS_INFINITELIGHT)
		__global InfiniteLight *infiniteLight,
		__global float *infiniteLightDistribution,
#endif
#if defined(PARAM_HAS_SUNLIGHT)
		__global SunLight *sunLight,
#endif
#if defined(PARAM_HAS_SKYLIGHT)
		__global SkyLight *skyLight,
#endif
#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
		__global TriangleLight *triLightDefs,
		__global HitPoint *directLightHitPoint,
#endif
		__global float *lightsDistribution,
		__global const Spectrum *pathThroughput, __global BSDF *bsdf,
		__global SampleResult *sampleResult,
		Ray *shadowRay, __global Spectrum *radiance, __global uint *ID
		MATERIALS_PARAM_DECL) {
	for (; *currentLightIndex < PARAM_LIGHT_COUNT; ++(*currentLightIndex)) {
		const int lightSamplesCount = lightSamples[*currentLightIndex];
		const uint sampleCount = (lightSamplesCount < 0) ? PARAM_DIRECT_LIGHT_SAMPLES : (uint)lightSamplesCount;
		const uint sampleCount2 = sampleCount * sampleCount;

		for (; *currentLightSampleIndex < sampleCount2; ++(*currentLightSampleIndex)) {
			//if (get_global_id(0) == 0)
			//	printf("DirectLightSampling_ALL() ==> currentLightIndex: %d  currentLightSampleIndex: %d\n", *currentLightIndex, *currentLightSampleIndex);

			float u0, u1;
			SampleGrid(seed, sampleCount,
					(*currentLightSampleIndex) % sampleCount, (*currentLightSampleIndex) / sampleCount,
					&u0, &u1);

			const float scaleFactor = 1.f / sampleCount2;
			const bool illuminated = DirectLightSampling(
				*currentLightIndex,
				1.f,
#if defined(PARAM_HAS_INFINITELIGHT) || defined(PARAM_HAS_SKYLIGHT)
				worldCenterX,
				worldCenterY,
				worldCenterZ,
				worldRadius,
#endif
#if defined(PARAM_HAS_INFINITELIGHT)
				infiniteLight,
				infiniteLightDistribution,
#endif
#if defined(PARAM_HAS_SUNLIGHT)
				sunLight,
#endif
#if defined(PARAM_HAS_SKYLIGHT)
				skyLight,
#endif
#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
				triLightDefs,
				directLightHitPoint,
#endif
				lightsDistribution,
				u0, u1, Rnd_FloatValue(seed),
				pathThroughput, bsdf,
				shadowRay, radiance, ID
				MATERIALS_PARAM);

			if (illuminated) {
				VSTORE3F(scaleFactor * VLOAD3F(&radiance->r), &radiance->r);
				return true;
			}
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_SHADOW_MASK)
			else {
				sampleResult->directShadowMask += scaleFactor;
			}
#endif
		}

		*currentLightSampleIndex = 0;
	}

	return false;
}
#endif