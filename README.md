# File Launcher for Windows

[![Batch Script](https://img.shields.io/badge/Made%20With-Batch%20Script-blue.svg)](https://en.wikipedia.org/wiki/Batch_file) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A lightweight file launcher utility that helps you quickly access frequently used files and projects through a simple terminal interface.

## Features ✨

- 🚀 One-click access to multiple files/projects
- 📂 Dynamic configuration via plain text file
- 🌐 Full UTF-8 support for international paths
- 📋 Interactive menu system
- 🔄 Batch open all configured items
- 🛠️ Auto-create sample configuration file

## Installation ⚡

1. **Prerequisites**
   - Windows 10
   - Basic text editor for configuration

2. **Quick Start**
   ```bash
   git clone https://github.com/Irobot-chf/File-Launcher-for-Windows.git
   cd file-launcher
## Configuration 🛠️
Create/edit launcher_config.txt in UTF-8 encoding:
```
# File Launcher Configuration
# Format: ID|Display Name|File Path
1|Keil Project|E:\path\to\your\project.uvprojx
2|Research Doc|G:\path\to\document.docx
3|STM32 Guide|C:\path\to\manual.pdf
```
## Usage 🖥️
launcher.bat

### Sample Workflow:
```python
File Launcher Utility
=====================
1. Keil Project
2. Research Doc
3. STM32 Guide
4. Open All Files
5. Exit
=====================
Enter choice (1-5):



