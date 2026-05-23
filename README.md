# 🛡️ Gate-Level Hamming Code Implementation in VHDL

This repository contains the VHDL implementation of an Error Correction & Detection system based on the **Hamming Code** algorithm. The project was developed as part of the Logic Circuits course at **Amirkabir University of Technology (Tehran Polytechnic)**.

## 📋 Project Overview
The primary goal of this project is to encode an 8-bit data input into a 13-bit Hamming sequence, introduce artificial noise (errors) to simulate channel transmission, and decode the received data while correcting single-bit errors and detecting double-bit errors. 

The entire system is designed at the **Gate-Level** using fundamental logic gates (AND, OR, XOR), providing a deep hardware-centric understanding of data integrity.

### 🏗️ Architecture
The system consists of three main modules:
1. **Encoder Module:** Receives 8-bit data (`Data`) and a parity mode selector (`Odd_Mode`). It generates 4 parity bits and 1 overall parity bit, outputting a 13-bit Hamming code (`DataOut`).
2. **Top Module (Channel Simulation):** Connects the Encoder and Decoder. It includes an XOR block that injects up to 2 error bits (`Error` input) into the encoded data to simulate transmission noise.
3. **Decoder Module:** Receives the 13-bit potentially corrupted data (`DataIn`). It calculates syndrome bits to check for errors:
   - **0 Errors:** Data is passed to output.
   - **1 Error:** The exact corrupted bit is identified and flipped (corrected).
   - **2 Errors:** The system detects the double-bit error and pulls the `Valid` signal to `0`.

![Top Module Architecture](https://via.placeholder.com/600x300.png?text=Add+TopModule+Diagram+Here) *(Note: Replace this image link with a screenshot of the project's block diagram).*

## ⚙️ Features
* **Data Width:** 8-bit Input → 13-bit Encoded Output.
* **Selectable Parity:** Supports both Odd and Even parity modes controlled by the `Odd_Mode` pin.
* **Error Handling:** * Single-bit Error Correction.
  * Double-bit Error Detection (`Valid` flag).
* **Design Level:** Pure Gate-Level implementation (Structural VHDL).
* **Verification:** Comprehensive Testbench covering error-free, single-error, and double-error scenarios.

## 💻 Tech Stack & Environment
* **Hardware Description Language:** VHDL
* **Synthesis & Simulation:** Xilinx ISE Design Suite
* **Development Environment:** Hosted on a Virtual Machine (VM) to ensure toolchain stability and isolate the development ecosystem.

## 🚀 How to Run
1. Clone this repository to your local machine:
   ```bash
   git clone [https://github.com/Anahita-Roohi/Hamming-Code-VHDL.git](https://github.com/Anahita-Roohi/Hamming-Code-VHDL.git)
