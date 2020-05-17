
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega16
;Program type           : Application
;Clock frequency        : 8,000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : float, width, precision
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega16
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

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
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
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
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
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
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
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
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
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

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _work_gps=R5
	.DEF _i=R4
	.DEF _temp_msb=R7
	.DEF _temp_lsb=R6
	.DEF _ed_speed=R9
	.DEF _deset_speed=R8
	.DEF _soten_speed=R11
	.DEF _sum_hours=R10
	.DEF _j=R13
	.DEF _ed_min_clock=R12

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  _ext_int0_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer0_ovf_isr
	JMP  0x00
	JMP  _usart_rx_isr
	JMP  0x00
	JMP  0x00
	JMP  _adc_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

;REGISTER BIT VARIABLES INITIALIZATION
__REG_BIT_VARS:
	.DW  0x0000

_0x3:
	.DB  0x0,0x1,0x2,0x3,0x40,0x41,0x42,0x43
	.DB  0x80,0x81
_0x0:
	.DB  0x20,0x0,0x3E,0x0,0x3C,0x0,0x30,0x0
	.DB  0x20,0x20,0x20,0x20,0x0,0x47,0x50,0x53
	.DB  0x20,0x69,0x6E,0x66,0x6F,0x20,0x73,0x79
	.DB  0x73,0x74,0x65,0x6D,0x0,0x56,0x65,0x72
	.DB  0x2E,0x20,0x31,0x38,0x2E,0x30,0x34,0x2E
	.DB  0x32,0x30,0x31,0x39,0x0,0x4D,0x38,0x30
	.DB  0x33,0x30,0x20,0x4E,0x45,0x4F,0x2D,0x4D
	.DB  0x38,0x4E,0x0,0x46,0x4C,0x41,0x53,0x48
	.DB  0x20,0x20,0x42,0x4E,0x2D,0x32,0x38,0x30
	.DB  0x0,0x50,0x53,0x41,0x20,0x20,0x47,0x72
	.DB  0x6F,0x75,0x70,0x65,0x0,0x50,0x45,0x55
	.DB  0x47,0x45,0x4F,0x54,0x20,0x33,0x30,0x37
	.DB  0x0,0x3A,0x0,0x53,0x3D,0x0,0x74,0x3D
	.DB  0x0,0x56,0x3D,0x0,0x45,0x52,0x52,0x4F
	.DB  0x52,0x20,0x20,0x0,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x0,0x4E,0x3D,0x20,0x20
	.DB  0x20,0x53,0x3D,0x0,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x0,0x20,0x20,0x4E
	.DB  0x4F,0x20,0x53,0x49,0x47,0x4E,0x41,0x4C
	.DB  0x0,0x23,0x0,0x47,0x50,0x53,0x5F,0x4F
	.DB  0x6B,0x20,0x0
_0x2000060:
	.DB  0x1
_0x2000000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0
_0x2060003:
	.DB  0x80,0xC0
_0x2080000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x02
	.DW  __REG_BIT_VARS*2

	.DW  0x0A
	.DW  _speed
	.DW  _0x3*2

	.DW  0x02
	.DW  _0x20
	.DW  _0x0*2

	.DW  0x02
	.DW  _0x20+2
	.DW  _0x0*2

	.DW  0x02
	.DW  _0x20+4
	.DW  _0x0*2+2

	.DW  0x02
	.DW  _0x20+6
	.DW  _0x0*2+4

	.DW  0x02
	.DW  _0x20+8
	.DW  _0x0*2+6

	.DW  0x05
	.DW  _0x20+10
	.DW  _0x0*2+8

	.DW  0x10
	.DW  _0x5F
	.DW  _0x0*2+13

	.DW  0x10
	.DW  _0x5F+16
	.DW  _0x0*2+29

	.DW  0x0E
	.DW  _0x5F+32
	.DW  _0x0*2+45

	.DW  0x0E
	.DW  _0x5F+46
	.DW  _0x0*2+59

	.DW  0x0C
	.DW  _0x5F+60
	.DW  _0x0*2+73

	.DW  0x0C
	.DW  _0x5F+72
	.DW  _0x0*2+85

	.DW  0x02
	.DW  _0x5F+84
	.DW  _0x0*2+97

	.DW  0x03
	.DW  _0x5F+86
	.DW  _0x0*2+99

	.DW  0x03
	.DW  _0x5F+89
	.DW  _0x0*2+102

	.DW  0x03
	.DW  _0x5F+92
	.DW  _0x0*2+105

	.DW  0x08
	.DW  _0x5F+95
	.DW  _0x0*2+108

	.DW  0x10
	.DW  _0x5F+103
	.DW  _0x0*2+116

	.DW  0x08
	.DW  _0x5F+119
	.DW  _0x0*2+132

	.DW  0x11
	.DW  _0x5F+127
	.DW  _0x0*2+140

	.DW  0x0C
	.DW  _0x5F+144
	.DW  _0x0*2+157

	.DW  0x11
	.DW  _0x5F+156
	.DW  _0x0*2+140

	.DW  0x02
	.DW  _0x5F+173
	.DW  _0x0*2+97

	.DW  0x03
	.DW  _0x5F+175
	.DW  _0x0*2+99

	.DW  0x02
	.DW  _0x5F+178
	.DW  _0x0*2+169

	.DW  0x11
	.DW  _0x5F+180
	.DW  _0x0*2+140

	.DW  0x08
	.DW  _0x5F+197
	.DW  _0x0*2+171

	.DW  0x02
	.DW  _0x5F+205
	.DW  _0x0*2+97

	.DW  0x02
	.DW  _0x5F+207
	.DW  _0x0*2+6

	.DW  0x02
	.DW  _0x5F+209
	.DW  _0x0*2+27

	.DW  0x01
	.DW  __seed_G100
	.DW  _0x2000060*2

	.DW  0x02
	.DW  __base_y_G103
	.DW  _0x2060003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
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

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

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
;Date    : 27.06.2018
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATmega16
;Program type            : Application
;AVR Core Clock frequency: 8,000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 256
;*******************************************************/
;
;#include <mega16.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;
;#include <delay.h>
;
;// I2C Bus functions
;#include <i2c.h>
;
;
;#include <stdlib.h>
;
;// 1 Wire Bus interface functions
;#include <1wire.h>
;
;// DS1820 Temperature Sensor functions
;#include <ds1820.h>
;
;
;#include <ds1307.h>
;
;// Alphanumeric LCD functions
;#include <alcd.h>
;
;// Standard Input/Output functions
;#include <stdio.h>
;
;#define adc_on ADCSRA|=0x80
;
;#define adc_off ADCSRA &=(~0x80)
;
;#define min_u 115
;
;#define max_u 148
;
;
;// Declare your global variables here
;
;unsigned char work_gps;
;unsigned char i;
;
;unsigned char temp_msb;
;unsigned char temp_lsb;
;unsigned char ed_speed;
;unsigned char deset_speed;
;unsigned char soten_speed;
;
;
;
;unsigned char sum_hours;
;
;unsigned char j;
;
;unsigned char ed_min_clock;
;unsigned char decet_min_clock;
;unsigned char ed_hours_clock;
;unsigned char decet_Hours_clock;
;
;unsigned char h;
;unsigned char m;
;unsigned char s;
;
;unsigned char st;
;
;unsigned char st_v;
;
;unsigned char st_po;
;unsigned int  err;
;
;unsigned char ;
;unsigned char counter;
;unsigned char work;
;unsigned char test;
;unsigned char es_gps;
;
;unsigned char cnt_rem;
;unsigned char cnt_c;
;unsigned char error;
;
;unsigned char kvadrat;
;//unsigned char kvad;
;//unsigned char kv;
;//unsigned char wrx;
;
;unsigned char decet_sek_clock;
;unsigned char alarm_u;
;   unsigned char c;
;   unsigned char t;
;     unsigned char s;
; unsigned int  metr;
;    unsigned char ts;
;     unsigned char tm;
;
;       unsigned char st_s;
;    unsigned char r;
;      unsigned char met;
;
;  unsigned int adc_dataw;
;  unsigned int adc_data;
;  unsigned int adc_datawi;
;   unsigned char cout_in;
;
;
;
; // unsigned int  crrc;
; //   unsigned int  crrw;
;
;
;
;
;float  copy;
;float  wcnt_rem;
;float wcnt_c;
;
;
;bit flag;
;
;unsigned char lcd_buf[16];
;
;unsigned char speed_array[10];
;
;unsigned char speed[]={0x00,0x01,0x02,0x03,0x40,0x41,0x42,0x43,0x80,0x81};

	.DSEG
;
;
;
;
; /*
;
;
;
;
;
; int calc_NMEA_Checksum( char *buf, int cnt )
; { char Character;
;int Checksum = 0;
; int i; // loop counter //foreach(char Character in sentence)
;for (i=0;i<cnt;++i) {
;Character = buf[i];
;switch(Character)
;{case'$':
;// Ignore the dollar sign
;break;
;case '*': // Stop processing before the asterisk
; i = cnt;
;continue;
;default: // Is this the first value for the checksum?
;if (Checksum == 0) {
;// Yes. Set the checksum to the value
; Checksum = Character; } else
;{
;// No. XOR the checksum with this character value
; Checksum = Checksum ^ Character; }
;break; }
; } // Return the checksum
;return (Checksum);
;} //
;
;
;
;  */
;
;
;
;  #define DATA_REGISTER_EMPTY (1<<UDRE)
;#define RX_COMPLETE (1<<RXC)
;#define FRAMING_ERROR (1<<FE)
;#define PARITY_ERROR (1<<UPE)
;#define DATA_OVERRUN (1<<DOR)
;
;// USART Receiver buffer
;#define RX_BUFFER_SIZE 100
;char rx_buffer[RX_BUFFER_SIZE];
;
;#if RX_BUFFER_SIZE < 256
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
; 0000 00D4 {

	.CSEG
_usart_rx_isr:
; .FSTART _usart_rx_isr
	ST   -Y,R26
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 00D5 char status,data;
; 0000 00D6 status=UCSRA;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R17
;	data -> R16
	IN   R17,11
; 0000 00D7 data=UDR;
	IN   R16,12
; 0000 00D8 if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x4
; 0000 00D9    {
; 0000 00DA    rx_buffer[rx_wr_index++]=data;
	LDS  R30,_rx_wr_index
	SUBI R30,-LOW(1)
	STS  _rx_wr_index,R30
	SUBI R30,LOW(1)
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer)
	SBCI R31,HIGH(-_rx_buffer)
	ST   Z,R16
; 0000 00DB #if RX_BUFFER_SIZE == 255
; 0000 00DC    // special case for receiver buffer size=256
; 0000 00DD    if (++rx_counter == 0) rx_buffer_overflow=1;
; 0000 00DE #else
; 0000 00DF    if (rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
	LDS  R26,_rx_wr_index
	CPI  R26,LOW(0x64)
	BRNE _0x5
	LDI  R30,LOW(0)
	STS  _rx_wr_index,R30
; 0000 00E0    if (++rx_counter == RX_BUFFER_SIZE)
_0x5:
	LDS  R26,_rx_counter
	SUBI R26,-LOW(1)
	STS  _rx_counter,R26
	CPI  R26,LOW(0x64)
	BRNE _0x6
; 0000 00E1       {
; 0000 00E2       rx_counter=0;
	LDI  R30,LOW(0)
	STS  _rx_counter,R30
; 0000 00E3       rx_buffer_overflow=1;
	SET
	BLD  R2,1
; 0000 00E4       }
; 0000 00E5 #endif
; 0000 00E6    }
_0x6:
; 0000 00E7 
; 0000 00E8 
; 0000 00E9 
; 0000 00EA    if( met>0)
_0x4:
	LDS  R26,_met
	CPI  R26,LOW(0x1)
	BRLO _0x7
; 0000 00EB         {
; 0000 00EC         ++met;
	LDS  R30,_met
	SUBI R30,-LOW(1)
	STS  _met,R30
; 0000 00ED       if( met==3)
	LDS  R26,_met
	CPI  R26,LOW(0x3)
	BRNE _0x8
; 0000 00EE       {
; 0000 00EF        work_gps=1;
	LDI  R30,LOW(1)
	MOV  R5,R30
; 0000 00F0                   return;
	LD   R16,Y+
	LD   R17,Y+
	RJMP _0x12A
; 0000 00F1                   }
; 0000 00F2                   }
_0x8:
; 0000 00F3    if (data=='*')
_0x7:
	CPI  R16,42
	BRNE _0x9
; 0000 00F4 
; 0000 00F5        met=1;
	LDI  R30,LOW(1)
	STS  _met,R30
; 0000 00F6 
; 0000 00F7 
; 0000 00F8     }
_0x9:
	LD   R16,Y+
	LD   R17,Y+
	RJMP _0x12A
; .FEND
;
;
;#ifndef _DEBUG_TERMINAL_IO_
;// Get a character from the USART Receiver buffer
;#define _ALTERNATE_GETCHAR_
;#pragma used+
;char getchar(void)
; 0000 0100 {
; 0000 0101 char data;
; 0000 0102 while (rx_counter==0);
;	data -> R17
; 0000 0103 data=rx_buffer[rx_rd_index++];
; 0000 0104 #if RX_BUFFER_SIZE != 256
; 0000 0105 if (rx_rd_index == RX_BUFFER_SIZE) rx_rd_index=0;
; 0000 0106 #endif
; 0000 0107 #asm("cli")
; 0000 0108 --rx_counter;
; 0000 0109 #asm("sei")
; 0000 010A return data;
; 0000 010B }
;#pragma used-
;#endif
;
;
;   #include <string.h>
;
;
;  void reset (void)
; 0000 0114      {
_reset:
; .FSTART _reset
; 0000 0115 
; 0000 0116 
; 0000 0117      // #asm("sei")
; 0000 0118     // TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B)
; 0000 0119  //    | (1<<TOIE1) | (0<<OCIE0) | (1<<TOIE0);
; 0000 011A       work_gps=0;
	CLR  R5
; 0000 011B              rx_wr_index=0;
	LDI  R30,LOW(0)
	STS  _rx_wr_index,R30
; 0000 011C        //   kvad=0;
; 0000 011D          //  wrx=0;
; 0000 011E          memset(rx_buffer,0,RX_BUFFER_SIZE);
	LDI  R30,LOW(_rx_buffer)
	LDI  R31,HIGH(_rx_buffer)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(100)
	LDI  R27,0
	CALL _memset
; 0000 011F 
; 0000 0120                           }
	RET
; .FEND
;
;      void lcd_d (void)
; 0000 0123   {
_lcd_d:
; .FSTART _lcd_d
; 0000 0124     if (rx_buffer [i+1]=='0')
	CALL SUBOPT_0x0
	CPI  R26,LOW(0x30)
	BREQ _0x121
; 0000 0125                lcd_putchar(rx_buffer [i+2]);
; 0000 0126                      else
; 0000 0127                {
; 0000 0128              lcd_putchar(rx_buffer [i+1]);
	CALL SUBOPT_0x0
	CALL _lcd_putchar
; 0000 0129                lcd_putchar(rx_buffer [i+2]);
_0x121:
	MOV  R30,R4
	LDI  R31,0
	__ADDW1MN _rx_buffer,2
	LD   R26,Z
	CALL _lcd_putchar
; 0000 012A                        }
; 0000 012B          // lcd_puts(lcd_buf);
; 0000 012C             lcd_putchar(0X20);
	LDI  R26,LOW(32)
	CALL _lcd_putchar
; 0000 012D           }
	RET
; .FEND
;
;
;
;
;
;
;
;  void tim(void)
; 0000 0136   {
_tim:
; .FSTART _tim
; 0000 0137 
; 0000 0138       ++st_s;
	LDS  R30,_st_s
	SUBI R30,-LOW(1)
	STS  _st_s,R30
; 0000 0139       if(st_s==2 || st_s==11)
	LDS  R26,_st_s
	CPI  R26,LOW(0x2)
	BREQ _0x11
	CPI  R26,LOW(0xB)
	BRNE _0x10
_0x11:
; 0000 013A       {
; 0000 013B 
; 0000 013C         //   UCSRB &=~(1<<RXCIE);
; 0000 013D 
; 0000 013E 
; 0000 013F       rtc_get_time(&h,&m,&s);
	LDI  R30,LOW(_h)
	LDI  R31,HIGH(_h)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_m)
	LDI  R31,HIGH(_m)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(_s)
	LDI  R27,HIGH(_s)
	CALL _rtc_get_time
; 0000 0140          if (s==0 || st_s==11)
	LDS  R26,_s
	CPI  R26,LOW(0x0)
	BREQ _0x14
	LDS  R26,_st_s
	CPI  R26,LOW(0xB)
	BRNE _0x13
_0x14:
; 0000 0141 
; 0000 0142           {
; 0000 0143 
; 0000 0144     decet_Hours_clock=h/10;
	LDS  R26,_h
	LDI  R27,0
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	STS  _decet_Hours_clock,R30
; 0000 0145     ed_hours_clock=h%10;
	LDS  R26,_h
	CLR  R27
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MODW21
	STS  _ed_hours_clock,R30
; 0000 0146     decet_min_clock=m/10;
	LDS  R26,_m
	LDI  R27,0
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	STS  _decet_min_clock,R30
; 0000 0147     ed_min_clock=m%10;
	LDS  R26,_m
	CLR  R27
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MODW21
	MOV  R12,R30
; 0000 0148                   }
; 0000 0149 
; 0000 014A 
; 0000 014B 
; 0000 014C           st_s=0;
_0x13:
	LDI  R30,LOW(0)
	STS  _st_s,R30
; 0000 014D           //  UCSRB|=(1<<RXCIE);
; 0000 014E             //  reset();
; 0000 014F 
; 0000 0150             }
; 0000 0151 
; 0000 0152     if(es_gps==0 && test==0)
_0x10:
	LDS  R26,_es_gps
	CPI  R26,LOW(0x0)
	BRNE _0x17
	LDS  R26,_test
	CPI  R26,LOW(0x0)
	BREQ _0x18
