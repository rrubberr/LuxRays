#line 2 "biaspatchocl_kernels.cl"

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

//------------------------------------------------------------------------------
// Init Kernel
//------------------------------------------------------------------------------

void GenerateCameraPath(
		__global GPUTask *task,
		__global Sample *sample,
		__global float *sampleData,
		__global Camera *camera,
		const uint filmWidth,
		const uint filmHeight,
		__global Ray *ray,
		Seed *seed) {
#if (PARAM_SAMPLER_TYPE == 0)

	const float scrSampleX = sampleData[IDX_SCREEN_X];
	const float scrSampleY = sampleData[IDX_SCREEN_Y];
#if defined(PARAM_CAMERA_HAS_DOF)
	const float dofSampleX = Rnd_FloatValue(seed);
	const float dofSampleY = Rnd_FloatValue(seed);
#endif
#if defined(PARAM_HAS_PASSTHROUGH)
	const float eyePassthrough = Rnd_FloatValue(seed);
#endif
#endif

#if (PARAM_SAMPLER_TYPE == 1)
	__global float *sampleDataPathBase = Sampler_GetSampleDataPathBase(sample, sampleData);
	const float scrSampleX = Sampler_GetSamplePath(IDX_SCREEN_X);
	const float scrSampleY = Sampler_GetSamplePath(IDX_SCREEN_Y);
#if defined(PARAM_CAMERA_HAS_DOF)
	const float dofSampleX = Sampler_GetSamplePath(IDX_DOF_X);
	const float dofSampleY = Sampler_GetSamplePath(IDX_DOF_Y);
#endif
#if defined(PARAM_HAS_PASSTHROUGH)
	const float eyePassthrough = Sampler_GetSamplePath(IDX_EYE_PASSTHROUGH);
#endif
#endif

#if (PARAM_SAMPLER_TYPE == 2)
	const float scrSampleX = sampleData[IDX_SCREEN_X];
	const float scrSampleY = sampleData[IDX_SCREEN_Y];
#if defined(PARAM_CAMERA_HAS_DOF)
	const float dofSampleX = Sampler_GetSamplePath(IDX_DOF_X);
	const float dofSampleY = Sampler_GetSamplePath(IDX_DOF_Y);
#endif
#if defined(PARAM_HAS_PASSTHROUGH)
	const float eyePassthrough = Sampler_GetSamplePath(IDX_EYE_PASSTHROUGH);
#endif
#endif

	Camera_GenerateRay(camera, filmWidth, filmHeight, ray, scrSampleX, scrSampleY
#if defined(PARAM_CAMERA_HAS_DOF)
			, dofSampleX, dofSampleY
#endif
			);

	// Initialize the path state
	task->pathStateBase.state = RT_NEXT_VERTEX;
	task->pathStateBase.depth = 1;
	VSTORE3F(WHITE, &task->pathStateBase.throughput.r);
	task->directLightState.pathBSDFEvent = NONE;
	task->directLightState.lastBSDFEvent = SPECULAR; // SPECULAR is required to avoid MIS
	task->directLightState.lastPdfW = 1.f;
#if defined(PARAM_HAS_PASSTHROUGH)
	// This is a bit tricky. I store the passThroughEvent in the BSDF
	// before of the initialization because it can be use during the
	// tracing of next path vertex ray.

	task->pathStateBase.bsdf.hitPoint.passThroughEvent = eyePassthrough;
#endif
}

__kernel __attribute__((work_group_size_hint(64, 1, 1))) void Init(
		uint seedBase,
		__global GPUTask *tasks,
		__global GPUTaskStats *taskStats,
		__global Sample *samples,
		__global float *samplesData,
		__global Ray *rays,
		__global Camera *camera,
		const uint filmWidth,
		const uint filmHeight
		) {
	const size_t gid = get_global_id(0);
	if (gid >= PARAM_TASK_COUNT)
		return;

	// Initialize the task
	__global GPUTask *task = &tasks[gid];

	// Initialize random number generator
	Seed seed;
	Rnd_Init(seedBase + gid, &seed);

	// Initialize the sample and path
	__global Sample *sample = &samples[gid];
	__global float *sampleData = Sampler_GetSampleData(sample, samplesData);
	Sampler_Init(&seed, sample, sampleData, filmWidth, filmHeight);
	GenerateCameraPath(task, sample, sampleData, camera, filmWidth, filmHeight, &rays[gid], &seed);

	// Save the seed
	task->seed.s1 = seed.s1;
	task->seed.s2 = seed.s2;
	task->seed.s3 = seed.s3;

	__global GPUTaskStats *taskStat = &taskStats[gid];
	taskStat->sampleCount = 0;
}

//------------------------------------------------------------------------------
// BiasAdvancePaths Kernel
//------------------------------------------------------------------------------

