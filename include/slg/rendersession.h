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

#ifndef _SLG_RENDERSESSION_H
#define	_SLG_RENDERSESSION_H

#include "luxrays/utils/properties.h"

#include "slg/slg.h"
#include "slg/renderconfig.h"
#include "slg/renderstate.h"
#include "slg/engines/renderengine.h"
#include "slg/film/film.h"

namespace slg {

class RenderSession {
public:
	RenderSession(RenderConfig *cfg, RenderState *startState = NULL, Film *startFilm = NULL);
	~RenderSession();

	bool IsStarted() const { return renderEngine->IsStarted(); }
	void Start();
	void Stop();

	bool IsInSceneEdit() const { return renderEngine->IsInSceneEdit(); }
	void BeginSceneEdit();
	void EndSceneEdit();

	bool IsInPause() const { return renderEngine->IsInPause(); }
	void Pause();
	void Resume();

	bool NeedPeriodicFilmSave();
	void SaveFilm(const std::string &fileName);
	void SaveFilmOutputs();
	
	RenderState *GetRenderState();

	void Parse(const luxrays::Properties &props);

	RenderConfig *renderConfig;
	RenderEngine *renderEngine;

	boost::mutex filmMutex;
	Film *film;

protected:
	double lastPeriodicSave, periodiceSaveTime;

	bool periodicSaveEnabled;
};

}

#endif	/* _SLG_RENDERSESSION_H */
