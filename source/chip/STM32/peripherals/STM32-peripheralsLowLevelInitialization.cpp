/**
 * \file
 * \brief chip::peripheralsLowLevelInitialization() implementation for STM32
 *
 * \author Copyright (C) 2016 Kamil Szczygiel http://www.distortec.com http://www.freddiechopin.info
 *
 * \par License
 * This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not
 * distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

#include "distortos/chip/peripheralsLowLevelInitialization.hpp"

#include "distortos/distortosConfiguration.h"

#ifdef CONFIG_CHIP_STM32_SPIV1
#include "SPIv1/STM32-SPIv1-spiLowLevelInitialization.hpp"
#endif	// def CONFIG_CHIP_STM32_SPIV1
#ifdef CONFIG_CHIP_STM32_SPIV2
#include "SPIv1/STM32-SPIv1-spiLowLevelInitialization.hpp"
#endif	// def CONFIG_CHIP_STM32_SPIV2
#ifdef CONFIG_CHIP_STM32_USARTV1
#include "USARTv1/STM32-USARTv1-usartLowLevelInitialization.hpp"
#endif	// def CONFIG_CHIP_STM32_USARTV1
#ifdef CONFIG_CHIP_STM32_USARTV2
#include "USARTv2/STM32-USARTv2-usartLowLevelInitialization.hpp"
#endif	// def CONFIG_CHIP_STM32_USARTV2

namespace distortos
{

namespace chip
{

/*---------------------------------------------------------------------------------------------------------------------+
| global functions
+---------------------------------------------------------------------------------------------------------------------*/

void peripheralsLowLevelInitialization()
{
#if defined(CONFIG_CHIP_STM32_SPIV1) || defined(CONFIG_CHIP_STM32_SPIV2)
	spiLowLevelInitialization();
#endif	// defined(CONFIG_CHIP_STM32_SPIV1) || defined(CONFIG_CHIP_STM32_SPIV2)
#if defined(CONFIG_CHIP_STM32_USARTV1) || defined(CONFIG_CHIP_STM32_USARTV2)
	usartLowLevelInitialization();
#endif	// defined(CONFIG_CHIP_STM32_USARTV1) || defined(CONFIG_CHIP_STM32_USARTV2)
}

}	// namespace chip

}	// namespace distortos