_0x17:
	RJMP _0x16
_0x18:
; 0000 0153 
; 0000 0154     {
; 0000 0155 
; 0000 0156      switch(kvadrat)
	LDS  R30,_kvadrat
	LDI  R31,0
; 0000 0157      {
; 0000 0158        case 0:
	SBIW R30,0
	BRNE _0x1C
; 0000 0159                flag=1;
	SET
	BLD  R2,0
; 0000 015A    while(flag==1){}
_0x1D:
	SBRC R2,0
	RJMP _0x1D
; 0000 015B         lcd_gotoxy(0,0);
	CALL SUBOPT_0x1
; 0000 015C lcd_puts(" ");
	__POINTW2MN _0x20,0
	CALL SUBOPT_0x2
; 0000 015D    lcd_gotoxy(6,0);
; 0000 015E lcd_puts(" ");
	__POINTW2MN _0x20,2
	CALL _lcd_puts
; 0000 015F 
; 0000 0160 
; 0000 0161            kvadrat++;
	LDS  R30,_kvadrat
	SUBI R30,-LOW(1)
	STS  _kvadrat,R30
; 0000 0162               break;
	RJMP _0x1B
; 0000 0163          case 1:
_0x1C:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0x1B
; 0000 0164 
; 0000 0165 
; 0000 0166 
; 0000 0167 
; 0000 0168                flag=1;
	SET
	BLD  R2,0
; 0000 0169    while(flag==1){}
_0x22:
	SBRC R2,0
	RJMP _0x22
; 0000 016A         lcd_gotoxy(0,0);
	CALL SUBOPT_0x1
; 0000 016B lcd_puts(">");
	__POINTW2MN _0x20,4
	CALL SUBOPT_0x2
; 0000 016C    lcd_gotoxy(6,0);
; 0000 016D lcd_puts("<");
	__POINTW2MN _0x20,6
	CALL _lcd_puts
; 0000 016E        kvadrat=0;
	LDI  R30,LOW(0)
	STS  _kvadrat,R30
; 0000 016F 
; 0000 0170 
; 0000 0171     if(++ts==60)
	LDS  R26,_ts
	SUBI R26,-LOW(1)
	STS  _ts,R26
	CPI  R26,LOW(0x3C)
	BRNE _0x25
; 0000 0172     {
; 0000 0173     ts=0;
	STS  _ts,R30
; 0000 0174      ++tm;
	LDS  R30,_tm
	SUBI R30,-LOW(1)
	STS  _tm,R30
; 0000 0175     flag=1;
	SET
	BLD  R2,0
; 0000 0176    while(flag==1){}
_0x26:
	SBRC R2,0
	RJMP _0x26
; 0000 0177        lcd_gotoxy(2,0);
	LDI  R30,LOW(2)
	CALL SUBOPT_0x3
; 0000 0178       if(tm<10)
	LDS  R26,_tm
	CPI  R26,LOW(0xA)
	BRSH _0x29
; 0000 0179            lcd_gotoxy(2,0);
	LDI  R30,LOW(2)
	RJMP _0x122
; 0000 017A            else
_0x29:
; 0000 017B             lcd_gotoxy(1,0);
	LDI  R30,LOW(1)
_0x122:
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _lcd_gotoxy
; 0000 017C 
; 0000 017D             itoa(tm,lcd_buf);
	CALL SUBOPT_0x4
; 0000 017E                  lcd_puts(lcd_buf);
	CALL SUBOPT_0x5
; 0000 017F    flag=1;
	SET
	BLD  R2,0
; 0000 0180    while(flag==1){}             }
_0x2B:
	SBRC R2,0
	RJMP _0x2B
; 0000 0181       lcd_gotoxy(4,0);
_0x25:
	LDI  R30,LOW(4)
	CALL SUBOPT_0x3
; 0000 0182       if(ts<10)
	LDS  R26,_ts
	CPI  R26,LOW(0xA)
	BRSH _0x2E
; 0000 0183          lcd_puts("0");
	__POINTW2MN _0x20,8
	CALL _lcd_puts
; 0000 0184 
; 0000 0185             itoa(ts,lcd_buf);
_0x2E:
	CALL SUBOPT_0x6
; 0000 0186                  lcd_puts(lcd_buf);
; 0000 0187 
; 0000 0188 
; 0000 0189 
; 0000 018A              break;
; 0000 018B 
; 0000 018C 
; 0000 018D 
; 0000 018E 
; 0000 018F                }
_0x1B:
; 0000 0190                }
; 0000 0191 
; 0000 0192    if(alarm_u>0)
_0x16:
	LDS  R26,_alarm_u
	CPI  R26,LOW(0x1)
	BRLO _0x2F
; 0000 0193      {
; 0000 0194 
; 0000 0195 
; 0000 0196      switch(c)
	LDS  R30,_c
	LDI  R31,0
; 0000 0197     {
; 0000 0198     case 0:
	SBIW R30,0
	BRNE _0x33
; 0000 0199               flag=1;
	SET
	BLD  R2,0
; 0000 019A    while(flag==1){}
_0x34:
	SBRC R2,0
	RJMP _0x34
; 0000 019B   lcd_gotoxy(12,1);
	CALL SUBOPT_0x7
; 0000 019C lcd_puts("    ");
	__POINTW2MN _0x20,10
	CALL _lcd_puts
; 0000 019D 
; 0000 019E  c++;
	LDS  R30,_c
	SUBI R30,-LOW(1)
	RJMP _0x123
; 0000 019F break;
; 0000 01A0 
; 0000 01A1  case 1:
_0x33:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x32
; 0000 01A2 
; 0000 01A3 
; 0000 01A4 
; 0000 01A5    ftoa((float)adc_datawi/10,1,lcd_buf);
	LDS  R30,_adc_datawi
	LDS  R31,_adc_datawi+1
	CALL SUBOPT_0x8
; 0000 01A6                       flag=1;
; 0000 01A7    while(flag==1){}
_0x38:
	SBRC R2,0
	RJMP _0x38
; 0000 01A8          lcd_gotoxy(12,1);
	CALL SUBOPT_0x7
; 0000 01A9       lcd_puts(lcd_buf); c=0;;
	CALL SUBOPT_0x5
	LDI  R30,LOW(0)
_0x123:
	STS  _c,R30
; 0000 01AA 
; 0000 01AB    break;
; 0000 01AC       }
_0x32:
; 0000 01AD 
; 0000 01AE       }
; 0000 01AF 
; 0000 01B0    }
_0x2F:
	RET
; .FEND

	.DSEG
_0x20:
	.BYTE 0xF
;
;
;
;// External Interrupt 0 service routine
;interrupt [EXT_INT0] void ext_int0_isr(void)
; 0000 01B6 {

	.CSEG
_ext_int0_isr:
; .FSTART _ext_int0_isr
	ST   -Y,R30
; 0000 01B7 // Place your code here
; 0000 01B8    work=1;
	LDI  R30,LOW(1)
	STS  _work,R30
; 0000 01B9 
; 0000 01BA 
; 0000 01BB       }
	LD   R30,Y+
	RETI
; .FEND
;
;// Standard Input/Output functions
;#include <stdio.h>
;
;// Timer 0 overflow interrupt service routine
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
; 0000 01C2 {
_timer0_ovf_isr:
; .FSTART _timer0_ovf_isr
	ST   -Y,R26
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 01C3 // Reinitialize Timer 0 value
; 0000 01C4 //TCNT0=0x64;
; 0000 01C5 // Place your code here
; 0000 01C6 
; 0000 01C7         PORTA=0;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 01C8      counter++;
	LDS  R30,_counter
	SUBI R30,-LOW(1)
	STS  _counter,R30
; 0000 01C9 
; 0000 01CA 
; 0000 01CB 
; 0000 01CC 
; 0000 01CD switch (counter)
	CALL SUBOPT_0x9
; 0000 01CE {
; 0000 01CF 
; 0000 01D0  case 1:  if (soten_speed==0 && test==0)return;
	BRNE _0x3E
	TST  R11
	BRNE _0x40
	LDS  R26,_test
	CPI  R26,LOW(0x0)
	BREQ _0x41
_0x40:
	RJMP _0x3F
_0x41:
	RJMP _0x12A
; 0000 01D1 
; 0000 01D2  PORTA.1=1; PORTC=speed[soten_speed];
_0x3F:
	SBI  0x1B,1
	MOV  R30,R11
	RJMP _0x124
; 0000 01D3      break;
; 0000 01D4  case 2:  if (deset_speed==0 && soten_speed==0 && test==0)return;
_0x3E:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x44
	TST  R8
	BRNE _0x46
	TST  R11
	BRNE _0x46
	LDS  R26,_test
	CPI  R26,LOW(0x0)
	BREQ _0x47
_0x46:
	RJMP _0x45
_0x47:
	RJMP _0x12A
; 0000 01D5 
; 0000 01D6  PORTA.2=1; PORTC=speed[deset_speed];
_0x45:
	SBI  0x1B,2
	MOV  R30,R8
	RJMP _0x124
; 0000 01D7      break;
; 0000 01D8  case 3:  if(test==0 && es_gps==0) return;
_0x44:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x4A
	LDS  R26,_test
	CPI  R26,LOW(0x0)
	BRNE _0x4C
	LDS  R26,_es_gps
	CPI  R26,LOW(0x0)
	BREQ _0x4D
_0x4C:
	RJMP _0x4B
_0x4D:
	RJMP _0x12A
; 0000 01D9 
; 0000 01DA  PORTA.3=1; PORTC=speed[ed_speed];
_0x4B:
	SBI  0x1B,3
	MOV  R30,R9
	RJMP _0x124
; 0000 01DB      break;
; 0000 01DC  case 4: if(test==0 && decet_Hours_clock ==0)return;
_0x4A:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x50
	LDS  R26,_test
	CPI  R26,LOW(0x0)
	BRNE _0x52
	LDS  R26,_decet_Hours_clock
	CPI  R26,LOW(0x0)
	BREQ _0x53
_0x52:
	RJMP _0x51
_0x53:
	RJMP _0x12A
; 0000 01DD      PORTA.4=1; PORTC=speed[decet_Hours_clock];
_0x51:
	SBI  0x1B,4
	LDS  R30,_decet_Hours_clock
	RJMP _0x124
; 0000 01DE      break;
; 0000 01DF  case 5:
_0x50:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x56
; 0000 01E0  PORTA.5=1; PORTC=speed[ed_hours_clock];
	SBI  0x1B,5
	LDS  R30,_ed_hours_clock
	RJMP _0x124
; 0000 01E1      break;
; 0000 01E2  case 6:
_0x56:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0x59
; 0000 01E3  PORTA.6=1; PORTC=speed[decet_min_clock];
	SBI  0x1B,6
	LDS  R30,_decet_min_clock
	RJMP _0x124
; 0000 01E4      break;
; 0000 01E5  case 7: counter=0;
_0x59:
	CPI  R30,LOW(0x7)
	LDI  R26,HIGH(0x7)
	CPC  R31,R26
	BRNE _0x3D
	LDI  R30,LOW(0)
	STS  _counter,R30
; 0000 01E6 
; 0000 01E7  PORTA.7=1; PORTC=speed[ed_min_clock];
	SBI  0x1B,7
	MOV  R30,R12
_0x124:
	LDI  R31,0
	SUBI R30,LOW(-_speed)
	SBCI R31,HIGH(-_speed)
	LD   R30,Z
	OUT  0x15,R30
; 0000 01E8 
; 0000 01E9      break;
; 0000 01EA         }
_0x3D:
; 0000 01EB 
; 0000 01EC 
; 0000 01ED   flag=0;
	CLT
	BLD  R2,0
; 0000 01EE 
; 0000 01EF }
_0x12A:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R26,Y+
	RETI
; .FEND
;
;
;
;
;
;
;
;
;
;// Voltage Reference: Int., cap. on AREF
;#define ADC_VREF_TYPE ((1<<REFS1) | (1<<REFS0) | (0<<ADLAR))
;
;// ADC interrupt service routine
;interrupt [ADC_INT] void adc_isr(void)
; 0000 01FE {
_adc_isr:
; .FSTART _adc_isr
	ST   -Y,R30
	ST   -Y,R31
; 0000 01FF 
; 0000 0200 // Read the AD conversion result
; 0000 0201 adc_data=ADCW;
	IN   R30,0x4
	IN   R31,0x4+1
	STS  _adc_data,R30
	STS  _adc_data+1,R31
; 0000 0202 // Place your code here
; 0000 0203     work=3;
	LDI  R30,LOW(3)
	STS  _work,R30
; 0000 0204 
; 0000 0205 
; 0000 0206 }
	LD   R31,Y+
	LD   R30,Y+
	RETI
