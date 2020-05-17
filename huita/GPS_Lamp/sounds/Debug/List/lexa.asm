
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATtiny2313
;Program type           : Application
;Clock frequency        : 8,000000 MHz
;Memory model           : Tiny
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 32 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_TINY_

	#pragma AVRPART ADMIN PART_NAME ATtiny2313
	#pragma AVRPART MEMORY PROG_FLASH 2048
	#pragma AVRPART MEMORY EEPROM 128
	#pragma AVRPART MEMORY INT_SRAM SIZE 128
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU WDTCR=0x21
	.EQU WDTCSR=0x21
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU SPL=0x3D
	.EQU SREG=0x3F
	.EQU GPIOR0=0x13
	.EQU GPIOR1=0x14
	.EQU GPIOR2=0x15

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x00DF
	.EQU __DSTACK_SIZE=0x0020
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	RCALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOV  R26,R@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOV  R26,R@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOV  R26,R@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOV  R26,R@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOV  R26,R@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOV  R26,R@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _nom_ok=R3
	.DEF _nom_n=R2
	.DEF _i=R5
	.DEF _t=R4
	.DEF _stdl=R6
	.DEF _stdl_msb=R7
	.DEF _rx_wr_index=R9
	.DEF _rx_rd_index=R8
	.DEF _rx_counter=R11

;GPIOR0-GPIOR2 INITIALIZATION VALUES
	.EQU __GPIOR0_INIT=0x00
	.EQU __GPIOR1_INIT=0x00
	.EQU __GPIOR2_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	RJMP __RESET
	RJMP _ext_int0_isr
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP _timer1_ovf_isr
	RJMP _timer0_ovf_isr
	RJMP _usart_rx_isr
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00

_noti1:
	.DB  0x5E,0xCD,0xED,0x7C,0xB3,0x5C,0xDA,0x31
	.DB  0x89,0x90,0x97,0x77,0xC4,0xC7,0xCA,0xCC
	.DB  0xD0,0xD3,0xD5,0xD8,0xDA,0xDC,0xDE,0xE0
_noti2:
	.DB  0x2E,0xE6,0x76,0x3D,0x59,0xAD,0xEC,0x18
	.DB  0x44,0x4F,0x4B,0x3B,0xE2,0xE3,0xE5,0xE6
	.DB  0xE8,0xE9,0xEA,0xEC,0xED,0xEE,0xEF,0xF0
_noti3:
	.DB  0x16,0xF2,0xBA,0x1E,0x2C,0xD6,0x76,0x47
	.DB  0xA1,0x23,0xA5,0x1D,0xF1,0xF1,0xF2,0xF3
	.DB  0xF4,0xF4,0xF5,0xF6,0xF6,0xF7,0xF7,0xF8
_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0


__GLOBAL_INI_TBL:
	.DW  0x04
	.DW  0x08
	.DW  __REG_VARS*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,__CLEAR_SRAM_SIZE
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;GPIOR0-GPIOR2 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30
	;__GPIOR1_INIT = __GPIOR0_INIT
	OUT  GPIOR1,R30
	;__GPIOR2_INIT = __GPIOR0_INIT
	OUT  GPIOR2,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x80

	.CSEG
;/*******************************************************
;This program was created by the
;CodeWizardAVR V3.12 Advanced
;Automatic Program Generator
;© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 08.02.2019
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATtiny2313
;AVR Core Clock frequency: 8,000000 MHz
;Memory model            : Tiny
;External RAM size       : 0
;Data Stack size         : 32
;*******************************************************/
;
;#include <tiny2313.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x50
	.EQU __sm_powerdown=0x10
	.EQU __sm_standby=0x40
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;// Declare your global variables here
;
;
;     unsigned  char nom_ok, nom_n, i,t;
;
;  unsigned  int   stdl;
; bit prer;
;
;
;
;
;
;flash char noti1[2] [12]={
;{0X5E,0XCD,0XED,0X7C,0XB3,0X5C,0XDA,0x31,0X89,0X90,0X97,0X77},
;
;{0XC4,0XC7,0XCA,0XCC,0XD0,0XD3,0XD5,0XD8,0XDA,0XDC,0XDE,0XE0}
;};
;
;flash char noti2[2][12]  ={
;{0X2E,0XE6,0X76,0X3D,0X59,0XAD,0XEC,0X18,0X44,0X4F,0X4B,0X3B},
;
;{0XE2,0XE3,0XE5,0XE6,0XE8,0XE9,0XEA,0XEC,0XED,0XEE,0XEF,0XF0}
;};
;
;flash char noti3[2][12]={
;{0X16,0XF2,0XBA,0X1E,0X2C,0XD6,0X76,0X47,0XA1,0X23,0XA5,0X1D},
;
;{0XF1,0XF1,0XF2,0XF3,0XF4,0XF4,0XF5,0XF6,0XF6,0XF7,0XF7,0XF8}
; };
;
;
;
;
;void igra ( char  nom, int  dl)
; 0000 003B {

	.CSEG
_igra:
; .FSTART _igra
; 0000 003C     nom_n=nom;
	ST   -Y,R27
	ST   -Y,R26
;	nom -> Y+2
;	dl -> Y+0
	LDD  R2,Y+2
; 0000 003D     stdl=dl;
	__GETWRS 6,7,0
; 0000 003E  TIMSK=0x82;
	LDI  R30,LOW(130)
	OUT  0x39,R30
; 0000 003F         while(nom_n>0)
_0x3:
	LDI  R30,LOW(0)
	CP   R30,R2
	BRSH _0x5
; 0000 0040         {
; 0000 0041         PORTB.7=1;
	SBI  0x18,7
; 0000 0042         prer=1;
	SBI  0x13,0
; 0000 0043        while(prer==1) {};
_0xA:
	SBIC 0x13,0
	RJMP _0xA
; 0000 0044         PORTB.7=0;     PORTB.6=1;
	CBI  0x18,7
	SBI  0x18,6
; 0000 0045         prer=1;
	SBI  0x13,0
; 0000 0046         while(prer==1){};
_0x13:
	SBIC 0x13,0
	RJMP _0x13
; 0000 0047         PORTB.6=0; }
	CBI  0x18,6
	RJMP _0x3
_0x5:
; 0000 0048         }
	ADIW R28,3
	RET
