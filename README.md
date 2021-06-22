# Drumpad
The main objective of this project is to obtain a prototype of percussion pads, i.e., an electronic
musical drum kit. This device aims to simulate an acoustic drum kit using ad-hoc pads and using an
FPGA for digital audio processing.
The pads will have piezoelectric sensors incorporated; these sensors provide a signal that depends on
the pressure that has been exerted on them. In this way we obtain the control of the volume associated
with the blow received. The analogue circuitry necessary to condition the signal coming from these
sensors will be designed and implemented. The aim of this process is to get as close as possible to the
operation of a real acoustic battery.
The analogue circuitry in charge of sampling the signal from the sensors will be designed and
implemented for its subsequent ADC conversion to have a suitable signal coming into the FPGA.
Next, a communication interface will be studied and developed with a DDR memory that will have
stored banks of sounds. After this, a general system controller will be developed with the
corresponding protocols to control accesses to the memory and its correct reproduction, culminating
in a functional prototype implemented in VHDL.
Thanks to the characteristics of this project, the programming language used and the environment
(Vivado), it will be possible to add functionalities, for example, effects, in a very simple way
depending on the application that you want to give it.
