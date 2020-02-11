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
+5.8v reg. output
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
	3050 3900 3050 3250
Connection ~ 1800 1950
Connection ~ 1800 2750
Connection ~ 750  4100
Wire Wire Line
	2300 4100 2900 4100
Connection ~ 2300 4100
Text Notes 1000 2800 0    35   ~ 0
drops 350mV\nprotects when\nbattery series
Wire Wire Line
	650  4100 750  4100
Wire Wire Line
	650  2250 2900 2250
Wire Wire Line
	3050 3250 1400 3250
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
	1400 1950 1400 1600
Connection ~ 1400 1950
Wire Wire Line
	1400 2750 1400 3250
Connection ~ 1400 2750
Wire Wire Line
	650  4100 650  3050
Wire Wire Line
	4250 2250 4250 2150
Wire Wire Line
	4250 2650 4250 2750
$Comp
L Device:Battery_Cell Lipo2
U 1 1 5E2AF186
P 4250 2950
F 0 "Lipo2" H 4368 3046 50  0000 L CNN
F 1 "3.7v" H 4368 2955 50  0000 L CNN
F 2 "" V 4250 3010 50  0001 C CNN
F 3 "~" V 4250 3010 50  0001 C CNN
	1    4250 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	2900 1950 3000 1950
$Comp
L Device:CP_Small C?
U 1 1 5E2C892C
P 3000 2050
F 0 "C?" H 3088 2096 35  0000 L CNN
F 1 "4.7μF" H 3088 2005 35  0000 L CNN
F 2 "" H 3000 2050 50  0001 C CNN
F 3 "~" H 3000 2050 50  0001 C CNN
	1    3000 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	3000 1950 3000 1850
Wire Wire Line
	2900 2950 3000 2950
Wire Wire Line
	3000 2950 3000 3050
$Comp
L Device:CP_Small C?
U 1 1 5E303454
P 3000 2850
F 0 "C?" H 3088 2896 35  0000 L CNN
F 1 "4.7μF" H 3088 2805 35  0000 L CNN
F 2 "" H 3000 2850 50  0001 C CNN
F 3 "~" H 3000 2850 50  0001 C CNN
	1    3000 2850
	1    0    0    -1  
$EndComp
$Comp
L Device:Battery_Cell Lipo1
U 1 1 5E32E546
P 4250 2050
F 0 "Lipo1" H 4368 2146 50  0000 L CNN
F 1 "3.7v" H 4368 2055 50  0000 L CNN
F 2 "" V 4250 2110 50  0001 C CNN
F 3 "~" V 4250 2110 50  0001 C CNN
	1    4250 2050
	1    0    0    -1  
$EndComp
Connection ~ 4250 3050
Wire Wire Line
	3000 2150 3000 2250
Wire Wire Line
	2900 2150 2900 2250
Connection ~ 2900 2250
Wire Wire Line
	2900 2250 3000 2250
Connection ~ 3000 2250
Wire Wire Line
	2900 2650 2900 2750
Wire Wire Line
	3000 2650 3000 2750
Connection ~ 3000 2650
Wire Wire Line
	3000 2650 2900 2650
Connection ~ 650  3050
Connection ~ 3000 1950
Connection ~ 3000 2950
Connection ~ 3000 3050
Wire Wire Line
	650  3050 3000 3050
$Comp
L Transistor_FET:IRLZ34N T_NPN5
U 1 1 5E2B08A7
P 4350 2450
F 0 "T_NPN5" H 4555 2496 39  0000 L CNN
F 1 "IRLZ34N" H 4555 2405 39  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-220-3_Vertical" H 4600 2375 50  0001 L CIN
F 3 "http://www.infineon.com/dgdl/irlz34npbf.pdf?fileId=5546d462533600a40153567206892720" H 4350 2450 50  0001 L CNN
	1    4350 2450
	-1   0    0    -1  
$EndComp
Connection ~ 4250 2250
Connection ~ 4250 2650
$Comp
L Transistor_BJT:2N2219 T_NPN?
U 1 1 5E2ED745
P 5450 3850
F 0 "T_NPN?" H 5641 3896 39  0000 L CNN
F 1 "2N2219" H 5641 3805 39  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-39-3" H 5650 3775 50  0001 L CIN
F 3 "http://www.onsemi.com/pub_link/Collateral/2N2219-D.PDF" H 5450 3850 50  0001 L CNN
	1    5450 3850
	0    -1   1    0   
$EndComp
Wire Wire Line
	3000 3050 4250 3050