; .FEND
;
;void main(void)
; 0000 0209 {
_main:
; .FSTART _main
; 0000 020A // Declare your local variables here
; 0000 020B 
; 0000 020C // Input/Output Ports initialization
; 0000 020D // Port A initialization
; 0000 020E // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=In
; 0000 020F DDRA=(1<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) | (1<<DDA3) | (1<<DDA2) | (1<<DDA1) | (0<<DDA0);
	LDI  R30,LOW(254)
	OUT  0x1A,R30
; 0000 0210 // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=T
; 0000 0211 PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 0212 
; 0000 0213 // Port B initialization
; 0000 0214 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0215 DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	OUT  0x17,R30
; 0000 0216 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0217 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	OUT  0x18,R30
; 0000 0218 
; 0000 0219 // Port C initialization
; 0000 021A // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 021B DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
	LDI  R30,LOW(255)
	OUT  0x14,R30
; 0000 021C // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 021D PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 021E 
; 0000 021F // Port D initialization
; 0000 0220 // Function: Bit7=Out Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0221 DDRD=(1<<DDD7) | (1<<DDD6) | (1<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	LDI  R30,LOW(224)
	OUT  0x11,R30
; 0000 0222 // State: Bit7=0 Bit6=T Bit5=P Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0223 PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (1<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	LDI  R30,LOW(16)
	OUT  0x12,R30
; 0000 0224 
; 0000 0225 // Timer/Counter 0 initialization
; 0000 0226 // Clock source: System Clock
; 0000 0227 // Clock value: Timer 0 Stopped
; 0000 0228 // Mode: Normal top=0xFF
; 0000 0229 // OC0 output: Disconnected
; 0000 022A TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (1<<CS01) | (1<<CS00);
	LDI  R30,LOW(3)
	OUT  0x33,R30
; 0000 022B TCNT0=0x64;
	LDI  R30,LOW(100)
	OUT  0x32,R30
; 0000 022C OCR0=0x00;
	LDI  R30,LOW(0)
	OUT  0x3C,R30
; 0000 022D 
; 0000 022E // Timer/Counter 1 initialization
; 0000 022F // Clock source: System Clock
; 0000 0230 // Clock value: 31,250 kHz
; 0000 0231 // Mode: Normal top=0xFFFF
; 0000 0232 // OC1A output: Disconnected
; 0000 0233 // OC1B output: Disconnected
; 0000 0234 // Noise Canceler: Off
; 0000 0235 // Input Capture on Falling Edge
; 0000 0236 // Timer Period: 2 s
; 0000 0237 // Timer1 Overflow Interrupt: On
; 0000 0238 // Input Capture Interrupt: Off
; 0000 0239 // Compare A Match Interrupt: Off
; 0000 023A // Compare B Match Interrupt: Off
; 0000 023B TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	OUT  0x2F,R30
; 0000 023C TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	OUT  0x2E,R30
; 0000 023D TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 023E TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 023F ICR1H=0x00;
	OUT  0x27,R30
; 0000 0240 ICR1L=0x00;
	OUT  0x26,R30
; 0000 0241 OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 0242 OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 0243 OCR1BH=0x00;
	OUT  0x29,R30
; 0000 0244 OCR1BL=0x00;
	OUT  0x28,R30
; 0000 0245 
; 0000 0246 // Timer/Counter 2 initialization
; 0000 0247 // Clock source: System Clock
; 0000 0248 // Clock value: Timer2 Stopped
; 0000 0249 // Mode: Normal top=0xFF
; 0000 024A // OC2 output: Disconnected
; 0000 024B ASSR=0<<AS2;
	OUT  0x22,R30
; 0000 024C TCCR2=(0<<PWM2) | (0<<COM21) | (0<<COM20) | (0<<CTC2) | (1<<CS22) | (1<<CS21) | (1<<CS20);
	LDI  R30,LOW(7)
	OUT  0x25,R30
; 0000 024D TCNT2=0x00;
	LDI  R30,LOW(0)
	OUT  0x24,R30
; 0000 024E OCR2=0x00;
	OUT  0x23,R30
; 0000 024F 
; 0000 0250 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 0251 TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (1<<TOIE0);
	LDI  R30,LOW(1)
	OUT  0x39,R30
; 0000 0252 
; 0000 0253 
; 0000 0254 // External Interrupt(s) initialization
; 0000 0255 // INT0: On
; 0000 0256 // INT0 Mode: Any change
; 0000 0257 // INT1: Off
; 0000 0258 // INT2: Off
; 0000 0259 GICR|=(0<<INT1) | (0<<INT0) | (0<<INT2);
	IN   R30,0x3B
	OUT  0x3B,R30
; 0000 025A MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (1<<ISC00);
	LDI  R30,LOW(1)
	OUT  0x35,R30
; 0000 025B MCUCSR=(0<<ISC2);
	LDI  R30,LOW(0)
	OUT  0x34,R30
; 0000 025C GIFR=(0<<INTF1) | (0<<INTF0) | (0<<INTF2);
	OUT  0x3A,R30
; 0000 025D 
; 0000 025E // USART initialization
; 0000 025F // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 0260 // USART Receiver: On
; 0000 0261 // USART Transmitter: On
; 0000 0262 // USART Mode: Asynchronous
; 0000 0263 // USART Baud Rate: 9600
; 0000 0264 UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
	OUT  0xB,R30
; 0000 0265 UCSRB=(1<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (1<<RXEN) | (1<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	LDI  R30,LOW(152)
	OUT  0xA,R30
; 0000 0266 UCSRC=(1<<URSEL) | (0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0000 0267 UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0000 0268 UBRRL=0x33;
	LDI  R30,LOW(51)
	OUT  0x9,R30
; 0000 0269 
; 0000 026A // Analog Comparator initialization
; 0000 026B // Analog Comparator: Off
; 0000 026C // The Analog Comparator's positive input is
; 0000 026D // connected to the AIN0 pin
; 0000 026E // The Analog Comparator's negative input is
; 0000 026F // connected to the AIN1 pin
; 0000 0270 ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 0271 
; 0000 0272 // ADC initialization
; 0000 0273 // ADC Clock frequency: 250,000 kHz
; 0000 0274 // ADC Voltage Reference: Int., cap. on AREF
; 0000 0275 // ADC Auto Trigger Source: Free Running
; 0000 0276 //ADMUX=0;
; 0000 0277 //ADCSRA=(0<<ADEN) | (0<<ADSC) | (1<<ADATE) | (0<<ADIF) | (1<<ADIE) | (1<<ADPS2) | (0<<ADPS1) | (1<<ADPS0);
; 0000 0278 //SFIOR=(0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);
; 0000 0279 
; 0000 027A    // ADC initialization
; 0000 027B // ADC Clock frequency: 125,000 kHz
; 0000 027C // ADC Voltage Reference: AREF pin
; 0000 027D // ADC Auto Trigger Source: Timer0 Overflow
; 0000 027E ADMUX=0xC0;
	LDI  R30,LOW(192)
	OUT  0x7,R30
; 0000 027F ADCSRA=(0<<ADEN) | (0<<ADSC) | (1<<ADATE) | (0<<ADIF) | (0<<ADIE)
; 0000 0280  | (1<<ADPS2) | (0<<ADPS1) | (1<<ADPS0);
	LDI  R30,LOW(37)
	OUT  0x6,R30
; 0000 0281 //ADCSRA=0x2E;
; 0000 0282 SFIOR&=0x1F;
	IN   R30,0x30
	ANDI R30,LOW(0x1F)
	OUT  0x30,R30
; 0000 0283 SFIOR|=0x80;
	IN   R30,0x30
	ORI  R30,0x80
	OUT  0x30,R30
; 0000 0284 
; 0000 0285 // SPI initialization
; 0000 0286 // SPI disabled
; 0000 0287 SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<1) | (0<<0);
	LDI  R30,LOW(0)
	OUT  0xD,R30
; 0000 0288 
; 0000 0289 // TWI initialization
; 0000 028A // TWI disabled
; 0000 028B TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
	OUT  0x36,R30
; 0000 028C 
; 0000 028D // Bit-Banged I2C Bus initialization
; 0000 028E // I2C Port: PORTD
; 0000 028F // I2C SDA bit: 1
; 0000 0290 // I2C SCL bit: 3
; 0000 0291 // Bit Rate: 100 kHz
; 0000 0292 // Note: I2C settings are specified in the
; 0000 0293 // Project|Configure|C Compiler|Libraries|I2C menu.
; 0000 0294 i2c_init();
	CALL _i2c_init
; 0000 0295 
; 0000 0296 // 1 Wire Bus initialization
; 0000 0297 // 1 Wire Data port: PORTD
; 0000 0298 // 1 Wire Data bit: 5
; 0000 0299 // Note: 1 Wire port settings are specified in the
; 0000 029A // Project|Configure|C Compiler|Libraries|1 Wire menu.
; 0000 029B w1_init();
	CALL _w1_init
; 0000 029C 
; 0000 029D 
; 0000 029E // DS1307 Real Time Clock initialization
; 0000 029F // Square wave output on pin SQW/OUT: On
; 0000 02A0 // Square wave frequency: 1Hz
; 0000 02A1 rtc_init(0,1,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _rtc_init
; 0000 02A2 
; 0000 02A3 // Alphanumeric LCD initialization
; 0000 02A4 // Connections are specified in the
; 0000 02A5 // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
; 0000 02A6 // RS - PORTB Bit 0
; 0000 02A7 // RD - PORTB Bit 1
; 0000 02A8 // EN - PORTB Bit 2
; 0000 02A9 // D4 - PORTB Bit 3
; 0000 02AA // D5 - PORTB Bit 4
; 0000 02AB // D6 - PORTB Bit 5
; 0000 02AC // D7 - PORTB Bit 6
; 0000 02AD // Characters/line: 8
; 0000 02AE lcd_init(16);
	LDI  R26,LOW(16)
	CALL _lcd_init
; 0000 02AF 
; 0000 02B0 // Global enable interrupts
; 0000 02B1 
; 0000 02B2 
; 0000 02B3   test=1;
	LDI  R30,LOW(1)
	STS  _test,R30
; 0000 02B4 
; 0000 02B5  lcd_gotoxy(0,0);
	CALL SUBOPT_0x1
; 0000 02B6 lcd_puts("GPS info system");
	__POINTW2MN _0x5F,0
	CALL SUBOPT_0xA
; 0000 02B7 
; 0000 02B8 lcd_gotoxy(0,1);
; 0000 02B9 lcd_puts("Ver. 18.04.2019");
	__POINTW2MN _0x5F,16
	CALL SUBOPT_0xB
; 0000 02BA    delay_ms(1000);
; 0000 02BB   lcd_clear();
; 0000 02BC 
; 0000 02BD 
; 0000 02BE 
; 0000 02BF 
; 0000 02C0  lcd_gotoxy(1,0);
	LDI  R30,LOW(1)
	CALL SUBOPT_0x3
; 0000 02C1 lcd_puts("M8030 NEO-M8N");
	__POINTW2MN _0x5F,32
	CALL _lcd_puts
; 0000 02C2 
; 0000 02C3 
; 0000 02C4 lcd_gotoxy(1,1);
	LDI  R30,LOW(1)
	CALL SUBOPT_0xC
; 0000 02C5 lcd_puts("FLASH  BN-280");
	__POINTW2MN _0x5F,46
	CALL SUBOPT_0xB
; 0000 02C6 
; 0000 02C7 
; 0000 02C8  delay_ms(1000);
; 0000 02C9   lcd_clear();
; 0000 02CA 
; 0000 02CB 
; 0000 02CC 
; 0000 02CD 
; 0000 02CE 
; 0000 02CF 
; 0000 02D0 lcd_gotoxy(3,0);
	LDI  R30,LOW(3)
	CALL SUBOPT_0x3
; 0000 02D1 lcd_puts("PSA  Groupe");
	__POINTW2MN _0x5F,60
	CALL _lcd_puts
; 0000 02D2 
; 0000 02D3   lcd_gotoxy(3,1);
	LDI  R30,LOW(3)
	CALL SUBOPT_0xC
; 0000 02D4 lcd_puts("PEUGEOT 307");
	__POINTW2MN _0x5F,72
	CALL _lcd_puts
; 0000 02D5 
; 0000 02D6 
; 0000 02D7 
; 0000 02D8 
; 0000 02D9 
; 0000 02DA 
; 0000 02DB 
; 0000 02DC 
; 0000 02DD 
; 0000 02DE     if(PIND.4==0)
	SBIC 0x10,4
	RJMP _0x60
; 0000 02DF 
; 0000 02E0              rtc_set_time(9,0,0);
	LDI  R30,LOW(9)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _rtc_set_time
; 0000 02E1 
; 0000 02E2     #asm("sei")
_0x60:
	sei
; 0000 02E3 
; 0000 02E4 
; 0000 02E5          // zvuk();
; 0000 02E6       putchar('v');
	LDI  R26,LOW(118)
	CALL _putchar
; 0000 02E7 
; 0000 02E8   //    PORTA=0;
; 0000 02E9 
; 0000 02EA    //   #asm("cli")
; 0000 02EB 
; 0000 02EC 
; 0000 02ED 
; 0000 02EE 
; 0000 02EF              for(j=0;j<10;j++)
	CLR  R13
_0x62:
	LDI  R30,LOW(10)
	CP   R13,R30
	BRSH _0x63
; 0000 02F0           {
; 0000 02F1 
; 0000 02F2           deset_speed=j;
	MOV  R8,R13
; 0000 02F3           ed_speed=j;
	MOV  R9,R13
; 0000 02F4          if(j<2) soten_speed=j;
	LDI  R30,LOW(2)
	CP   R13,R30
	BRSH _0x64
	MOV  R11,R13
; 0000 02F5          if(j<3) decet_Hours_clock=j;
_0x64:
	LDI  R30,LOW(3)
	CP   R13,R30
	BRSH _0x65
	STS  _decet_Hours_clock,R13
; 0000 02F6           if(j<6)decet_min_clock=j;
_0x65:
	LDI  R30,LOW(6)
	CP   R13,R30
	BRSH _0x66
	STS  _decet_min_clock,R13
; 0000 02F7             ed_min_clock=j;
_0x66:
	MOV  R12,R13
; 0000 02F8 
; 0000 02F9           ed_hours_clock=j;
	STS  _ed_hours_clock,R13
; 0000 02FA            delay_ms(200);
	LDI  R26,LOW(200)
	LDI  R27,0
	CALL _delay_ms
; 0000 02FB 
; 0000 02FC      }
	INC  R13
	RJMP _0x62
_0x63:
; 0000 02FD 
; 0000 02FE 
; 0000 02FF 
; 0000 0300           delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	CALL _delay_ms
; 0000 0301 
; 0000 0302 
; 0000 0303              test=0;
	LDI  R30,LOW(0)
	STS  _test,R30
; 0000 0304 
; 0000 0305         soten_speed = 0;
	CLR  R11
; 0000 0306             deset_speed= 0;
	CLR  R8
; 0000 0307               ed_speed= 0;
	CLR  R9
; 0000 0308 
; 0000 0309 
; 0000 030A 
; 0000 030B       lcd_clear();
	CALL _lcd_clear
; 0000 030C 
; 0000 030D 
; 0000 030E 
; 0000 030F      lcd_gotoxy(3,0);
	LDI  R30,LOW(3)
	CALL SUBOPT_0x3
; 0000 0310 
; 0000 0311         lcd_puts(":");
	__POINTW2MN _0x5F,84
	CALL _lcd_puts
; 0000 0312 
; 0000 0313         lcd_gotoxy(10,0);
	LDI  R30,LOW(10)
	CALL SUBOPT_0x3
; 0000 0314 
; 0000 0315         lcd_puts("S=");
	__POINTW2MN _0x5F,86
	CALL SUBOPT_0xA
; 0000 0316 
; 0000 0317 
; 0000 0318        lcd_gotoxy(0,1);
; 0000 0319 
; 0000 031A       lcd_puts("t=");
	__POINTW2MN _0x5F,89
	CALL _lcd_puts
; 0000 031B 
; 0000 031C         lcd_gotoxy(10,1);
	LDI  R30,LOW(10)
	CALL SUBOPT_0xC
; 0000 031D       lcd_puts("V=");
	__POINTW2MN _0x5F,92
	CALL _lcd_puts
; 0000 031E 
; 0000 031F 
; 0000 0320             ADCSRA|= (1<<ADIE);
	SBI  0x6,3
; 0000 0321 
; 0000 0322 
; 0000 0323    GICR|=(0<<INT1) | (1<<INT0) | (0<<INT2);
	IN   R30,0x3B
	ORI  R30,0x40
	OUT  0x3B,R30
; 0000 0324    GIFR=(0<<INTF1) | (1<<INTF0) | (0<<INTF2);
	LDI  R30,LOW(64)
	OUT  0x3A,R30
; 0000 0325 
; 0000 0326             st_s=10;
	LDI  R30,LOW(10)
	STS  _st_s,R30
; 0000 0327 
; 0000 0328      /*
; 0000 0329 
; 0000 032A 
; 0000 032B    ftoa(copy/10,1,lcd_buf);
; 0000 032C 
; 0000 032D 
; 0000 032E          soten_speed = 0;
; 0000 032F             deset_speed= 0;
; 0000 0330               ed_speed= 0;
; 0000 0331 
; 0000 0332  if(copy >0)
; 0000 0333  {
; 0000 0334    // strcpy( lcd_buf1, lcd_buf);
; 0000 0335 
; 0000 0336  for(i=9;i<255;i--)
; 0000 0337 
; 0000 0338     lcd_buf[i+1]= lcd_buf[i];
; 0000 0339 
; 0000 033A 
; 0000 033B   lcd_buf[0]='+';
; 0000 033C 
; 0000 033D       }
; 0000 033E 
; 0000 033F   lcd_puts(lcd_buf);
; 0000 0340 
; 0000 0341      */
; 0000 0342 
; 0000 0343     //   #asm("sei")
; 0000 0344 
; 0000 0345 while (1)
_0x67:
; 0000 0346       {
; 0000 0347       // Place your code here
; 0000 0348        // Place your code here
; 0000 0349 m1:
_0x6A:
; 0000 034A 
; 0000 034B 
; 0000 034C 
; 0000 034D    while(work==0 && work_gps==0){};
_0x6B:
	LDS  R26,_work
	CPI  R26,LOW(0x0)
	BRNE _0x6E
	TST  R5
	BREQ _0x6F
_0x6E:
	RJMP _0x6D
_0x6F:
	RJMP _0x6B
_0x6D:
; 0000 034E 
; 0000 034F 
; 0000 0350 
; 0000 0351 
; 0000 0352    switch(work)
	LDS  R30,_work
	CALL SUBOPT_0x9
; 0000 0353 
; 0000 0354 
; 0000 0355    {
; 0000 0356    case 1:
	BRNE _0x73
; 0000 0357    tim();
	RCALL _tim
; 0000 0358       ++st;
	LDS  R30,_st
	SUBI R30,-LOW(1)
	STS  _st,R30
; 0000 0359    if(st==2)
	LDS  R26,_st
	CPI  R26,LOW(0x2)
	BRNE _0x74
; 0000 035A    {
; 0000 035B    flag=1;
	SET
	BLD  R2,0
; 0000 035C    while(flag==1){}
_0x75:
	SBRC R2,0
	RJMP _0x75
; 0000 035D     w1_init();
	CALL _w1_init
; 0000 035E  w1_write(0xCC);
	LDI  R26,LOW(204)
	CALL _w1_write
; 0000 035F    w1_write(0x44);
	LDI  R26,LOW(68)
	CALL _w1_write
; 0000 0360 
; 0000 0361     adc_on;
	SBI  0x6,7
; 0000 0362     work=3;
	LDI  R30,LOW(3)
	STS  _work,R30
; 0000 0363 
; 0000 0364 
; 0000 0365             continue;
	RJMP _0x67
; 0000 0366 
; 0000 0367       }
; 0000 0368      if(st==4)
_0x74:
	LDS  R26,_st
	CPI  R26,LOW(0x4)
	BRNE _0x78
; 0000 0369      {
; 0000 036A        st=0;
	LDI  R30,LOW(0)
	STS  _st,R30
; 0000 036B         work=2;
	LDI  R30,LOW(2)
	STS  _work,R30
; 0000 036C        continue;
	RJMP _0x67
; 0000 036D        }
; 0000 036E     work=0;
_0x78:
	RJMP _0x125
; 0000 036F     break;
; 0000 0370 
; 0000 0371 
; 0000 0372     case 2:
_0x73:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0x79
; 0000 0373 
; 0000 0374      flag=1;
	SET
	BLD  R2,0
; 0000 0375    while(flag==1){}
_0x7A:
	SBRC R2,0
	RJMP _0x7A
; 0000 0376   error = w1_init();
	CALL _w1_init
	STS  _error,R30
; 0000 0377 
; 0000 0378   if(error==1)
	LDS  R26,_error
	CPI  R26,LOW(0x1)
	BREQ PC+2
	RJMP _0x7D
; 0000 0379   {
; 0000 037A  w1_write(0xCC);
	LDI  R26,LOW(204)
	CALL _w1_write
; 0000 037B  w1_write(0xbe);
	LDI  R26,LOW(190)
	CALL _w1_write
; 0000 037C          temp_lsb=w1_read();
	CALL _w1_read
	MOV  R6,R30
; 0000 037D          temp_msb=w1_read();
	CALL _w1_read
	MOV  R7,R30
; 0000 037E          w1_read();
	CALL _w1_read
; 0000 037F          w1_read();
	CALL _w1_read
; 0000 0380          w1_read();
	CALL _w1_read
; 0000 0381          w1_read();
	CALL _w1_read
; 0000 0382          flag=1;
	SET
	BLD  R2,0
; 0000 0383    while(flag==1){}
_0x7E:
	SBRC R2,0
	RJMP _0x7E
; 0000 0384 
; 0000 0385          cnt_rem=w1_read();;
	CALL _w1_read
	STS  _cnt_rem,R30
; 0000 0386          cnt_c=w1_read();
	CALL _w1_read
	STS  _cnt_c,R30
; 0000 0387           w1_read();
	CALL _w1_read
; 0000 0388 
; 0000 0389           if (temp_msb>0)
	LDI  R30,LOW(0)
	CP   R30,R7
	BRSH _0x81
; 0000 038A 
; 0000 038B           temp_lsb = ~ temp_lsb;
	COM  R6
; 0000 038C 
; 0000 038D           temp_lsb = temp_lsb >>1;
_0x81:
	LSR  R6
; 0000 038E            copy =  temp_lsb;
	MOV  R30,R6
	LDI  R26,LOW(_copy)
	LDI  R27,HIGH(_copy)
	CALL SUBOPT_0xD
; 0000 038F            wcnt_rem =  cnt_rem;
	LDS  R30,_cnt_rem
	LDI  R26,LOW(_wcnt_rem)
	LDI  R27,HIGH(_wcnt_rem)
	CALL SUBOPT_0xD
; 0000 0390            wcnt_c = cnt_c;
	LDS  R30,_cnt_c
	LDI  R26,LOW(_wcnt_c)
	LDI  R27,HIGH(_wcnt_c)
	CALL SUBOPT_0xD
; 0000 0391        if(temp_msb==0)
	TST  R7
	BRNE _0x82
; 0000 0392        {    copy = copy - 0.25;
	CALL SUBOPT_0xE
	__GETD2N 0x3E800000
	CALL SUBOPT_0xF
; 0000 0393             copy+=(wcnt_c -wcnt_rem)/wcnt_c;
	CALL SUBOPT_0x10
	CALL __ADDF12
	RJMP _0x126
; 0000 0394              }
; 0000 0395             else
_0x82:
; 0000 0396              {
; 0000 0397               copy = copy + 1.25;
	CALL SUBOPT_0xE
	__GETD2N 0x3FA00000
	CALL __ADDF12
	CALL SUBOPT_0x11
; 0000 0398               copy-=(wcnt_c -wcnt_rem)/wcnt_c;
	CALL SUBOPT_0x10
	CALL __SWAPD12
	CALL SUBOPT_0xF
; 0000 0399               copy*=-1;
	CALL SUBOPT_0x12
	__GETD1N 0xBF800000
	CALL __MULF12
_0x126:
	STS  _copy,R30
	STS  _copy+1,R31
	STS  _copy+2,R22
	STS  _copy+3,R23
; 0000 039A 
; 0000 039B            }
; 0000 039C 
; 0000 039D        copy*=10;
	CALL SUBOPT_0x13
	CALL __MULF12
	CALL SUBOPT_0x11
; 0000 039E 
; 0000 039F 
; 0000 03A0   //     intf(lcd_buf,"t=%.1f", copy/10);
; 0000 03A1 
; 0000 03A2    ftoa(copy/10,1,lcd_buf);
	CALL SUBOPT_0x13
	CALL __DIVF21
	CALL __PUTPARD1
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R26,LOW(_lcd_buf)
	LDI  R27,HIGH(_lcd_buf)
	CALL _ftoa
; 0000 03A3 
; 0000 03A4 
; 0000 03A5    //#asm("cli")
; 0000 03A6 
; 0000 03A7 
; 0000 03A8 
; 0000 03A9     //  lcd_puts("t=");
; 0000 03AA 
; 0000 03AB 
; 0000 03AC  if(copy >0)
	CALL SUBOPT_0x12
	CALL __CPD02
	BRGE _0x84
; 0000 03AD  {
; 0000 03AE    // strcpy( lcd_buf1, lcd_buf);
; 0000 03AF 
; 0000 03B0  for(t=9;t<255;t--)
	LDI  R30,LOW(9)
	STS  _t,R30
_0x86:
	LDS  R26,_t
	CPI  R26,LOW(0xFF)
	BRSH _0x87
; 0000 03B1 
; 0000 03B2     lcd_buf[t+1]= lcd_buf[t];
	LDS  R30,_t
	LDI  R31,0
	MOVW R0,R30
	__ADDW1MN _lcd_buf,1
	MOVW R26,R30
	MOVW R30,R0
	SUBI R30,LOW(-_lcd_buf)
	SBCI R31,HIGH(-_lcd_buf)
	LD   R30,Z
	ST   X,R30
	LDS  R30,_t
	SUBI R30,LOW(1)
	STS  _t,R30
	RJMP _0x86
_0x87:
; 0000 03B5 lcd_buf[0]='+';
	LDI  R30,LOW(43)
	STS  _lcd_buf,R30
; 0000 03B6 
; 0000 03B7       }
; 0000 03B8 
; 0000 03B9        flag=1;
_0x84:
	SET
	BLD  R2,0
; 0000 03BA    while(flag==1){}
_0x88:
	SBRC R2,0
	RJMP _0x88
; 0000 03BB 
; 0000 03BC      lcd_gotoxy(2,1);
	LDI  R30,LOW(2)
	CALL SUBOPT_0xC
; 0000 03BD 
; 0000 03BE   lcd_puts(lcd_buf);
	CALL SUBOPT_0x5
; 0000 03BF 
; 0000 03C0   lcd_putchar(0xDF);
	LDI  R26,LOW(223)
	CALL _lcd_putchar
; 0000 03C1   lcd_putchar(0x43);
	LDI  R26,LOW(67)
	CALL _lcd_putchar
; 0000 03C2   lcd_putchar(0x20);
	LDI  R26,LOW(32)
	CALL _lcd_putchar
; 0000 03C3    // lcd_puts("*C ");
; 0000 03C4 
; 0000 03C5         }
; 0000 03C6 
; 0000 03C7         else
	RJMP _0x8B
_0x7D:
; 0000 03C8         {
; 0000 03C9 
; 0000 03CA    flag=1;
	SET
	BLD  R2,0
; 0000 03CB    while(flag==1){}
_0x8C:
	SBRC R2,0
	RJMP _0x8C
; 0000 03CC           lcd_gotoxy(2,1);
	LDI  R30,LOW(2)
	CALL SUBOPT_0xC
; 0000 03CD                      //+55.9*c
; 0000 03CE              lcd_puts("ERROR  ");
	__POINTW2MN _0x5F,95
	CALL _lcd_puts
; 0000 03CF 
; 0000 03D0                     }
_0x8B:
; 0000 03D1     //  #asm("sei")
; 0000 03D2 
; 0000 03D3 
; 0000 03D4 
; 0000 03D5 
; 0000 03D6 
; 0000 03D7         if(es_gps > 0)
	LDS  R26,_es_gps
	CPI  R26,LOW(0x1)
	BRSH PC+2
	RJMP _0x8F
; 0000 03D8         {
; 0000 03D9 
; 0000 03DA       if(st_po<3)
	LDS  R26,_st_po
	CPI  R26,LOW(0x3)
	BRSH _0x90
; 0000 03DB      {
; 0000 03DC        ++st_po;
	LDS  R30,_st_po
	SUBI R30,-LOW(1)
	STS  _st_po,R30
; 0000 03DD 
; 0000 03DE 
; 0000 03DF            if(st_po==3)
	LDS  R26,_st_po
	CPI  R26,LOW(0x3)
	BRNE _0x91
; 0000 03E0             {
; 0000 03E1             ++st_po;
	SUBI R30,-LOW(1)
	STS  _st_po,R30
; 0000 03E2             flag=1;
	SET
	BLD  R2,0
; 0000 03E3    while(flag==1){}
_0x92:
	SBRC R2,0
	RJMP _0x92
; 0000 03E4 
; 0000 03E5             lcd_gotoxy(0,0);
	CALL SUBOPT_0x1
; 0000 03E6              lcd_puts("               ");
	__POINTW2MN _0x5F,103
	CALL SUBOPT_0x14
; 0000 03E7 
; 0000 03E8                 lcd_gotoxy(0,0);
; 0000 03E9           lcd_puts("N=   S=");
	__POINTW2MN _0x5F,119
	CALL _lcd_puts
; 0000 03EA 
; 0000 03EB 
; 0000 03EC              }
; 0000 03ED             }
_0x91:
; 0000 03EE       ++err;
_0x90:
	LDI  R26,LOW(_err)
	LDI  R27,HIGH(_err)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0000 03EF 
; 0000 03F0         switch(err)
	LDS  R30,_err
	LDS  R31,_err+1
; 0000 03F1         {
; 0000 03F2 
; 0000 03F3           case 3:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x98
; 0000 03F4 
; 0000 03F5           es_gps =1;
	LDI  R30,LOW(1)
	STS  _es_gps,R30
; 0000 03F6 
; 0000 03F7 
; 0000 03F8 
; 0000 03F9         UCSRB &=~(1<<RXCIE);
	CBI  0xA,7
; 0000 03FA 
; 0000 03FB             soten_speed = 0;
	CLR  R11
; 0000 03FC             deset_speed= 0;
	CLR  R8
; 0000 03FD               ed_speed= 0;
	CLR  R9
; 0000 03FE 
; 0000 03FF              // #asm("cli")
; 0000 0400 
; 0000 0401               flag=1;
	SET
	BLD  R2,0
; 0000 0402    while(flag==1){}
_0x99:
	SBRC R2,0
	RJMP _0x99
; 0000 0403               putchar('n');
	LDI  R26,LOW(110)
	CALL _putchar
; 0000 0404              lcd_gotoxy(0,0);
	CALL SUBOPT_0x1
; 0000 0405          lcd_puts("                ");
	__POINTW2MN _0x5F,127
	CALL SUBOPT_0x14
; 0000 0406              lcd_gotoxy(0,0);
; 0000 0407           lcd_puts("  NO SIGNAL");
	__POINTW2MN _0x5F,144
	RJMP _0x127
; 0000 0408 
; 0000 0409         //  #asm("sei")
; 0000 040A     // zvuk();
; 0000 040B 
; 0000 040C                  break;
; 0000 040D 
; 0000 040E          case 5:
_0x98:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x97
; 0000 040F 
; 0000 0410            es_gps =0;
	LDI  R30,LOW(0)
	STS  _es_gps,R30
; 0000 0411            err = 0;
	STS  _err,R30
	STS  _err+1,R30
; 0000 0412            st_po=0;
	STS  _st_po,R30
; 0000 0413 
; 0000 0414               UCSRB|=(1<<RXCIE);
	SBI  0xA,7
; 0000 0415 
; 0000 0416           //       #asm("cli")
; 0000 0417 
; 0000 0418                 flag=1;
	SET
	BLD  R2,0
; 0000 0419    while(flag==1){}
_0x9D:
	SBRC R2,0
	RJMP _0x9D
; 0000 041A                lcd_gotoxy(0,0);
	CALL SUBOPT_0x1
; 0000 041B           lcd_puts("                ");
	__POINTW2MN _0x5F,156
	CALL _lcd_puts
; 0000 041C           lcd_gotoxy(3,0);
	LDI  R30,LOW(3)
	CALL SUBOPT_0x3
; 0000 041D 
; 0000 041E         lcd_puts(":");
	__POINTW2MN _0x5F,173
	CALL _lcd_puts
; 0000 041F 
; 0000 0420         lcd_gotoxy(10,0);
	LDI  R30,LOW(10)
	CALL SUBOPT_0x3
; 0000 0421 
; 0000 0422         lcd_puts("S=");
	__POINTW2MN _0x5F,175
_0x127:
	CALL _lcd_puts
; 0000 0423 
; 0000 0424        //  #asm("sei")
; 0000 0425 
; 0000 0426 
; 0000 0427             break;
; 0000 0428        }
_0x97:
; 0000 0429          }
; 0000 042A 
; 0000 042B 
; 0000 042C 
; 0000 042D         adc_on;
_0x8F:
	SBI  0x6,7
; 0000 042E 
; 0000 042F 
; 0000 0430            work=3;
	LDI  R30,LOW(3)
	STS  _work,R30
; 0000 0431 
; 0000 0432 
; 0000 0433             continue;
	RJMP _0x67
; 0000 0434 
; 0000 0435 
; 0000 0436   case 3:
_0x79:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0x72
; 0000 0437 
; 0000 0438    if(st_v<3)
	LDS  R26,_st_v
	CPI  R26,LOW(0x3)
	BRSH _0xA2
; 0000 0439      {
; 0000 043A       ++st_v;
	LDS  R30,_st_v
	SUBI R30,-LOW(1)
	STS  _st_v,R30
; 0000 043B        goto m3;
	RJMP _0xA3
; 0000 043C        }
; 0000 043D 
; 0000 043E    adc_dataw+=adc_data;
_0xA2:
	LDS  R30,_adc_data
	LDS  R31,_adc_data+1
	CALL SUBOPT_0x15
	ADD  R30,R26
	ADC  R31,R27
	STS  _adc_dataw,R30
	STS  _adc_dataw+1,R31
; 0000 043F           if( cout_in<8)
	LDS  R26,_cout_in
	CPI  R26,LOW(0x8)
	BRSH _0xA4
; 0000 0440                    adc_on;
	SBI  0x6,7
; 0000 0441             if (++cout_in==8)
_0xA4:
	LDS  R26,_cout_in
	SUBI R26,-LOW(1)
	STS  _cout_in,R26
	CPI  R26,LOW(0x8)
	BREQ PC+2
	RJMP _0xA5
; 0000 0442           {
; 0000 0443 
; 0000 0444            adc_off;
	CBI  0x6,7
; 0000 0445 
; 0000 0446          adc_dataw=adc_dataw>>5;
	CALL SUBOPT_0x15
	LDI  R30,LOW(5)
	CALL __LSRW12
	STS  _adc_dataw,R30
	STS  _adc_dataw+1,R31
; 0000 0447        // adc_dataw=adc_dataw>>2;
; 0000 0448             cout_in=0;
	LDI  R30,LOW(0)
	STS  _cout_in,R30
; 0000 0449 
; 0000 044A 
; 0000 044B              ftoa((float)adc_dataw/10,1,lcd_buf);
	CALL SUBOPT_0x16
	CALL SUBOPT_0x8
; 0000 044C              flag=1;
; 0000 044D    while(flag==1){}
_0xA6:
	SBRC R2,0
	RJMP _0xA6
; 0000 044E 
; 0000 044F          lcd_gotoxy(12,1);
	CALL SUBOPT_0x7
; 0000 0450       lcd_puts(lcd_buf);
	CALL SUBOPT_0x5
; 0000 0451 
; 0000 0452           if(( adc_dataw <= min_u || adc_dataw >= max_u )&& alarm_u==0)
	CALL SUBOPT_0x15
	CPI  R26,LOW(0x74)
	LDI  R30,HIGH(0x74)
	CPC  R27,R30
	BRLO _0xAA
	CALL SUBOPT_0x15
	CPI  R26,LOW(0x94)
	LDI  R30,HIGH(0x94)
	CPC  R27,R30
	BRLO _0xAC
_0xAA:
	LDS  R26,_alarm_u
	CPI  R26,LOW(0x0)
	BREQ _0xAD
_0xAC:
	RJMP _0xA9
_0xAD:
; 0000 0453 
; 0000 0454           {
; 0000 0455         alarm_u=1;
	LDI  R30,LOW(1)
	STS  _alarm_u,R30
; 0000 0456               adc_datawi=adc_dataw;
	CALL SUBOPT_0x17
; 0000 0457                  putchar('b');
	LDI  R26,LOW(98)
	CALL _putchar
; 0000 0458 
; 0000 0459                        }
; 0000 045A 
; 0000 045B 
; 0000 045C         if(( adc_dataw > min_u && adc_dataw < max_u )&&  alarm_u==1)
_0xA9:
	CALL SUBOPT_0x15
	CPI  R26,LOW(0x74)
	LDI  R30,HIGH(0x74)
	CPC  R27,R30
	BRLO _0xAF
	CALL SUBOPT_0x15
	CPI  R26,LOW(0x94)
	LDI  R30,HIGH(0x94)
	CPC  R27,R30
	BRLO _0xB0
_0xAF:
	RJMP _0xB1
_0xB0:
	LDS  R26,_alarm_u
	CPI  R26,LOW(0x1)
	BREQ _0xB2
_0xB1:
	RJMP _0xAE
_0xB2:
; 0000 045D 
; 0000 045E                {
; 0000 045F 
; 0000 0460                alarm_u=0;
	LDI  R30,LOW(0)
	STS  _alarm_u,R30
; 0000 0461 
; 0000 0462                   ftoa((float)adc_dataw/10,1,lcd_buf);
	CALL SUBOPT_0x16
	CALL SUBOPT_0x8
; 0000 0463 
; 0000 0464           flag=1;
; 0000 0465    while(flag==1){}
_0xB3:
	SBRC R2,0
	RJMP _0xB3
; 0000 0466          lcd_gotoxy(12,1);
	CALL SUBOPT_0x7
; 0000 0467            lcd_puts(lcd_buf);
	CALL SUBOPT_0x5
; 0000 0468 
; 0000 0469             }
; 0000 046A      /*
; 0000 046B       ++st_po;
; 0000 046C 
; 0000 046D           itoa(st_po,lcd_buf);
; 0000 046E            lcd_gotoxy(12,0);
; 0000 046F 
; 0000 0470                 lcd_puts(lcd_buf);
; 0000 0471          */
; 0000 0472     //   #asm("sei")
; 0000 0473 
; 0000 0474 
; 0000 0475 
; 0000 0476 
; 0000 0477          adc_datawi=adc_dataw;
_0xAE:
	CALL SUBOPT_0x17
; 0000 0478         adc_dataw=0;
	LDI  R30,LOW(0)
	STS  _adc_dataw,R30
	STS  _adc_dataw+1,R30
; 0000 0479 
; 0000 047A 
; 0000 047B         }
; 0000 047C 
; 0000 047D 
; 0000 047E 
; 0000 047F      m3:
_0xA5:
_0xA3:
; 0000 0480        work=0;
_0x125:
	LDI  R30,LOW(0)
	STS  _work,R30
; 0000 0481         break;
; 0000 0482   }
_0x72:
; 0000 0483 
; 0000 0484     if( work_gps==0) goto m1;
	TST  R5
	BRNE _0xB6
	RJMP _0x6A
; 0000 0485 
; 0000 0486        //GPS----------------------------------------------------------
; 0000 0487 
; 0000 0488        if ( work_gps==1)
_0xB6:
	LDI  R30,LOW(1)
	CP   R30,R5
	BRNE _0xB7
; 0000 0489        {
; 0000 048A   //  #asm("cli")
; 0000 048B 
; 0000 048C        for(i=0; i<rx_wr_index; i++)
	CLR  R4
_0xB9:
	LDS  R30,_rx_wr_index
	CP   R4,R30
	BRSH _0xBA
; 0000 048D        {
; 0000 048E        if  (rx_buffer [i]=='$')
	CALL SUBOPT_0x18
	CPI  R26,LOW(0x24)
	BRNE _0xBB
; 0000 048F        {
; 0000 0490        work_gps=2;
	LDI  R30,LOW(2)
	MOV  R5,R30
; 0000 0491 
; 0000 0492         break;
	RJMP _0xBA
; 0000 0493        }
; 0000 0494           }
_0xBB:
	INC  R4
	RJMP _0xB9
_0xBA:
; 0000 0495              }
; 0000 0496 
; 0000 0497              if (work_gps==1)
_0xB7:
	LDI  R30,LOW(1)
	CP   R30,R5
	BRNE _0xBC
; 0000 0498              {
; 0000 0499          reset();
	RCALL _reset
; 0000 049A               goto m1;
	RJMP _0x6A
; 0000 049B 
; 0000 049C                  }
; 0000 049D 
; 0000 049E 
; 0000 049F        //switch(
; 0000 04A0 
; 0000 04A1        if (work_gps==2)
_0xBC:
	LDI  R30,LOW(2)
	CP   R30,R5
	BREQ PC+2
	RJMP _0xBD
; 0000 04A2        {
; 0000 04A3        if(rx_buffer [i+3]=='R' && rx_buffer [i+4]=='M'
; 0000 04A4        && rx_buffer [i+5]=='C' )
	CALL SUBOPT_0x19
	CPI  R26,LOW(0x52)
	BRNE _0xBF
	CALL SUBOPT_0x1A
	CPI  R26,LOW(0x4D)
	BRNE _0xBF
	CALL SUBOPT_0x1B
	CPI  R26,LOW(0x43)
	BREQ _0xC0
_0xBF:
	RJMP _0xBE
_0xC0:
; 0000 04A5 
; 0000 04A6        work_gps=3;
	LDI  R30,LOW(3)
	MOV  R5,R30
; 0000 04A7 
; 0000 04A8 
; 0000 04A9 
; 0000 04AA         if((rx_buffer [i+3]=='V') && (rx_buffer [i+4]=='T')
_0xBE:
; 0000 04AB        && (rx_buffer [i+5]=='G'))
	CALL SUBOPT_0x19
	CPI  R26,LOW(0x56)
	BRNE _0xC2
	CALL SUBOPT_0x1A
	CPI  R26,LOW(0x54)
	BRNE _0xC2
	CALL SUBOPT_0x1B
	CPI  R26,LOW(0x47)
	BREQ _0xC3
_0xC2:
	RJMP _0xC1
_0xC3:
; 0000 04AC 
; 0000 04AD        work_gps=5;
	LDI  R30,LOW(5)
	MOV  R5,R30
; 0000 04AE 
; 0000 04AF 
; 0000 04B0 
; 0000 04B1 
; 0000 04B2 
; 0000 04B3         if(rx_buffer [i+3]=='G' && rx_buffer [i+4]=='S'
_0xC1:
; 0000 04B4        && rx_buffer [i+5]=='V')// && es_gps == 0)
	CALL SUBOPT_0x19
	CPI  R26,LOW(0x47)
	BRNE _0xC5
	CALL SUBOPT_0x1A
	CPI  R26,LOW(0x53)
	BRNE _0xC5
	CALL SUBOPT_0x1B
	CPI  R26,LOW(0x56)
	BREQ _0xC6
_0xC5:
	RJMP _0xC4
_0xC6:
; 0000 04B5 
; 0000 04B6          work_gps=10;
	LDI  R30,LOW(10)
	MOV  R5,R30
; 0000 04B7 
; 0000 04B8 
; 0000 04B9 
; 0000 04BA          if(rx_buffer [i+3]=='G' && rx_buffer [i+4]=='G'
_0xC4:
; 0000 04BB        && rx_buffer [i+5]=='A' && st_po == 4)
	CALL SUBOPT_0x19
	CPI  R26,LOW(0x47)
	BRNE _0xC8
	CALL SUBOPT_0x1A
	CPI  R26,LOW(0x47)
	BRNE _0xC8
	CALL SUBOPT_0x1B
	CPI  R26,LOW(0x41)
	BRNE _0xC8
	LDS  R26,_st_po
	CPI  R26,LOW(0x4)
	BREQ _0xC9
_0xC8:
	RJMP _0xC7
_0xC9:
; 0000 04BC 
; 0000 04BD         work_gps=9;
	LDI  R30,LOW(9)
	MOV  R5,R30
; 0000 04BE 
; 0000 04BF 
; 0000 04C0 
; 0000 04C1       }
_0xC7:
; 0000 04C2 
; 0000 04C3 
; 0000 04C4          if (work_gps==2)
_0xBD:
	LDI  R30,LOW(2)
	CP   R30,R5
	BRNE _0xCA
; 0000 04C5             {
; 0000 04C6          reset();
	RCALL _reset
; 0000 04C7               goto m1;
	RJMP _0x6A
; 0000 04C8 
; 0000 04C9                  }
; 0000 04CA 
; 0000 04CB 
; 0000 04CC 
; 0000 04CD 
; 0000 04CE 
; 0000 04CF 
; 0000 04D0 
; 0000 04D1 
; 0000 04D2      /*
; 0000 04D3         {
; 0000 04D4 
; 0000 04D5        for(i=0; i<rx_wr_index; i++)
; 0000 04D6 
; 0000 04D7      {
; 0000 04D8        if(rx_buffer [i]==',')
; 0000 04D9 
; 0000 04DA      {
; 0000 04DB      work_gps=4;break;
; 0000 04DC 
; 0000 04DD      }
; 0000 04DE        }
; 0000 04DF       }   */
; 0000 04E0 
; 0000 04E1 
; 0000 04E2 
; 0000 04E3 
; 0000 04E4           if (work_gps==3 && es_gps == 3 )
_0xCA:
	LDI  R30,LOW(3)
	CP   R30,R5
	BRNE _0xCC
	LDS  R26,_es_gps
	CPI  R26,LOW(0x3)
	BREQ _0xCD
_0xCC:
	RJMP _0xCB
_0xCD:
; 0000 04E5           {
; 0000 04E6                for(i=0; i<rx_wr_index; i++)
	CLR  R4
_0xCF:
	LDS  R30,_rx_wr_index
	CP   R4,R30
	BRSH _0xD0
; 0000 04E7 
; 0000 04E8      {
; 0000 04E9        if(rx_buffer [i]=='A')
	CALL SUBOPT_0x18
	CPI  R26,LOW(0x41)
	BRNE _0xD1
; 0000 04EA 
; 0000 04EB      {
; 0000 04EC      work_gps=4;break;
	LDI  R30,LOW(4)
	MOV  R5,R30
	RJMP _0xD0
; 0000 04ED 
; 0000 04EE      }
; 0000 04EF        }
_0xD1:
	INC  R4
	RJMP _0xCF
_0xD0:
; 0000 04F0 
; 0000 04F1          if( work_gps==4)
	LDI  R30,LOW(4)
	CP   R30,R5
	BREQ PC+2
	RJMP _0xD2
; 0000 04F2          {
; 0000 04F3           for(i=0; i<rx_wr_index; i++)
	CLR  R4
_0xD4:
	LDS  R30,_rx_wr_index
	CP   R4,R30
	BRSH _0xD5
; 0000 04F4 
; 0000 04F5      {
; 0000 04F6        if(rx_buffer [i]==',') break;
	CALL SUBOPT_0x18
	CPI  R26,LOW(0x2C)
	BREQ _0xD5
; 0000 04F7 
; 0000 04F8           }
	INC  R4
	RJMP _0xD4
_0xD5:
; 0000 04F9 
; 0000 04FA 
; 0000 04FB 
; 0000 04FC 
; 0000 04FD            sum_hours=((rx_buffer [i+1])-48)*10+(rx_buffer [i+2]-48);
	MOV  R30,R4
	LDI  R31,0
	__ADDW1MN _rx_buffer,1
	CALL SUBOPT_0x1C
	__ADDW1MN _rx_buffer,2
	LD   R30,Z
	SUBI R30,LOW(48)
	ADD  R30,R26
	MOV  R10,R30
; 0000 04FE 
; 0000 04FF            if  (sum_hours<21)
	LDI  R30,LOW(21)
	CP   R10,R30
	BRSH _0xD7
; 0000 0500 
; 0000 0501             sum_hours=sum_hours+3;
	LDI  R30,LOW(3)
	ADD  R10,R30
; 0000 0502 
; 0000 0503 
; 0000 0504                else
	RJMP _0xD8
_0xD7:
; 0000 0505         {
; 0000 0506 
; 0000 0507            switch (sum_hours)
	MOV  R30,R10
	LDI  R31,0
; 0000 0508             {
; 0000 0509             case 21: sum_hours=0; break;
	CPI  R30,LOW(0x15)
	LDI  R26,HIGH(0x15)
	CPC  R31,R26
	BRNE _0xDC
	CLR  R10
	RJMP _0xDB
; 0000 050A              case 22: sum_hours=1; break;
_0xDC:
	CPI  R30,LOW(0x16)
	LDI  R26,HIGH(0x16)
	CPC  R31,R26
	BRNE _0xDD
	LDI  R30,LOW(1)
	RJMP _0x128
; 0000 050B               case 23: sum_hours=2; break;
_0xDD:
	CPI  R30,LOW(0x17)
	LDI  R26,HIGH(0x17)
	CPC  R31,R26
	BRNE _0xDB
	LDI  R30,LOW(2)
_0x128:
	MOV  R10,R30
; 0000 050C 
; 0000 050D 
; 0000 050E               }
_0xDB:
; 0000 050F            }
_0xD8:
; 0000 0510 
; 0000 0511 
; 0000 0512             //  decet_Hours_clock=sum_hours/10;
; 0000 0513 
; 0000 0514             //  ed_hours_clock=sum_hours%10;
; 0000 0515 
; 0000 0516 
; 0000 0517           decet_min_clock=(rx_buffer [i+3]-48)*10 + rx_buffer [i+4]-48 ;
	MOV  R30,R4
	LDI  R31,0
	__ADDW1MN _rx_buffer,3
	CALL SUBOPT_0x1C
	__ADDW1MN _rx_buffer,4
	LD   R30,Z
	ADD  R26,R30
	SUBI R26,LOW(48)
	STS  _decet_min_clock,R26
; 0000 0518 
; 0000 0519          // ed_min_clock=rx_buffer [i+4]-48;
; 0000 051A 
; 0000 051B 
; 0000 051C 
; 0000 051D            decet_sek_clock=(rx_buffer [i+5]-48)*10 + rx_buffer [i+6]-48;
	MOV  R30,R4
	LDI  R31,0
	__ADDW1MN _rx_buffer,5
	CALL SUBOPT_0x1C
	__ADDW1MN _rx_buffer,6
	LD   R30,Z
	ADD  R26,R30
	SUBI R26,LOW(48)
	STS  _decet_sek_clock,R26
; 0000 051E 
; 0000 051F 
; 0000 0520              rtc_set_time(sum_hours,decet_min_clock,decet_sek_clock);
	ST   -Y,R10
	LDS  R30,_decet_min_clock
	ST   -Y,R30
	CALL _rtc_set_time
; 0000 0521 
; 0000 0522 
; 0000 0523                    ++es_gps;
	LDS  R30,_es_gps
	SUBI R30,-LOW(1)
	STS  _es_gps,R30
; 0000 0524                     st_s=10;
	LDI  R30,LOW(10)
	STS  _st_s,R30
; 0000 0525                   // rtc_get_time(&h,&m,&s);
; 0000 0526 
; 0000 0527                //    time();
; 0000 0528              flag=1;
	SET
	BLD  R2,0
; 0000 0529    while(flag==1){}
_0xDF:
	SBRC R2,0
	RJMP _0xDF
; 0000 052A 
; 0000 052B                    lcd_gotoxy(15,0);
	LDI  R30,LOW(15)
	CALL SUBOPT_0x3
; 0000 052C 
; 0000 052D                       lcd_puts("#");
	__POINTW2MN _0x5F,178
	CALL _lcd_puts
; 0000 052E 
; 0000 052F 
; 0000 0530 
; 0000 0531 
; 0000 0532 
; 0000 0533          reset();
	RCALL _reset
; 0000 0534               goto m1;
	RJMP _0x6A
; 0000 0535 
; 0000 0536 
; 0000 0537 
; 0000 0538 
; 0000 0539 
; 0000 053A                  }
; 0000 053B             }
_0xD2:
; 0000 053C 
; 0000 053D           if( work_gps==3)
_0xCB:
	LDI  R30,LOW(3)
	CP   R30,R5
	BRNE _0xE2
; 0000 053E             {
; 0000 053F          reset();
	RCALL _reset
; 0000 0540               goto m1;
	RJMP _0x6A
; 0000 0541 
; 0000 0542                  }
; 0000 0543 
; 0000 0544 
; 0000 0545          if (work_gps==5)
_0xE2:
	LDI  R30,LOW(5)
	CP   R30,R5
	BREQ PC+2
	RJMP _0xE3
; 0000 0546 
; 0000 0547           {
; 0000 0548 
; 0000 0549 
; 0000 054A 
; 0000 054B              for(i=0; i<rx_wr_index; i++)
	CLR  R4
_0xE5:
	LDS  R30,_rx_wr_index
	CP   R4,R30
	BRLO PC+2
	RJMP _0xE6
; 0000 054C 
; 0000 054D             {
; 0000 054E 
; 0000 054F             if ( (rx_buffer [i]=='N')&&(rx_buffer [i+1]==','))
	CALL SUBOPT_0x18
	CPI  R26,LOW(0x4E)
	BRNE _0xE8
	CALL SUBOPT_0x0
	CPI  R26,LOW(0x2C)
	BREQ _0xE9
_0xE8:
	RJMP _0xE7
_0xE9:
; 0000 0550            {
; 0000 0551 
; 0000 0552            err=0; work_gps=6;
	LDI  R30,LOW(0)
	STS  _err,R30
	STS  _err+1,R30
	LDI  R30,LOW(6)
	MOV  R5,R30
; 0000 0553 
; 0000 0554            if(es_gps==0)
	LDS  R30,_es_gps
	CPI  R30,0
	BRNE _0xEA
; 0000 0555                {
; 0000 0556                 es_gps =3;
	LDI  R30,LOW(3)
	STS  _es_gps,R30
; 0000 0557               itoa(tm,lcd_buf);
	CALL SUBOPT_0x4
; 0000 0558              flag=1;
	SET
	BLD  R2,0
; 0000 0559    while(flag==1){}
_0xEB:
	SBRC R2,0
	RJMP _0xEB
; 0000 055A 
; 0000 055B            lcd_gotoxy(0,0);
	CALL SUBOPT_0x1
; 0000 055C 
; 0000 055D 
; 0000 055E          lcd_puts("                ");
	__POINTW2MN _0x5F,180
	CALL SUBOPT_0x14
; 0000 055F             lcd_gotoxy(0,0);
; 0000 0560           lcd_puts("GPS_Ok ");
	__POINTW2MN _0x5F,197
	CALL _lcd_puts
; 0000 0561 
; 0000 0562                   lcd_puts(lcd_buf);
	CALL SUBOPT_0x5
; 0000 0563            lcd_puts(":");
	__POINTW2MN _0x5F,205
	CALL _lcd_puts
; 0000 0564             if(ts<10)
	LDS  R26,_ts
	CPI  R26,LOW(0xA)
	BRSH _0xEE
; 0000 0565            lcd_puts("0");
	__POINTW2MN _0x5F,207
	CALL _lcd_puts
; 0000 0566 
; 0000 0567             itoa(ts,lcd_buf);
_0xEE:
	CALL SUBOPT_0x6
; 0000 0568                  lcd_puts(lcd_buf);
; 0000 0569 
; 0000 056A                   putchar('s');
	LDI  R26,LOW(115)
	CALL _putchar
; 0000 056B 
; 0000 056C                 ts=0;
	LDI  R30,LOW(0)
	STS  _ts,R30
; 0000 056D                 tm=0;
	STS  _tm,R30
; 0000 056E                 kvadrat = 0;
	STS  _kvadrat,R30
; 0000 056F 
; 0000 0570                      }
; 0000 0571 
; 0000 0572            break;
_0xEA:
	RJMP _0xE6
; 0000 0573          }
; 0000 0574 
; 0000 0575 
; 0000 0576 
; 0000 0577 
; 0000 0578        }
_0xE7:
	INC  R4
	RJMP _0xE5
_0xE6:
; 0000 0579 
; 0000 057A            }
; 0000 057B 
; 0000 057C          if (work_gps==5)
_0xE3:
	LDI  R30,LOW(5)
	CP   R30,R5
	BRNE _0xEF
; 0000 057D           {
; 0000 057E          reset();
	RCALL _reset
; 0000 057F               goto m1;
	RJMP _0x6A
; 0000 0580 
; 0000 0581                  }
; 0000 0582 
; 0000 0583 
; 0000 0584 
; 0000 0585 
; 0000 0586              if (work_gps==6)
_0xEF:
	LDI  R30,LOW(6)
	CP   R30,R5
	BREQ PC+2
	RJMP _0xF0
; 0000 0587           {
; 0000 0588 
; 0000 0589 
; 0000 058A 
; 0000 058B 
; 0000 058C 
; 0000 058D                 sum_hours=255;
	LDI  R30,LOW(255)
	MOV  R10,R30
; 0000 058E 
; 0000 058F 
; 0000 0590 
; 0000 0591               for(i= i+2; i<rx_wr_index ; i++)
	INC  R4
	INC  R4
_0xF2:
	LDS  R30,_rx_wr_index
	CP   R4,R30
	BRSH _0xF3
; 0000 0592               {
; 0000 0593                 sum_hours++;
	INC  R10
; 0000 0594                if(rx_buffer [i]!=',')
	CALL SUBOPT_0x18
	CPI  R26,LOW(0x2C)
	BREQ _0xF4
; 0000 0595                {
; 0000 0596 
; 0000 0597              speed_array[sum_hours]= rx_buffer [i];
	MOV  R26,R10
	LDI  R27,0
	SUBI R26,LOW(-_speed_array)
	SBCI R27,HIGH(-_speed_array)
	MOV  R30,R4
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer)
	SBCI R31,HIGH(-_rx_buffer)
	LD   R30,Z
	ST   X,R30
; 0000 0598 
; 0000 0599 
; 0000 059A 
; 0000 059B              }
; 0000 059C                  else
	RJMP _0xF5
_0xF4:
; 0000 059D                  break;
	RJMP _0xF3
; 0000 059E 
; 0000 059F 
; 0000 05A0              }
_0xF5:
	INC  R4
	RJMP _0xF2
_0xF3:
; 0000 05A1 
; 0000 05A2 
; 0000 05A3 
; 0000 05A4             for(r=0; r<sum_hours; r++)
	LDI  R30,LOW(0)
	STS  _r,R30
_0xF7:
	LDS  R26,_r
	CP   R26,R10
	BRSH _0xF8
; 0000 05A5 
; 0000 05A6              if( speed_array[r]=='.')
	LDS  R30,_r
	LDI  R31,0
	SUBI R30,LOW(-_speed_array)
	SBCI R31,HIGH(-_speed_array)
	LD   R26,Z
	CPI  R26,LOW(0x2E)
	BREQ _0xF8
; 0000 05A7               {
; 0000 05A8 
; 0000 05A9           //   soten_speed =5;                         //     unsigned char ed_speed;
; 0000 05AA               break;
; 0000 05AB                }
; 0000 05AC             //    i=2;                                             //   unsigned char deset_speed;
; 0000 05AD                                                              // unsigned char soten_speed;
; 0000 05AE             switch (r)
	LDS  R30,_r
	SUBI R30,-LOW(1)
	STS  _r,R30
	RJMP _0xF7
_0xF8:
	LDS  R30,_r
	CALL SUBOPT_0x9
; 0000 05AF             {
; 0000 05B0              case 1: ed_speed = speed_array[0]-48;
	BRNE _0xFD
	LDS  R30,_speed_array
	SUBI R30,LOW(48)
	MOV  R9,R30
; 0000 05B1 
; 0000 05B2               soten_speed = deset_speed = 0;
	LDI  R30,LOW(0)
	MOV  R8,R30
	RJMP _0x129
; 0000 05B3                   break;
; 0000 05B4 
; 0000 05B5               case 2: ed_speed = speed_array[1]-48;
_0xFD:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0xFE
	__GETB1MN _speed_array,1
	SUBI R30,LOW(48)
	MOV  R9,R30
; 0000 05B6                    deset_speed = speed_array[0]-48;
	LDS  R30,_speed_array
	SUBI R30,LOW(48)
	MOV  R8,R30
; 0000 05B7 
; 0000 05B8               soten_speed =  0;
	CLR  R11
; 0000 05B9                   break;
	RJMP _0xFC
; 0000 05BA 
; 0000 05BB               case 3: ed_speed = speed_array[2]-48;
_0xFE:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0xFC
	__GETB1MN _speed_array,2
	SUBI R30,LOW(48)
	MOV  R9,R30
; 0000 05BC                    deset_speed = speed_array[1]-48;
	__GETB1MN _speed_array,1
	SUBI R30,LOW(48)
	MOV  R8,R30
; 0000 05BD 
; 0000 05BE               soten_speed = speed_array[0]-48;
	LDS  R30,_speed_array
	SUBI R30,LOW(48)
_0x129:
	MOV  R11,R30
; 0000 05BF                   break;
; 0000 05C0 
; 0000 05C1              }
_0xFC:
; 0000 05C2 
; 0000 05C3               for(r=0; r<10; r++)
	LDI  R30,LOW(0)
	STS  _r,R30
_0x101:
	LDS  R26,_r
	CPI  R26,LOW(0xA)
	BRSH _0x102
; 0000 05C4                speed_array[r]=0;
	LDS  R30,_r
	LDI  R31,0
	SUBI R30,LOW(-_speed_array)
	SBCI R31,HIGH(-_speed_array)
	LDI  R26,LOW(0)
	STD  Z+0,R26
	LDS  R30,_r
	SUBI R30,-LOW(1)
	STS  _r,R30
	RJMP _0x101
_0x102:
; 0000 05E5 reset();
	RCALL _reset
; 0000 05E6               goto m1;
	RJMP _0x6A
; 0000 05E7 
; 0000 05E8 
; 0000 05E9 
; 0000 05EA 
; 0000 05EB        }
; 0000 05EC 
; 0000 05ED 
; 0000 05EE 
; 0000 05EF 
; 0000 05F0 
; 0000 05F1 
; 0000 05F2 
; 0000 05F3 
; 0000 05F4 
; 0000 05F5 
; 0000 05F6           if( work_gps==9 )
_0xF0:
	LDI  R30,LOW(9)
	CP   R30,R5
	BREQ PC+2
	RJMP _0x103
; 0000 05F7           {
; 0000 05F8 
; 0000 05F9              sum_hours=0;
	CLR  R10
; 0000 05FA         //  ed_sek_clock=rx_buffer [i+6]-48;
; 0000 05FB 
; 0000 05FC             for(i=0; i<rx_wr_index; i++)
	CLR  R4
_0x105:
	LDS  R30,_rx_wr_index
	CP   R4,R30
	BRSH _0x106
; 0000 05FD        {
; 0000 05FE        if  (rx_buffer [i]==',')
	CALL SUBOPT_0x18
	CPI  R26,LOW(0x2C)
	BRNE _0x107
; 0000 05FF        {
; 0000 0600        if(++sum_hours==7)
	INC  R10
	LDI  R30,LOW(7)
	CP   R30,R10
	BRNE _0x108
; 0000 0601        {
; 0000 0602                       //n sputnik
; 0000 0603 
; 0000 0604         //  decet_sek_clock=(rx_buffer [i+1]-48)*10 + rx_buffer [i+2]-48;
; 0000 0605 
; 0000 0606 
; 0000 0607        //   ed_sek_clock=
; 0000 0608     //   itoa(decet_sek_clock ,lcd_buf);
; 0000 0609          flag=1;
	SET
	BLD  R2,0
; 0000 060A        while(flag==1){}
_0x109:
	SBRC R2,0
	RJMP _0x109
; 0000 060B           lcd_gotoxy(2,0);
	LDI  R30,LOW(2)
	CALL SUBOPT_0x3
; 0000 060C 
; 0000 060D           lcd_d ();
	RCALL _lcd_d
; 0000 060E 
; 0000 060F          //  #asm("sei")
; 0000 0610 
; 0000 0611            break;
	RJMP _0x106
; 0000 0612 
; 0000 0613             }
; 0000 0614             }
_0x108:
; 0000 0615            }
_0x107:
	INC  R4
	RJMP _0x105
_0x106:
; 0000 0616 
; 0000 0617 
; 0000 0618         sum_hours=0;
	CLR  R10
; 0000 0619         //  ed_sek_clock=rx_buffer [i+6]-48;
; 0000 061A 
; 0000 061B             for(i=0; i<rx_wr_index; i++)
	CLR  R4
_0x10D:
	LDS  R30,_rx_wr_index
	CP   R4,R30
	BRLO PC+2
	RJMP _0x10E
; 0000 061C        {
; 0000 061D        if(rx_buffer [i]==',')
	CALL SUBOPT_0x18
	CPI  R26,LOW(0x2C)
	BREQ PC+2
	RJMP _0x10F
; 0000 061E        {
; 0000 061F        if(++sum_hours==9)
	INC  R10
	LDI  R30,LOW(9)
	CP   R30,R10
	BREQ PC+2
	RJMP _0x110
; 0000 0620        {
; 0000 0621                       //METR
; 0000 0622 
; 0000 0623           metr=((rx_buffer [i+1]-48)*100) + ((rx_buffer [i+2]-48)*10)
; 0000 0624 
; 0000 0625           +( rx_buffer [i+3]-48);
	MOV  R30,R4
	LDI  R31,0
	__ADDW1MN _rx_buffer,1
	LD   R30,Z
	LDI  R31,0
	SBIW R30,48
	LDI  R26,LOW(100)
	LDI  R27,HIGH(100)
	CALL __MULW12
	MOVW R22,R30
	MOV  R30,R4
	LDI  R31,0
	__ADDW1MN _rx_buffer,2
	LD   R30,Z
	LDI  R31,0
	SBIW R30,48
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12
	MOVW R26,R22
	ADD  R26,R30
	ADC  R27,R31
	MOV  R30,R4
	LDI  R31,0
	__ADDW1MN _rx_buffer,3
	LD   R30,Z
	LDI  R31,0
	SBIW R30,48
	ADD  R30,R26
	ADC  R31,R27
	STS  _metr,R30
	STS  _metr+1,R31
; 0000 0626 
; 0000 0627 
; 0000 0628              itoa(metr ,lcd_buf);
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(_lcd_buf)
	LDI  R27,HIGH(_lcd_buf)
	CALL _itoa
; 0000 0629 
; 0000 062A               flag=1;
	SET
	BLD  R2,0
; 0000 062B           while(flag==1){}
_0x111:
	SBRC R2,0
	RJMP _0x111
; 0000 062C 
; 0000 062D           lcd_gotoxy(10,0);
	LDI  R30,LOW(10)
	CALL SUBOPT_0x3
; 0000 062E 
; 0000 062F           lcd_puts(lcd_buf);
	CALL SUBOPT_0x5
; 0000 0630 
; 0000 0631                  lcd_puts("m");
	__POINTW2MN _0x5F,209
	CALL _lcd_puts
; 0000 0632 
; 0000 0633       if(metr<=999)
	LDS  R26,_metr
	LDS  R27,_metr+1
	CPI  R26,LOW(0x3E8)
	LDI  R30,HIGH(0x3E8)
	CPC  R27,R30
	BRSH _0x114
; 0000 0634 
; 0000 0635               lcd_putchar(0X20);
	LDI  R26,LOW(32)
	CALL _lcd_putchar
; 0000 0636 
; 0000 0637             //  #asm("sei")
; 0000 0638 
; 0000 0639                break;
_0x114:
	RJMP _0x10E
; 0000 063A                }
; 0000 063B                }
_0x110:
; 0000 063C              }
_0x10F:
	INC  R4
	RJMP _0x10D
_0x10E:
; 0000 063D 
; 0000 063E 
; 0000 063F 
; 0000 0640          reset();
	RCALL _reset
; 0000 0641               goto m1;
	RJMP _0x6A
; 0000 0642 
; 0000 0643 
; 0000 0644 
; 0000 0645 
; 0000 0646 
; 0000 0647             }
; 0000 0648 
; 0000 0649 
; 0000 064A          if( work_gps==10)
_0x103:
	LDI  R30,LOW(10)
	CP   R30,R5
	BRNE _0x115
; 0000 064B           {
; 0000 064C 
; 0000 064D 
; 0000 064E                sum_hours=0;
	CLR  R10
; 0000 064F         //  ed_sek_clock=rx_buffer [i+6]-48;
; 0000 0650 
; 0000 0651             for(i=0; i<rx_wr_index; i++)
	CLR  R4
_0x117:
	LDS  R30,_rx_wr_index
	CP   R4,R30
	BRSH _0x118
; 0000 0652        {
; 0000 0653        if  (rx_buffer [i]==',')
	CALL SUBOPT_0x18
	CPI  R26,LOW(0x2C)
	BRNE _0x119
; 0000 0654        {
; 0000 0655        if(++sum_hours==3)
	INC  R10
	LDI  R30,LOW(3)
	CP   R30,R10
	BRNE _0x11A
; 0000 0656        {
; 0000 0657                       //S sputnik
; 0000 0658 
; 0000 0659         //  decet_sek_clock=(rx_buffer [i+1]-48)*10 + rx_buffer [i+2]-48;
; 0000 065A 
; 0000 065B     //   itoa(decet_sek_clock ,lcd_buf);
; 0000 065C 
; 0000 065D               flag=1;
	SET
	BLD  R2,0
; 0000 065E        while(flag==1){}
_0x11B:
	SBRC R2,0
	RJMP _0x11B
; 0000 065F 
; 0000 0660        if(es_gps==0)
	LDS  R30,_es_gps
	CPI  R30,0
	BRNE _0x11E
; 0000 0661        {
; 0000 0662          lcd_gotoxy(12,0);
	LDI  R30,LOW(12)
	CALL SUBOPT_0x3
; 0000 0663             lcd_d ();
	RCALL _lcd_d
; 0000 0664             }
; 0000 0665         if(st_po==4)
_0x11E:
	LDS  R26,_st_po
	CPI  R26,LOW(0x4)
	BRNE _0x11F
; 0000 0666         {
; 0000 0667           lcd_gotoxy(7,0);
	LDI  R30,LOW(7)
	CALL SUBOPT_0x3
; 0000 0668             lcd_d ();
	RCALL _lcd_d
; 0000 0669               }
; 0000 066A           //  #asm("sei")
; 0000 066B 
; 0000 066C          reset();
_0x11F:
	RCALL _reset
; 0000 066D               goto m1;
	RJMP _0x6A
; 0000 066E 
; 0000 066F 
; 0000 0670 
; 0000 0671            break;
; 0000 0672 
; 0000 0673             }
; 0000 0674 
; 0000 0675             }
_0x11A:
; 0000 0676           }
_0x119:
	INC  R4
	RJMP _0x117
_0x118:
; 0000 0677 
; 0000 0678         }
; 0000 0679           reset ();
_0x115:
	RCALL _reset
; 0000 067A 
; 0000 067B       }
	RJMP _0x67
; 0000 067C }
_0x120:
	RJMP _0x120
; .FEND

	.DSEG
_0x5F:
	.BYTE 0xD3

	.CSEG
_itoa:
; .FSTART _itoa
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    ld   r30,y+
    ld   r31,y+
    adiw r30,0
    brpl __itoa0
    com  r30
    com  r31
    adiw r30,1
    ldi  r22,'-'
    st   x+,r22
__itoa0:
    clt
    ldi  r24,low(10000)
    ldi  r25,high(10000)
    rcall __itoa1
    ldi  r24,low(1000)
    ldi  r25,high(1000)
    rcall __itoa1
    ldi  r24,100
    clr  r25
    rcall __itoa1
    ldi  r24,10
    rcall __itoa1
    mov  r22,r30
    rcall __itoa5
    clr  r22
    st   x,r22
    ret

__itoa1:
    clr	 r22
__itoa2:
    cp   r30,r24
    cpc  r31,r25
    brlo __itoa3
    inc  r22
    sub  r30,r24
    sbc  r31,r25
    brne __itoa2
__itoa3:
    tst  r22
    brne __itoa4
    brts __itoa5
    ret
__itoa4:
    set
__itoa5:
    subi r22,-0x30
    st   x+,r22
    ret
; .FEND
_ftoa:
; .FSTART _ftoa
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,4
	LDI  R30,LOW(0)
	ST   Y,R30
	STD  Y+1,R30
	STD  Y+2,R30
	LDI  R30,LOW(63)
	STD  Y+3,R30
	ST   -Y,R17
	ST   -Y,R16
	LDD  R30,Y+11
	LDD  R31,Y+11+1
	CPI  R30,LOW(0xFFFF)
	LDI  R26,HIGH(0xFFFF)
	CPC  R31,R26
	BRNE _0x200000D
	CALL SUBOPT_0x1D
	__POINTW2FN _0x2000000,0
	CALL _strcpyf
	RJMP _0x2120005
_0x200000D:
	CPI  R30,LOW(0x7FFF)
	LDI  R26,HIGH(0x7FFF)
	CPC  R31,R26
	BRNE _0x200000C
	CALL SUBOPT_0x1D
	__POINTW2FN _0x2000000,1
	CALL _strcpyf
	RJMP _0x2120005
_0x200000C:
	LDD  R26,Y+12
	TST  R26
	BRPL _0x200000F
	__GETD1S 9
	CALL __ANEGF1
	CALL SUBOPT_0x1E
	CALL SUBOPT_0x1F
	LDI  R30,LOW(45)
	ST   X,R30
_0x200000F:
	LDD  R26,Y+8
	CPI  R26,LOW(0x7)
	BRLO _0x2000010
	LDI  R30,LOW(6)
	STD  Y+8,R30
_0x2000010:
	LDD  R17,Y+8
_0x2000011:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BREQ _0x2000013
	CALL SUBOPT_0x20
	CALL SUBOPT_0x21
	CALL SUBOPT_0x22
	RJMP _0x2000011
_0x2000013:
	CALL SUBOPT_0x23
	CALL __ADDF12
	CALL SUBOPT_0x1E
	LDI  R17,LOW(0)
	__GETD1N 0x3F800000
	CALL SUBOPT_0x22
_0x2000014:
	CALL SUBOPT_0x23
	CALL __CMPF12
	BRLO _0x2000016
	CALL SUBOPT_0x20
	CALL SUBOPT_0x24
	CALL SUBOPT_0x22
	SUBI R17,-LOW(1)
	CPI  R17,39
	BRLO _0x2000017
	CALL SUBOPT_0x1D
	__POINTW2FN _0x2000000,5
	CALL _strcpyf
	RJMP _0x2120005
_0x2000017:
	RJMP _0x2000014
_0x2000016:
	CPI  R17,0
	BRNE _0x2000018
	CALL SUBOPT_0x1F
	LDI  R30,LOW(48)
	ST   X,R30
	RJMP _0x2000019
_0x2000018:
_0x200001A:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BREQ _0x200001C
	CALL SUBOPT_0x20
	CALL SUBOPT_0x21
	__GETD2N 0x3F000000
	CALL __ADDF12
	MOVW R26,R30
	MOVW R24,R22
	CALL _floor
	CALL SUBOPT_0x22
	CALL SUBOPT_0x23
	CALL __DIVF21
	CALL __CFD1U
	MOV  R16,R30
	CALL SUBOPT_0x1F
	MOV  R30,R16
	SUBI R30,-LOW(48)
	ST   X,R30
	MOV  R30,R16
	LDI  R31,0
	CALL SUBOPT_0x20
	CALL __CWD1
	CALL __CDF1
	CALL __MULF12
	CALL SUBOPT_0x25
	CALL SUBOPT_0x26
	RJMP _0x200001A
_0x200001C:
_0x2000019:
	LDD  R30,Y+8
	CPI  R30,0
	BREQ _0x2120004
	CALL SUBOPT_0x1F
	LDI  R30,LOW(46)
	ST   X,R30
_0x200001E:
	LDD  R30,Y+8
	SUBI R30,LOW(1)
	STD  Y+8,R30
	SUBI R30,-LOW(1)
	BREQ _0x2000020
	CALL SUBOPT_0x25
	CALL SUBOPT_0x24
	CALL SUBOPT_0x1E
	__GETD1S 9
	CALL __CFD1U
	MOV  R16,R30
	CALL SUBOPT_0x1F
	MOV  R30,R16
	SUBI R30,-LOW(48)
	ST   X,R30
	MOV  R30,R16
	LDI  R31,0
	CALL SUBOPT_0x25
	CALL __CWD1
	CALL __CDF1
	CALL SUBOPT_0x26
	RJMP _0x200001E
_0x2000020:
_0x2120004:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
_0x2120005:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,13
	RET
; .FEND

	.DSEG

	.CSEG

	.CSEG

	.CSEG
_rtc_init:
; .FSTART _rtc_init
	ST   -Y,R26
	LDD  R30,Y+2
	ANDI R30,LOW(0x3)
	STD  Y+2,R30
	LDD  R30,Y+1
	CPI  R30,0
	BREQ _0x2040003
	LDD  R30,Y+2
	ORI  R30,0x10
	STD  Y+2,R30
_0x2040003:
	LD   R30,Y
	CPI  R30,0
	BREQ _0x2040004
	LDD  R30,Y+2
	ORI  R30,0x80
	STD  Y+2,R30
_0x2040004:
	CALL SUBOPT_0x27
	LDI  R26,LOW(7)
	CALL _i2c_write
	LDD  R26,Y+2
	CALL SUBOPT_0x28
	RJMP _0x2120003
; .FEND
_rtc_get_time:
; .FSTART _rtc_get_time
	ST   -Y,R27
	ST   -Y,R26
	CALL SUBOPT_0x27
	LDI  R26,LOW(0)
	CALL SUBOPT_0x28
	CALL _i2c_start
	LDI  R26,LOW(209)
	CALL _i2c_write
	CALL SUBOPT_0x29
	LD   R26,Y
	LDD  R27,Y+1
	ST   X,R30
	CALL SUBOPT_0x29
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ST   X,R30
	LDI  R26,LOW(0)
	CALL _i2c_read
	MOV  R26,R30
	CALL _bcd2bin
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X,R30
	CALL _i2c_stop
	ADIW R28,6
	RET
; .FEND
_rtc_set_time:
; .FSTART _rtc_set_time
	ST   -Y,R26
	CALL SUBOPT_0x27
	LDI  R26,LOW(0)
	CALL _i2c_write
	LD   R26,Y
	CALL _bin2bcd
	MOV  R26,R30
	CALL _i2c_write
	LDD  R26,Y+1
	CALL _bin2bcd
	MOV  R26,R30
	CALL _i2c_write
	LDD  R26,Y+2
	CALL _bin2bcd
	MOV  R26,R30
	CALL SUBOPT_0x28
	RJMP _0x2120003
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G103:
; .FSTART __lcd_write_nibble_G103
	ST   -Y,R26
	LD   R30,Y
	ANDI R30,LOW(0x10)
	BREQ _0x2060004
	SBI  0x18,3
	RJMP _0x2060005
_0x2060004:
	CBI  0x18,3
_0x2060005:
	LD   R30,Y
	ANDI R30,LOW(0x20)
	BREQ _0x2060006
	SBI  0x18,4
	RJMP _0x2060007
_0x2060006:
	CBI  0x18,4
_0x2060007:
	LD   R30,Y
	ANDI R30,LOW(0x40)
	BREQ _0x2060008
	SBI  0x18,5
	RJMP _0x2060009
_0x2060008:
	CBI  0x18,5
_0x2060009:
	LD   R30,Y
	ANDI R30,LOW(0x80)
	BREQ _0x206000A
	SBI  0x18,6
	RJMP _0x206000B
_0x206000A:
	CBI  0x18,6
_0x206000B:
	__DELAY_USB 13
	SBI  0x18,2
	__DELAY_USB 13
	CBI  0x18,2
	__DELAY_USB 13
	JMP  _0x2120002
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G103
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G103
	__DELAY_USB 133
	RJMP _0x2120002
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G103)
	SBCI R31,HIGH(-__base_y_G103)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R30,Y+1
	STS  __lcd_x,R30
	LD   R30,Y
	STS  __lcd_y,R30
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	CALL SUBOPT_0x2A
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	CALL SUBOPT_0x2A
	LDI  R30,LOW(0)
	STS  __lcd_y,R30
	STS  __lcd_x,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2060011
	LDS  R30,__lcd_maxx
	LDS  R26,__lcd_x
	CP   R26,R30
	BRLO _0x2060010
_0x2060011:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDS  R26,__lcd_y
	SUBI R26,-LOW(1)
	STS  __lcd_y,R26
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2060013
	RJMP _0x2120002
_0x2060013:
_0x2060010:
	LDS  R30,__lcd_x
	SUBI R30,-LOW(1)
	STS  __lcd_x,R30
	SBI  0x18,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x18,0
	RJMP _0x2120002
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2060014:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x2060016
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2060014
_0x2060016:
	LDD  R17,Y+0
_0x2120003:
	ADIW R28,3
	RET
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	SBI  0x17,3
	SBI  0x17,4
	SBI  0x17,5
	SBI  0x17,6
	SBI  0x17,2
	SBI  0x17,0
	SBI  0x17,1
	CBI  0x18,2
	CBI  0x18,0
	CBI  0x18,1
	LD   R30,Y
	STS  __lcd_maxx,R30
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G103,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G103,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	CALL SUBOPT_0x2B
	CALL SUBOPT_0x2B
	CALL SUBOPT_0x2B
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G103
	__DELAY_USW 200
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
	RJMP _0x2120002
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_putchar:
; .FSTART _putchar
	ST   -Y,R26
putchar0:
     sbis usr,udre
     rjmp putchar0
     ld   r30,y
     out  udr,r30
_0x2120002:
	ADIW R28,1
	RET
; .FEND

	.CSEG
_memset:
; .FSTART _memset
	ST   -Y,R27
	ST   -Y,R26
    ldd  r27,y+1
    ld   r26,y
    adiw r26,0
    breq memset1
    ldd  r31,y+4
    ldd  r30,y+3
    ldd  r22,y+2
memset0:
    st   z+,r22
    sbiw r26,1
    brne memset0
memset1:
    ldd  r30,y+3
    ldd  r31,y+4
	ADIW R28,5
	RET
; .FEND
_strcpyf:
; .FSTART _strcpyf
	ST   -Y,R27
	ST   -Y,R26
    ld   r30,y+
    ld   r31,y+
    ld   r26,y+
    ld   r27,y+
    movw r24,r26
strcpyf0:
	lpm  r0,z+
    st   x+,r0
    tst  r0
    brne strcpyf0
    movw r30,r24
    ret
; .FEND

	.CSEG

	.CSEG
_ftrunc:
; .FSTART _ftrunc
	CALL __PUTPARD2
   ldd  r23,y+3
   ldd  r22,y+2
   ldd  r31,y+1
   ld   r30,y
   bst  r23,7
   lsl  r23
   sbrc r22,7
   sbr  r23,1
   mov  r25,r23
   subi r25,0x7e
   breq __ftrunc0
   brcs __ftrunc0
   cpi  r25,24
   brsh __ftrunc1
   clr  r26
   clr  r27
   clr  r24
__ftrunc2:
   sec
   ror  r24
   ror  r27
   ror  r26
   dec  r25
   brne __ftrunc2
   and  r30,r26
   and  r31,r27
   and  r22,r24
   rjmp __ftrunc1
__ftrunc0:
   clt
   clr  r23
   clr  r30
   clr  r31
   clr  r22
__ftrunc1:
   cbr  r22,0x80
   lsr  r23
   brcc __ftrunc3
   sbr  r22,0x80
__ftrunc3:
   bld  r23,7
   ld   r26,y+
   ld   r27,y+
   ld   r24,y+
   ld   r25,y+
   cp   r30,r26
   cpc  r31,r27
   cpc  r22,r24
   cpc  r23,r25
   bst  r25,7
   ret
; .FEND
_floor:
; .FSTART _floor
	CALL __PUTPARD2
	CALL __GETD2S0
	CALL _ftrunc
	CALL __PUTD1S0
    brne __floor1
__floor0:
	CALL __GETD1S0
	RJMP _0x2120001
__floor1:
    brtc __floor0
	CALL __GETD1S0
	__GETD2N 0x3F800000
	CALL __SUBF12
_0x2120001:
	ADIW R28,4
	RET
; .FEND

	.CSEG
_bcd2bin:
; .FSTART _bcd2bin
	ST   -Y,R26
    ld   r30,y
    swap r30
    andi r30,0xf
    mov  r26,r30
    lsl  r26
    lsl  r26
    add  r30,r26
    lsl  r30
    ld   r26,y+
    andi r26,0xf
    add  r30,r26
    ret
; .FEND
_bin2bcd:
; .FSTART _bin2bcd
	ST   -Y,R26
    ld   r26,y+
    clr  r30
bin2bcd0:
    subi r26,10
    brmi bin2bcd1
    subi r30,-16
    rjmp bin2bcd0
bin2bcd1:
    subi r26,-10
    add  r30,r26
    ret
; .FEND

	.DSEG
___ds1820_scratch_pad:
	.BYTE 0x9
_decet_min_clock:
	.BYTE 0x1
_ed_hours_clock:
	.BYTE 0x1
_decet_Hours_clock:
	.BYTE 0x1
_h:
	.BYTE 0x1
_m:
	.BYTE 0x1
_s:
	.BYTE 0x1
_st:
	.BYTE 0x1
_st_v:
	.BYTE 0x1
_st_po:
	.BYTE 0x1
_err:
	.BYTE 0x2
_counter:
	.BYTE 0x1
_work:
	.BYTE 0x1
_test:
	.BYTE 0x1
_es_gps:
	.BYTE 0x1
_cnt_rem:
	.BYTE 0x1
_cnt_c:
	.BYTE 0x1
_error:
	.BYTE 0x1
_kvadrat:
	.BYTE 0x1
_decet_sek_clock:
	.BYTE 0x1
_alarm_u:
	.BYTE 0x1
_c:
	.BYTE 0x1
_t:
	.BYTE 0x1
_metr:
	.BYTE 0x2
_ts:
	.BYTE 0x1
_tm:
	.BYTE 0x1
_st_s:
	.BYTE 0x1
_r:
	.BYTE 0x1
_met:
	.BYTE 0x1
_adc_dataw:
	.BYTE 0x2
_adc_data:
	.BYTE 0x2
_adc_datawi:
	.BYTE 0x2
_cout_in:
	.BYTE 0x1
_copy:
	.BYTE 0x4
_wcnt_rem:
	.BYTE 0x4
_wcnt_c:
	.BYTE 0x4
_lcd_buf:
	.BYTE 0x10
_speed_array:
	.BYTE 0xA
_speed:
	.BYTE 0xA
_rx_buffer:
	.BYTE 0x64
_rx_wr_index:
	.BYTE 0x1
_rx_rd_index:
	.BYTE 0x1
_rx_counter:
	.BYTE 0x1
__seed_G100:
	.BYTE 0x4
__base_y_G103:
	.BYTE 0x4
__lcd_x:
	.BYTE 0x1
__lcd_y:
	.BYTE 0x1
__lcd_maxx:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x0:
	MOV  R30,R4
	LDI  R31,0
	__ADDW1MN _rx_buffer,1
	LD   R26,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:24 WORDS
SUBOPT_0x1:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2:
	CALL _lcd_puts
	LDI  R30,LOW(6)
	ST   -Y,R30
	LDI  R26,LOW(0)
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x3:
	ST   -Y,R30
	LDI  R26,LOW(0)
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x4:
	LDS  R30,_tm
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(_lcd_buf)
	LDI  R27,HIGH(_lcd_buf)
	JMP  _itoa

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x5:
	LDI  R26,LOW(_lcd_buf)
	LDI  R27,HIGH(_lcd_buf)
	JMP  _lcd_puts

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x6:
	LDS  R30,_ts
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(_lcd_buf)
	LDI  R27,HIGH(_lcd_buf)
	CALL _itoa
	RJMP SUBOPT_0x5

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x7:
	LDI  R30,LOW(12)
	ST   -Y,R30
	LDI  R26,LOW(1)
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:37 WORDS
SUBOPT_0x8:
	CLR  R22
	CLR  R23
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x41200000
	CALL __DIVF21
	CALL __PUTPARD1
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R26,LOW(_lcd_buf)
	LDI  R27,HIGH(_lcd_buf)
	CALL _ftoa
	SET
	BLD  R2,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9:
	LDI  R31,0
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xA:
	CALL _lcd_puts
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xB:
	CALL _lcd_puts
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	CALL _delay_ms
	JMP  _lcd_clear

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xC:
	ST   -Y,R30
	LDI  R26,LOW(1)
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xD:
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __CDF1
	CALL __PUTDP1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xE:
	LDS  R30,_copy
	LDS  R31,_copy+1
	LDS  R22,_copy+2
	LDS  R23,_copy+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xF:
	CALL __SUBF12
	STS  _copy,R30
	STS  _copy+1,R31
	STS  _copy+2,R22
	STS  _copy+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:33 WORDS
SUBOPT_0x10:
	LDS  R26,_wcnt_rem
	LDS  R27,_wcnt_rem+1
	LDS  R24,_wcnt_rem+2
	LDS  R25,_wcnt_rem+3
	LDS  R30,_wcnt_c
	LDS  R31,_wcnt_c+1
	LDS  R22,_wcnt_c+2
	LDS  R23,_wcnt_c+3
	CALL __SUBF12
	MOVW R26,R30
	MOVW R24,R22
	LDS  R30,_wcnt_c
	LDS  R31,_wcnt_c+1
	LDS  R22,_wcnt_c+2
	LDS  R23,_wcnt_c+3
	CALL __DIVF21
	LDS  R26,_copy
	LDS  R27,_copy+1
	LDS  R24,_copy+2
	LDS  R25,_copy+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x11:
	STS  _copy,R30
	STS  _copy+1,R31
	STS  _copy+2,R22
	STS  _copy+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x12:
	LDS  R26,_copy
	LDS  R27,_copy+1
	LDS  R24,_copy+2
	LDS  R25,_copy+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x13:
	RCALL SUBOPT_0x12
	__GETD1N 0x41200000
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x14:
	CALL _lcd_puts
	RJMP SUBOPT_0x1

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x15:
	LDS  R26,_adc_dataw
	LDS  R27,_adc_dataw+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x16:
	LDS  R30,_adc_dataw
	LDS  R31,_adc_dataw+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x17:
	RCALL SUBOPT_0x16
	STS  _adc_datawi,R30
	STS  _adc_datawi+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x18:
	MOV  R30,R4
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer)
	SBCI R31,HIGH(-_rx_buffer)
	LD   R26,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x19:
	MOV  R30,R4
	LDI  R31,0
	__ADDW1MN _rx_buffer,3
	LD   R26,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x1A:
	MOV  R30,R4
	LDI  R31,0
	__ADDW1MN _rx_buffer,4
	LD   R26,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x1B:
	MOV  R30,R4
	LDI  R31,0
	__ADDW1MN _rx_buffer,5
	LD   R26,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x1C:
	LD   R30,Z
	SUBI R30,LOW(48)
	LDI  R26,LOW(10)
	MULS R30,R26
	MOVW R30,R0
	MOV  R26,R30
	MOV  R30,R4
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1D:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1E:
	__PUTD1S 9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x1F:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,1
	STD  Y+6,R26
	STD  Y+6+1,R27
	SBIW R26,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x20:
	__GETD2S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x21:
	__GETD1N 0x3DCCCCCD
	CALL __MULF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x22:
	__PUTD1S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x23:
	__GETD1S 2
	__GETD2S 9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x24:
	__GETD1N 0x41200000
	CALL __MULF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x25:
	__GETD2S 9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x26:
	CALL __SWAPD12
	CALL __SUBF12
	RJMP SUBOPT_0x1E

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x27:
	CALL _i2c_start
	LDI  R26,LOW(208)
	JMP  _i2c_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x28:
	CALL _i2c_write
	JMP  _i2c_stop

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x29:
	LDI  R26,LOW(1)
	CALL _i2c_read
	MOV  R26,R30
	JMP  _bcd2bin

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2A:
	CALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x2B:
	LDI  R26,LOW(48)
	CALL __lcd_write_nibble_G103
	__DELAY_USW 200
	RET


	.CSEG
	.equ __sda_bit=7
	.equ __scl_bit=3
	.equ __i2c_port=0x12 ;PORTD
	.equ __i2c_dir=__i2c_port-1
	.equ __i2c_pin=__i2c_port-2

