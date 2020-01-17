EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L power:GND #PWR0101
U 1 1 5E1F10A7
P 3850 2950
F 0 "#PWR0101" H 3850 2700 50  0001 C CNN
F 1 "GND" H 3855 2777 50  0000 C CNN
F 2 "" H 3850 2950 50  0001 C CNN
F 3 "" H 3850 2950 50  0001 C CNN
	1    3850 2950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 5E1F1C5B
P 3850 2150
F 0 "#PWR0102" H 3850 1900 50  0001 C CNN
F 1 "GND" H 3855 1977 50  0000 C CNN
F 2 "" H 3850 2150 50  0001 C CNN
F 3 "" H 3850 2150 50  0001 C CNN
	1    3850 2150
	1    0    0    -1  
$EndComp
$Comp
L power:+3V8 #PWR0103
U 1 1 5E1F95D4
P 3850 2750
F 0 "#PWR0103" H 3850 2600 50  0001 C CNN
F 1 "+3V8" H 3865 2923 50  0000 C CNN
F 2 "" H 3850 2750 50  0001 C CNN
F 3 "" H 3850 2750 50  0001 C CNN
	1    3850 2750
	1    0    0    -1  
$EndComp
$Comp
L power:+3V8 #PWR0104
U 1 1 5E1F8F00
P 3850 1950
F 0 "#PWR0104" H 3850 1800 50  0001 C CNN
F 1 "+3V8" H 3865 2123 50  0000 C CNN
F 2 "" H 3850 1950 50  0001 C CNN
F 3 "" H 3850 1950 50  0001 C CNN
	1    3850 1950
	1    0    0    -1  
$EndComp
Text Notes 3750 2500 0    38   ~ 0
2x Lipo cells\nmax 4v
$Comp
L craft-rescue:MCP73831-open-project lipo_charger2
U 1 1 5E1FD019
P 2500 2850
F 0 "lipo_charger2" H 2500 3165 50  0001 C CNN
F 1 "MCP73831" H 2500 3073 50  0000 C CNN
F 2 "" H 2500 2850 60  0001 C CNN
F 3 "" H 2500 2850 60  0000 C CNN
	1    2500 2850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0105
U 1 1 5E1FED7C
P 750 4100
F 0 "#PWR0105" H 750 3850 50  0001 C CNN
F 1 "GND" H 755 3927 50  0000 C CNN
F 2 "" H 750 4100 50  0001 C CNN
F 3 "" H 750 4100 50  0001 C CNN
	1    750  4100
	1    0    0    -1  
$EndComp
$Comp
L craft-rescue:MCP73831-open-project lipo_charger1
U 1 1 5E1FACC4
P 2500 2050
F 0 "lipo_charger1" H 2500 2365 50  0000 C CNN
F 1 "MCP73831" H 2500 2273 50  0000 C CNN
F 2 "" H 2500 2050 60  0001 C CNN
F 3 "" H 2500 2050 60  0000 C CNN
	1    2500 2050
	1    0    0    -1  
$EndComp
$Comp
L Regulator_Switching:LM2596T-5 U1
U 1 1 5E21D6BD
P 1800 3800
F 0 "U1" H 1800 4167 50  0001 C CNN
F 1 "LM2596T-5" H 1800 4075 50  0000 C CNN
F 2 "Package_TO_SOT_THT:TO-220-5_P3.4x3.7mm_StaggerOdd_Lead3.8mm_Vertical" H 1850 3550 50  0001 L CIN
F 3 "http://www.ti.com/lit/ds/symlink/lm2596.pdf" H 1800 3800 50  0001 C CNN
	1    1800 3800
	1    0    0    -1  
$EndComp
Text Notes 600  5300 0    50   ~ 0
stationary charge-board with 12v in and 5v regulator out
Wire Notes Line
	550  3350 550  5350
Wire Notes Line
	550  5350 3350 5350
Wire Notes Line
	3350 5350 3350 3350
Wire Notes Line
	3350 3350 550  3350
