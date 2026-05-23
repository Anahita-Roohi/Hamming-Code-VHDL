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

## 📊 Simulation Results & Waveforms

The system was rigorously tested using an ISim testbench to cover various edge cases, including single-bit and double-bit errors across different parity modes. Below is the analysis of the simulation results:

### Test 1: Single Parity Bit Error
* **Conditions:** `Data = 11010110`, `Odd_Mode = 1`, `Error injected at P2`
* **Analysis:** The decoder successfully identifies that the error occurred within the second parity bit rather than the data payload. The `Valid` flag remains `1`, and the output data correctly matches the original error-free input.
> <img width="667" height="106" alt="image" src="https://github.com/user-attachments/assets/bf1ff759-bf10-4965-a910-dab7288ab67e" />

### Test 2: Single Data Bit Error
* **Conditions:** `Data = 00100101`, `Odd_Mode = 0`, `Error injected at Data(3)`
* **Analysis:** A single bit of the main data payload is corrupted. The decoder successfully locates and corrects the flipped bit. The `Valid` flag is asserted to `1`, and the recovered output is completely accurate.
> <img width="668" height="106" alt="image" src="https://github.com/user-attachments/assets/d81692f2-06a3-4324-964e-28cf867497e4" />

### Test 3: Double Data Bit Error
* **Conditions:** `Data = 00111001`, `Odd_Mode = 1`, `Error injected at Data(1) & Data(5)`
* **Analysis:** Two bits within the data payload are simultaneously corrupted. As expected from the Hamming Code limitations, the system detects the double error but cannot correct it. The `Valid` flag correctly drops to `0`, indicating invalid output.
> <img width="668" height="102" alt="image" src="https://github.com/user-attachments/assets/3f56fcf8-2966-417d-b6e4-156810d37cbf" />

### Test 4: Mixed Double Error (Data & Parity)
* **Conditions:** `Data = 11100001`, `Odd_Mode = 0`, `Error injected at P8 & Data(3)`
* **Analysis:** One parity bit and one data bit are corrupted. The overall parity check successfully catches the double-bit error condition. The `Valid` flag is pulled to `0` to warn the system of data invalidity.
> <img width="668" height="103" alt="image" src="https://github.com/user-attachments/assets/c9a23dd7-7a08-405c-bdfe-bb433b4c7b35" />

### Test 5: Overall Parity Bit Error
* **Conditions:** `Data = 00111111`, `Odd_Mode = 1`, `Error injected at P13`
* **Analysis:** The error is isolated to the 13th bit (overall parity bit). The system recognizes that the main data and primary syndromes are intact. The `Valid` flag remains `1`, and the output data is passed through without issue.
> <img width="668" height="104" alt="image" src="https://github.com/user-attachments/assets/5afa348b-bf0e-4721-9aa4-f53433759fd9" />

### Test 6: Double Parity Bit Error
* **Conditions:** `Data = 10101010`, `Odd_Mode = 0`, `Error injected at P1 & P2`
* **Analysis:** Two parity bits are corrupted simultaneously. The system correctly identifies the presence of multiple errors. Consequently, the `Valid` flag becomes `0`.
> <img width="678" height="105" alt="image" src="https://github.com/user-attachments/assets/6cc81c02-2177-4e8c-97b5-df6bf3763728" />