$Comp
L Device:R_Small_US r_down?
U 1 1 5E35C671
P 3750 3650
F 0 "r_down?" H 3682 3615 35  0000 R CNN
F 1 "10KΩ" H 3682 3684 35  0000 R CNN
F 2 "" H 3750 3650 50  0001 C CNN
F 3 "~" H 3750 3650 50  0001 C CNN
	1    3750 3650
	-1   0    0    1   
$EndComp
$Comp
L Device:D_Small D?
U 1 1 5E360C40
P 4950 3550
F 0 "D?" H 4950 3652 35  0000 C CNN
F 1 "D_Small" H 4950 3664 50  0001 C CNN
F 2 "" V 4950 3550 50  0001 C CNN
F 3 "~" V 4950 3550 50  0001 C CNN
	1    4950 3550
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3000 1850 4250 1850
Wire Wire Line
	3000 2250 4250 2250
$Comp
L Device:D_Schottky_Small DS?
U 1 1 5E3C39B5
P 4000 4250
F 0 "DS?" V 3954 4318 35  0000 L CNN
F 1 "1N5824" V 4045 4318 50  0001 L CNN
F 2 "" V 4000 4250 50  0001 C CNN
F 3 "~" V 4000 4250 50  0001 C CNN
	1    4000 4250
	0    1    1    0   
$EndComp
Wire Wire Line
	1400 2750 1800 2750
Wire Wire Line
	1400 1950 1800 1950
$Comp
L Device:D_Schottky_Small DS2
U 1 1 5E3D6969
P 1400 2650
F 0 "DS2" V 1354 2718 35  0000 L CNN
F 1 "1N5824" V 1445 2718 50  0001 L CNN
F 2 "" V 1400 2650 50  0001 C CNN
F 3 "~" V 1400 2650 50  0001 C CNN
	1    1400 2650
	0    1    1    0   
$EndComp
Wire Wire Line
	1400 2550 1400 1950
$Comp
L Regulator_Linear:LM1117-5.0 reg_5v?
U 1 1 5E45F8D0
P 6350 3650
F 0 "reg_5v?" H 6350 3892 50  0000 C CNN
F 1 "LM1117-5.0" H 6350 3801 50  0000 C CNN
F 2 "" H 6350 3650 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm1117.pdf" H 6350 3650 50  0001 C CNN
	1    6350 3650
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Variable_US 5-8v_loads?
U 1 1 5E47C78B
P 5200 3450
F 0 "5-8v_loads?" H 5328 3450 50  0000 L CNN
F 1 "R_Variable_US" H 5328 3405 50  0001 L CNN
F 2 "" V 5130 3450 50  0001 C CNN
F 3 "~" H 5200 3450 50  0001 C CNN
	1    5200 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5800 2650 5900 2650
$Comp
L Device:R_Small_US r_diode?
U 1 1 5E2902D2
P 5700 2650
F 0 "r_diode?" V 5905 2650 50  0001 C CNN
F 1 "82Ω" V 5796 2650 28  0000 C CNN
F 2 "" H 5700 2650 50  0001 C CNN
F 3 "~" H 5700 2650 50  0001 C CNN
	1    5700 2650
	0    -1   -1   0   
$EndComp
Text Notes 4150 1600 0    35   ~ 0
+5.45v when plugged
$Comp
L Isolator:PC817 opto_coupler1
U 1 1 5E572540
P 5200 2550
F 0 "opto_coupler1" H 5200 2875 50  0000 C CNN
F 1 "PC817" H 5200 2784 50  0000 C CNN
F 2 "Package_DIP:DIP-4_W7.62mm" H 5000 2350 50  0001 L CIN
F 3 "http://www.soselectronic.cz/a_info/resource/d/pc817.pdf" H 5200 2550 50  0001 L CNN
	1    5200 2550
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR0107
U 1 1 5E59E6D6
P 5900 2650
F 0 "#PWR0107" H 5900 2400 50  0001 C CNN
F 1 "GND" H 5905 2477 50  0000 C CNN
F 2 "" H 5900 2650 50  0001 C CNN
F 3 "" H 5900 2650 50  0001 C CNN
	1    5900 2650
	1    0    0    -1  
$EndComp
Text GLabel 5900 2100 0    50   Input ~ 0
3.3vGPIO_charge_trigger
Wire Wire Line
	6950 1850 7050 1850
Wire Wire Line
	7050 1850 7050 1900
Connection ~ 6200 1850
Wire Wire Line
	6200 1850 6350 1850
Wire Wire Line
	6200 2650 6200 1850
Wire Wire Line
	6200 3050 6200 2950
