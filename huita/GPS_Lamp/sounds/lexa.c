/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
� Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 08.02.2019
Author  : 
Company : 
Comments: 


Chip type               : ATtiny2313
AVR Core Clock frequency: 8,000000 MHz
Memory model            : Tiny
External RAM size       : 0
Data Stack size         : 32
*******************************************************/

#include <tiny2313.h>
#include <delay.h>
// Declare your global variables here


     unsigned  char nom_ok, nom_n, i,t;

  unsigned  int   stdl;
 bit prer;
 
 
 


flash char noti1[2] [12]={
{0X5E,0XCD,0XED,0X7C,0XB3,0X5C,0XDA,0x31,0X89,0X90,0X97,0X77},

{0XC4,0XC7,0XCA,0XCC,0XD0,0XD3,0XD5,0XD8,0XDA,0XDC,0XDE,0XE0}
};

flash char noti2[2][12]  ={
{0X2E,0XE6,0X76,0X3D,0X59,0XAD,0XEC,0X18,0X44,0X4F,0X4B,0X3B},

{0XE2,0XE3,0XE5,0XE6,0XE8,0XE9,0XEA,0XEC,0XED,0XEE,0XEF,0XF0}
};

flash char noti3[2][12]={
{0X16,0XF2,0XBA,0X1E,0X2C,0XD6,0X76,0X47,0XA1,0X23,0XA5,0X1D},

{0XF1,0XF1,0XF2,0XF3,0XF4,0XF4,0XF5,0XF6,0XF6,0XF7,0XF7,0XF8}
 };




