# Devlog Entry

**Title**:  
INITIAL BOOTLOADER

**Date**:  
February 26, 2025

**Version**:  
v0.1

**Devs**:  
ShuaG

---

## Goal:
Understand the basics of the project, get the initial bootloader running and decide future steps.

---

## Development:
I started by trying to figure out where to continue after the lines "I want to build an operating
system". I found a good beginner tutorial by nanobyte to write the first bootloader. from my current 
understaing as I am writing this now a bootloader is the first 512 bytes the computer reads off the 
disk or drive the os is hosted on. it's job is to reference the actual files of the os to the computer 
so that the computer can load the os into memory and we can use it.

During the first stages of the tutorial I learned to use qemu to test my os over time. the next thing I
learned was how to make a basic assembly script for our first iteration of the os. the script did 
virtually nothing. it just kept the cpu halted and if it broke out of the halt it would get stuck in an
infinite loop. throughout this initial design I learned that the bootloader needs to be 512 bytes and end
with specific bytes. so after the halt command I just filled the rest with zeros until the last 4 bytes,
'0xAA55' which signify the end of the bootloader.

After creating the assembly code I had to learn and understand what the makefile is. After getting some
help understanding from AI tools I learned that it's just a short tool that assembles our assembly into 
the appropriate binary file for us to run. After some trial and error I got a working makefile, assembled
my bootloader and ran it using qemu (in WSL). and got a perfectly working operating system that does nothing except halt.

The next stage was a drop more complicated but by understanding the basics of the x86 architecture and using the tutorial I managed to learn how to print text on the screen using my bootloader in assembly. it works by saving a string into memory and then incrementing through that area of memory reading each char and by calling the BIOS interrupt. the interrupt kind of reminds me of protocols but it basically sends our operating system an interrupt, as the name suggests, which the BIOS (Basic Input Output System) knows to recieve based on the register and value it gets and to perform an action. In our case that action is printing to the screen. I assembled and ran it and after a few minor tweaks it worked!

---

## Challenges:
My main challenges during this first milestone were picking my project, figuring out where to even start and making sure I understood what I was doing. it took me some trial to get used to all the installs I needed like qemu and nasm. Thankfully I had used WSL in the past so I was able to smoothly use it for qemu. I also got a drop overworked trying to understand the makefile but having AI explain the main idea to me helped a lot. 

---

## Notes:
- Despite my initial worry of using tutorials, as long as I understand what I am doing they can be a useful tool
- This project looks like it will not be easy but overall I think I will learn a lot.

---

## Result:
- Got a working OS that does nothing
- Understood and used a makefile to turn my bootloader into a binary file to run
- Upgraded my initial bootloader to print hello world

---

## What's Next:
- Upgrade my bootloader to be nicer and play around with it
- Try to understand the behind the scenes better
- Name my OS
- Figure out what's next

---

## Credit:
- Nanobyte [tutorial](https://www.youtube.com/watch?v=9t-SPC7Tczc) I used to build my initial bootloader
- Good ol' ChatGPT to help me understand some of the behind the scenes and the makefile