$Comp
L power:+12V #PWR0106
U 1 1 5E223236
P 750 3700
F 0 "#PWR0106" H 750 3550 50  0001 C CNN
F 1 "+12V" H 765 3873 50  0000 C CNN
F 2 "" H 750 3700 50  0001 C CNN
F 3 "" H 750 3700 50  0001 C CNN
	1    750  3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	750  3700 900  3700
Connection ~ 900  3700
Wire Wire Line
	900  3700 1300 3700
$Comp
L Device:CP_Small C1
U 1 1 5E225AAD
P 900 3800
F 0 "C1" H 988 3846 50  0000 L CNN
F 1 "680μF" H 988 3755 50  0000 L CNN
F 2 "" H 900 3800 50  0001 C CNN
F 3 "~" H 900 3800 50  0001 C CNN
	1    900  3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	750  4100 900  4100
Wire Wire Line
	1300 3900 1300 4100
Connection ~ 1300 4100
Wire Wire Line
	1300 4100 1800 4100
Wire Wire Line
	900  3900 900  4100
Connection ~ 900  4100
Wire Wire Line
	900  4100 1300 4100
$Comp
L Device:D_Schottky_Small DS1
U 1 1 5E22C48C
P 2300 4000
F 0 "DS1" V 2254 4068 50  0000 L CNN
F 1 "1N5824" V 2345 4068 50  0000 L CNN
F 2 "" V 2300 4000 50  0001 C CNN
F 3 "~" V 2300 4000 50  0001 C CNN
	1    2300 4000
	0    1    1    0   
$EndComp
Wire Wire Line
	1800 4100 2300 4100
Connection ~ 1800 4100
$Comp
L Device:L_Small L1
U 1 1 5E230184
P 2600 3900
F 0 "L1" V 2419 3900 50  0000 C CNN
F 1 "33μF" V 2510 3900 50  0000 C CNN
F 2 "" H 2600 3900 50  0001 C CNN
F 3 "~" H 2600 3900 50  0001 C CNN
	1    2600 3900
	0    1    1    0   
$EndComp
Wire Wire Line
	2300 3900 2500 3900
Connection ~ 2300 3900
$Comp
L Device:CP_Small C2
U 1 1 5E233786
P 2900 4000
F 0 "C2" H 2988 4046 50  0000 L CNN
F 1 "220μF" H 2988 3955 50  0000 L CNN
F 2 "" H 2900 4000 50  0001 C CNN
F 3 "~" H 2900 4000 50  0001 C CNN
	1    2900 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2700 3900 2900 3900
Wire Wire Line
	2300 3700 2900 3700
Wire Wire Line
	2900 3700 2900 3900
Connection ~ 2900 3900
Wire Wire Line
	2900 3900 3050 3900
Text Notes 1450 3450 0    50   ~ 0
5v reg. output 3A load
$Comp
L Device:R_Small_US r_charge_state_1
U 1 1 5E24B6EA
P 2000 2150
F 0 "r_charge_state_1" V 2205 2150 50  0001 C CNN
F 1 "470Ω" V 2096 2150 28  0000 C CNN
F 2 "" H 2000 2150 50  0001 C CNN
F 3 "~" H 2000 2150 50  0001 C CNN
	1    2000 2150
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED_Small D_charge_stat_1
U 1 1 5E255CEF
P 1800 2050
F 0 "D_charge_stat_1" V 1846 1982 50  0001 R CNN
F 1 "LED_Small" V 1755 1982 50  0001 R CNN
F 2 "" V 1800 2050 50  0001 C CNN
F 3 "~" V 1800 2050 50  0001 C CNN
	1    1800 2050
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1800 1950 2100 1950
Wire Wire Line
	1800 2150 1900 2150
$Comp
L Device:CP_Small C4
U 1 1 5E25C16D
P 3300 2050
F 0 "C4" H 3388 2096 35  0000 L CNN
F 1 "4.7μF" H 3388 2005 35  0000 L CNN
F 2 "" H 3300 2050 50  0001 C CNN
F 3 "~" H 3300 2050 50  0001 C CNN
	1    3300 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	3300 1950 2900 1950