void igra ( char  nom, int  dl)
{
    nom_n=nom;
    stdl=dl;
 TIMSK=0x82;
        while(nom_n>0)
        {
        PORTB.7=1;
        prer=1;
       while(prer==1) {};
        PORTB.7=0;     PORTB.6=1;
        prer=1;
        while(prer==1){};
        PORTB.6=0; }
        }

        void pauza (int pau) {
         PORTB.7=0; TIMSK=0x02;  stdl=pau;
        while(stdl!=0){};
        }



     void melodi (unsigned  char n)
         {
           
           
            switch(n)
          {  
           case 1: 
           
          
                //vkluchenie     
                    nom_ok=2;
                    
                    igra(7,10);
                   pauza(20);
                   igra(7,10);
                    pauza(20);
         
                      
                   igra(11,10);
                   pauza(20);
                   igra(11,10);
                   pauza(20);
                
                   nom_ok=3; 
                  igra(5,30);
                   pauza(30);
                
                
                
                
                
                
                                    
               
                 
                 
                return; 
                 
           case 2:
          
               
                //sputniki naideni
                   nom_ok=2;   
                 
                   igra(1,15);
                   igra(4,15);
                   igra(7,30);
                   pauza(15);  
                   igra(2,15);
                   igra(5,15);
                   igra(9,30);
                   pauza(15);
                     nom_ok=2;
                   igra(7,30);   
                   nom_ok=3;
                    igra(4,50);
                 
                
                return; 
                   
                /*
                
                //vnimanie akb  
                 igra(1,30);
                   pauza(30);
                   igra(1,30);
                   pauza(30);
                   igra(1,30);
                   pauza(30);
                   igra(1,30);
                    pauza(30);
                   igra(11,10);
                   igra(10,10);
                   igra(9,10);
                   igra(8,10);
                   igra(7,10);
                   igra(6,10);
                   igra(5,10);
                   igra(4,10);
                   igra(3,10);
                   igra(2,10);
                   igra(1,10);
                   pauza(10);
                   igra(1,30);
                   pauza(30);
                   igra(1,30);
                   pauza(30);
                   igra(1,30);
                   pauza(30);
                   igra(1,30);
                     pauza(30);
                    igra(11,10);
                   igra(10,10);
                   igra(9,10);
                   igra(8,10);
                   igra(7,10);
                   igra(6,10);
                   igra(5,10);
                   igra(4,10);
                   igra(3,10);
                   igra(2,10);
                   igra(1,10);
                   pauza(10);
                   igra(1,30);
                   pauza(30);
                   igra(1,30);
                   pauza(30);
                   igra(1,30);
                   pauza(30);
                   igra(1,30);
                   
                
                
                
                pauza(280);
               */     
               
            case 3:   
                //vnimanie akb  
                  nom_ok=2; 
                
                    igra(11 ,80);
                   pauza(50); 
                   
                     igra(9,20);
                   pauza(20);  
                         igra(9,20);
                   pauza(20);
                         igra(9,20);
                   pauza(20); 
                     igra(9,20);
                   pauza(100);
                     
                   
                   
                             
                    
                   
                 
                   
                    
                    
                   /*
                       pauza(70);
                    igra(5,20);
                   igra(5,20);
                   igra(5,20);
                   igra(2,50);              
                   */
                     
                       
                
                return; 
                   
                        
             case 4:             
                                 nom_ok=1;   
                               //poterya signala     
                               
                               
                              igra(9,20);
                               igra(8,20);
                                igra(7,20);
                                 igra(6,20);
                                  igra(5,20);   
                                   pauza(50);
                                    igra(5,20);
                                     
                                    
                                     
                                 return;
                           /*    
                       //sputniki naideni
                       
                       
                    nom_ok=1; 
                        
                       igra(11,30);   
                       
                    nom_ok=2;
                    
                     
                       igra(4,30);
                       igra(7,30);
                       igra(11,30);
                       
                     nom_ok=3;
                     
                     
                       igra(0,15); 
                       
                         nom_ok=2;
                         
                         
                       igra(11,30);
                       igra(9,15);
                       igra(8,30);
                       igra(9,15);
                       igra(8,30);
                       igra(5,15);
                       igra(4,30);
                       igra(5,15);   
                       
                       nom_ok=1;
                       
                       igra(11,60);  
                       
                        pauza(400);
                                   
                        
                         //sputniki naideni
                       igra(7,80);  
                         pauza(30);
                                   
                       igra(0,30); 
                       pauza(30);
                       igra(4,30);
                       pauza(30);
                       igra(7,30);
                       
                       pauza(400);         
                          
           igra(2,30);
           igra(2,15);
           igra(5,15);
           igra(9,30);
           igra(2,30);
           igra(4,30);
           igra(4,30);
            
             pauza(60);
             
             
           igra(1,30);
           igra(0,15);
           igra(4,30);
           igra(9,30);
           igra(0,30);
            igra(2,30);   
            igra(2,30);
           
            
            pauza(50); 
            
            igra(2,30);
           igra(2,15);
           igra(5,15);
           igra(9,30);
           igra(2,30);
           igra(4,30);
           igra(4,30); 
           
             pauza(60);   
             
           igra(7,30);
           igra(5,30);
           igra(4,30);
           igra(7,30);
           igra(9,60);
              
             
         pauza(180);  
         
              
           
           
         //var2
          nom_ok=2;
          igra(4,15);
          
            pauza(5);
         
          igra(4,15); 
          
          pauza(25);
          
          igra(4,15);
          
          pauza(25);
          
          igra(0,15);
           pauza(5); 
           
          igra(4,35);
          
           pauza(5);
           
          igra(7,20);
          
           pauza(30); 
           
            nom_ok=1;
          
          igra(7,40);
          
           pauza(50);
             */
           }  
           
          
               }  
               
               
  
#define  red_off PORTB.3=0; 

#define  green_off PORTB.2=0; 

#define  blue_off PORTD.5=0; 

#define  red_on PORTB.3=1; 

#define  green_on PORTB.2=1; 

#define   blue_on PORTD.5=1;




void color_es(char red, char green, char blue,int time,char n)

  {  
   char k;
   for(k=n;k<255;k++)
   
   {
     if(red==1) OCR1A=k;
      if(green==1) OCR0A=k;
       if(blue==1) OCR0B=k;
        delay_ms(time);
        }
        }    
        
        
void color_no(char red, char green, char blue,int time,char n)

  {  
   char w;
   for(w=n;w>0;w--)
   
   {
     if(red==1) OCR1A=w;
      if(green==1) OCR0A=w;
       if(blue==1) OCR0B=w;
        delay_ms(time);
        }
        }         
        
void color (void) 