_i2c_init:
	cbi  __i2c_port,__scl_bit
	cbi  __i2c_port,__sda_bit
	sbi  __i2c_dir,__scl_bit
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_delay2
_i2c_start:
	cbi  __i2c_dir,__sda_bit
	cbi  __i2c_dir,__scl_bit
	clr  r30
	nop
	sbis __i2c_pin,__sda_bit
	ret
	sbis __i2c_pin,__scl_bit
	ret
	rcall __i2c_delay1
	sbi  __i2c_dir,__sda_bit
	rcall __i2c_delay1
	sbi  __i2c_dir,__scl_bit
	ldi  r30,1
__i2c_delay1:
	ldi  r22,13
	rjmp __i2c_delay2l
_i2c_stop:
	sbi  __i2c_dir,__sda_bit
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__sda_bit
__i2c_delay2:
	ldi  r22,27
__i2c_delay2l:
	dec  r22
	brne __i2c_delay2l
	ret
_i2c_read:
	ldi  r23,8
__i2c_read0:
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
__i2c_read3:
	sbis __i2c_pin,__scl_bit
	rjmp __i2c_read3
	rcall __i2c_delay1
	clc
	sbic __i2c_pin,__sda_bit
	sec
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	rol  r30
	dec  r23
	brne __i2c_read0
	mov  r23,r26
	tst  r23
	brne __i2c_read1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_read2
