--
-- file: Tupfile.lua
--
-- author: Copyright (C) 2017 Kamil Szczygiel http://www.distortec.com http://www.freddiechopin.info
--
-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not
-- distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
--

if CONFIG_CHIP_STM32F7 == "y" then

	local sram1Unified = 0
	local sram2Unified = 0
	local unifiedRamSize = 0

	if CONFIG_CHIP_STM32F7_UNIFY_DTCM_SRAM1 == "y" then
		sram1Unified = 1
		unifiedRamSize = CONFIG_CHIP_STM32F7_DTCM_SIZE + CONFIG_CHIP_STM32F7_SRAM1_SIZE
	elseif CONFIG_CHIP_STM32F7_UNIFY_DTCM_SRAM1_SRAM2 == "y" then
		sram1Unified = 1
		sram2Unified = 1
		unifiedRamSize = CONFIG_CHIP_STM32F7_DTCM_SIZE + CONFIG_CHIP_STM32F7_SRAM1_SIZE +
				CONFIG_CHIP_STM32F7_SRAM2_SIZE
	else
		unifiedRamSize = CONFIG_CHIP_STM32F7_DTCM_SIZE
	end

	local ldScriptGenerator = DISTORTOS_TOP .. "source/architecture/ARM/ARMv6-M-ARMv7-M/ARMv6-M-ARMv7-M.ld.sh"
	local mainThreadStackSize = (math.ceil(CONFIG_MAIN_THREAD_STACK_SIZE / CONFIG_ARCHITECTURE_STACK_ALIGNMENT) +
			math.ceil(CONFIG_STACK_GUARD_SIZE / CONFIG_ARCHITECTURE_STACK_ALIGNMENT)) *
			CONFIG_ARCHITECTURE_STACK_ALIGNMENT
	local ldScriptGeneratorArguments = string.format('"%s" "0x%x,%u" "0x%x,%u" "%u" "%u"', CONFIG_CHIP,
			CONFIG_CHIP_ROM_ADDRESS + CONFIG_LDSCRIPT_ROM_BEGIN, CONFIG_LDSCRIPT_ROM_END - CONFIG_LDSCRIPT_ROM_BEGIN,
			CONFIG_CHIP_STM32F7_DTCM_ADDRESS, unifiedRamSize, CONFIG_ARCHITECTURE_ARMV6_M_ARMV7_M_MAIN_STACK_SIZE,
			mainThreadStackSize)

	if CONFIG_CHIP_STM32F7_BKPSRAM_ADDRESS ~= nil then
		ldScriptGeneratorArguments = string.format('%s "bkpsram,0x%x,%u"', ldScriptGeneratorArguments,
				CONFIG_CHIP_STM32F7_BKPSRAM_ADDRESS, CONFIG_CHIP_STM32F7_BKPSRAM_SIZE)
	end

	if CONFIG_CHIP_STM32F7_UNIFY_SRAM1_SRAM2 == "y" then
		sram1Unified = 1
		sram2Unified = 1
		ldScriptGeneratorArguments = string.format('%s "sram12,0x%x,%u"', ldScriptGeneratorArguments,
				CONFIG_CHIP_STM32F7_SRAM1_ADDRESS, CONFIG_CHIP_STM32F7_SRAM1_SIZE + CONFIG_CHIP_STM32F7_SRAM2_SIZE)
	end

	if CONFIG_CHIP_STM32F7_SRAM1_ADDRESS ~= nil and sram1Unified == 0 then
		ldScriptGeneratorArguments = string.format('%s "sram1,0x%x,%u"', ldScriptGeneratorArguments,
				CONFIG_CHIP_STM32F7_SRAM1_ADDRESS, CONFIG_CHIP_STM32F7_SRAM1_SIZE)
	end

	if CONFIG_CHIP_STM32F7_SRAM2_ADDRESS ~= nil and sram2Unified == 0 then
		ldScriptGeneratorArguments = string.format('%s "sram2,0x%x,%u"', ldScriptGeneratorArguments,
				CONFIG_CHIP_STM32F7_SRAM2_ADDRESS, CONFIG_CHIP_STM32F7_SRAM2_SIZE)
	end

	tup.rule(string.format('^ SH %s^ ./%s %s > "%%o"', ldScriptGenerator, ldScriptGenerator,
			ldScriptGeneratorArguments), {LDSCRIPT, filenameToGroup(LDSCRIPT)})

	CXXFLAGS += STANDARD_INCLUDES
	CXXFLAGS += ARCHITECTURE_INCLUDES
	CXXFLAGS += CHIP_INCLUDES

	tup.include(DISTORTOS_TOP .. "compile.lua")

end	-- if CONFIG_CHIP_STM32F7 == "y" then