{

 TCCR0A=(1<<COM0A1) | (0<<COM0A0) | (1<<COM0B1) | (0<<COM0B0) | (0<<WGM01) | (1<<WGM00);
TCCR0B=(0<<WGM02) | (0<<CS02) | (1<<CS01) | (1<<CS00);



TCCR1A=(1<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (1<<WGM10);
TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (1<<CS11) | (1<<CS10);




 //TCCR1A=(1<<COM1A1) | (1<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (1<<WGM10);
//TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (1<<CS11) | (1<<CS10); 
 //TCCR0A=(1<<COM0A1) | (1<<COM0A0) | (1<<COM0B1) | (1<<COM0B0) | (0<<WGM01) | (1<<WGM00);
//TCCR0B=(0<<WGM02) | (0<<CS02) | (1<<CS01) | (1<<CS00);    
         
   }
   
void sound (void)

 { 
 
TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (1<<CS10);
   TCCR0A=0x00;
TCCR0B=0x05;

 
 
}                
               


// External Interrupt 0 service routine
interrupt [EXT_INT0] void ext_int0_isr(void)
{
// Place your code here
   i=5;
}

#define DATA_REGISTER_EMPTY (1<<UDRE)
#define RX_COMPLETE (1<<RXC)
#define FRAMING_ERROR (1<<FE)
#define PARITY_ERROR (1<<UPE)
#define DATA_OVERRUN (1<<DOR)

// USART Receiver buffer
#define RX_BUFFER_SIZE 8
char rx_buffer[RX_BUFFER_SIZE];

#if RX_BUFFER_SIZE <= 256
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
#if RX_BUFFER_SIZE == 256
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
   
   switch(data)
   {
     case 'v': i=1; break;
     case 's': i=2; break;
      case 'b': i=3; break;
       case 'n': i=4; break; 
       
       }
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

// Standard Input/Output functions
#include <stdio.h>

// Timer 0 overflow interrupt service routine
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
// Place your code here
 TCNT0=177;
stdl--;
if(stdl==0)
         nom_n=0; 
}

// Timer1 overflow interrupt service routine
interrupt [TIM1_OVF] void timer1_ovf_isr(void)
{
// Place your code here


 switch(nom_ok)
{

case 1 :

TCNT1L=noti1[0][nom_n];TCNT1H=noti1[1][nom_n]; break;

 case 2 :

TCNT1L=noti2[0][nom_n];TCNT1H=noti2[1][nom_n]; break;

 case 3 :

TCNT1L=noti3[0][nom_n];TCNT1H=noti3[1][nom_n]; break;
 default:
    };
prer=0;



}