__i2c_read1:
	sbi  __i2c_dir,__sda_bit
__i2c_read2:
	rcall __i2c_delay1
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_delay1

_i2c_write:
	ldi  r23,8
__i2c_write0:
	lsl  r26
	brcc __i2c_write1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_write2
__i2c_write1:
	sbi  __i2c_dir,__sda_bit
__i2c_write2:
	rcall __i2c_delay2
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
__i2c_write3:
	sbis __i2c_pin,__scl_bit
	rjmp __i2c_write3
	rcall __i2c_delay1
	sbi  __i2c_dir,__scl_bit
	dec  r23
	brne __i2c_write0
	cbi  __i2c_dir,__sda_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	ldi  r30,1
	sbic __i2c_pin,__sda_bit
	clr  r30
	sbi  __i2c_dir,__scl_bit
	rjmp __i2c_delay1

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

	.equ __w1_port=0x12
	.equ __w1_bit=0x05

_w1_init:
	clr  r30
	cbi  __w1_port,__w1_bit
	sbi  __w1_port-1,__w1_bit
	__DELAY_USW 0x3C0
	cbi  __w1_port-1,__w1_bit
	__DELAY_USB 0x25
	sbis __w1_port-2,__w1_bit
	ret
	__DELAY_USB 0xCB
	sbis __w1_port-2,__w1_bit
	ldi  r30,1
	__DELAY_USW 0x30C
	ret