__kernel __attribute__((work_group_size_hint(64, 1, 1))) void AdvancePaths(
		__global GPUTask *tasks,
		__global GPUTaskStats *taskStats,
		__global Sample *samples,
		__global float *samplesData,
		__global Ray *rays,
		__global RayHit *rayHits,
		// Film parameters
		const uint filmWidth, const uint filmHeight
#if defined(PARAM_FILM_RADIANCE_GROUP_0)
		, __global float *filmRadianceGroup0
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_1)
		, __global float *filmRadianceGroup1
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_2)
		, __global float *filmRadianceGroup2
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_3)
		, __global float *filmRadianceGroup3
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_4)
		, __global float *filmRadianceGroup4
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_5)
		, __global float *filmRadianceGroup5
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_6)
		, __global float *filmRadianceGroup6
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_7)
		, __global float *filmRadianceGroup7
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_ALPHA)
		, __global float *filmAlpha
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DEPTH)
		, __global float *filmDepth
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_POSITION)
		, __global float *filmPosition
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_GEOMETRY_NORMAL)
		, __global float *filmGeometryNormal
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_SHADING_NORMAL)
		, __global float *filmShadingNormal
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_MATERIAL_ID)
		, __global uint *filmMaterialID
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_DIFFUSE)
		, __global float *filmDirectDiffuse
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_GLOSSY)
		, __global float *filmDirectGlossy
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_EMISSION)
		, __global float *filmEmission
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_DIFFUSE)
		, __global float *filmIndirectDiffuse
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_GLOSSY)
		, __global float *filmIndirectGlossy
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SPECULAR)
		, __global float *filmIndirectSpecular
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_MATERIAL_ID_MASK)
		, __global float *filmMaterialIDMask
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_SHADOW_MASK)
		, __global float *filmDirectShadowMask
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SHADOW_MASK)
		, __global float *filmIndirectShadowMask
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_UV)
		, __global float *filmUV
#endif
		,
		// Scene parameters
		const float worldCenterX,
		const float worldCenterY,
		const float worldCenterZ,
		const float worldRadius,
		__global Material *mats,
		__global Texture *texs,
		__global uint *meshMats,
		__global Mesh *meshDescs,
		__global Point *vertices,
#if defined(PARAM_HAS_NORMALS_BUFFER)
		__global Vector *vertNormals,
#endif
#if defined(PARAM_HAS_UVS_BUFFER)
		__global UV *vertUVs,
#endif
#if defined(PARAM_HAS_COLS_BUFFER)
		__global Spectrum *vertCols,
#endif
#if defined(PARAM_HAS_ALPHAS_BUFFER)
		__global float *vertAlphas,
#endif
		__global Triangle *triangles,
		__global Camera *camera,
		__global float *lightsDistribution
#if defined(PARAM_HAS_INFINITELIGHT)
		, __global InfiniteLight *infiniteLight
		, __global float *infiniteLightDistribution
#endif
#if defined(PARAM_HAS_SUNLIGHT)
		, __global SunLight *sunLight
#endif
#if defined(PARAM_HAS_SKYLIGHT)
		, __global SkyLight *skyLight
#endif
#if (PARAM_DL_LIGHT_COUNT > 0)
		, __global TriangleLight *triLightDefs
		, __global uint *meshTriLightDefsOffset
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_0)
		, __global ImageMap *imageMapDescs, __global float *imageMapBuff0
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_1)
		, __global float *imageMapBuff1
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_2)
		, __global float *imageMapBuff2
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_3)
		, __global float *imageMapBuff3
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_4)
		, __global float *imageMapBuff4
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_5)
		, __global float *imageMapBuff5
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_6)
		, __global float *imageMapBuff6
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_7)
		, __global float *imageMapBuff7
