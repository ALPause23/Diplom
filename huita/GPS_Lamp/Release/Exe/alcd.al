;PCODE: $00000000 VOL: 0
	#ifndef __SLEEP_DEFINED__
;PCODE: $00000001 VOL: 0
	#define __SLEEP_DEFINED__
;PCODE: $00000002 VOL: 0
	.EQU __se_bit=0x40
;PCODE: $00000003 VOL: 0
	.EQU __sm_mask=0xB0
;PCODE: $00000004 VOL: 0
	.EQU __sm_powerdown=0x20
;PCODE: $00000005 VOL: 0
	.EQU __sm_powersave=0x30
;PCODE: $00000006 VOL: 0
	.EQU __sm_standby=0xA0
;PCODE: $00000007 VOL: 0
	.EQU __sm_ext_standby=0xB0
;PCODE: $00000008 VOL: 0
	.EQU __sm_adc_noise_red=0x10
;PCODE: $00000009 VOL: 0
	.SET power_ctrl_reg=mcucr
;PCODE: $0000000A VOL: 0
	#endif
;PCODE: $0000000B VOL: 0
;PCODE: $0000000C VOL: 0

	.DSEG

	.CSEG
;PCODE: $0000000D VOL: 0
;PCODE: $0000000E VOL: 0
;PCODE: $0000000F VOL: 0
;PCODE: $00000010 VOL: 0
;PCODE: $00000011 VOL: 0
;PCODE: $00000012 VOL: 0
;PCODE: $00000013 VOL: 0
;PCODE: $00000014 VOL: 0
;PCODE: $00000015 VOL: 0
;PCODE: $00000016 VOL: 0
;PCODE: $00000017 VOL: 0
;PCODE: $00000018 VOL: 0
;PCODE: $00000019 VOL: 0
;PCODE: $0000001A VOL: 0
;PCODE: $0000001B VOL: 0
;PCODE: $0000001C VOL: 0
;PCODE: $0000001D VOL: 0
;PCODE: $0000001E VOL: 0
;PCODE: $0000001F VOL: 0
;PCODE: $00000020 VOL: 0
;PCODE: $00000021 VOL: 0
;PCODE: $00000022 VOL: 0
;PCODE: $00000023 VOL: 0
;PCODE: $00000024 VOL: 0
;PCODE: $00000025 VOL: 0
;PCODE: $00000026 VOL: 0
;PCODE: $00000027 VOL: 0
;PCODE: $00000028 VOL: 0
;PCODE: $00000029 VOL: 0
;PCODE: $0000002A VOL: 0
;PCODE: $0000002B VOL: 0
;PCODE: $0000002C VOL: 0
;PCODE: $0000002D VOL: 0
;PCODE: $0000002E VOL: 0
;PCODE: $0000002F VOL: 0
;PCODE: $00000030 VOL: 0
;PCODE: $00000031 VOL: 0
;PCODE: $00000032 VOL: 0
;PCODE: $00000033 VOL: 0
;PCODE: $00000034 VOL: 0
;PCODE: $00000035 VOL: 0
;PCODE: $00000036 VOL: 0
;PCODE: $00000037 VOL: 0
;PCODE: $00000038 VOL: 0
;PCODE: $00000039 VOL: 0
;PCODE: $0000003A VOL: 0
;PCODE: $0000003B VOL: 0
;PCODE: $0000003C VOL: 0
;PCODE: $0000003D VOL: 0
;PCODE: $0000003E VOL: 0
;PCODE: $0000003F VOL: 0
;PCODE: $00000040 VOL: 0
;PCODE: $00000041 VOL: 0
;PCODE: $00000042 VOL: 0
;PCODE: $00000043 VOL: 0
;PCODE: $00000044 VOL: 0
;PCODE: $00000045 VOL: 0
;PCODE: $00000046 VOL: 0
;PCODE: $00000047 VOL: 0
    ld    r30,y
;PCODE: $00000048 VOL: 0
    swap  r30
;PCODE: $00000049 VOL: 0
    st    y,r30