; .FEND
;
;        void pauza (int pau) {
; 0000 004A void pauza (int pau) {
_pauza:
; .FSTART _pauza
; 0000 004B          PORTB.7=0; TIMSK=0x02;  stdl=pau;
	ST   -Y,R27
	ST   -Y,R26
;	pau -> Y+0
	CBI  0x18,7
	LDI  R30,LOW(2)
	OUT  0x39,R30
	__GETWRS 6,7,0
; 0000 004C         while(stdl!=0){};
_0x1A:
	MOV  R0,R6
	OR   R0,R7
	BRNE _0x1A
; 0000 004D         }
	ADIW R28,2
	RET
; .FEND
;
;
;
;     void melodi (unsigned  char n)
; 0000 0052          {
_melodi:
; .FSTART _melodi
; 0000 0053 
; 0000 0054 
; 0000 0055             switch(n)
	ST   -Y,R26
;	n -> Y+0
	LD   R30,Y
	RCALL SUBOPT_0x0
; 0000 0056           {
; 0000 0057            case 1:
	BRNE _0x20
; 0000 0058 
; 0000 0059 
; 0000 005A                 //vkluchenie
; 0000 005B                     nom_ok=2;
	RCALL SUBOPT_0x1
; 0000 005C 
; 0000 005D                     igra(7,10);
	RCALL SUBOPT_0x2
; 0000 005E                    pauza(20);
; 0000 005F                    igra(7,10);
	RCALL SUBOPT_0x2
; 0000 0060                     pauza(20);
; 0000 0061 
; 0000 0062 
; 0000 0063                    igra(11,10);
	RCALL SUBOPT_0x3
; 0000 0064                    pauza(20);
; 0000 0065                    igra(11,10);
	RCALL SUBOPT_0x3
; 0000 0066                    pauza(20);
; 0000 0067 
; 0000 0068                    nom_ok=3;
	LDI  R30,LOW(3)
	MOV  R3,R30
; 0000 0069                   igra(5,30);
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0x5
	RCALL _igra
; 0000 006A                    pauza(30);
	RCALL SUBOPT_0x5
	RCALL _pauza
; 0000 006B 
; 0000 006C 
; 0000 006D 
; 0000 006E 
; 0000 006F 
; 0000 0070 
; 0000 0071 
; 0000 0072 
; 0000 0073 
; 0000 0074 
; 0000 0075                 return;
	RJMP _0x2060002
; 0000 0076 
; 0000 0077            case 2:
_0x20:
	RCALL SUBOPT_0x6
	BRNE _0x21
; 0000 0078 
; 0000 0079 
; 0000 007A                 //sputniki naideni
; 0000 007B                    nom_ok=2;
	RCALL SUBOPT_0x1
; 0000 007C 
; 0000 007D                    igra(1,15);
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x8
; 0000 007E                    igra(4,15);
	LDI  R30,LOW(4)
	ST   -Y,R30
	RCALL SUBOPT_0x8
; 0000 007F                    igra(7,30);
	LDI  R30,LOW(7)
	ST   -Y,R30
	RCALL SUBOPT_0x5
	RCALL SUBOPT_0x9
; 0000 0080                    pauza(15);
; 0000 0081                    igra(2,15);
	LDI  R30,LOW(2)
	ST   -Y,R30
	RCALL SUBOPT_0x8
; 0000 0082                    igra(5,15);
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0x8
; 0000 0083                    igra(9,30);
	RCALL SUBOPT_0xA
	RCALL SUBOPT_0x5
	RCALL SUBOPT_0x9
; 0000 0084                    pauza(15);
; 0000 0085                      nom_ok=2;
	RCALL SUBOPT_0x1
; 0000 0086                    igra(7,30);
	LDI  R30,LOW(7)
	ST   -Y,R30
	RCALL SUBOPT_0x5
	RCALL _igra
; 0000 0087                    nom_ok=3;
	LDI  R30,LOW(3)
	MOV  R3,R30
; 0000 0088                     igra(4,50);
	LDI  R30,LOW(4)
	ST   -Y,R30
	LDI  R26,LOW(50)
	RCALL SUBOPT_0xB
; 0000 0089 
; 0000 008A 
; 0000 008B                 return;
	RJMP _0x2060002
; 0000 008C 
; 0000 008D                 /*
; 0000 008E 
; 0000 008F                 //vnimanie akb
; 0000 0090                  igra(1,30);
; 0000 0091                    pauza(30);
; 0000 0092                    igra(1,30);
; 0000 0093                    pauza(30);
; 0000 0094                    igra(1,30);
; 0000 0095                    pauza(30);
; 0000 0096                    igra(1,30);
; 0000 0097                     pauza(30);
; 0000 0098                    igra(11,10);
; 0000 0099                    igra(10,10);
; 0000 009A                    igra(9,10);
; 0000 009B                    igra(8,10);
; 0000 009C                    igra(7,10);
; 0000 009D                    igra(6,10);
; 0000 009E                    igra(5,10);
; 0000 009F                    igra(4,10);
; 0000 00A0                    igra(3,10);
; 0000 00A1                    igra(2,10);
; 0000 00A2                    igra(1,10);
; 0000 00A3                    pauza(10);
; 0000 00A4                    igra(1,30);
; 0000 00A5                    pauza(30);
; 0000 00A6                    igra(1,30);
; 0000 00A7                    pauza(30);
; 0000 00A8                    igra(1,30);
; 0000 00A9                    pauza(30);
; 0000 00AA                    igra(1,30);
; 0000 00AB                      pauza(30);
; 0000 00AC                     igra(11,10);
; 0000 00AD                    igra(10,10);
; 0000 00AE                    igra(9,10);
; 0000 00AF                    igra(8,10);
; 0000 00B0                    igra(7,10);
; 0000 00B1                    igra(6,10);
; 0000 00B2                    igra(5,10);
; 0000 00B3                    igra(4,10);
; 0000 00B4                    igra(3,10);
; 0000 00B5                    igra(2,10);
; 0000 00B6                    igra(1,10);
; 0000 00B7                    pauza(10);
; 0000 00B8                    igra(1,30);
; 0000 00B9                    pauza(30);
; 0000 00BA                    igra(1,30);
; 0000 00BB                    pauza(30);
; 0000 00BC                    igra(1,30);
; 0000 00BD                    pauza(30);
; 0000 00BE                    igra(1,30);
; 0000 00BF 
; 0000 00C0 
; 0000 00C1 
; 0000 00C2 
; 0000 00C3                 pauza(280);
; 0000 00C4                */
; 0000 00C5 
; 0000 00C6             case 3:
_0x21:
	RCALL SUBOPT_0xC
	BRNE _0x22
; 0000 00C7                 //vnimanie akb
; 0000 00C8                   nom_ok=2;
	RCALL SUBOPT_0x1
; 0000 00C9 
; 0000 00CA                     igra(11 ,80);
	LDI  R30,LOW(11)
	ST   -Y,R30
	LDI  R26,LOW(80)
	RCALL SUBOPT_0xB
; 0000 00CB                    pauza(50);
	LDI  R26,LOW(50)
	RCALL SUBOPT_0xD
; 0000 00CC 
; 0000 00CD                      igra(9,20);
	RCALL SUBOPT_0xE
; 0000 00CE                    pauza(20);
	LDI  R26,LOW(20)
	RCALL SUBOPT_0xD
; 0000 00CF                          igra(9,20);
	RCALL SUBOPT_0xE
; 0000 00D0                    pauza(20);
	LDI  R26,LOW(20)
	RCALL SUBOPT_0xD
; 0000 00D1                          igra(9,20);
	RCALL SUBOPT_0xE
; 0000 00D2                    pauza(20);
	LDI  R26,LOW(20)
	RCALL SUBOPT_0xD
; 0000 00D3                      igra(9,20);
	RCALL SUBOPT_0xE
; 0000 00D4                    pauza(100);
	LDI  R26,LOW(100)
	LDI  R27,0
	RCALL _pauza
; 0000 00D5 
; 0000 00D6 
; 0000 00D7 
; 0000 00D8 
; 0000 00D9 
; 0000 00DA 
; 0000 00DB 
; 0000 00DC 
; 0000 00DD 
; 0000 00DE 
; 0000 00DF                    /*
; 0000 00E0                        pauza(70);
; 0000 00E1                     igra(5,20);
; 0000 00E2                    igra(5,20);
; 0000 00E3                    igra(5,20);
; 0000 00E4                    igra(2,50);
; 0000 00E5                    */
; 0000 00E6 
; 0000 00E7 
; 0000 00E8 
; 0000 00E9                 return;
	RJMP _0x2060002
; 0000 00EA 
; 0000 00EB 
; 0000 00EC              case 4:
_0x22:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x1F
; 0000 00ED                                  nom_ok=1;
	LDI  R30,LOW(1)
	MOV  R3,R30
; 0000 00EE                                //poterya signala
; 0000 00EF 
; 0000 00F0 
; 0000 00F1                               igra(9,20);
	RCALL SUBOPT_0xA
	RCALL SUBOPT_0xE
; 0000 00F2                                igra(8,20);
	LDI  R30,LOW(8)
	ST   -Y,R30
	RCALL SUBOPT_0xE
; 0000 00F3                                 igra(7,20);
	LDI  R30,LOW(7)
	ST   -Y,R30
	RCALL SUBOPT_0xE
; 0000 00F4                                  igra(6,20);
	LDI  R30,LOW(6)
	ST   -Y,R30
	RCALL SUBOPT_0xE
; 0000 00F5                                   igra(5,20);
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0xE
; 0000 00F6                                    pauza(50);
	LDI  R26,LOW(50)
	LDI  R27,0
	RCALL _pauza
; 0000 00F7                                     igra(5,20);
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0xE
; 0000 00F8 
; 0000 00F9 
; 0000 00FA 
; 0000 00FB                                  return;
; 0000 00FC                            /*
; 0000 00FD                        //sputniki naideni
; 0000 00FE 
; 0000 00FF 
; 0000 0100                     nom_ok=1;
; 0000 0101 
; 0000 0102                        igra(11,30);
; 0000 0103 
; 0000 0104                     nom_ok=2;
; 0000 0105 
; 0000 0106 
; 0000 0107                        igra(4,30);
; 0000 0108                        igra(7,30);
; 0000 0109                        igra(11,30);
; 0000 010A 
; 0000 010B                      nom_ok=3;
; 0000 010C 
; 0000 010D 
; 0000 010E                        igra(0,15);
; 0000 010F 
; 0000 0110                          nom_ok=2;
; 0000 0111 
; 0000 0112 
; 0000 0113                        igra(11,30);
; 0000 0114                        igra(9,15);
; 0000 0115                        igra(8,30);
; 0000 0116                        igra(9,15);
; 0000 0117                        igra(8,30);
; 0000 0118                        igra(5,15);
; 0000 0119                        igra(4,30);
; 0000 011A                        igra(5,15);
; 0000 011B 
; 0000 011C                        nom_ok=1;
; 0000 011D 
; 0000 011E                        igra(11,60);
; 0000 011F 
; 0000 0120                         pauza(400);
; 0000 0121 
; 0000 0122 
; 0000 0123                          //sputniki naideni
; 0000 0124                        igra(7,80);
; 0000 0125                          pauza(30);
; 0000 0126 
; 0000 0127                        igra(0,30);
; 0000 0128                        pauza(30);
; 0000 0129                        igra(4,30);
; 0000 012A                        pauza(30);
; 0000 012B                        igra(7,30);
; 0000 012C 
; 0000 012D                        pauza(400);
; 0000 012E 
; 0000 012F            igra(2,30);
; 0000 0130            igra(2,15);
; 0000 0131            igra(5,15);
; 0000 0132            igra(9,30);
; 0000 0133            igra(2,30);
; 0000 0134            igra(4,30);
; 0000 0135            igra(4,30);
; 0000 0136 
; 0000 0137              pauza(60);
; 0000 0138 
; 0000 0139 
; 0000 013A            igra(1,30);
; 0000 013B            igra(0,15);
; 0000 013C            igra(4,30);
; 0000 013D            igra(9,30);
; 0000 013E            igra(0,30);
; 0000 013F             igra(2,30);
; 0000 0140             igra(2,30);
; 0000 0141 
; 0000 0142 
; 0000 0143             pauza(50);
; 0000 0144 
; 0000 0145             igra(2,30);
; 0000 0146            igra(2,15);
; 0000 0147            igra(5,15);
; 0000 0148            igra(9,30);
; 0000 0149            igra(2,30);
; 0000 014A            igra(4,30);
; 0000 014B            igra(4,30);
; 0000 014C 
; 0000 014D              pauza(60);
; 0000 014E 
; 0000 014F            igra(7,30);
; 0000 0150            igra(5,30);
; 0000 0151            igra(4,30);
; 0000 0152            igra(7,30);
; 0000 0153            igra(9,60);
; 0000 0154 
; 0000 0155 
; 0000 0156          pauza(180);
; 0000 0157 
; 0000 0158 
; 0000 0159 
; 0000 015A 
; 0000 015B          //var2
; 0000 015C           nom_ok=2;
; 0000 015D           igra(4,15);
; 0000 015E 
; 0000 015F             pauza(5);
; 0000 0160 
; 0000 0161           igra(4,15);
; 0000 0162 
; 0000 0163           pauza(25);
; 0000 0164 
; 0000 0165           igra(4,15);
; 0000 0166 
; 0000 0167           pauza(25);
; 0000 0168 
; 0000 0169           igra(0,15);
; 0000 016A            pauza(5);
; 0000 016B 
; 0000 016C           igra(4,35);
; 0000 016D 
; 0000 016E            pauza(5);
; 0000 016F 
; 0000 0170           igra(7,20);
; 0000 0171 
; 0000 0172            pauza(30);
; 0000 0173 
; 0000 0174             nom_ok=1;
; 0000 0175 
; 0000 0176           igra(7,40);
; 0000 0177 
; 0000 0178            pauza(50);
; 0000 0179              */
; 0000 017A            }
_0x1F:
; 0000 017B 
; 0000 017C 
; 0000 017D                }
_0x2060002:
	ADIW R28,1
	RET
; .FEND
;
;
;
;#define  red_off PORTB.3=0;
;
;#define  green_off PORTB.2=0;
;
;#define  blue_off PORTD.5=0;
;
;#define  red_on PORTB.3=1;
;
;#define  green_on PORTB.2=1;
;
;#define   blue_on PORTD.5=1;
;
;
;
;
;void color_es(char red, char green, char blue,int time,char n)
; 0000 0191 
; 0000 0192   {
_color_es:
; .FSTART _color_es
; 0000 0193    char k;
; 0000 0194    for(k=n;k<255;k++)
	ST   -Y,R26
	ST   -Y,R17
;	red -> Y+6
;	green -> Y+5
;	blue -> Y+4
;	time -> Y+2
;	n -> Y+1
;	k -> R17
	LDD  R17,Y+1
_0x25:
	CPI  R17,255
	BRSH _0x26
; 0000 0195 
; 0000 0196    {
; 0000 0197      if(red==1) OCR1A=k;
	LDD  R26,Y+6
	CPI  R26,LOW(0x1)
	BRNE _0x27
	RCALL SUBOPT_0xF
; 0000 0198       if(green==1) OCR0A=k;
_0x27:
	LDD  R26,Y+5
	CPI  R26,LOW(0x1)
	BRNE _0x28
	OUT  0x36,R17
; 0000 0199        if(blue==1) OCR0B=k;
_0x28:
	LDD  R26,Y+4
	CPI  R26,LOW(0x1)
	BRNE _0x29
	OUT  0x3C,R17
; 0000 019A         delay_ms(time);
_0x29:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	RCALL _delay_ms
; 0000 019B         }
	SUBI R17,-1
	RJMP _0x25
_0x26:
; 0000 019C         }
	RJMP _0x2060001
; .FEND
;
;
;void color_no(char red, char green, char blue,int time,char n)
; 0000 01A0 
; 0000 01A1   {
_color_no:
; .FSTART _color_no
; 0000 01A2    char w;
; 0000 01A3    for(w=n;w>0;w--)
	ST   -Y,R26
	ST   -Y,R17
;	red -> Y+6
;	green -> Y+5
;	blue -> Y+4
;	time -> Y+2
;	n -> Y+1
;	w -> R17
	LDD  R17,Y+1
_0x2B:
	CPI  R17,1
	BRLO _0x2C
; 0000 01A4 
; 0000 01A5    {
; 0000 01A6      if(red==1) OCR1A=w;
	LDD  R26,Y+6
	CPI  R26,LOW(0x1)
	BRNE _0x2D
	RCALL SUBOPT_0xF
; 0000 01A7       if(green==1) OCR0A=w;
_0x2D:
	LDD  R26,Y+5
	CPI  R26,LOW(0x1)
	BRNE _0x2E
	OUT  0x36,R17
; 0000 01A8        if(blue==1) OCR0B=w;
_0x2E:
	LDD  R26,Y+4
	CPI  R26,LOW(0x1)
	BRNE _0x2F
	OUT  0x3C,R17
; 0000 01A9         delay_ms(time);
_0x2F:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	RCALL _delay_ms
; 0000 01AA         }
	SUBI R17,1
	RJMP _0x2B
_0x2C:
; 0000 01AB         }
_0x2060001:
	LDD  R17,Y+0
	ADIW R28,7
	RET
; .FEND
;
;void color (void)
; 0000 01AE 
; 0000 01AF 
; 0000 01B0 {
_color:
; .FSTART _color
; 0000 01B1 
; 0000 01B2  TCCR0A=(1<<COM0A1) | (0<<COM0A0) | (1<<COM0B1) | (0<<COM0B0) | (0<<WGM01) | (1<<WGM00);
	LDI  R30,LOW(161)
	OUT  0x30,R30
; 0000 01B3 TCCR0B=(0<<WGM02) | (0<<CS02) | (1<<CS01) | (1<<CS00);
	LDI  R30,LOW(3)
	OUT  0x33,R30
; 0000 01B4 
; 0000 01B5 
; 0000 01B6 
; 0000 01B7 TCCR1A=(1<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (1<<WGM10);
	LDI  R30,LOW(129)
	OUT  0x2F,R30
; 0000 01B8 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (1<<CS11) | (1<<CS10);
	LDI  R30,LOW(3)
	OUT  0x2E,R30
; 0000 01B9 
; 0000 01BA 
; 0000 01BB 
; 0000 01BC 
; 0000 01BD  //TCCR1A=(1<<COM1A1) | (1<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (1<<WGM10);
; 0000 01BE //TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (1<<CS11) | (1<<CS10);
; 0000 01BF  //TCCR0A=(1<<COM0A1) | (1<<COM0A0) | (1<<COM0B1) | (1<<COM0B0) | (0<<WGM01) | (1<<WGM00);
; 0000 01C0 //TCCR0B=(0<<WGM02) | (0<<CS02) | (1<<CS01) | (1<<CS00);
; 0000 01C1 
; 0000 01C2    }
	RET
; .FEND
;
;void sound (void)
; 0000 01C5 
; 0000 01C6  {
_sound:
; .FSTART _sound
; 0000 01C7 
; 0000 01C8 TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	RCALL SUBOPT_0x10
; 0000 01C9 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (1<<CS10);
; 0000 01CA    TCCR0A=0x00;
	OUT  0x30,R30
; 0000 01CB TCCR0B=0x05;
	LDI  R30,LOW(5)
	OUT  0x33,R30
; 0000 01CC 
; 0000 01CD 
; 0000 01CE 
; 0000 01CF }
	RET
; .FEND
;
;
;
;// External Interrupt 0 service routine
;interrupt [EXT_INT0] void ext_int0_isr(void)
; 0000 01D5 {
_ext_int0_isr:
; .FSTART _ext_int0_isr
	ST   -Y,R30
; 0000 01D6 // Place your code here
; 0000 01D7    i=5;
	LDI  R30,LOW(5)
	MOV  R5,R30
; 0000 01D8 }
	LD   R30,Y+
	RETI
; .FEND
;
;#define DATA_REGISTER_EMPTY (1<<UDRE)
;#define RX_COMPLETE (1<<RXC)
;#define FRAMING_ERROR (1<<FE)
;#define PARITY_ERROR (1<<UPE)
;#define DATA_OVERRUN (1<<DOR)
;
;// USART Receiver buffer
;#define RX_BUFFER_SIZE 8
;char rx_buffer[RX_BUFFER_SIZE];
;
;#if RX_BUFFER_SIZE <= 256
;unsigned char rx_wr_index=0,rx_rd_index=0;
;#else
;unsigned int rx_wr_index=0,rx_rd_index=0;
;#endif
;
;#if RX_BUFFER_SIZE < 256
;unsigned char rx_counter=0;
;#else
;unsigned int rx_counter=0;
;#endif
;
;// This flag is set on USART Receiver buffer overflow
;bit rx_buffer_overflow;
;
;// USART Receiver interrupt service routine
;interrupt [USART_RXC] void usart_rx_isr(void)
; 0000 01F5 {
_usart_rx_isr:
; .FSTART _usart_rx_isr
	ST   -Y,R26
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 01F6 char status,data;
; 0000 01F7 status=UCSRA;
	RCALL __SAVELOCR2
;	status -> R17
;	data -> R16
	IN   R17,11
; 0000 01F8 data=UDR;
	IN   R16,12
; 0000 01F9 if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x30
; 0000 01FA    {
; 0000 01FB    rx_buffer[rx_wr_index++]=data;
	MOV  R30,R9
	INC  R9
	SUBI R30,-LOW(_rx_buffer)
	ST   Z,R16
; 0000 01FC #if RX_BUFFER_SIZE == 256
; 0000 01FD    // special case for receiver buffer size=256
; 0000 01FE    if (++rx_counter == 0) rx_buffer_overflow=1;
; 0000 01FF #else
; 0000 0200    if (rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
	LDI  R30,LOW(8)
	CP   R30,R9
	BRNE _0x31
	CLR  R9
; 0000 0201    if (++rx_counter == RX_BUFFER_SIZE)
_0x31:
	INC  R11
	LDI  R30,LOW(8)
	CP   R30,R11
	BRNE _0x32
; 0000 0202       {
; 0000 0203       rx_counter=0;
	CLR  R11
; 0000 0204       rx_buffer_overflow=1;
	SBI  0x13,1
; 0000 0205       }
; 0000 0206 #endif
; 0000 0207    }
_0x32:
; 0000 0208 
; 0000 0209    switch(data)
_0x30:
	MOV  R30,R16
	LDI  R31,0
; 0000 020A    {
; 0000 020B      case 'v': i=1; break;
	CPI  R30,LOW(0x76)
	LDI  R26,HIGH(0x76)
	CPC  R31,R26
	BRNE _0x38
	LDI  R30,LOW(1)
	RJMP _0xA8
; 0000 020C      case 's': i=2; break;
_0x38:
	CPI  R30,LOW(0x73)
	LDI  R26,HIGH(0x73)
	CPC  R31,R26
	BRNE _0x39
	LDI  R30,LOW(2)
	RJMP _0xA8
; 0000 020D       case 'b': i=3; break;
_0x39:
	CPI  R30,LOW(0x62)
	LDI  R26,HIGH(0x62)
	CPC  R31,R26
	BRNE _0x3A
	LDI  R30,LOW(3)
	RJMP _0xA8
; 0000 020E        case 'n': i=4; break;
_0x3A:
	CPI  R30,LOW(0x6E)
	LDI  R26,HIGH(0x6E)
	CPC  R31,R26
	BRNE _0x37
	LDI  R30,LOW(4)
_0xA8:
	MOV  R5,R30
; 0000 020F 
; 0000 0210        }
_0x37:
; 0000 0211 }
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R26,Y+
	RETI
; .FEND
;
;#ifndef _DEBUG_TERMINAL_IO_
;// Get a character from the USART Receiver buffer
;#define _ALTERNATE_GETCHAR_
;#pragma used+
;char getchar(void)
; 0000 0218 {
; 0000 0219 char data;
; 0000 021A while (rx_counter==0);
;	data -> R17
; 0000 021B data=rx_buffer[rx_rd_index++];
; 0000 021C #if RX_BUFFER_SIZE != 256
; 0000 021D if (rx_rd_index == RX_BUFFER_SIZE) rx_rd_index=0;
; 0000 021E #endif
; 0000 021F #asm("cli")
; 0000 0220 --rx_counter;
; 0000 0221 #asm("sei")
; 0000 0222 return data;
; 0000 0223 }
;#pragma used-
;#endif
;
;// Standard Input/Output functions
;#include <stdio.h>
;
;// Timer 0 overflow interrupt service routine
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
; 0000 022C {
_timer0_ovf_isr:
; .FSTART _timer0_ovf_isr
	ST   -Y,R0
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 022D // Place your code here
; 0000 022E  TCNT0=177;
	LDI  R30,LOW(177)
	OUT  0x32,R30
; 0000 022F stdl--;
	MOVW R30,R6
	SBIW R30,1
	MOVW R6,R30
; 0000 0230 if(stdl==0)
	MOV  R0,R6
	OR   R0,R7
	BRNE _0x40
; 0000 0231          nom_n=0;
	CLR  R2
; 0000 0232 }
_0x40:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R0,Y+
	RETI
; .FEND
;
;// Timer1 overflow interrupt service routine
;interrupt [TIM1_OVF] void timer1_ovf_isr(void)
; 0000 0236 {
_timer1_ovf_isr:
; .FSTART _timer1_ovf_isr
	ST   -Y,R0
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 0237 // Place your code here
; 0000 0238 
; 0000 0239 
; 0000 023A  switch(nom_ok)
	MOV  R30,R3
	RCALL SUBOPT_0x0
; 0000 023B {
; 0000 023C 
; 0000 023D case 1 :
	BRNE _0x44
; 0000 023E 
; 0000 023F TCNT1L=noti1[0][nom_n];TCNT1H=noti1[1][nom_n]; break;
	RCALL SUBOPT_0x11
	SUBI R30,LOW(-_noti1*2)
	SBCI R31,HIGH(-_noti1*2)
	LPM  R0,Z
	OUT  0x2C,R0
	__POINTW2FN _noti1,12
	RCALL SUBOPT_0x11
	RCALL SUBOPT_0x12
	RJMP _0x43
; 0000 0240 
; 0000 0241  case 2 :
_0x44:
	RCALL SUBOPT_0x6
	BRNE _0x45
; 0000 0242 
; 0000 0243 TCNT1L=noti2[0][nom_n];TCNT1H=noti2[1][nom_n]; break;
	RCALL SUBOPT_0x11
	SUBI R30,LOW(-_noti2*2)
	SBCI R31,HIGH(-_noti2*2)
	LPM  R0,Z
	OUT  0x2C,R0
	__POINTW2FN _noti2,12
	RCALL SUBOPT_0x11
	RCALL SUBOPT_0x12
	RJMP _0x43
; 0000 0244 
; 0000 0245  case 3 :
_0x45:
	RCALL SUBOPT_0xC
	BRNE _0x47
; 0000 0246 
; 0000 0247 TCNT1L=noti3[0][nom_n];TCNT1H=noti3[1][nom_n]; break;
	RCALL SUBOPT_0x11
	SUBI R30,LOW(-_noti3*2)
	SBCI R31,HIGH(-_noti3*2)
	LPM  R0,Z
	OUT  0x2C,R0
	__POINTW2FN _noti3,12
	RCALL SUBOPT_0x11
	RCALL SUBOPT_0x12
; 0000 0248  default:
_0x47:
; 0000 0249     };
_0x43:
; 0000 024A prer=0;
	CBI  0x13,0
; 0000 024B 
; 0000 024C 
; 0000 024D 
; 0000 024E }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R0,Y+
	RETI
; .FEND
;
;void main(void)
; 0000 0251 {
_main:
; .FSTART _main
; 0000 0252 // Declare your local variables here
; 0000 0253 
; 0000 0254 // Crystal Oscillator division factor: 1
; 0000 0255 #pragma optsize-
; 0000 0256 CLKPR=(1<<CLKPCE);
	LDI  R30,LOW(128)
	OUT  0x26,R30
; 0000 0257 CLKPR=(0<<CLKPCE) | (0<<CLKPS3) | (0<<CLKPS2) | (0<<CLKPS1) | (0<<CLKPS0);
	LDI  R30,LOW(0)
	OUT  0x26,R30
; 0000 0258 #ifdef _OPTIMIZE_SIZE_
; 0000 0259 #pragma optsize+
; 0000 025A #endif
; 0000 025B 
; 0000 025C // Input/Output Ports initialization
; 0000 025D // Port A initialization
; 0000 025E // Function: Bit2=In Bit1=In Bit0=In
; 0000 025F DDRA=(0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	OUT  0x1A,R30
; 0000 0260 // State: Bit2=T Bit1=T Bit0=T
; 0000 0261 PORTA=(0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	OUT  0x1B,R30
; 0000 0262 
; 0000 0263 // Port B initialization
; 0000 0264 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0265 DDRB=(1<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (1<<DDB3) | (1<<DDB2) | (0<<DDB1) | (0<<DDB0);
	LDI  R30,LOW(140)
	OUT  0x17,R30
; 0000 0266 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0267 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 0268 
; 0000 0269 // Port D initialization
; 0000 026A // Function: Bit6=Out Bit5=In Bit4=In Bit3=In Bit2=Out Bit1=In Bit0=In
; 0000 026B DDRD=(1<<DDD6) | (1<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	LDI  R30,LOW(96)
	OUT  0x11,R30
; 0000 026C // State: Bit6=0 Bit5=T Bit4=T Bit3=T Bit2=0 Bit1=T Bit0=T
; 0000 026D PORTD=(0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (1<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	LDI  R30,LOW(4)
	OUT  0x12,R30
; 0000 026E 
; 0000 026F 
; 0000 0270 
; 0000 0271 // Timer/Counter 0 initialization
; 0000 0272 // Clock source: System Clock
; 0000 0273 // Clock value: 7,813 kHz
; 0000 0274 // Mode: Normal top=0xFF
; 0000 0275 // OC0A output: Disconnected
; 0000 0276 // OC0B output: Disconnected
; 0000 0277 TCCR0A=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 0278 TCCR0B=0x05;
	LDI  R30,LOW(5)
	OUT  0x33,R30
; 0000 0279 TCNT0=0x00;
	LDI  R30,LOW(0)
	OUT  0x32,R30
; 0000 027A OCR0A=0x00;
	OUT  0x36,R30
; 0000 027B OCR0B=0x00;
	OUT  0x3C,R30
; 0000 027C 
; 0000 027D 
; 0000 027E 
; 0000 027F 
; 0000 0280 // Timer/Counter 1 initialization
; 0000 0281 // Clock source: System Clock
; 0000 0282 // Clock value: Timer1 Stopped
; 0000 0283 // Mode: Normal top=0xFFFF
; 0000 0284 // OC1A output: Disconnected
; 0000 0285 // OC1B output: Disconnected
; 0000 0286 // Noise Canceler: Off
; 0000 0287 // Input Capture on Falling Edge
; 0000 0288 // Timer1 Overflow Interrupt: On
; 0000 0289 // Input Capture Interrupt: Off
; 0000 028A // Compare A Match Interrupt: Off
; 0000 028B // Compare B Match Interrupt: Off
; 0000 028C TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	RCALL SUBOPT_0x10
; 0000 028D TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (1<<CS10);
; 0000 028E TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 028F TCNT1L=0x00;
	LDI  R30,LOW(0)
	OUT  0x2C,R30
; 0000 0290 ICR1H=0x00;
	OUT  0x25,R30
; 0000 0291 ICR1L=0x00;
	OUT  0x24,R30
; 0000 0292 OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 0293 OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 0294 OCR1BH=0x00;
	OUT  0x29,R30
; 0000 0295 OCR1BL=0x00;
	OUT  0x28,R30
; 0000 0296 
; 0000 0297 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 0298 TIMSK=(0<<TOIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<ICIE1) | (0<<OCIE0B) | (0<<TOIE0) | (0<<OCIE0A);
	RCALL SUBOPT_0x13
; 0000 0299 
; 0000 029A // External Interrupt(s) initialization
; 0000 029B // INT0: On
; 0000 029C // INT0 Mode: Rising Edge
; 0000 029D // INT1: Off
; 0000 029E // Interrupt on any change on pins PCINT0-7: Off
; 0000 029F GIMSK=(0<<INT1) | (1<<INT0) | (0<<PCIE);
	LDI  R30,LOW(64)
	OUT  0x3B,R30
; 0000 02A0 MCUCR=(0<<ISC11) | (0<<ISC10) | (1<<ISC01) | (1<<ISC00);
	LDI  R30,LOW(3)
	OUT  0x35,R30
; 0000 02A1 EIFR=(0<<INTF1) | (1<<INTF0) | (0<<PCIF);
	LDI  R30,LOW(64)
	OUT  0x3A,R30
; 0000 02A2 
; 0000 02A3 // USI initialization
; 0000 02A4 // Mode: Disabled
; 0000 02A5 // Clock source: Register & Counter=no clk.
; 0000 02A6 // USI Counter Overflow Interrupt: Off
; 0000 02A7 USICR=(0<<USISIE) | (0<<USIOIE) | (0<<USIWM1) | (0<<USIWM0) | (0<<USICS1) | (0<<USICS0) | (0<<USICLK) | (0<<USITC);
	LDI  R30,LOW(0)
	OUT  0xD,R30
; 0000 02A8 
; 0000 02A9 // USART initialization
; 0000 02AA // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 02AB // USART Receiver: On
; 0000 02AC // USART Transmitter: Off
; 0000 02AD // USART Mode: Asynchronous
; 0000 02AE // USART Baud Rate: 9600
; 0000 02AF UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
	OUT  0xB,R30
; 0000 02B0 UCSRB=(1<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (1<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	LDI  R30,LOW(144)
	OUT  0xA,R30
; 0000 02B1 UCSRC=(0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
	LDI  R30,LOW(6)
	OUT  0x3,R30
; 0000 02B2 UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x2,R30
; 0000 02B3 UBRRL=0x33;
	LDI  R30,LOW(51)
	OUT  0x9,R30
; 0000 02B4 
; 0000 02B5 // Analog Comparator initialization
; 0000 02B6 // Analog Comparator: Off
; 0000 02B7 // The Analog Comparator's positive input is
; 0000 02B8 // connected to the AIN0 pin
; 0000 02B9 // The Analog Comparator's negative input is
; 0000 02BA // connected to the AIN1 pin
; 0000 02BB ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 02BC // Digital input buffer on AIN0: On
; 0000 02BD // Digital input buffer on AIN1: On
; 0000 02BE DIDR=(0<<AIN0D) | (0<<AIN1D);
	LDI  R30,LOW(0)
	OUT  0x1,R30
; 0000 02BF 
; 0000 02C0 
; 0000 02C1 // Global enable interrupts
; 0000 02C2 
; 0000 02C3 #asm("sei")
	sei
; 0000 02C4               delay_ms(1800);
	LDI  R26,LOW(1800)
	LDI  R27,HIGH(1800)
	RCALL _delay_ms
; 0000 02C5   melodi(1);
	LDI  R26,LOW(1)
	RCALL SUBOPT_0x14
; 0000 02C6      TIMSK=0;
; 0000 02C7           PORTB.7=0;
	CBI  0x18,7
; 0000 02C8       color();
	RCALL SUBOPT_0x15
; 0000 02C9  color_es(1,0,0,3,0);
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x17
; 0000 02CA 
; 0000 02CB color_es(0,0,1,3,0);
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x17
; 0000 02CC 
; 0000 02CD color_es(0,1,0,3,0);
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x18
; 0000 02CE 
; 0000 02CF color_no(1,1,1,2,255);
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x19
; 0000 02D0 
; 0000 02D1      blue_off
; 0000 02D2 //color_es(1,0,0,10,0);
; 0000 02D3 
; 0000 02D4 
; 0000 02D5 
; 0000 02D6 
; 0000 02D7     color_es(1,1,0,1,0);
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x16
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RCALL SUBOPT_0x1A
; 0000 02D8 
; 0000 02D9       sound();
; 0000 02DA 
; 0000 02DB     red_on
; 0000 02DC    green_on
; 0000 02DD    blue_off
; 0000 02DE 
; 0000 02DF 
; 0000 02E0 
; 0000 02E1 
; 0000 02E2 while (1)
_0x54:
; 0000 02E3       {
; 0000 02E4 
; 0000 02E5    while(i==0){};
_0x57:
	TST  R5
	BREQ _0x57
; 0000 02E6 
; 0000 02E7       switch(i)
	MOV  R30,R5
	LDI  R31,0
; 0000 02E8    {
; 0000 02E9 
; 0000 02EA  //   case 1:
; 0000 02EB 
; 0000 02EC     case 5:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x5D
; 0000 02ED 
; 0000 02EE 
; 0000 02EF     melodi(1);
	LDI  R26,LOW(1)
	RCALL SUBOPT_0x14
; 0000 02F0      TIMSK=0;
; 0000 02F1           PORTB.7=0;
	CBI  0x18,7
; 0000 02F2       color();
	RCALL SUBOPT_0x15
; 0000 02F3  color_es(1,0,0,3,0);
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x17
; 0000 02F4 
; 0000 02F5 color_es(0,0,1,3,0);
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x17
; 0000 02F6 
; 0000 02F7 color_es(0,1,0,3,0);
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x18
; 0000 02F8 
; 0000 02F9 color_no(1,1,1,2,255);
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x19
; 0000 02FA 
; 0000 02FB      blue_off
; 0000 02FC //color_es(1,0,0,10,0);
; 0000 02FD 
; 0000 02FE 
; 0000 02FF 
; 0000 0300 
; 0000 0301     color_es(1,1,0,10,0);
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x1B
	RCALL SUBOPT_0x1A
; 0000 0302 
; 0000 0303       sound();
; 0000 0304 
; 0000 0305     red_on
; 0000 0306    green_on
; 0000 0307    blue_off
; 0000 0308 
; 0000 0309 
; 0000 030A 
; 0000 030B 
; 0000 030C 
; 0000 030D 
; 0000 030E          if(i==5)
	LDI  R30,LOW(5)
	CP   R30,R5
	BRNE _0x68
; 0000 030F 
; 0000 0310          {
; 0000 0311 
; 0000 0312             i=6;
	LDI  R30,LOW(6)
	RCALL SUBOPT_0x1C
; 0000 0313         delay_ms(500);
; 0000 0314          continue;
	RJMP _0x54
; 0000 0315 
; 0000 0316          }
; 0000 0317 
; 0000 0318      break;
_0x68:
	RJMP _0x5C
; 0000 0319 
; 0000 031A      case 2: case 6:
_0x5D:
	RCALL SUBOPT_0x6
	BREQ _0x6A
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0x6B
_0x6A:
; 0000 031B 
; 0000 031C 
; 0000 031D          melodi(2);
	LDI  R26,LOW(2)
	RCALL SUBOPT_0x14
; 0000 031E           TIMSK=0;
; 0000 031F             PORTB.7=0;
	RCALL SUBOPT_0x1D
; 0000 0320           red_off  green_off
; 0000 0321 
; 0000 0322        for(t=0;t<4;t++)
_0x73:
	LDI  R30,LOW(4)
	CP   R4,R30
	BRSH _0x74
; 0000 0323        {
; 0000 0324          green_on delay_ms(300);green_off
	SBI  0x18,2
	RCALL SUBOPT_0x1E
	CBI  0x18,2
; 0000 0325                   delay_ms(300);
	RCALL SUBOPT_0x1E
; 0000 0326                   }
	INC  R4
	RJMP _0x73
_0x74:
; 0000 0327                delay_ms(150);
	RCALL SUBOPT_0x1F
; 0000 0328 
; 0000 0329          color();
; 0000 032A            color_es(1,1,0,10,0);
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x20
; 0000 032B 
; 0000 032C       sound();
; 0000 032D 
; 0000 032E     red_on
; 0000 032F    green_on
; 0000 0330 
; 0000 0331           if(i==6)
	LDI  R30,LOW(6)
	CP   R30,R5
	BRNE _0x7D
; 0000 0332           {
; 0000 0333           i=7;
	LDI  R30,LOW(7)
	RCALL SUBOPT_0x1C
; 0000 0334           delay_ms(500);
; 0000 0335           continue;
	RJMP _0x54
; 0000 0336                 }
; 0000 0337     break;
_0x7D:
	RJMP _0x5C
; 0000 0338 
; 0000 0339 
; 0000 033A 
; 0000 033B      case 3: case 7:
_0x6B:
	RCALL SUBOPT_0xC
	BREQ _0x7F
	CPI  R30,LOW(0x7)
	LDI  R26,HIGH(0x7)
	CPC  R31,R26
	BRNE _0x80
_0x7F:
; 0000 033C 
; 0000 033D           melodi(3);
	LDI  R26,LOW(3)
	RCALL SUBOPT_0x14
; 0000 033E            TIMSK=0;
; 0000 033F           PORTB.7=0;
	RCALL SUBOPT_0x1D
; 0000 0340         red_off  green_off
; 0000 0341        for(t=0;t<4;t++)
_0x88:
	LDI  R30,LOW(4)
	CP   R4,R30
	BRSH _0x89
; 0000 0342        {
; 0000 0343          red_on delay_ms(300);red_off
	SBI  0x18,3
	RCALL SUBOPT_0x1E
	CBI  0x18,3
; 0000 0344                   delay_ms(300);
	RCALL SUBOPT_0x1E
; 0000 0345                   }
	INC  R4
	RJMP _0x88
_0x89:
; 0000 0346 
; 0000 0347              delay_ms(150);
	RCALL SUBOPT_0x1F
; 0000 0348          color();
; 0000 0349            color_es(1,1,0,10,0);
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x20
; 0000 034A 
; 0000 034B       sound();
; 0000 034C 
; 0000 034D     red_on
; 0000 034E    green_on
; 0000 034F 
; 0000 0350           if(i==7)
	LDI  R30,LOW(7)
	CP   R30,R5
	BRNE _0x92
; 0000 0351           {
; 0000 0352           i=8;
	LDI  R30,LOW(8)
	RCALL SUBOPT_0x1C
; 0000 0353           delay_ms(500);
; 0000 0354           continue;
	RJMP _0x54
; 0000 0355                 }
; 0000 0356       break;
_0x92:
	RJMP _0x5C
; 0000 0357 
; 0000 0358 
; 0000 0359        case 4: case 8:
_0x80:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BREQ _0x94
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x5C
_0x94:
; 0000 035A 
; 0000 035B 
; 0000 035C           melodi(4);
	LDI  R26,LOW(4)
	RCALL SUBOPT_0x14
; 0000 035D            TIMSK=0;
; 0000 035E           PORTB.7=0;
	RCALL SUBOPT_0x1D
; 0000 035F          red_off  green_off
; 0000 0360 
; 0000 0361        for(t=0;t<4;t++)
_0x9D:
	LDI  R30,LOW(4)
	CP   R4,R30
	BRSH _0x9E
; 0000 0362        {
; 0000 0363          blue_on delay_ms(300);blue_off
	SBI  0x12,5
	RCALL SUBOPT_0x1E
	CBI  0x12,5
; 0000 0364                  delay_ms(300);
	RCALL SUBOPT_0x1E
; 0000 0365                   }
	INC  R4
	RJMP _0x9D
_0x9E:
; 0000 0366 
; 0000 0367           delay_ms(150);
	RCALL SUBOPT_0x1F
; 0000 0368          color();
; 0000 0369            color_es(1,1,0,10,0);
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x20
; 0000 036A 
; 0000 036B       sound();
; 0000 036C       red_on
; 0000 036D    green_on
; 0000 036E 
; 0000 036F     break;
; 0000 0370 
; 0000 0371 
; 0000 0372 
; 0000 0373        }
_0x5C:
; 0000 0374 
; 0000 0375 
; 0000 0376            i=0;
	CLR  R5
; 0000 0377 
; 0000 0378 
; 0000 0379 
; 0000 037A 
; 0000 037B         rx_wr_index=0;
	CLR  R9
; 0000 037C 
; 0000 037D 
; 0000 037E 
; 0000 037F 
; 0000 0380 
; 0000 0381 
; 0000 0382 
; 0000 0383 
; 0000 0384 
; 0000 0385 
; 0000 0386 
; 0000 0387       // Place your code here
; 0000 0388 
; 0000 0389       }
	RJMP _0x54
; 0000 038A }
_0xA7:
	RJMP _0xA7
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x50
	.EQU __sm_powerdown=0x10
	.EQU __sm_standby=0x40
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG

	.CSEG

	.CSEG

	.DSEG
_rx_buffer:
	.BYTE 0x8

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	LDI  R31,0
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	LDI  R30,LOW(2)
	MOV  R3,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x2:
	LDI  R30,LOW(7)
	ST   -Y,R30
	LDI  R26,LOW(10)
	LDI  R27,0
	RCALL _igra
	LDI  R26,LOW(20)
	LDI  R27,0
	RJMP _pauza

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x3:
	LDI  R30,LOW(11)
	ST   -Y,R30
	LDI  R26,LOW(10)
	LDI  R27,0
	RCALL _igra
	LDI  R26,LOW(20)
	LDI  R27,0
	RJMP _pauza

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4:
	LDI  R30,LOW(5)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x5:
	LDI  R26,LOW(30)
	LDI  R27,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x6:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 23 TIMES, CODE SIZE REDUCTION:20 WORDS
SUBOPT_0x7:
	LDI  R30,LOW(1)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x8:
	LDI  R26,LOW(15)
	LDI  R27,0
	RJMP _igra

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9:
	RCALL _igra
	LDI  R26,LOW(15)
	LDI  R27,0
	RJMP _pauza

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xA:
	LDI  R30,LOW(9)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xB:
	LDI  R27,0
	RJMP _igra

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xC:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xD:
	LDI  R27,0
	RCALL _pauza
	RJMP SUBOPT_0xA

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xE:
	LDI  R26,LOW(20)
	RJMP SUBOPT_0xB

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF:
	MOV  R30,R17
	LDI  R31,0
	OUT  0x2A+1,R31
	OUT  0x2A,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x10:
	LDI  R30,LOW(0)
	OUT  0x2F,R30
	LDI  R30,LOW(1)
	OUT  0x2E,R30
	LDI  R30,LOW(0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x11:
	MOV  R30,R2
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x12:
	ADD  R30,R26
	ADC  R31,R27
	LPM  R0,Z
	OUT  0x2D,R0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x13:
	LDI  R30,LOW(0)
	OUT  0x39,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x14:
	RCALL _melodi
	RJMP SUBOPT_0x13

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x15:
	RCALL _color
	RJMP SUBOPT_0x7

;OPTIMIZER ADDED SUBROUTINE, CALLED 17 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0x16:
	LDI  R30,LOW(0)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0x17:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _color_es
	RJMP SUBOPT_0x16

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x18:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _color_es
	RJMP SUBOPT_0x7

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x19:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(255)
	RCALL _color_no
	CBI  0x12,5
	RJMP SUBOPT_0x7

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1A:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _color_es
	RCALL _sound
	SBI  0x18,3
	SBI  0x18,2
	CBI  0x12,5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1B:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1C:
	MOV  R5,R30
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1D:
	CBI  0x18,7
	CBI  0x18,3
	CBI  0x18,2
	CLR  R4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x1E:
	LDI  R26,LOW(300)
	LDI  R27,HIGH(300)
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1F:
	LDI  R26,LOW(150)
	LDI  R27,0
	RCALL _delay_ms
	RJMP SUBOPT_0x15

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x20:
	RCALL SUBOPT_0x1B
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _color_es
	RCALL _sound
	SBI  0x18,3
	SBI  0x18,2
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

;END OF CODE MARKER
__END_OF_CODE:
