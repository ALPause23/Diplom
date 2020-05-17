/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 27.06.2018
Author  : 
Company : 
Comments: 


Chip type               : ATmega16
Program type            : Application
AVR Core Clock frequency: 8,000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*******************************************************/

#include <mega16.h>

#include <delay.h>

// I2C Bus functions
#include <i2c.h>


#include <stdlib.h>

// 1 Wire Bus interface functions
#include <1wire.h>

// DS1820 Temperature Sensor functions
#include <ds1820.h>


#include <ds1307.h>

// Alphanumeric LCD functions
#include <alcd.h>

// Standard Input/Output functions
#include <stdio.h>

#define adc_on ADCSRA|=0x80
 
#define adc_off ADCSRA &=(~0x80) 

#define min_u 115

#define max_u 148


// Declare your global variables here

unsigned char work_gps;
unsigned char i;

unsigned char temp_msb;
unsigned char temp_lsb;
unsigned char ed_speed;
unsigned char deset_speed;
unsigned char soten_speed;



unsigned char sum_hours;

unsigned char j;

unsigned char ed_min_clock;
unsigned char decet_min_clock;
unsigned char ed_hours_clock;
unsigned char decet_Hours_clock;

unsigned char h;
unsigned char m;
unsigned char s;

unsigned char st;

unsigned char st_v;

unsigned char st_po;
unsigned int  err;

unsigned char ;
unsigned char counter;
unsigned char work;
unsigned char test;
unsigned char es_gps;

unsigned char cnt_rem;
unsigned char cnt_c;
unsigned char error;

unsigned char kvadrat;
//unsigned char kvad;
//unsigned char kv;
//unsigned char wrx;

unsigned char decet_sek_clock;
unsigned char alarm_u;
   unsigned char c; 
   unsigned char t; 
     unsigned char s;
 unsigned int  metr;  
    unsigned char ts; 
     unsigned char tm;  
     
       unsigned char st_s; 
    unsigned char r;    
      unsigned char met;  
     
  unsigned int adc_dataw;
  unsigned int adc_data;
  unsigned int adc_datawi;
   unsigned char cout_in;    
     
     
    
 // unsigned int  crrc; 
 //   unsigned int  crrw;
  



float  copy;
float  wcnt_rem;
float wcnt_c;


bit flag;

unsigned char lcd_buf[16]; 

unsigned char speed_array[10];

unsigned char speed[]={0x00,0x01,0x02,0x03,0x40,0x41,0x42,0x43,0x80,0x81};

   
 
  
 /*  
       
 
 
 
 
 int calc_NMEA_Checksum( char *buf, int cnt )
 { char Character; 
int Checksum = 0;
 int i; // loop counter //foreach(char Character in sentence) 
for (i=0;i<cnt;++i) { 
Character = buf[i]; 
switch(Character) 
{case'$': 
// Ignore the dollar sign 
break; 
case '*': // Stop processing before the asterisk
 i = cnt; 
continue; 
default: // Is this the first value for the checksum? 
if (Checksum == 0) { 
// Yes. Set the checksum to the value
 Checksum = Character; } else 
{ 
// No. XOR the checksum with this character value
 Checksum = Checksum ^ Character; } 
break; }
 } // Return the checksum 
return (Checksum); 
} // 

 
 
  */
 
 

  #define DATA_REGISTER_EMPTY (1<<UDRE)
#define RX_COMPLETE (1<<RXC)
#define FRAMING_ERROR (1<<FE)
#define PARITY_ERROR (1<<UPE)
#define DATA_OVERRUN (1<<DOR)

// USART Receiver buffer
#define RX_BUFFER_SIZE 100
char rx_buffer[RX_BUFFER_SIZE];

#if RX_BUFFER_SIZE < 256
unsigned char rx_wr_index=0,rx_rd_index=0;
#else
unsigned int rx_wr_index=0,rx_rd_index=0;
#endif

#if RX_BUFFER_SIZE < 256
unsigned char rx_counter=0;
#else
unsigned int rx_counter=0;
#endif

// This flag is set on USART Receiver buffer overflow
bit rx_buffer_overflow;