;PCODE: $0000004A VOL: 0
;PCODE: $0000004B VOL: 0
;PCODE: $0000004C VOL: 0
;PCODE: $0000004D VOL: 0
;PCODE: $0000004E VOL: 0
;PCODE: $0000004F VOL: 0
;PCODE: $00000050 VOL: 0
;PCODE: $00000051 VOL: 0
;PCODE: $00000052 VOL: 0
;PCODE: $00000053 VOL: 0
;PCODE: $00000054 VOL: 0
;PCODE: $00000055 VOL: 0
;PCODE: $00000056 VOL: 0
;PCODE: $00000057 VOL: 0
;PCODE: $00000058 VOL: 0
;PCODE: $00000059 VOL: 0
;PCODE: $0000005A VOL: 0
;PCODE: $0000005B VOL: 0
;PCODE: $0000005C VOL: 0
;PCODE: $0000005D VOL: 0
;PCODE: $0000005E VOL: 0
;PCODE: $0000005F VOL: 0
;PCODE: $00000060 VOL: 0
;PCODE: $00000061 VOL: 0
;PCODE: $00000062 VOL: 0
;PCODE: $00000063 VOL: 0
;PCODE: $00000064 VOL: 0
;PCODE: $00000065 VOL: 0
;PCODE: $00000066 VOL: 0
;PCODE: $00000067 VOL: 0
;PCODE: $00000068 VOL: 0
;PCODE: $00000069 VOL: 0
;PCODE: $0000006A VOL: 0
;PCODE: $0000006B VOL: 0
;PCODE: $0000006C VOL: 0
;PCODE: $0000006D VOL: 0
;PCODE: $0000006E VOL: 0
;PCODE: $0000006F VOL: 0
;PCODE: $00000070 VOL: 0
;PCODE: $00000071 VOL: 0
;PCODE: $00000072 VOL: 0
;PCODE: $00000073 VOL: 0
;PCODE: $00000074 VOL: 0
;PCODE: $00000075 VOL: 0
;PCODE: $00000076 VOL: 0
;PCODE: $00000077 VOL: 0
;PCODE: $00000078 VOL: 0
;PCODE: $00000079 VOL: 0
;PCODE: $0000007A VOL: 0
;PCODE: $0000007B VOL: 0
;PCODE: $0000007C VOL: 0
;PCODE: $0000007D VOL: 0
;PCODE: $0000007E VOL: 0
;PCODE: $0000007F VOL: 0
;PCODE: $00000080 VOL: 0
;PCODE: $00000081 VOL: 0
;PCODE: $00000082 VOL: 0
;PCODE: $00000083 VOL: 0
;PCODE: $00000084 VOL: 0
;PCODE: $00000085 VOL: 0
;PCODE: $00000086 VOL: 0
;PCODE: $00000087 VOL: 0
;PCODE: $00000088 VOL: 0
;PCODE: $00000089 VOL: 0
;PCODE: $0000008A VOL: 0
;PCODE: $0000008B VOL: 0
;PCODE: $0000008C VOL: 0
;PCODE: $0000008D VOL: 0
;PCODE: $0000008E VOL: 0
;PCODE: $0000008F VOL: 0
;PCODE: $00000090 VOL: 0
;PCODE: $00000091 VOL: 0
;PCODE: $00000092 VOL: 0
;PCODE: $00000093 VOL: 0
;PCODE: $00000094 VOL: 0
;PCODE: $00000095 VOL: 0
;PCODE: $00000096 VOL: 0
;PCODE: $00000097 VOL: 0
;PCODE: $00000098 VOL: 0
;PCODE: $00000099 VOL: 0
;PCODE: $0000009A VOL: 0
;PCODE: $0000009B VOL: 0
;PCODE: $0000009C VOL: 0
;PCODE: $0000009D VOL: 0
;PCODE: $0000009E VOL: 0
;PCODE: $0000009F VOL: 0
;PCODE: $000000A0 VOL: 0
;PCODE: $000000A1 VOL: 0
;PCODE: $000000A2 VOL: 0
;PCODE: $000000A3 VOL: 0
;PCODE: $000000A4 VOL: 0
;PCODE: $000000A5 VOL: 0
;PCODE: $000000A6 VOL: 0
;PCODE: $000000A7 VOL: 0
;PCODE: $000000A8 VOL: 0
;PCODE: $000000A9 VOL: 0
;PCODE: $000000AA VOL: 0
;PCODE: $000000AB VOL: 0
;PCODE: $000000AC VOL: 0
;PCODE: $000000AD VOL: 0
;PCODE: $000000AE VOL: 0
;PCODE: $000000AF VOL: 0
;PCODE: $000000B0 VOL: 0
;PCODE: $000000B1 VOL: 0
;PCODE: $000000B2 VOL: 0
;PCODE: $000000B3 VOL: 0
;PCODE: $000000B4 VOL: 0
;PCODE: $000000B5 VOL: 0
;PCODE: $000000B6 VOL: 0
;PCODE: $000000B7 VOL: 0
;PCODE: $000000B8 VOL: 0
;PCODE: $000000B9 VOL: 0
;PCODE: $000000BA VOL: 0
;PCODE: $000000BB VOL: 0
;PCODE: $000000BC VOL: 0
;PCODE: $000000BD VOL: 0
;PCODE: $000000BE VOL: 0
;PCODE: $000000BF VOL: 0
;PCODE: $000000C0 VOL: 0
;PCODE: $000000C1 VOL: 0
;PCODE: $000000C2 VOL: 0
;PCODE: $000000C3 VOL: 0
;PCODE: $000000C4 VOL: 0
;PCODE: $000000C5 VOL: 0
;PCODE: $000000C6 VOL: 0
;PCODE: $000000C7 VOL: 0
;PCODE: $000000C8 VOL: 0
;PCODE: $000000C9 VOL: 0
;PCODE: $000000CA VOL: 0
;PCODE: $000000CB VOL: 0
;PCODE: $000000CC VOL: 0
;PCODE: $000000CD VOL: 0
;PCODE: $000000CE VOL: 0
;PCODE: $000000CF VOL: 0
;PCODE: $000000D0 VOL: 0
;PCODE: $000000D1 VOL: 0
;PCODE: $000000D2 VOL: 0
;PCODE: $000000D3 VOL: 0
;PCODE: $000000D4 VOL: 0
;PCODE: $000000D5 VOL: 0
;PCODE: $000000D6 VOL: 0
;PCODE: $000000D7 VOL: 0
;PCODE: $000000D8 VOL: 0
;PCODE: $000000D9 VOL: 0
;PCODE: $000000DA VOL: 0
;PCODE: $000000DB VOL: 0
;PCODE: $000000DC VOL: 0
;PCODE: $000000DD VOL: 0
;PCODE: $000000DE VOL: 0
;PCODE: $000000DF VOL: 0
;PCODE: $000000E0 VOL: 0
;PCODE: $000000E1 VOL: 0
;PCODE: $000000E2 VOL: 0
;PCODE: $000000E3 VOL: 0
;PCODE: $000000E4 VOL: 0
;PCODE: $000000E5 VOL: 0
;PCODE: $000000E6 VOL: 0
;PCODE: $000000E7 VOL: 0
;PCODE: $000000E8 VOL: 0
;PCODE: $000000E9 VOL: 0
;PCODE: $000000EA VOL: 0
;PCODE: $000000EB VOL: 0
;PCODE: $000000EC VOL: 0
;PCODE: $000000ED VOL: 0
;PCODE: $000000EE VOL: 0
;PCODE: $000000EF VOL: 0
;PCODE: $000000F0 VOL: 0
;PCODE: $000000F1 VOL: 0
;PCODE: $000000F2 VOL: 0
;PCODE: $000000F3 VOL: 0
;PCODE: $000000F4 VOL: 0
;PCODE: $000000F5 VOL: 0
;PCODE: $000000F6 VOL: 0
;PCODE: $000000F7 VOL: 0
;PCODE: $000000F8 VOL: 0
;PCODE: $000000F9 VOL: 0
;PCODE: $000000FA VOL: 0
;PCODE: $000000FB VOL: 0
;PCODE: $000000FC VOL: 0
;PCODE: $000000FD VOL: 0
;PCODE: $000000FE VOL: 0
;PCODE: $000000FF VOL: 0
;PCODE: $00000100 VOL: 0
;PCODE: $00000101 VOL: 0
;PCODE: $00000102 VOL: 0
;PCODE: $00000103 VOL: 0
;PCODE: $00000104 VOL: 0
;PCODE: $00000105 VOL: 0
;PCODE: $00000106 VOL: 0
;PCODE: $00000107 VOL: 0
;PCODE: $00000108 VOL: 0
;PCODE: $00000109 VOL: 0
;PCODE: $0000010A VOL: 0
;PCODE: $0000010B VOL: 0
;PCODE: $0000010C VOL: 0
;PCODE: $0000010D VOL: 0
;PCODE: $0000010E VOL: 0
;PCODE: $0000010F VOL: 0
;PCODE: $00000110 VOL: 0
;PCODE: $00000111 VOL: 0
;PCODE: $00000112 VOL: 0
;PCODE: $00000113 VOL: 0
;PCODE: $00000114 VOL: 0
;PCODE: $00000115 VOL: 0
;PCODE: $00000116 VOL: 0
;PCODE: $00000117 VOL: 0
;PCODE: $00000118 VOL: 0
;PCODE: $00000119 VOL: 0
;PCODE: $0000011A VOL: 0
;PCODE: $0000011B VOL: 0
;PCODE: $0000011C VOL: 0
;PCODE: $0000011D VOL: 0
;PCODE: $0000011E VOL: 0
;PCODE: $0000011F VOL: 0
;PCODE: $00000120 VOL: 0
;PCODE: $00000121 VOL: 0
;PCODE: $00000122 VOL: 0
;PCODE: $00000123 VOL: 0
;PCODE: $00000124 VOL: 0
;PCODE: $00000125 VOL: 0
;PCODE: $00000126 VOL: 0
;PCODE: $00000127 VOL: 0
;PCODE: $00000128 VOL: 0
;PCODE: $00000129 VOL: 0
;PCODE: $0000012A VOL: 0
;PCODE: $0000012B VOL: 0
;PCODE: $0000012C VOL: 0
;PCODE: $0000012D VOL: 0
;PCODE: $0000012E VOL: 0
;PCODE: $0000012F VOL: 0
;PCODE: $00000130 VOL: 0
;PCODE: $00000131 VOL: 0
;PCODE: $00000132 VOL: 0
;PCODE: $00000133 VOL: 0
;PCODE: $00000134 VOL: 0
;PCODE: $00000135 VOL: 0
;PCODE: $00000136 VOL: 0
;PCODE: $00000137 VOL: 0
;PCODE: $00000138 VOL: 0
;PCODE: $00000139 VOL: 0
;PCODE: $0000013A VOL: 0
;PCODE: $0000013B VOL: 0
;PCODE: $0000013C VOL: 0
;PCODE: $0000013D VOL: 0
;PCODE: $0000013E VOL: 0
;PCODE: $0000013F VOL: 0
;PCODE: $00000140 VOL: 0
;PCODE: $00000141 VOL: 0
;PCODE: $00000142 VOL: 0
;PCODE: $00000143 VOL: 0
;PCODE: $00000144 VOL: 0
;PCODE: $00000145 VOL: 0
;PCODE: $00000146 VOL: 0
;PCODE: $00000147 VOL: 0
;PCODE: $00000148 VOL: 0
;PCODE: $00000149 VOL: 0
;PCODE: $0000014A VOL: 0
;PCODE: $0000014B VOL: 0
;PCODE: $0000014C VOL: 0
;PCODE: $0000014D VOL: 0
;PCODE: $0000014E VOL: 0
;PCODE: $0000014F VOL: 0
;PCODE: $00000150 VOL: 0
;PCODE: $00000151 VOL: 0
;PCODE: $00000152 VOL: 0
;PCODE: $00000153 VOL: 0
;PCODE: $00000154 VOL: 0
;PCODE: $00000155 VOL: 0
;PCODE: $00000156 VOL: 0
;PCODE: $00000157 VOL: 0
;PCODE: $00000158 VOL: 0
;PCODE: $00000159 VOL: 0
;PCODE: $0000015A VOL: 0
;PCODE: $0000015B VOL: 0
;PCODE: $0000015C VOL: 0
;PCODE: $0000015D VOL: 0
;PCODE: $0000015E VOL: 0
;PCODE: $0000015F VOL: 0
;PCODE: $00000160 VOL: 0
;PCODE: $00000161 VOL: 0
;PCODE: $00000162 VOL: 0
;PCODE: $00000163 VOL: 0
;PCODE: $00000164 VOL: 0
;PCODE: $00000165 VOL: 0
;PCODE: $00000166 VOL: 0
;PCODE: $00000167 VOL: 0
;PCODE: $00000168 VOL: 0
;PCODE: $00000169 VOL: 0
;PCODE: $0000016A VOL: 0
;PCODE: $0000016B VOL: 0
;PCODE: $0000016C VOL: 0
;PCODE: $0000016D VOL: 0
;PCODE: $0000016E VOL: 0
;PCODE: $0000016F VOL: 0
;PCODE: $00000170 VOL: 0
;PCODE: $00000171 VOL: 0
;PCODE: $00000172 VOL: 0
;PCODE: $00000173 VOL: 0
;PCODE: $00000174 VOL: 0
;PCODE: $00000175 VOL: 0
;PCODE: $00000176 VOL: 0
;PCODE: $00000177 VOL: 0
;PCODE: $00000178 VOL: 0