void main(void)
{
// Declare your local variables here

// Crystal Oscillator division factor: 1
#pragma optsize-
CLKPR=(1<<CLKPCE);
CLKPR=(0<<CLKPCE) | (0<<CLKPS3) | (0<<CLKPS2) | (0<<CLKPS1) | (0<<CLKPS0);
#ifdef _OPTIMIZE_SIZE_
#pragma optsize+
#endif

// Input/Output Ports initialization
// Port A initialization
// Function: Bit2=In Bit1=In Bit0=In 
DDRA=(0<<DDA2) | (0<<DDA1) | (0<<DDA0);
// State: Bit2=T Bit1=T Bit0=T 
PORTA=(0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

// Port B initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRB=(1<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (1<<DDB3) | (1<<DDB2) | (0<<DDB1) | (0<<DDB0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

// Port D initialization
// Function: Bit6=Out Bit5=In Bit4=In Bit3=In Bit2=Out Bit1=In Bit0=In 
DDRD=(1<<DDD6) | (1<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
// State: Bit6=0 Bit5=T Bit4=T Bit3=T Bit2=0 Bit1=T Bit0=T 
PORTD=(0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (1<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);



// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 7,813 kHz
// Mode: Normal top=0xFF
// OC0A output: Disconnected
// OC0B output: Disconnected
TCCR0A=0x00;
TCCR0B=0x05;
TCNT0=0x00;
OCR0A=0x00;
OCR0B=0x00;




// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: Timer1 Stopped
// Mode: Normal top=0xFFFF
// OC1A output: Disconnected
// OC1B output: Disconnected
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer1 Overflow Interrupt: On
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (1<<CS10);
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=(0<<TOIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<ICIE1) | (0<<OCIE0B) | (0<<TOIE0) | (0<<OCIE0A);

// External Interrupt(s) initialization
// INT0: On
// INT0 Mode: Rising Edge
// INT1: Off
// Interrupt on any change on pins PCINT0-7: Off
GIMSK=(0<<INT1) | (1<<INT0) | (0<<PCIE);
MCUCR=(0<<ISC11) | (0<<ISC10) | (1<<ISC01) | (1<<ISC00);
EIFR=(0<<INTF1) | (1<<INTF0) | (0<<PCIF);

// USI initialization
// Mode: Disabled
// Clock source: Register & Counter=no clk.
// USI Counter Overflow Interrupt: Off
USICR=(0<<USISIE) | (0<<USIOIE) | (0<<USIWM1) | (0<<USIWM0) | (0<<USICS1) | (0<<USICS0) | (0<<USICLK) | (0<<USITC);

// USART initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART Receiver: On
// USART Transmitter: Off
// USART Mode: Asynchronous
// USART Baud Rate: 9600
UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
UCSRB=(1<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (1<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
UCSRC=(0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
UBRRH=0x00;
UBRRL=0x33;

// Analog Comparator initialization
// Analog Comparator: Off
// The Analog Comparator's positive input is
// connected to the AIN0 pin
// The Analog Comparator's negative input is
// connected to the AIN1 pin
ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
// Digital input buffer on AIN0: On
// Digital input buffer on AIN1: On
DIDR=(0<<AIN0D) | (0<<AIN1D);


// Global enable interrupts

#asm("sei")
              delay_ms(1800); 
  melodi(1); 
     TIMSK=0;   
          PORTB.7=0;  
      color(); 
 color_es(1,0,0,3,0); 

color_es(0,0,1,3,0); 

color_es(0,1,0,3,0);

color_no(1,1,1,2,255);

     blue_off  
//color_es(1,0,0,10,0); 



              
    color_es(1,1,0,1,0); 
    
      sound();
    
    red_on
   green_on 
   blue_off    




while (1)
      {  
      
   while(i==0){};  
         
      switch(i)
   {
    
 //   case 1: 
 
    case 5:  
          
   
    melodi(1); 
     TIMSK=0;   
          PORTB.7=0;  
      color(); 
 color_es(1,0,0,3,0); 

color_es(0,0,1,3,0); 

color_es(0,1,0,3,0);

color_no(1,1,1,2,255);

     blue_off  
//color_es(1,0,0,10,0); 



              
    color_es(1,1,0,10,0); 
    
      sound();
    
    red_on
   green_on 
   blue_off    
          
          
          
          
          
          
         if(i==5) 
         
         { 
        
            i=6;
        delay_ms(500); 
         continue; 
    
         }
         
     break;  
     
     case 2: case 6: 
     
        
         melodi(2); 
          TIMSK=0;   
            PORTB.7=0; 
          red_off  green_off  
            
       for(t=0;t<4;t++)
       {
         green_on delay_ms(300);green_off
                  delay_ms(300);
                  } 
               delay_ms(150);     
                  
         color();          
           color_es(1,1,0,10,0); 
    
      sound();
    
    red_on
   green_on   
     
          if(i==6) 
          { 
          i=7;
          delay_ms(500); 
          continue;        
                }
    break;  
     
     
     
     case 3: case 7:
    
          melodi(3); 
           TIMSK=0;   
          PORTB.7=0;
        red_off  green_off     
       for(t=0;t<4;t++)
       {
         red_on delay_ms(300);red_off
                  delay_ms(300);
                  }       
                  
             delay_ms(150);        
         color();          
           color_es(1,1,0,10,0); 
    
      sound();
    
    red_on
   green_on  
        
          if(i==7)
          {  
          i=8;
          delay_ms(500); 
          continue;        
                }
      break;
      
    
       case 4: case 8:
       
       
          melodi(4); 
           TIMSK=0;   
          PORTB.7=0; 
         red_off  green_off  
          
       for(t=0;t<4;t++)
       {
         blue_on delay_ms(300);blue_off
                 delay_ms(300);
                  }  
                 
          delay_ms(150);        
         color();          
           color_es(1,1,0,10,0); 
    
      sound();
      red_on
   green_on 
   
    break;  
    
        
       
       }  
       
      
           i=0;

   
    
        
        rx_wr_index=0;
   
 
             
   
   
       
              
   
         
      
      
      // Place your code here

      }
}
