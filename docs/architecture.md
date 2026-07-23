# Aquila16 Architecture

## Descripción

Aquila16 es un proyecto de diseño de una computadora de 16 bits
basada en FPGA.

El objetivo es crear:

- CPU propia en VHDL
- Ensamblador en Python
- Herramientas de carga y depuración
- Periféricos FPGA
- Sistema básico de software

---

# Hardware objetivo

FPGA:

- Altera Cyclone IV
- EP4CE6E22C8N

Características de la placa:

- Cristal de 50 MHz
- SDRAM 64 Mbit
- VGA
- UART RS232
- GPIO
- LCD
- PS/2
- EEPROM I2C

---

# Arquitectura CPU

Nombre:

Aquila-16

Tipo:

- RISC
- Harvard
- 16 bits

---

# Registros

Registros generales:

R0-R7

Cada registro:

16 bits

Registros especiales:

- PC
- SP
- FLAGS

---

# FLAGS

- Z Zero
- C Carry
- N Negative
- V Overflow

---

# Organización del hardware

rtl/

cpu/

- register_file
- alu
- decoder
- control_unit
- cpu_core

peripherals/

- uart
- gpio
- timer
- vga
- spi
- i2c

---

# Flujo de desarrollo

1. Diseñar módulo
2. Crear testbench
3. Simular
4. Sintetizar en Quartus
5. Probar en FPGA

---

# Estado actual

Versión inicial.

Completado:

- Estructura Git
- Documento ISA inicial
- Banco de registros VHDL
- Testbench inicial