__w1_read_bit:
	sbi  __w1_port-1,__w1_bit
	__DELAY_USB 0x5
	cbi  __w1_port-1,__w1_bit
	__DELAY_USB 0x1D
	clc
	sbic __w1_port-2,__w1_bit
	sec
	ror  r30
	__DELAY_USB 0xD5
	ret

__w1_write_bit:
	clt
	sbi  __w1_port-1,__w1_bit
	__DELAY_USB 0x5
	sbrc r23,0
	cbi  __w1_port-1,__w1_bit
	__DELAY_USB 0x23
	sbic __w1_port-2,__w1_bit
	rjmp __w1_write_bit0
	sbrs r23,0
	rjmp __w1_write_bit1
	ret
__w1_write_bit0:
	sbrs r23,0
	ret
__w1_write_bit1:
	__DELAY_USB 0xC8
	cbi  __w1_port-1,__w1_bit
	__DELAY_USB 0xD
	set
	ret

_w1_read:
	ldi  r22,8
	__w1_read0:
	rcall __w1_read_bit
	dec  r22
	brne __w1_read0
	ret

_w1_write:
	mov  r23,r26
	ldi  r22,8
	clr  r30
__w1_write0:
	rcall __w1_write_bit
	brtc __w1_write1
	ror  r23
	dec  r22
	brne __w1_write0
	inc  r30