Connection ~ 3300 2150
Wire Wire Line
	3300 2150 3150 2150
$Comp
L Device:LED_Small D_charge_stat_2
U 1 1 5E265FB6
P 1800 2850
F 0 "D_charge_stat_2" V 1800 2782 50  0001 R CNN
F 1 "LED_Small" V 1755 2782 50  0001 R CNN
F 2 "" V 1800 2850 50  0001 C CNN
F 3 "~" V 1800 2850 50  0001 C CNN
	1    1800 2850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1800 2750 2100 2750
$Comp
L Device:R_Small_US r_charge_state_2
U 1 1 5E266323
P 2000 2950
F 0 "r_charge_state_2" V 2205 2950 50  0001 C CNN
F 1 "470Ω" V 2096 2950 28  0000 C CNN
F 2 "" H 2000 2950 50  0001 C CNN
F 3 "~" H 2000 2950 50  0001 C CNN
	1    2000 2950
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1800 2950 1900 2950
Wire Wire Line
	3300 1950 3450 1950
Wire Wire Line
	3050 3900 3050 3250
Connection ~ 1800 1950
Connection ~ 1800 2750
Connection ~ 750  4100
Wire Wire Line
	3300 2250 3300 2150
Wire Wire Line
	2300 4100 2900 4100
Connection ~ 2300 4100
Connection ~ 3300 1950
Text Notes 3000 2500 0    35   ~ 0
4v+ side when parallel\nbehind charger ICs
$Comp
L Device:D_Small D_protect_1
U 1 1 5E2B794A
P 3550 1950
F 0 "D_protect_1" H 3550 2046 28  0000 C CNN
F 1 "D_Small" H 3550 2064 50  0001 C CNN
F 2 "" V 3550 1950 50  0001 C CNN
F 3 "~" V 3550 1950 50  0001 C CNN
	1    3550 1950
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3650 1950 3850 1950
Wire Wire Line
	3300 2150 3850 2150
Wire Wire Line
	650  4100 750  4100
Wire Wire Line
	650  2250 3300 2250
Wire Wire Line
	650  3050 650  2800
Wire Wire Line
	3050 3250 1400 3250
Wire Wire Line
	1400 2750 1800 2750
Wire Wire Line
	1400 2750 1400 1950
Wire Wire Line
	1400 1950 1800 1950
$Comp
L Device:D_Small D_protect_3
U 1 1 5E2DBC40
P 1600 3050
F 0 "D_protect_3" H 1600 3146 28  0000 C CNN
F 1 "D_Small" H 1600 3164 50  0001 C CNN
F 2 "" V 1600 3050 50  0001 C CNN
F 3 "~" V 1600 3050 50  0001 C CNN
	1    1600 3050
	1    0    0    -1  
$EndComp
$Comp
L Device:D_Small D_protect_2
U 1 1 5E2E9F7B
P 3050 2150
F 0 "D_protect_2" H 3050 2246 28  0000 C CNN
F 1 "D_Small" H 3050 2264 50  0001 C CNN
F 2 "" V 3050 2150 50  0001 C CNN
F 3 "~" V 3050 2150 50  0001 C CNN
	1    3050 2150
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2950 2150 2900 2150
$Comp
L Device:R_Variable_US 5-8v_loads1
U 1 1 5E2F35B0
P 6000 2450
F 0 "5-8v_loads1" H 6128 2450 50  0000 L CNN
F 1 "R_Variable_US" H 6128 2405 50  0001 L CNN
F 2 "" V 5930 2450 50  0001 C CNN
F 3 "~" H 6000 2450 50  0001 C CNN
	1    6000 2450
	1    0    0    -1  
$EndComp
$Comp
L Transistor_FET:IRLZ34N NPNMOSFET1
U 1 1 5E2F7223
P 4800 3900
F 0 "NPNMOSFET1" H 5005 3946 50  0000 L CNN
F 1 "IRLZ34N" H 5005 3855 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-220-3_Vertical" H 5050 3825 50  0001 L CIN
F 3 "http://www.infineon.com/dgdl/irlz34npbf.pdf?fileId=5546d462533600a40153567206892720" H 4800 3900 50  0001 L CNN
	1    4800 3900
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3850 1950 4100 1950
Connection ~ 3850 1950
Connection ~ 3850 2150
Wire Wire Line
	3850 2750 4650 2750
Connection ~ 3850 2750
$Comp
L Transistor_BJT:2N2219 NPN_gpio_triggered1
U 1 1 5E36CC87
P 6150 3900
F 0 "NPN_gpio_triggered1" H 6341 3946 50  0000 L CNN
F 1 "2N2219" H 6341 3855 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-39-3" H 6350 3825 50  0001 L CIN
F 3 "http://www.onsemi.com/pub_link/Collateral/2N2219-D.PDF" H 6150 3900 50  0001 L CNN
	1    6150 3900
	-1   0    0    -1  
$EndComp
$Comp
L Regulator_Linear:LM1117-3.3 3.3Voltage_regulator1
U 1 1 5E377484
P 6900 1950
F 0 "3.3Voltage_regulator1" H 6900 2192 50  0000 C CNN
F 1 "LM1117-3.3" H 6900 2101 50  0000 C CNN
F 2 "" H 6900 1950 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm1117.pdf" H 6900 1950 50  0001 C CNN
	1    6900 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	6900 2250 6900 2950
Wire Wire Line
	6900 2950 6600 2950
$Comp
L Device:D_Small D_protect_4
U 1 1 5E37A736
P 6500 2950
F 0 "D_protect_4" H 6500 3046 28  0000 C CNN
F 1 "D_Small" H 6500 3064 50  0001 C CNN
F 2 "" V 6500 2950 50  0001 C CNN
F 3 "~" V 6500 2950 50  0001 C CNN
	1    6500 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	7200 1950 7450 1950
Wire Wire Line
	7450 1950 7450 2300
Wire Wire Line
	7450 2950 6900 2950
Connection ~ 6900 2950
$Comp
L Device:R_Variable_US 3.3V_loads1
U 1 1 5E38AE0F
P 7450 2450
F 0 "3.3V_loads1" H 7578 2450 50  0000 L CNN
F 1 "R_Variable_US" H 7578 2405 50  0001 L CNN
F 2 "" V 7380 2450 50  0001 C CNN
F 3 "~" H 7450 2450 50  0001 C CNN
	1    7450 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	7450 2600 7450 2950
$Comp
L Device:D_Small D_protect_5
U 1 1 5E3C7C20
P 4200 1950
F 0 "D_protect_5" H 4200 2046 28  0000 C CNN
F 1 "D_Small" H 4200 2064 50  0001 C CNN
F 2 "" V 4200 1950 50  0001 C CNN
F 3 "~" V 4200 1950 50  0001 C CNN
	1    4200 1950
	-1   0    0    -1  
$EndComp
Wire Wire Line
	6000 2300 6000 1950
Connection ~ 6000 1950
Wire Wire Line
	6000 1950 6600 1950
Wire Wire Line
	6000 2950 6000 2600
Wire Wire Line
	6000 2950 6400 2950
Connection ~ 6000 2950
Wire Wire Line
	3850 2150 4650 2150
$Comp
L Transistor_FET:IRF9383M T_PNP1
U 1 1 5E200BBA
P 4750 2450
F 0 "T_PNP1" H 4954 2496 50  0000 L CNN
F 1 "IRF9383M" H 4954 2405 50  0000 L CNN
F 2 "Package_DirectFET:DirectFET_MX" H 4750 2450 50  0001 C CIN
F 3 "https://www.infineon.com/dgdl/irf9383mpbf.pdf?fileId=5546d462533600a40153561169a11dab" H 4750 2450 50  0001 L CNN
	1    4750 2450
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4650 2150 4650 2250
Wire Wire Line
	4650 2650 4650 2750