// USART Receiver interrupt service routine
interrupt [USART_RXC] void usart_rx_isr(void)
{
char status,data;
status=UCSRA;
data=UDR;
if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
   {
   rx_buffer[rx_wr_index++]=data;
#if RX_BUFFER_SIZE == 255
   // special case for receiver buffer size=256
   if (++rx_counter == 0) rx_buffer_overflow=1;
#else
   if (rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
   if (++rx_counter == RX_BUFFER_SIZE)
      {
      rx_counter=0;
      rx_buffer_overflow=1;
      }
#endif
   }  
 
  
                                       
   if( met>0) 
        {
        ++met;
      if( met==3) 
      {
       work_gps=1;
                  return;
                  } 
                  }
   if (data=='*')  
     
       met=1;
       
     
    }
   
  
#ifndef _DEBUG_TERMINAL_IO_
// Get a character from the USART Receiver buffer
#define _ALTERNATE_GETCHAR_
#pragma used+
char getchar(void)
{
char data;
while (rx_counter==0);
data=rx_buffer[rx_rd_index++];
#if RX_BUFFER_SIZE != 256
if (rx_rd_index == RX_BUFFER_SIZE) rx_rd_index=0;
#endif
#asm("cli")
--rx_counter;
#asm("sei")
return data;
}
#pragma used-
#endif


   #include <string.h> 
   
   
  void reset (void)
     {
     
      
     // #asm("sei")
    // TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B)
 //    | (1<<TOIE1) | (0<<OCIE0) | (1<<TOIE0);   
      work_gps=0;
             rx_wr_index=0; 
       //   kvad=0;   
         //  wrx=0;  
         memset(rx_buffer,0,RX_BUFFER_SIZE);     
             
                          }    
                          
      void lcd_d (void) 
  {
    if (rx_buffer [i+1]=='0')
               lcd_putchar(rx_buffer [i+2]);
                     else
               {
             lcd_putchar(rx_buffer [i+1]); 
               lcd_putchar(rx_buffer [i+2]);
                       }
         // lcd_puts(lcd_buf);
            lcd_putchar(0X20);  
          }  
                     
                          
                          
                          
                          
                          
                           
  void tim(void)
  {   
  
      ++st_s;
      if(st_s==2 || st_s==11)
      {
         
        //   UCSRB &=~(1<<RXCIE);
      
      
      rtc_get_time(&h,&m,&s);  
         if (s==0 || st_s==11)
         
          {
   
    decet_Hours_clock=h/10;
    ed_hours_clock=h%10;
    decet_min_clock=m/10;
    ed_min_clock=m%10;
                  }


           
          st_s=0; 
          //  UCSRB|=(1<<RXCIE); 
            //  reset();
              
            }

    if(es_gps==0 && test==0)
    
    {  
    
     switch(kvadrat)
     {
       case 0:
               flag=1;                     
   while(flag==1){}  
        lcd_gotoxy(0,0);
lcd_puts(" ");
   lcd_gotoxy(6,0);
lcd_puts(" ");


           kvadrat++;
              break;
         case 1:   
         
          
         
         
               flag=1;                     
   while(flag==1){}
        lcd_gotoxy(0,0);
lcd_puts(">");
   lcd_gotoxy(6,0);
lcd_puts("<"); 
       kvadrat=0; 
          
         
    if(++ts==60)
    {
    ts=0;  
     ++tm;  
    flag=1;                     
   while(flag==1){}
       lcd_gotoxy(2,0); 
      if(tm<10)  
           lcd_gotoxy(2,0);
           else
            lcd_gotoxy(1,0);
        
            itoa(tm,lcd_buf); 
                 lcd_puts(lcd_buf);
   flag=1;                     
   while(flag==1){}             }
      lcd_gotoxy(4,0); 
      if(ts<10)
         lcd_puts("0");
        
            itoa(ts,lcd_buf); 
                 lcd_puts(lcd_buf);
         
         
       
             break;
         
         
         
      
               }
               }  
               
   if(alarm_u>0)
     {            
        

     switch(c)
    {  
    case 0:
              flag=1;                     
   while(flag==1){}
  lcd_gotoxy(12,1);
lcd_puts("    ");

 c++;
break;

 case 1:
 
        
                     
   ftoa((float)adc_datawi/10,1,lcd_buf);  
                      flag=1;                     
   while(flag==1){}
         lcd_gotoxy(12,1);      
      lcd_puts(lcd_buf); c=0;;

   break;
      }    
   
      }
  
   } 
       
    
    
// External Interrupt 0 service routine
interrupt [EXT_INT0] void ext_int0_isr(void)
{
// Place your code here
   work=1;

      
      }

// Standard Input/Output functions
#include <stdio.h>

// Timer 0 overflow interrupt service routine
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
// Reinitialize Timer 0 value
//TCNT0=0x64;
// Place your code here
     
        PORTA=0;
     counter++;  
     
  
     
     
switch (counter) 
{
   
 case 1:  if (soten_speed==0 && test==0)return;
 
 PORTA.1=1; PORTC=speed[soten_speed];
     break;
 case 2:  if (deset_speed==0 && soten_speed==0 && test==0)return;
 
 PORTA.2=1; PORTC=speed[deset_speed];
     break;
 case 3:  if(test==0 && es_gps==0) return;

 PORTA.3=1; PORTC=speed[ed_speed];
     break;  
 case 4: if(test==0 && decet_Hours_clock ==0)return;
     PORTA.4=1; PORTC=speed[decet_Hours_clock];
     break; 
 case 5: 
 PORTA.5=1; PORTC=speed[ed_hours_clock];
     break;      
 case 6: 
 PORTA.6=1; PORTC=speed[decet_min_clock];
     break;     
 case 7: counter=0;
   
 PORTA.7=1; PORTC=speed[ed_min_clock];   
       
     break;     
        }
     
     
  flag=0;      
     
}



 