__w1_write1:
	ret

__ANEGF1:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __ANEGF10
	SUBI R23,0x80
__ANEGF10:
	RET

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__SWAPACC:
	PUSH R20
	MOVW R20,R30
	MOVW R30,R26
	MOVW R26,R20
	MOVW R20,R22
	MOVW R22,R24
	MOVW R24,R20
	MOV  R20,R0
	MOV  R0,R1
	MOV  R1,R20
	POP  R20
	RET

__UADD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	RET

__NEGMAN1:
	COM  R30
	COM  R31
	COM  R22
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	RET

__SUBF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129
	LDI  R21,0x80
	EOR  R1,R21

	RJMP __ADDF120

__ADDF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129

__ADDF120:
	CPI  R23,0x80
	BREQ __ADDF128
__ADDF121:
	MOV  R21,R23
	SUB  R21,R25
	BRVS __ADDF1211
	BRPL __ADDF122
	RCALL __SWAPACC
	RJMP __ADDF121
__ADDF122:
	CPI  R21,24
	BRLO __ADDF123
	CLR  R26
	CLR  R27
	CLR  R24
__ADDF123:
	CPI  R21,8
	BRLO __ADDF124
	MOV  R26,R27
	MOV  R27,R24
	CLR  R24
	SUBI R21,8
	RJMP __ADDF123
__ADDF124:
	TST  R21
	BREQ __ADDF126
__ADDF125:
	LSR  R24
	ROR  R27
	ROR  R26
	DEC  R21
	BRNE __ADDF125
__ADDF126:
	MOV  R21,R0
	EOR  R21,R1
	BRMI __ADDF127
	RCALL __UADD12
	BRCC __ADDF129
	ROR  R22
	ROR  R31
	ROR  R30
	INC  R23
	BRVC __ADDF129
	RJMP __MAXRES
__ADDF128:
	RCALL __SWAPACC
__ADDF129:
	RCALL __REPACK
	POP  R21
	RET
__ADDF1211:
	BRCC __ADDF128
	RJMP __ADDF129
__ADDF127:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	BREQ __ZERORES
	BRCC __ADDF1210
	COM  R0
	RCALL __NEGMAN1
__ADDF1210:
	TST  R22
	BRMI __ADDF129
	LSL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVC __ADDF1210

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R0
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R17
	CLR  R18
	CLR  R25
	MUL  R22,R24
	MOVW R20,R0
	MUL  R24,R31
	MOV  R19,R0
	ADD  R20,R1
	ADC  R21,R25
	MUL  R22,R27
	ADD  R19,R0
	ADC  R20,R1
	ADC  R21,R25
	MUL  R24,R30
	RCALL __MULF126
	MUL  R27,R31
	RCALL __MULF126
	MUL  R22,R26
	RCALL __MULF126
	MUL  R27,R30
	RCALL __MULF127
	MUL  R26,R31
	RCALL __MULF127
	MUL  R26,R30
	ADD  R17,R1
	ADC  R18,R25
	ADC  R19,R25
	ADC  R20,R25
	ADC  R21,R25
	MOV  R30,R19
	MOV  R31,R20
	MOV  R22,R21
	MOV  R21,R18
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	POP  R0
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__MULF127:
	ADD  R17,R0
	ADC  R18,R1
	ADC  R19,R25
	RJMP __MULF128
__MULF126:
	ADD  R18,R0
	ADC  R19,R1
__MULF128:
	ADC  R20,R25
	ADC  R21,R25
	RET

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __DIVF219
	RJMP __MINRES
__DIVF219:
	RJMP __MAXRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R17
	CLR  R18
	CLR  R19
	CLR  R20
	CLR  R21
	LDI  R25,32
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R20,R17
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R20,R17
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R21
	ROL  R18
	ROL  R19
	ROL  R1
	ROL  R26
	ROL  R27
	ROL  R24
	ROL  R20
	DEC  R25
	BRNE __DIVF212
	MOVW R30,R18
	MOV  R22,R1
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	TST  R22
	BRMI __DIVF215
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__CMPF12:
	TST  R25
	BRMI __CMPF120
	TST  R23
	BRMI __CMPF121
	CP   R25,R23
	BRLO __CMPF122
	BRNE __CMPF121
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	BRLO __CMPF122
	BREQ __CMPF123
__CMPF121:
	CLZ
	CLC
	RET
__CMPF122:
	CLZ
	SEC
	RET
__CMPF123:
	SEZ
	CLC
	RET
__CMPF120:
	TST  R23
	BRPL __CMPF122
	CP   R25,R23
	BRLO __CMPF121
	BRNE __CMPF122
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	BRLO __CMPF122
	BREQ __CMPF123
	RJMP __CMPF121

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__LSRW12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	BREQ __LSRW12R
__LSRW12L:
	LSR  R31
	ROR  R30
	DEC  R0
	BRNE __LSRW12L
__LSRW12R:
	RET

__CBD1:
	MOV  R31,R30
	ADD  R31,R31
	SBC  R31,R31
	MOV  R22,R31
	MOV  R23,R31
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULW12:
	RCALL __CHKSIGNW
	RCALL __MULW12U
	BRTC __MULW121
	RCALL __ANEGW1
__MULW121:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__PUTDP1:
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	RET

__GETD1S0:
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R22,Y+2
	LDD  R23,Y+3
	RET

__GETD2S0:
	LD   R26,Y
	LDD  R27,Y+1
	LDD  R24,Y+2
	LDD  R25,Y+3
	RET

__PUTD1S0:
	ST   Y,R30
	STD  Y+1,R31
	STD  Y+2,R22
	STD  Y+3,R23
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__PUTPARD2:
	ST   -Y,R25
	ST   -Y,R24
	ST   -Y,R27
	ST   -Y,R26
	RET

__SWAPD12:
	MOV  R1,R24
	MOV  R24,R22
	MOV  R22,R1
	MOV  R1,R25
	MOV  R25,R23
	MOV  R23,R1

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__CPD02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	CPC  R0,R24
	CPC  R0,R25
	RET

;END OF CODE MARKER
__END_OF_CODE:
