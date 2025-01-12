/***************************************************************************
 * Copyright 1998-2017 by authors (see AUTHORS.txt)                        *
 *                                                                         *
 *   This file is part of LuxRender.                                       *
 *                                                                         *
 * Licensed under the Apache License, Version 2.0 (the "License");         *
 * you may not use this file except in compliance with the License.        *
 * You may obtain a copy of the License at                                 *
 *                                                                         *
 *     http://www.apache.org/licenses/LICENSE-2.0                          *
 *                                                                         *
 * Unless required by applicable law or agreed to in writing, software     *
 * distributed under the License is distributed on an "AS IS" BASIS,       *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.*
 * See the License for the specific language governing permissions and     *
 * limitations under the License.                                          *
 ***************************************************************************/

#ifndef _SLG_OCLRENDERENGINE_H
#define	_SLG_OCLRENDERENGINE_H


#include "luxrays/utils/utils.h"

#include "slg/slg.h"
#include "slg/engines/renderengine.h"

namespace slg {

//------------------------------------------------------------------------------
// Base class for OpenCL render engines
//------------------------------------------------------------------------------

class OCLRenderEngine : public RenderEngine {
public:
	OCLRenderEngine(const RenderConfig *cfg, Film *flm, boost::mutex *flmMutex,
		bool fatal = true);

	static size_t GetQBVHEstimatedStackSize(const luxrays::DataSet &dataSet);
	static luxrays::Properties ToProperties(const luxrays::Properties &cfg);

protected:
	static const luxrays::Properties &GetDefaultProps();
};

}

#endif	/* _SLG_RENDERENGINE_H */
