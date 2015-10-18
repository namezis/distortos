/**
 * \file
 * \brief DynamicRawFifoQueue class implementation
 *
 * \author Copyright (C) 2015 Kamil Szczygiel http://www.distortec.com http://www.freddiechopin.info
 *
 * \par License
 * This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not
 * distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * \date 2015-10-17
 */

#include "distortos/DynamicRawFifoQueue.hpp"

namespace distortos
{

/*---------------------------------------------------------------------------------------------------------------------+
| public functions
+---------------------------------------------------------------------------------------------------------------------*/

DynamicRawFifoQueue::DynamicRawFifoQueue(const size_t elementSize, const size_t queueSize) :
		storageUniquePointer_{new uint8_t[elementSize * queueSize]},
		rawFifoQueue_{storageUniquePointer_.get(), elementSize, queueSize}
{

}

DynamicRawFifoQueue::~DynamicRawFifoQueue()
{

}

}	// namespace distortos