#endif
		ACCELERATOR_INTERSECT_PARAM_DECL
		) {
	const size_t gid = get_global_id(0);
	if (gid >= PARAM_TASK_COUNT)
		return;

	__global GPUTask *task = &tasks[gid];

	// Read the path state
	PathState pathState = task->pathStateBase.state;
	const uint depth = task->pathStateBase.depth;
	__global BSDF *bsdf = &task->pathStateBase.bsdf;

	__global Sample *sample = &samples[gid];
	__global float *sampleData = Sampler_GetSampleData(sample, samplesData);
	__global float *sampleDataPathBase = Sampler_GetSampleDataPathBase(sample, sampleData);
#if (PARAM_SAMPLER_TYPE != 0)
	// Used by Sampler_GetSamplePathVertex() macro
	__global float *sampleDataPathVertexBase = Sampler_GetSampleDataPathVertex(
			sample, sampleDataPathBase, depth);
#endif

	// Read the seed
	Seed seedValue;
	seedValue.s1 = task->seed.s1;
	seedValue.s2 = task->seed.s2;
	seedValue.s3 = task->seed.s3;
	// This trick is required by Sampler_GetSample() macro
	Seed *seed = &seedValue;

	//--------------------------------------------------------------------------
	// Initialize image maps page pointer table
	//--------------------------------------------------------------------------

#if defined(PARAM_HAS_IMAGEMAPS)
	__global float *imageMapBuff[PARAM_IMAGEMAPS_COUNT];
#if defined(PARAM_IMAGEMAPS_PAGE_0)
	imageMapBuff[0] = imageMapBuff0;
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_1)
	imageMapBuff[1] = imageMapBuff1;
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_2)
	imageMapBuff[2] = imageMapBuff2;
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_3)
	imageMapBuff[3] = imageMapBuff3;
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_4)
	imageMapBuff[4] = imageMapBuff4;
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_5)
	imageMapBuff[5] = imageMapBuff5;
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_6)
	imageMapBuff[6] = imageMapBuff6;
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_7)
	imageMapBuff[7] = imageMapBuff7;
#endif
#endif

	//--------------------------------------------------------------------------
	// Render a sample
	//--------------------------------------------------------------------------

	__global Ray *ray = &rays[gid];
	__global RayHit *rayHit = &rayHits[gid];

	do {
		//----------------------------------------------------------------------
		// Ray trace step
		//----------------------------------------------------------------------

		{
			Ray r = *ray;
			RayHit rh = *rayHit;
			Accelerator_Intersect(&r, &rh
				ACCELERATOR_INTERSECT_PARAM);
			*rayHit = rh;
			*ray = r;
		}

		//----------------------------------------------------------------------
		// Advance the finite state machine step
		//----------------------------------------------------------------------

		const bool rayMiss = (rayHit->meshIndex == NULL_INDEX);

		//--------------------------------------------------------------------------
		// Evaluation of the Path finite state machine.
		//
		// From: RT_NEXT_VERTEX
		// To: SPLAT_SAMPLE or GENERATE_DL_RAY
		//--------------------------------------------------------------------------

		if (pathState == RT_NEXT_VERTEX) {
			if (!rayMiss) {
				//------------------------------------------------------------------
				// Something was hit
				//------------------------------------------------------------------

				VADD3F(&sample->result.radiancePerPixelNormalized[0].r, BLACK);
				pathState = SPLAT_SAMPLE;
			} else {
				//------------------------------------------------------------------
				// Nothing was hit, add environmental lights radiance
				//------------------------------------------------------------------

				VADD3F(&sample->result.radiancePerPixelNormalized[0].r, WHITE);
				pathState = SPLAT_SAMPLE;
			}
		}

		//--------------------------------------------------------------------------
		// Evaluation of the Path finite state machine.
		//
		// From: SPLAT_SAMPLE
		// To: RT_NEXT_VERTEX
		//--------------------------------------------------------------------------

		if (pathState == SPLAT_SAMPLE) {	
			// Initialize Film radiance group pointer table
			__global float *filmRadianceGroup[PARAM_FILM_RADIANCE_GROUP_COUNT];
	#if defined(PARAM_FILM_RADIANCE_GROUP_0)
			filmRadianceGroup[0] = filmRadianceGroup0;
	#endif
	#if defined(PARAM_FILM_RADIANCE_GROUP_1)
			filmRadianceGroup[1] = filmRadianceGroup1;
	#endif
	#if defined(PARAM_FILM_RADIANCE_GROUP_2)
			filmRadianceGroup[2] = filmRadianceGroup2;
	#endif
	#if defined(PARAM_FILM_RADIANCE_GROUP_3)
			filmRadianceGroup[3] = filmRadianceGroup3;
	#endif
	#if defined(PARAM_FILM_RADIANCE_GROUP_4)
			filmRadianceGroup[3] = filmRadianceGroup4;
	#endif
	#if defined(PARAM_FILM_RADIANCE_GROUP_5)
			filmRadianceGroup[3] = filmRadianceGroup5;
	#endif
	#if defined(PARAM_FILM_RADIANCE_GROUP_6)
			filmRadianceGroup[3] = filmRadianceGroup6;
	#endif
	#if defined(PARAM_FILM_RADIANCE_GROUP_7)
			filmRadianceGroup[3] = filmRadianceGroup7;
	#endif

			Sampler_NextSample(seed, sample, sampleData
					FILM_PARAM);
			taskStats[gid].sampleCount += 1;

			pathState = DONE;
		} else {
			// Save the state
			task->pathStateBase.state = pathState;
		}
	} while (pathState != DONE);
		

	//--------------------------------------------------------------------------

	// Save the seed
	task->seed.s1 = seed->s1;
	task->seed.s2 = seed->s2;
	task->seed.s3 = seed->s3;
}