Wire Wire Line
	1400 1950 1400 1650
Connection ~ 1400 1950
Wire Wire Line
	6000 1650 6000 1950
$Comp
L Device:D_Small D_protect_7
U 1 1 5E441D7B
P 5750 1650
F 0 "D_protect_7" H 5750 1746 28  0000 C CNN
F 1 "D_Small" H 5750 1764 50  0001 C CNN
F 2 "" V 5750 1650 50  0001 C CNN
F 3 "~" V 5750 1650 50  0001 C CNN
	1    5750 1650
	-1   0    0    -1  
$EndComp
Wire Wire Line
	5850 1650 6000 1650
Connection ~ 3850 2950
Connection ~ 5300 2950
Wire Wire Line
	4300 1950 6000 1950
Wire Wire Line
	1400 1650 4900 1650
Connection ~ 5300 1650
Wire Wire Line
	5300 1650 5650 1650
$Comp
L Device:R_Small_US r_down4
U 1 1 5E4E2F26
P 5300 2750
F 0 "r_down4" H 5232 2715 35  0000 R CNN
F 1 "10KΩ" H 5232 2784 35  0000 R CNN
F 2 "" H 5300 2750 50  0001 C CNN
F 3 "~" H 5300 2750 50  0001 C CNN
	1    5300 2750
	-1   0    0    1   
$EndComp
Wire Wire Line
	5300 2850 5300 2950
Wire Wire Line
	5300 1650 5300 2200
$Comp
L Transistor_BJT:2N2219 T_NPN2
U 1 1 5E5118C7
P 5100 2200
F 0 "T_NPN2" H 5291 2235 35  0000 L CNN
F 1 "2N2219" H 5291 2166 35  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-39-3" H 5300 2125 50  0001 L CIN
F 3 "http://www.onsemi.com/pub_link/Collateral/2N2219-D.PDF" H 5100 2200 50  0001 L CNN
	1    5100 2200
	-1   0    0    -1  
$EndComp
Connection ~ 5300 2200
Wire Wire Line
	5300 2200 5300 2650
Text GLabel 6200 1050 2    50   Input ~ 0
3.3vGPIO_charge_trigger
Wire Wire Line
	3850 2950 5000 2950
Wire Wire Line
	5000 2400 5000 2450
Wire Wire Line
	5000 2450 5000 2600
Connection ~ 5000 2450
Wire Wire Line
	5000 2450 4950 2450
Connection ~ 5000 2950
Wire Wire Line
	5000 2950 5300 2950
$Comp
L Device:R_Small_US r_down2
U 1 1 5E525023
P 5000 2750
F 0 "r_down2" H 4932 2715 35  0000 R CNN
F 1 "10KΩ" H 4932 2784 35  0000 R CNN
F 2 "" H 5000 2750 50  0001 C CNN
F 3 "~" H 5000 2750 50  0001 C CNN
	1    5000 2750
	-1   0    0    1   
$EndComp
Wire Wire Line
	5000 2850 5000 2950
$Comp
L Device:R_Small_US r_down3
U 1 1 5E53E872
P 5200 1500
F 0 "r_down3" V 5372 1500 35  0000 C CNN
F 1 "10KΩ" V 5303 1500 35  0000 C CNN
F 2 "" H 5200 1500 50  0001 C CNN
F 3 "~" H 5200 1500 50  0001 C CNN
	1    5200 1500
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1400 2750 1400 3250
Connection ~ 1400 2750
Wire Wire Line
	650  4100 650  3050
Connection ~ 650  3050
Wire Wire Line
	650  3050 1000 3050
$Comp
L Isolator:PC817 opto_coupler1
U 1 1 5E572540
P 5600 1150
F 0 "opto_coupler1" H 5600 1475 50  0000 C CNN
F 1 "PC817" H 5600 1384 50  0000 C CNN
F 2 "Package_DIP:DIP-4_W7.62mm" H 5400 950 50  0001 L CIN
F 3 "http://www.soselectronic.cz/a_info/resource/d/pc817.pdf" H 5600 1150 50  0001 L CNN
	1    5600 1150
	-1   0    0    -1  
