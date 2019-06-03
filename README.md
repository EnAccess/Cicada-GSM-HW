# Cicada HW - IoT Communications Module for Energy Access. 

An easy way to get production ready, bi-directional communications for your IoT embedded device.

This repository contains the hardware design for supported  2G, 3G, 4G modems (wifi comming in the future).

Checkout the examples in the firmware repository here https://github.com/EnAccess/Cicada 


## Manufacturing files

If you are only interested in manufacturing the PCBs, you only need files in the `/manufacturing/` directory. Just grab the latest .zip files, and send them to your contract manufacturer of choice.

For Cicada 2G, the latest files are in `/manufacturing/Cicada-2G-v1.1_biuld0_2019-05-22.zip`

Fot Cicada 4G, the latest files are in `/manufacturing/Cicada-4G-v1.1_biuld0_2019-05-20.zip`

The .zip contains the PCB Gerber/drill files, the BOM, and assembly instructions.

## Source files

If you'd like to take a look at the schematics and PCB layout, first, make sure you have a fresh version of KiCAD. It's a free and open source electronics design tool, and can be downloaded from http://kicad-pcb.org. Make sure you are not using an old version that some Linux distributions might be still shipping.

### File structure

The schematics and related files live under the `/design/` directory:

`/design/doc/datasheets/` - Datasheets for some of the components used. Obviously, not covered by the LICENSE.
`/design/pdfs/` - Schamatics exported as PDF.
`/design/renders` - 3D renders of the PCBs.
`/design/source/ltspice` - Ltspice simulations, mainly concerning power usage and decoupling capacitors.
`/design/source/kicad` - The juicy bits.

Here we have:

`/design/source/kicad/lib` - schematics symbols and footprint for a few parts not found in the standard KiCAD libraries.
`/design/source/kicad/cicada-2g` - source files for the Cicada 2G (SIM800C based) PCB.
`/design/source/kicad/cicada-4g` - source files for the Cicada 4G (SIM7600 based) PCB.

## Standard KiCAD libraries.

To make sure we are using the same version of standard KiCAD libraries, we've made a proxy repo that references the KiCAD github repositories, https://github.com/EnAccess/kicad-libs. Please clone it along side this repositories, and KiCAD should be able to pick up the schematics symbols / footprints from there:

`/Cicada-HW/` - This repo.

`/kicad-libs/` - Kicad libraries repo.

You might want to remove "global" kicad libraries from your settings to avoid possible version mismatches.

# A qiuck look at the schematics.

The schamtics is lagely based on the `SIM7600 Series_Hardware Design_V1.02` and `SIM800C_Hardware_Design_V1.05` documents from simcomm, both found in the documentation folder. Most design festures are shared between the 2G and 4G boards.

## Host interface

![](https://github.com/EnAccess/Cicada-HW/blob/master/design/doc/figures/Host-interface.png)

The host interface provides provides:
- 5V - power
- 3.3v - logiv level VCC reference.
- VER_1 and VER_2 - version pins.
- UART TX and RX. 
- SPI - only available on the 4G board as an option. Normally, UART can be used for communication.
- POWER enable pin - drive hogh to enable power.
- RESET pin - drive low to reset, drive at 1.8 - 3.3v during normal operation. Is not implemented on the 2G board, since the SIM800C chip does not have a RESET line.


## Sim card slot

![](https://github.com/EnAccess/Cicada-HW/blob/master/design/doc/figures/Sim-card.png)

Same for Cicada 2G and Cicada 4G boards.

## Power

Both Cicada 2G and Cicada 4G use single-chip SMPS to convert 5v down to 4v required by both SIM7600 and SIM800C modules.

![](https://github.com/EnAccess/Cicada-HW/blob/master/design/doc/figures/Power.png)

## Level shifters.

The SIM7600 module (Cicada 4G) operates at 1.8v logic level, while the SIM800C module (Cicada 2G) operates at 2.8v. In both vases, simple discrete level shifters are used to make the logic levels compatible with more common 3.3v.

![](https://github.com/EnAccess/Cicada-HW/blob/master/design/doc/figures/Level-shifters.png)




