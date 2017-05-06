#ifndef CONFIG_LOCAL_SERIAL_H
#define CONFIG_LOCAL_SERIAL_H

#ifdef T3KTON_SOL
#undef COMCONSOLE

#if T3TKTON_SOL == 0
#define COMCONSOLE COM1

#elif T3TKTON_SOL == 1
#define COMCONSOLE COM2

#elif T3TKTON_SOL == 2
#define COMCONSOLE COM3

#elif T3TKTON_SOL == 3
#define COMCONSOLE COM4

#else
#error T3tkton sol com not defined

#endif /* T3TKTON_SOL_COM? */


#endif /* T3TKTON_SOL */


#endif /* CONFIG_LOCAL_SERIAL */