Connection ~ 6200 3050
$Comp
L Device:R_Variable_US 5-8v_loads1
U 1 1 5E2F35B0
P 6200 2800
F 0 "5-8v_loads1" H 6328 2800 50  0000 L CNN
F 1 "R_Variable_US" H 6328 2755 50  0001 L CNN
F 2 "" V 6130 2800 50  0001 C CNN
F 3 "~" H 6200 2800 50  0001 C CNN
	1    6200 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Variable_US 5V_loads
U 1 1 5E38AE0F
P 7050 2050
F 0 "5V_loads" H 7178 2050 50  0000 L CNN
F 1 "R_Variable_US" H 7178 2005 50  0001 L CNN
F 2 "" V 6980 2050 50  0001 C CNN
F 3 "~" H 7050 2050 50  0001 C CNN
	1    7050 2050
	1    0    0    -1  
$EndComp
$Comp
L Regulator_Linear:LM1117-5.0 reg_5v
U 1 1 5E433E2E
P 6650 1850
F 0 "reg_5v" H 6650 2092 50  0000 C CNN
F 1 "LM1117-5.0" H 6650 2001 50  0000 C CNN
F 2 "" H 6650 1850 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm1117.pdf" H 6650 1850 50  0001 C CNN
	1    6650 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	4250 1850 4500 1850
Connection ~ 4250 1850
$Comp
L Device:D_Schottky_Small DS3
U 1 1 5E533389
P 4600 1850
F 0 "DS3" V 4554 1918 35  0000 L CNN
F 1 "1N5824" V 4645 1918 50  0001 L CNN
F 2 "" V 4600 1850 50  0001 C CNN
F 3 "~" V 4600 1850 50  0001 C CNN
	1    4600 1850
	-1   0    0    1   
$EndComp
Wire Wire Line
	4700 1850 4750 1850
Wire Wire Line
	5500 2450 5900 2450
Wire Wire Line
	6200 3050 7050 3050
Wire Wire Line
	6650 2150 6650 2250
Wire Wire Line
	6650 2250 7050 2250
Wire Wire Line
	7050 2200 7050 2250
Connection ~ 7050 2250
Wire Wire Line
	7050 2250 7050 3050
$Comp
L Device:R_Small_US r_up
U 1 1 5E3912BF
P 4750 2200
F 0 "r_up" H 4682 2165 35  0000 R CNN
F 1 "10KΩ" H 4682 2234 35  0000 R CNN
F 2 "" H 4750 2200 50  0001 C CNN
F 3 "~" H 4750 2200 50  0001 C CNN
	1    4750 2200
	1    0    0    -1  
$EndComp
Text Notes 4550 2600 0    35   ~ 0
0v when\nopto on
Wire Wire Line
	4250 3050 4900 3050
Wire Wire Line
	5500 2650 5600 2650
Wire Wire Line
	5900 2100 5900 2450
Wire Wire Line
	4550 2450 4750 2450
Wire Wire Line
	4750 2300 4750 2450
Connection ~ 4750 2450
Wire Wire Line
	4750 2450 4900 2450
Wire Wire Line
	4900 2650 4900 3050
Connection ~ 4900 3050
Wire Wire Line
	4900 3050 6200 3050
Wire Wire Line
	4750 2100 4750 1850
Connection ~ 4750 1850
Wire Wire Line
	4750 1850 6200 1850
Wire Wire Line
	1400 1600 4750 1600
Wire Wire Line
	4750 1600 4750 1850
Wire Wire Line
	3000 2650 4250 2650
Wire Wire Line
	650  3050 650  2700
Wire Wire Line
	650  2300 650  2250
$Comp
L Transistor_BJT:2N2219 T_NPN?
U 1 1 5E392AA1
P 750 2500
F 0 "T_NPN?" H 941 2546 39  0000 L CNN
F 1 "2N2219" H 941 2455 39  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-39-3" H 950 2425 50  0001 L CIN
F 3 "http://www.onsemi.com/pub_link/Collateral/2N2219-D.PDF" H 750 2500 50  0001 L CNN
	1    750  2500
	-1   0    0    -1  
$EndComp
$Comp
L Device:R_Small_US r_up?
U 1 1 5E424A40
P 3000 2500
F 0 "r_up?" H 2932 2465 35  0000 R CNN
F 1 "10KΩ" H 2932 2534 35  0000 R CNN
F 2 "" H 3000 2500 50  0001 C CNN
F 3 "~" H 3000 2500 50  0001 C CNN
	1    3000 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	3000 2650 3000 2600
Wire Wire Line
	3000 2400 950  2400
Wire Wire Line
	950  2400 950  2500
$EndSCHEMATC