$EndComp
$Comp
L Device:R_Small_US r_diode1
U 1 1 5E592BB0
P 6000 1050
F 0 "r_diode1" V 6205 1050 50  0001 C CNN
F 1 "82Ω" V 6096 1050 28  0000 C CNN
F 2 "" H 6000 1050 50  0001 C CNN
F 3 "~" H 6000 1050 50  0001 C CNN
	1    6000 1050
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6200 1050 6100 1050
Wire Wire Line
	5900 1250 6200 1250
$Comp
L power:GND #PWR0107
U 1 1 5E59E6D6
P 6200 1250
F 0 "#PWR0107" H 6200 1000 50  0001 C CNN
F 1 "GND" H 6205 1077 50  0000 C CNN
F 2 "" H 6200 1250 50  0001 C CNN
F 3 "" H 6200 1250 50  0001 C CNN
	1    6200 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 2950 5600 2950
Wire Wire Line
	5300 1250 5000 1250
Wire Wire Line
	4900 1650 4900 1050
Wire Wire Line
	4900 1050 5300 1050
Connection ~ 4900 1650
Wire Wire Line
	4900 1650 5300 1650
Wire Wire Line
	5600 2950 5600 1500
Wire Wire Line
	5600 1500 5300 1500
Connection ~ 5600 2950
Wire Wire Line
	5600 2950 6000 2950
Wire Wire Line
	5100 1500 5000 1500
Wire Wire Line
	5000 1250 5000 1500
Connection ~ 5000 1500
Wire Wire Line
	5000 1500 5000 2000
$Comp
L Transistor_FET:IRLZ34N T_NPN1
U 1 1 5E5F0880
P 750 2600
F 0 "T_NPN1" H 955 2646 50  0000 L CNN
F 1 "IRLZ34N" H 955 2555 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-220-3_Vertical" H 1000 2525 50  0001 L CIN
F 3 "http://www.infineon.com/dgdl/irlz34npbf.pdf?fileId=5546d462533600a40153567206892720" H 750 2600 50  0001 L CNN
	1    750  2600
	-1   0    0    -1  
$EndComp
Wire Wire Line
	650  2400 650  2250
Wire Wire Line
	5000 2600 1000 2600
Connection ~ 5000 2600
Wire Wire Line
	5000 2600 5000 2650
$Comp
L Device:R_Small_US r_down1
U 1 1 5E604798
P 1000 2800
F 0 "r_down1" H 932 2765 35  0000 R CNN
F 1 "10KΩ" H 932 2834 35  0000 R CNN
F 2 "" H 1000 2800 50  0001 C CNN
F 3 "~" H 1000 2800 50  0001 C CNN
	1    1000 2800
	-1   0    0    1   
$EndComp
Wire Wire Line
	1000 2600 1000 2700
Connection ~ 1000 2600
Wire Wire Line
	1000 2600 950  2600
Wire Wire Line
	1000 2900 1000 3050
Connection ~ 1000 3050
Wire Wire Line
	1000 3050 1500 3050
Wire Wire Line
	1700 3050 3300 3050
Wire Wire Line
	3300 2950 3850 2950
Wire Wire Line
	3300 2950 2900 2950
Connection ~ 3300 2950
Wire Wire Line
	3300 2750 3850 2750
Connection ~ 3300 2750
Wire Wire Line
	3300 2750 2900 2750
$Comp
L Device:CP_Small C3
U 1 1 5E2665D4
P 3300 2850
F 0 "C3" H 3388 2896 35  0000 L CNN
F 1 "4.7μF" H 3388 2805 35  0000 L CNN
F 2 "" H 3300 2850 50  0001 C CNN
F 3 "~" H 3300 2850 50  0001 C CNN
	1    3300 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	3300 3050 3300 2950
$EndSCHEMATC