// Voltage Reference: Int., cap. on AREF
#define ADC_VREF_TYPE ((1<<REFS1) | (1<<REFS0) | (0<<ADLAR))

// ADC interrupt service routine
interrupt [ADC_INT] void adc_isr(void)
{

// Read the AD conversion result
adc_data=ADCW;
// Place your code here
    work=3;

     
}

void main(void)
{
// Declare your local variables here

// Input/Output Ports initialization
// Port A initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=In 
DDRA=(1<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) | (1<<DDA3) | (1<<DDA2) | (1<<DDA1) | (0<<DDA0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=T 
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

// Port B initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

// Port C initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

// Port D initialization
// Function: Bit7=Out Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRD=(1<<DDD7) | (1<<DDD6) | (1<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
// State: Bit7=0 Bit6=T Bit5=P Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (1<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: Timer 0 Stopped
// Mode: Normal top=0xFF
// OC0 output: Disconnected
TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (1<<CS01) | (1<<CS00);
TCNT0=0x64;
OCR0=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: 31,250 kHz
// Mode: Normal top=0xFFFF
// OC1A output: Disconnected
// OC1B output: Disconnected
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer Period: 2 s
// Timer1 Overflow Interrupt: On
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer2 Stopped
// Mode: Normal top=0xFF
// OC2 output: Disconnected
ASSR=0<<AS2;
TCCR2=(0<<PWM2) | (0<<COM21) | (0<<COM20) | (0<<CTC2) | (1<<CS22) | (1<<CS21) | (1<<CS20);
TCNT2=0x00;
OCR2=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (1<<TOIE0);


// External Interrupt(s) initialization
// INT0: On
// INT0 Mode: Any change
// INT1: Off
// INT2: Off
GICR|=(0<<INT1) | (0<<INT0) | (0<<INT2);
MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (1<<ISC00);
MCUCSR=(0<<ISC2);
GIFR=(0<<INTF1) | (0<<INTF0) | (0<<INTF2);

// USART initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART Receiver: On
// USART Transmitter: On
// USART Mode: Asynchronous
// USART Baud Rate: 9600
UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
UCSRB=(1<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (1<<RXEN) | (1<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
UCSRC=(1<<URSEL) | (0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
UBRRH=0x00;
UBRRL=0x33;

// Analog Comparator initialization
// Analog Comparator: Off
// The Analog Comparator's positive input is
// connected to the AIN0 pin
// The Analog Comparator's negative input is
// connected to the AIN1 pin
ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);

// ADC initialization
// ADC Clock frequency: 250,000 kHz
// ADC Voltage Reference: Int., cap. on AREF
// ADC Auto Trigger Source: Free Running
//ADMUX=0;
//ADCSRA=(0<<ADEN) | (0<<ADSC) | (1<<ADATE) | (0<<ADIF) | (1<<ADIE) | (1<<ADPS2) | (0<<ADPS1) | (1<<ADPS0);
//SFIOR=(0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);

   // ADC initialization
// ADC Clock frequency: 125,000 kHz
// ADC Voltage Reference: AREF pin
// ADC Auto Trigger Source: Timer0 Overflow
ADMUX=0xC0;
ADCSRA=(0<<ADEN) | (0<<ADSC) | (1<<ADATE) | (0<<ADIF) | (0<<ADIE)
 | (1<<ADPS2) | (0<<ADPS1) | (1<<ADPS0);
//ADCSRA=0x2E;
SFIOR&=0x1F;
SFIOR|=0x80;

// SPI initialization
// SPI disabled
SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<1) | (0<<0);

// TWI initialization
// TWI disabled
TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);

// Bit-Banged I2C Bus initialization
// I2C Port: PORTD
// I2C SDA bit: 1
// I2C SCL bit: 3
// Bit Rate: 100 kHz
// Note: I2C settings are specified in the
// Project|Configure|C Compiler|Libraries|I2C menu.
i2c_init();

// 1 Wire Bus initialization
// 1 Wire Data port: PORTD
// 1 Wire Data bit: 5
// Note: 1 Wire port settings are specified in the
// Project|Configure|C Compiler|Libraries|1 Wire menu.
w1_init();


// DS1307 Real Time Clock initialization
// Square wave output on pin SQW/OUT: On
// Square wave frequency: 1Hz
rtc_init(0,1,0);

// Alphanumeric LCD initialization
// Connections are specified in the
// Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
// RS - PORTB Bit 0
// RD - PORTB Bit 1
// EN - PORTB Bit 2
// D4 - PORTB Bit 3
// D5 - PORTB Bit 4
// D6 - PORTB Bit 5
// D7 - PORTB Bit 6
// Characters/line: 8
lcd_init(16);

// Global enable interrupts


  test=1;

 lcd_gotoxy(0,0);
lcd_puts("GPS info system");

lcd_gotoxy(0,1);
lcd_puts("Ver. 18.04.2019");
   delay_ms(1000);
  lcd_clear(); 
  
 
 
 
 lcd_gotoxy(1,0);
lcd_puts("M8030 NEO-M8N");

 
lcd_gotoxy(1,1);
lcd_puts("FLASH  BN-280");

  
 delay_ms(1000);
  lcd_clear();    
   
 


 
 
lcd_gotoxy(3,0);
lcd_puts("PSA  Groupe"); 
 
  lcd_gotoxy(3,1);
lcd_puts("PEUGEOT 307");

 






    
    if(PIND.4==0)

             rtc_set_time(9,0,0);  
             
    #asm("sei")         
             
             
         // zvuk(); 
      putchar('v'); 
      
  //    PORTA=0;    
          
   //   #asm("cli")      
           
            
                
              
             for(j=0;j<10;j++) 
          {
          
          deset_speed=j; 
          ed_speed=j;
         if(j<2) soten_speed=j;
         if(j<3) decet_Hours_clock=j; 
          if(j<6)decet_min_clock=j; 
            ed_min_clock=j; 
          
          ed_hours_clock=j; 
           delay_ms(200); 
           
     }   
     
                  
          
          delay_ms(500);
 
          
             test=0; 
           
        soten_speed = 0;
            deset_speed= 0;
              ed_speed= 0;   
              
   
            
      lcd_clear();  
      
          
       
     lcd_gotoxy(3,0);
        
        lcd_puts(":");
       
        lcd_gotoxy(10,0);
        
        lcd_puts("S=");
        
      
       lcd_gotoxy(0,1);
       
      lcd_puts("t="); 
      
        lcd_gotoxy(10,1);
      lcd_puts("V=");
      
       
            ADCSRA|= (1<<ADIE);
            
           
   GICR|=(0<<INT1) | (1<<INT0) | (0<<INT2);           
   GIFR=(0<<INTF1) | (1<<INTF0) | (0<<INTF2);                         
                         
            st_s=10;     
           
     /*         
           
        
   ftoa(copy/10,1,lcd_buf);  
 
      
         soten_speed = 0;
            deset_speed= 0;
              ed_speed= 0; 
    
 if(copy >0) 
 { 
   // strcpy( lcd_buf1, lcd_buf);
 
 for(i=9;i<255;i--) 
 
    lcd_buf[i+1]= lcd_buf[i];
    
    
  lcd_buf[0]='+';  
  
      } 
      
  lcd_puts(lcd_buf);      
        
     */   
     
    //   #asm("sei")
       
while (1)
      {
      // Place your code here   
       // Place your code here   
m1: 
  

      
   while(work==0 && work_gps==0){}; 
   
   
      
       
   switch(work)  
   
   
   {
   case 1: 
   tim();  
      ++st;
   if(st==2)
   { 
   flag=1;
   while(flag==1){}
    w1_init();
 w1_write(0xCC);
   w1_write(0x44); 
      
    adc_on;
    work=3;  
           
           
            continue;
  
      }
     if(st==4)
     {
       st=0;
        work=2;
       continue;
       }
    work=0;
    break; 
    
    
    case 2: 
    
     flag=1;
   while(flag==1){}
  error = w1_init(); 
  
  if(error==1)
  {
 w1_write(0xCC);   
 w1_write(0xbe);
         temp_lsb=w1_read();
         temp_msb=w1_read();
         w1_read();
         w1_read();
         w1_read();
         w1_read();       
         flag=1;
   while(flag==1){}    
         
         cnt_rem=w1_read();; 
         cnt_c=w1_read();
          w1_read();
          
          if (temp_msb>0) 
         
          temp_lsb = ~ temp_lsb;
          
          temp_lsb = temp_lsb >>1;
           copy =  temp_lsb; 
           wcnt_rem =  cnt_rem;
           wcnt_c = cnt_c;
       if(temp_msb==0)  
       {    copy = copy - 0.25; 
            copy+=(wcnt_c -wcnt_rem)/wcnt_c;
             }  
            else
             {  
              copy = copy + 1.25; 
              copy-=(wcnt_c -wcnt_rem)/wcnt_c; 
              copy*=-1;
             
           }  
           
       copy*=10;   
       
       
  //     intf(lcd_buf,"t=%.1f", copy/10);
               
   ftoa(copy/10,1,lcd_buf);  
   
   
   //#asm("cli")
 
     
       
    //  lcd_puts("t=");
      
  
 if(copy >0) 
 { 
   // strcpy( lcd_buf1, lcd_buf);
 
 for(t=9;t<255;t--) 
 
    lcd_buf[t+1]= lcd_buf[t];
    
    
  lcd_buf[0]='+';  
  
      }  
      
       flag=1;
   while(flag==1){}
      
     lcd_gotoxy(2,1);
      
  lcd_puts(lcd_buf); 
  
  lcd_putchar(0xDF);
  lcd_putchar(0x43); 
  lcd_putchar(0x20); 
   // lcd_puts("*C ");
    
        }
        
        else
        {  
        
   flag=1;                     
   while(flag==1){}
          lcd_gotoxy(2,1);
                     //+55.9*c
             lcd_puts("ERROR  ");  
             
                    } 
    //  #asm("sei")              
                    
           
           
           
          
        if(es_gps > 0) 
        {           
        
      if(st_po<3)
     { 
       ++st_po;  
      
        
           if(st_po==3)
            {  
            ++st_po; 
            flag=1;
   while(flag==1){} 
            
            lcd_gotoxy(0,0);
             lcd_puts("               ");
           
                lcd_gotoxy(0,0);     
          lcd_puts("N=   S=");  
           
        
             }
            }    
      ++err;
          
        switch(err)
        {
        
          case 3: 
          
          es_gps =1; 
          
         
         
        UCSRB &=~(1<<RXCIE);
             
            soten_speed = 0;
            deset_speed= 0;
              ed_speed= 0; 
              
             // #asm("cli")
             
              flag=1;
   while(flag==1){}  
              putchar('n'); 
             lcd_gotoxy(0,0);
         lcd_puts("                ");
             lcd_gotoxy(0,0);
          lcd_puts("  NO SIGNAL"); 
             
        //  #asm("sei")
    // zvuk();
          
                 break;
                
         case 5:
         
           es_gps =0;         
           err = 0;  
           st_po=0;
            
              UCSRB|=(1<<RXCIE);  
              
          //       #asm("cli") 
                 
                flag=1;
   while(flag==1){}  
               lcd_gotoxy(0,0); 
          lcd_puts("                "); 
          lcd_gotoxy(3,0);
        
        lcd_puts(":"); 
       
        lcd_gotoxy(10,0);
        
        lcd_puts("S=");  
        
       //  #asm("sei")
           
         
            break; 
       }   
         }        
           
           
           
        adc_on;    
         
         
           work=3;    
           
           
            continue; 
            
            
  case 3: 
  
   if(st_v<3)  
     {
      ++st_v;
       goto m3;
       }
  
   adc_dataw+=adc_data; 
          if( cout_in<8)
                   adc_on;
            if (++cout_in==8)
          {   
              
           adc_off;  
     
         adc_dataw=adc_dataw>>5;
       // adc_dataw=adc_dataw>>2;
            cout_in=0;  
              
               
             ftoa((float)adc_dataw/10,1,lcd_buf);
             flag=1;
   while(flag==1){}   
 
         lcd_gotoxy(12,1);      
      lcd_puts(lcd_buf); 
            
          if(( adc_dataw <= min_u || adc_dataw >= max_u )&& alarm_u==0)
          
          {
        alarm_u=1; 
              adc_datawi=adc_dataw;
                 putchar('b');  
                       
                       }        
           
             
        if(( adc_dataw > min_u && adc_dataw < max_u )&&  alarm_u==1)
        
               {
                 
               alarm_u=0;  
               
                  ftoa((float)adc_dataw/10,1,lcd_buf);  
        
          flag=1;
   while(flag==1){}
         lcd_gotoxy(12,1); 
           lcd_puts(lcd_buf);
              
            }
     /* 
      ++st_po;
      
          itoa(st_po,lcd_buf);
           lcd_gotoxy(12,0);
           
                lcd_puts(lcd_buf);
         */  
    //   #asm("sei")
      
         
       
       
         adc_datawi=adc_dataw;   
        adc_dataw=0; 
        
         
        }  
        
          
          
     m3: 
       work=0; 
        break;   
  }       
         
    if( work_gps==0) goto m1;

       //GPS----------------------------------------------------------
           
       if ( work_gps==1) 
       {  
  //  #asm("cli")
       
       for(i=0; i<rx_wr_index; i++)
       {
       if  (rx_buffer [i]=='$')  
       {
       work_gps=2;
         
        break;
       }
          } 
             }  
             
             if (work_gps==1) 
             {
         reset();
              goto m1;       
    
                 }        
                           
                            
       //switch(                     
             
       if (work_gps==2)
       {
       if(rx_buffer [i+3]=='R' && rx_buffer [i+4]=='M'
       && rx_buffer [i+5]=='C' )  
        
       work_gps=3;  
        
        
       
        if((rx_buffer [i+3]=='V') && (rx_buffer [i+4]=='T')
       && (rx_buffer [i+5]=='G'))
       
       work_gps=5;    
       
                           
        
         
         
        if(rx_buffer [i+3]=='G' && rx_buffer [i+4]=='S' 
       && rx_buffer [i+5]=='V')// && es_gps == 0)  
       
         work_gps=10;      
         
         
         
         if(rx_buffer [i+3]=='G' && rx_buffer [i+4]=='G'
       && rx_buffer [i+5]=='A' && st_po == 4) 
       
        work_gps=9;
       
         
       
      }    
          
      
         if (work_gps==2) 
            {
         reset();
              goto m1;       
    
                 }  
        
               
      
              
     
             
        
            
     /*   
        {  
       
       for(i=0; i<rx_wr_index; i++) 
       
     { 
       if(rx_buffer [i]==',') 
     
     {  
     work_gps=4;break; 
     
     }
       }
      }   */
      
       
          
           
          if (work_gps==3 && es_gps == 3 )
          {
               for(i=0; i<rx_wr_index; i++) 
       
     { 
       if(rx_buffer [i]=='A') 
     
     {  
     work_gps=4;break; 
     
     }
       }  
       
         if( work_gps==4)
         {
          for(i=0; i<rx_wr_index; i++) 
       
     { 
       if(rx_buffer [i]==',') break;
     
          }    
          
          
          
         
           sum_hours=((rx_buffer [i+1])-48)*10+(rx_buffer [i+2]-48);
           
           if  (sum_hours<21) 
           
            sum_hours=sum_hours+3;
            
            
               else
        {   
           
           switch (sum_hours)
            {
            case 21: sum_hours=0; break; 
             case 22: sum_hours=1; break;
              case 23: sum_hours=2; break;   
              
              
              }
           } 
           
            
            //  decet_Hours_clock=sum_hours/10;   
       
            //  ed_hours_clock=sum_hours%10;    
              
              
          decet_min_clock=(rx_buffer [i+3]-48)*10 + rx_buffer [i+4]-48 ;
       
         // ed_min_clock=rx_buffer [i+4]-48;
       
            
              
           decet_sek_clock=(rx_buffer [i+5]-48)*10 + rx_buffer [i+6]-48;  
           
          
             rtc_set_time(sum_hours,decet_min_clock,decet_sek_clock); 
             
         
                   ++es_gps;
                    st_s=10;
                  // rtc_get_time(&h,&m,&s);   
                        
               //    time(); 
             flag=1;                     
   while(flag==1){} 
                   
                   lcd_gotoxy(15,0);
                   
                      lcd_puts("#");
                   
              
                          
                          
                               
         reset();
              goto m1;       
    
                  
                                
                   
                   
                 }  
            }
        
          if( work_gps==3)  
            {
         reset();
              goto m1;       
    
                 }      
                            
        
         if (work_gps==5)  
         
          {  
          
          
          
             for(i=0; i<rx_wr_index; i++) 
             
            { 
             
            if ( (rx_buffer [i]=='N')&&(rx_buffer [i+1]==',')) 
           {
            
           err=0; work_gps=6; 
           
           if(es_gps==0)
               {
                es_gps =3;   
              itoa(tm,lcd_buf);   
             flag=1;                                     
   while(flag==1){} 
   
           lcd_gotoxy(0,0); 
            
           
         lcd_puts("                "); 
            lcd_gotoxy(0,0);
          lcd_puts("GPS_Ok "); 
          
                  lcd_puts(lcd_buf);
           lcd_puts(":");  
            if(ts<10)  
           lcd_puts("0"); 
           
            itoa(ts,lcd_buf); 
                 lcd_puts(lcd_buf);
            
                  putchar('s');    
                   
                ts=0;
                tm=0;   
                kvadrat = 0; 
               
                     }
        
           break;              
         }      
        
      
    
     
       }  
           
           }  
               
         if (work_gps==5)   
          {
         reset();
              goto m1;       
    
                 }  
                            
                            
                          
                
             if (work_gps==6) 
          {   
            
          
          
           
          
                sum_hours=255; 
                
                 
             
              for(i= i+2; i<rx_wr_index ; i++) 
              { 
                sum_hours++;
               if(rx_buffer [i]!=',') 
               {
                 
             speed_array[sum_hours]= rx_buffer [i]; 
         
              
             
             }
                 else
                 break;
             
             
             }   
             
              
             
            for(r=0; r<sum_hours; r++)
            
             if( speed_array[r]=='.') 
              {      
         
          //   soten_speed =5;                         //     unsigned char ed_speed;
              break;  
               }
            //    i=2;                                             //   unsigned char deset_speed;
                                                             // unsigned char soten_speed;
            switch (r)  
            {
             case 1: ed_speed = speed_array[0]-48;
             
              soten_speed = deset_speed = 0;
                  break;               
             
              case 2: ed_speed = speed_array[1]-48;
                   deset_speed = speed_array[0]-48;
             
              soten_speed =  0;
                  break; 
                  
              case 3: ed_speed = speed_array[2]-48;
                   deset_speed = speed_array[1]-48;
             
              soten_speed = speed_array[0]-48;
                  break; 
                  
             }   
             
              for(r=0; r<10; r++)
               speed_array[r]=0; 
          /*     
               
         crrc = calc_NMEA_Checksum( rx_buffer, rx_wr_index );
         
          
          if((rx_buffer[wrx-2]-48) > 9)
          rx_buffer[wrx-2]-=55;
          
          else
                rx_buffer[wrx-2]-=48;
                
       
         
         
         crrw =  rx_buffer[wrx-2]; 
         
           
          
          if((rx_buffer[wrx-1]-48) > 9)
          rx_buffer[wrx-1]-=55;
          
          else
                rx_buffer[wrx-1]-=48;
                
         crrw = (crrw << 4) + rx_buffer[wrx-1];  
         
        
         
         if (crrw ==  crrc)  kv=1;
             
          */
               
         reset();
              goto m1;       
    
                  
                  
             
       }   
            
             
 
        
       
          
                         
                            
                              
               
          if( work_gps==9 )
          {  
               
             sum_hours=0;
        //  ed_sek_clock=rx_buffer [i+6]-48;
       
            for(i=0; i<rx_wr_index; i++)
       {
       if  (rx_buffer [i]==',')  
       {
       if(++sum_hours==7)
       {
                      //n sputnik
       
        //  decet_sek_clock=(rx_buffer [i+1]-48)*10 + rx_buffer [i+2]-48; 
       
      
       //   ed_sek_clock=  
    //   itoa(decet_sek_clock ,lcd_buf);
         flag=1;                     
       while(flag==1){}
          lcd_gotoxy(2,0); 
          
          lcd_d (); 
           
         //  #asm("sei")
      
           break;
       
            }
            }
           }  
            
          
        sum_hours=0;
        //  ed_sek_clock=rx_buffer [i+6]-48;
       
            for(i=0; i<rx_wr_index; i++)
       {
       if(rx_buffer [i]==',')  
       {
       if(++sum_hours==9)
       {
                      //METR
       
          metr=((rx_buffer [i+1]-48)*100) + ((rx_buffer [i+2]-48)*10)
          
          +( rx_buffer [i+3]-48);    
          
          
             itoa(metr ,lcd_buf); 
             
              flag=1;                     
          while(flag==1){}
          
          lcd_gotoxy(10,0); 
          
          lcd_puts(lcd_buf); 
           
                 lcd_puts("m"); 
                 
      if(metr<=999)           
                   
              lcd_putchar(0X20);
                  
            //  #asm("sei")
               
               break;
               }
               }
             }
                                  
                           
                                
         reset();
              goto m1;       
    
                   
                          
                   
         
            }
        
        
         if( work_gps==10)
          {

         
               sum_hours=0;
        //  ed_sek_clock=rx_buffer [i+6]-48;
       
            for(i=0; i<rx_wr_index; i++)
       {
       if  (rx_buffer [i]==',')  
       {
       if(++sum_hours==3)
       {
                      //S sputnik
       
        //  decet_sek_clock=(rx_buffer [i+1]-48)*10 + rx_buffer [i+2]-48; 
            
    //   itoa(decet_sek_clock ,lcd_buf);
       
              flag=1;                     
       while(flag==1){}  
       
       if(es_gps==0) 
       {
         lcd_gotoxy(12,0); 
            lcd_d ();
            }
        if(st_po==4)
        { 
          lcd_gotoxy(7,0); 
            lcd_d ();
              }
          //  #asm("sei")
                
         reset();
              goto m1;       
    
                  
      
           break;
       
            } 
            
            }
          }   
       
        } 
          reset ();
       
      }
}
