# 🌟 ANNiVerSary 🌟

[![🔧 Verilog](https://img.shields.io/badge/Verilog-HDVL-blue)](https://github.com/AdakHaddad/ANNiVerSary)
[![📜 License](https://img.shields.io/github/license/AdakHaddad/ANNiVerSary)](LICENSE)

**ANNiVerSary** is a Verilog-based project developed as part of the **MSIB** (Magang dan Studi Independen Bersertifikat) program, designed to apply and deepen understanding of hardware acceleration for artificial neural networks (ANN). This project explores efficient matrix computation through a systolic array architecture, providing foundational modules and testbenches to support ANN processing. ANNiVerSary is a hands-on initiative to learn, build, and optimize high-performance neural network elements in hardware.

## ✨ Features

- 🔄 **Systolic Array Architecture**: Designed for parallel, efficient matrix operations ideal for ANN applications.
- ⚙️ **Configurable Parameters**: Scalable module settings for flexible adaptation to various ANN sizes.
- 🧪 **Thorough Testbenches**: Includes simulation and verification for every component to ensure robust, accurate results.
- 🛠️ **Reusable Components**: Modular Verilog files that can be customized or integrated as needed for ANN accelerators.

## 📂 File Overview

| 📁 File               | 📄 Description                                         |
| --------------------- | ----------------------------------------------------- |
| `6x6.v`               | 6x6 matrix processing element implementation          |
| `6x6TB.v`             | Testbench for 6x6 matrix module                       |
| `AllSystolic6x6.v`    | Comprehensive systolic array for 6x6 matrix operations |
| `AllSystolic6x6TB.v`  | Testbench for `AllSystolic6x6.v`                      |
| `MultAdd.v`           | Multiply-and-accumulate module, essential for ANN weight calculations |
| `TBMultAdd.v`         | Testbench for `MultAdd.v`                             |
| `register.v`          | Basic register module for data retention within the systolic array |
| `registerTB.v`        | Testbench for `register.v`                            |
| `systolic_2x2.v`      | 2x2 systolic array implementation for smaller matrix processing |
| `systolic_2x2TB.v`    | Testbench for `systolic_2x2.v`                        |

