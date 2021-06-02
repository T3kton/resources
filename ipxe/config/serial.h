#ifndef CONFIG_LOCAL_SERIAL_H
#define CONFIG_LOCAL_SERIAL_H

#if(T3KTON_COM)
#undef COMCONSOLE

#if(T3KTON_COM == 1)
#define COMCONSOLE COM1

#elif(T3KTON_COM == 2)
#define COMCONSOLE COM2

#elif(T3KTON_COM == 3)
#define COMCONSOLE COM3

#elif(T3KTON_COM == 4)
#define COMCONSOLE COM4

#endif /* T3TKTON_SOL */

#undef  COMPRESERVE

#ifndef COMPRESERVE
#define COMSPEED        115200          /* Baud rate */
#define COMDATA         8               /* Data bits */
#define COMPARITY       0               /* Parity: 0=None, 1=Odd, 2=Even */
#define COMSTOP         1               /* Stop bits */
#endif

#endif /* T3TKTON_SOL */


#endif /* CONFIG_LOCAL_SERIAL */
