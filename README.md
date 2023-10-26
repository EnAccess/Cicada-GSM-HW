<p align="center">
  <a href="https://github.com/EnAccess/Cicada-GSM-HW">
    <img
      src="https://enaccess.org/wp-content/uploads/2023/04/Cicada-graphic-GitHub-2240-%c3%97-800-.svg"
      alt="Cicada GSM"
      width="640"
    >
  </a>
</p>
<p align="center">
    <em>IoT Communications Module for Energy Access. A quick way to get production ready, bi-directional communications for your IoT embedded device.</em>
</p>
<p align="center">
  <img
    alt="Project Status"
    src="https://img.shields.io/badge/Project%20Status-stable-green"
  >
  <!-- <img
    alt="GitHub Workflow Status"
    src="https://img.shields.io/github/actions/workflow/status/EnAccess/Cicada-GSM-HW/workflow.yaml"
  > -->
  <a href="https://github.com/EnAccess/Cicada-GSM-HW/blob/main/LICENSE" target="_blank">
    <img
      alt="License"
      src="https://img.shields.io/github/license/EnAccess/Cicada-GSM-HW"
    >
  </a>
</p>

---

# Cicada HW - IoT Communications Module for Energy Access

This repository contains the hardware design of IOT embedded bi-directional communications device. through  2G, 3G, 4G modemsTech.

Checkout the examples in the firmware repository here <https://github.com/EnAccess/Cicada>

## Manufacturing files

If you are only interested in manufacturing the PCBs, you only need files in the /manufacturing/ directory. send them to your contract manufacturer of choice,Some examples of other turnkey PCBA manufacturers are:

| Manufacturers |
|---------------|
| JLCPCB |
| PCBCart |
| Bittele |

The /manufacturing/ directory contains the PCB Gerber/drill files, the BOM, and assembly instructions.

## Source files

If you'd like to take a look at the schematics and PCB layout, first, make sure you have a fresh version of KiCAD. It's a free and open source electronics design tool, and can be downloaded from <http://kicad.org>. Make sure you are not using an old version that some Linux distributions might be still shipping.

### File structure

The schematics and related files live under the /design/ directory:

| Directory | Content |
|-------|---------------|
| /design/doc/datasheets/ | Datasheets for some of the components used. These files are not covered by this project's open source licence |
| /design/pdf | Schematics exported as PDF |
| /design/source/kicad/ | Kicad source files for the CICADA GSM hardwares inculding component lib files |
| /manufacturing/gerber/ |  these are set of files which gives information on different layers used in the project (copper layers, silk screen , court yard and other relevent files) |
| /manufacturing/stackup/ | Text file containing the details of the PCB material and stackup |
| /manufacturing/pick and place/ | Pick and place files describing component locations and orientations for PCB Assembly |
| /manufacturing/nc drill/ | NC Drill files describing type and specification of PCB drill holes (vias, through holes, mounting holes etc) |
| /manufacturing/BOM/ | BOM contains the imformation of all the components used for cicad. directely generated from Kicad using the bom genration script  |

## Standard KiCAD libraries

To make sure we are using the same version of standard KiCAD libraries, we've made a proxy repo that references the KiCAD github repositories, <https://github.com/EnAccess/kicad-libs>. Please clone it along side this repositories, and KiCAD should be able to pick up the schematics symbols / footprints from there:

`/Cicada-HW/` - This repo.

`/kicad-libs/` - Kicad libraries repo.

You might want to remove "global" kicad libraries from your settings to avoid possible version mismatches.

# A quick look at the schematics

The schematics are lagely based on the `SIM7600 Series_Hardware Design_V1.02` and `SIM800C_Hardware_Design_V1.05` documents from Simcom, both found in the documentation folder. Most design festures are shared between the 2G and 4G boards.

## Host interface

![](https://github.com/EnAccess/Cicada-HW/blob/master/design/doc/figures/Host-interface.png)

The host interface provides:

- 5V - power
- 3.3v - logic level VCC reference.
- VER_1 and VER_2 - version pins.
- UART TX and RX.
- SPI - only available on the 4G board as an option. Normally, UART can be used for communication.
- POWER enable pin - drive hogh to enable power.
- RESET pin - drive low to reset, drive at 1.8 - 3.3v during normal operation. Is not implemented on the 2G board, since the SIM800C chip does not have a RESET line.

## Version information

The host interface provides a way for the host to detect the presence of a Cicada board, and distinguish between different boards:

![](https://github.com/EnAccess/Cicada-HW/blob/master/design/doc/figures/Host-interface-versioning.png)

## Sim card slot

![](https://github.com/EnAccess/Cicada-HW/blob/master/design/doc/figures/Sim-card.png)

Same for Cicada 2G and Cicada 4G boards.

## Power

Both Cicada 2G and Cicada 4G use single-chip SMPS to convert 5v down to 4v required by both SIM7600 and SIM800C modules.

Both the modules use M3406-ADJ, which come with a internal over current protection (1.5A) and rated to 800mA operation. but the power supply circuit is design with the bulk output Capacitance which maintaines the voltage and pumps the shorter peak current requirment and the series resister at the power supply input reduce the stress on the hosts 5v regulator.

![](https://github.com/EnAccess/Cicada-HW/blob/master/design/doc/figures/Power.png)

## Level shifters

The SIM7600 module (Cicada 4G) operates at 1.8v logic level, while the SIM800C module (Cicada 2G) operates at 2.8v. In both vases, simple discrete level shifters are used to make the logic levels compatible with more common 3.3v.

![](https://github.com/EnAccess/Cicada-HW/blob/master/design/doc/figures/Level-shifters.png)

## Antennas

Antenna circuitry compied from the simcomm reference documentation:

### Cicada 4G - Main and Auxiliary antennas, plus a GPS antenna

![](https://github.com/EnAccess/Cicada-HW/blob/master/design/doc/figures/Antennas-7600.png)

### Cicada 2G - Only the main antenna

![](https://github.com/EnAccess/Cicada-HW/blob/master/design/doc/figures/Antennas-800C.png)

## USB

On both Cicada 2G and Cicada 4G, USB can be used to update the modem firmware.
The USB connector can also provide 5V power to the board during the process.

![](https://github.com/EnAccess/Cicada-HW/blob/master/design/doc/figures/USB.png)
