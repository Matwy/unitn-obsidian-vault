---
date: 2026/02/09
tags:
Materia: "[[Embedded]]"
pdf: "[[Lecture-3.pdf]]"
---
# Lecture 3 – Embedded Program Development

---

## 1. Typical Program-Generation Flow

- **Program-generation flow**: the sequence of steps required to transform source code into an executable running on the target processor
- The standard pipeline is: **Compile → Assemble → Link → Download**
- The final output is called the **program image** (or **executable file**), which is stored in **program memory** (normally **on-chip flash memory**) and then fetched by the processor

### 1.1 Pipeline Stages

```
C Code
  │
  ▼  [Compile]
Assembly Code
  │
  ▼  [Assemble]
Object Code  +  Libraries
  │                │
  └──────┬─────────┘
         ▼  [Link]
   Program Image
         │
         ▼  [Download]
   Program Memory
```

- **Compile**: translates high-level C code into assembly language
- **Assemble**: converts assembly instructions into machine-readable **object code** (binary)
- **Link**: combines multiple object files and libraries into a single **program image** (executable)
- **Download**: transfers the program image into the target's program memory (e.g., flash)
- All these steps happen **off-line** (on the host/development machine), not on the target

### 1.2 Processor Execution Cycle

- Once the program image resides in program memory, the processor operates in its standard cycle:
	- **Fetch** → **Decode** → **Execute**
- The processor fetches instructions from flash, decodes them, executes them, and processes input data to produce output data

---

## 2. Cortex-M4 Memory Map Recap

- The Cortex-M4 uses a **standardized 4 GB memory map** divided into defined regions:

| Region | Address Range | Typical Use |
|---|---|---|
| **Code** | `0x00000000` – `0x1FFFFFFF` (512 MB) | On-chip FLASH (program image) |
| **SRAM** | `0x20000000` – `0x3FFFFFFF` (512 MB) | On-chip SRAM (data memory) |
| **Peripheral** | `0x40000000` – `0x5FFFFFFF` (512 MB) | Timer, UART, GPIO (vendor-specific) |
| **External RAM** | `0x60000000` – `0x9FFFFFFF` (1 GB) | External SRAM, SDRAM, LCD, SD card |
| **External Device** | `0xA0000000` – `0xDFFFFFFF` (1 GB) | External device interfaces |
| **Private Peripheral Bus (PPB)** | `0xE0000000` – `0xE00FFFFF` | SCS, NVIC, Debug Controller |
| **Vendor-specific / Reserved** | `0xE0100000` – `0xFFFFFFFF` | Vendor-specific memory |

- The **Code region** is where the program image resides (flash)
- The **SRAM region** is where program data (variables, stack, heap) is stored at runtime
- The **Peripheral region** contains memory-mapped I/O registers for on-chip peripherals
- The **PPB** hosts the Cortex-M4 internal components: NVIC (interrupt controller), SCS (System Control Space), and Debug

---

## 3. Cortex-M4 Program Image

### 3.1 What is a Program Image?

- **Program image** (also called **executable file**): a piece of fully integrated code that is ready to execute on the target
- It is stored in the **Code region** of the memory map (addresses `0x00000000` – `0x1FFFFFFF`)
- Typically burned into **non-volatile memory** such as on-chip **FLASH**

### 3.2 Components of the Program Image

The Cortex-M4 program image contains four main components:

1. **Vector Table**
2. **C Start-up Routine**
3. **Program Code**
4. **C Library Code**

```
Code Region (Flash)
┌─────────────────────────────┐ 0x00000000
│       Vector Table          │
├─────────────────────────────┤
│     Start-up Routine        │
│           &                 │
│      Program Code           │
│           &                 │
│     C Library Code          │
│                             │
└─────────────────────────────┘
```

#### 3.2.1 Vector Table

- Located at the **very beginning** of the code region (starting at address `0x00000000`)
- Contains:
	- **Initial MSP (Main Stack Pointer) value** – at address `0x00000000`
	- **Reset vector** – at address `0x00000004`
	- **Exception/interrupt handler addresses** (NMI, Hard Fault, SVCall, PendSV, SysTick, external interrupts, etc.)
- The vector table tells the processor where to jump when specific events occur

**Vector Table Layout:**

| Address | Content |
|---|---|
| `0x00000000` | Initial MSP value |
| `0x00000004` | Reset vector (start address of program) |
| `0x00000008` | NMI vector |
| `0x0000000C` | Hard Fault vector |
| `0x00000010` | Reserved |
| `0x0000002C` | SVCall |
| `0x00000030` | Reserved |
| `0x00000038` | PendSV |
| `0x0000003C` | SysTick |
| `0x00000040+` | External Interrupts |

#### 3.2.2 C Start-up Routine

- **Purpose**: sets up the data memory and initializes values for global data variables before `main()` is called
- It is **automatically inserted** by the compiler/linker (e.g., labeled as `__start` by the GNU C compiler)
- Responsibilities include:
	- Copying `.data` section initial values from Flash to RAM
	- Zeroing out the `.bss` section in RAM
	- Setting up the stack and heap
	- Calling `main()`

#### 3.2.3 Program Code

- The **instructions and data** generated from the application program (your C source code compiled to machine code)

#### 3.2.4 C Library Code

- **Object codes** from standard C libraries (e.g., `strcpy`, `printf`, `malloc`) that are inserted into the program image by the **linker**

---

## 4. System Initialization (Boot Sequence)

### 4.1 Cortex-M4 Reset Sequence

After reset (power-on or manual reset), the Cortex-M4 processor performs the following steps **automatically in hardware**:

1. **Fetch initial MSP value** – reads the 32-bit value at address `0x00000000` and loads it into the MSP register
2. **Fetch reset vector** – reads the 32-bit value at address `0x00000004` (this is the address of the reset handler)
3. **Branch to reset handler** – the processor jumps to the address specified by the reset vector and begins executing instructions
4. **Execute program instructions** – normal instruction execution continues sequentially

```
         Reset
           │
           ▼
  Fetch initial MSP value
  (read address 0x00000000)
           │
           ▼
  Fetch reset vector
  (read address 0x00000004)
           │
           ▼
  Fetch 1st instruction
  (at address from reset vector)
           │
           ▼
  Fetch 2nd instruction
  (subsequent instructions)
           │
           ▼
       ... continues ...
```

> **Key point**: unlike many other architectures, the Cortex-M4 does NOT start executing code at address 0. Instead, address 0 holds the initial stack pointer value, and address 4 holds the address of the first instruction to execute.

---

## 5. Program Image in Global Memory

- The program image resides in the **Code region**: `0x00000000` to `0x1FFFFFFF` (up to 512 MB)
- Usually implemented on **non-volatile memory** (on-chip FLASH)
- Program **data** (variables, stack, heap) is stored separately in the **SRAM region** (`0x20000000` – `0x3FFFFFFF`, up to 512 MB)

```
Global Memory Space
┌──────────────────────┐ 0x3FFFFFFF
│    SRAM Region       │ ← Data memory (on-chip SRAM, SDRAM)
│    (512 MB)          │   Variables, stack, heap
├──────────────────────┤ 0x20000000
│                      │ 0x1FFFFFFF
│    Code Region       │ ← Program image (on-chip FLASH)
│    (512 MB)          │   Instructions, constants, vectors
└──────────────────────┘ 0x00000000
```

---

## 6. Data Storage in SRAM

### 6.1 Three Data Sections

Data in SRAM is typically divided into three areas:

- **Static Data** (bottom of RAM, low addresses)
	- Contains **global variables** and **static variables**
	- Allocated at compile time, exists for the entire program lifetime
	- Fixed location in memory, space is never reused

- **Heap** (grows upward from low to high addresses)
	- Memory dynamically reserved at runtime by function calls such as `malloc()` and `alloc()`
	- **Generally not preferred in embedded systems** because:
		- It introduces fragmentation
		- It makes memory usage unpredictable
		- Embedded systems have very limited RAM

- **Stack** (grows downward from high to low addresses)
	- Used for: **local variables**, **parameter passing** in function calls, **register saving** during exceptions/interrupts
	- Managed automatically by the compiler and hardware

```
Memory Address
    High ┌──────────────┐
         │    Stack     │ ← Grows DOWNWARD
         │      ↓       │
         │              │
         │      ↑       │
         │    Heap      │ ← Grows UPWARD
         ├──────────────┤
         │ Static Data  │ ← Fixed
    Low  └──────────────┘
```

> **Important**: Stack and Heap grow toward each other. If they collide, a **stack overflow** or **heap corruption** occurs — a critical bug in embedded systems.

### 6.2 Memory Lifetime of Data

| Allocation Type | Lifetime | Reuse of Space | Example |
|---|---|---|---|
| **Statically allocated** | Program start → program end | No (fixed location) | Global variables, static variables |
| **Automatically allocated** | Function start → function end | Yes (stack is reclaimed) | Local variables |
| **Dynamically allocated** | Explicit allocation → explicit deallocation | Yes (after `free()`) | `malloc()` / `free()` |

### 6.3 Read-Only vs. Read/Write Decision

- **Can the information change at runtime?**
	- **No** → store in **read-only non-volatile memory** (Flash ROM)
		- Examples: instructions, constant strings, constant operands, initialization values
	- **Yes** → store in **volatile read/write memory** (SRAM)
		- Examples: variables, intermediate computations, return addresses

---

## 7. Executable Image Sections

### 7.1 Standard Sections

An executable image is organized into the following standard sections:

- **`.text`**: contains the compiled machine **instructions** (program code)
- **`.data`** and **`.sdata`** (small data):
	- Contain the **initial values** for global and static variables that are initialized to non-zero values
	- These values are stored in Flash and **copied to RAM** at startup
- **`.bss`** and **`.sbss`** (small bss):
	- **Uninitialized** (or zero-initialized) data sections
	- Their content is **empty** in the Flash image — no storage needed in Flash
	- The startup code **fills them with zeros** in RAM
- **`.const`**:
	- Contains **constant data** (e.g., `const` variables, string literals)
	- This section is **read-only** and stays in Flash

### 7.2 Memory Layout: Flash ROM vs RAM

```
Flash ROM                          RAM
┌─────────────────────────┐        ┌──────────────────────┐
│  Startup & Runtime      │        │       Stack          │
│  Library Code (.text)   │        │   (local vars: e, f) │
├─────────────────────────┤        ├──────────────────────┤
│  Constant Data (.const) │        │  Zero-Init Data      │
│  (c=123, "Hello!")      │        │  (.bss) → a, b       │
├─────────────────────────┤        ├──────────────────────┤
│  Initialization Data    │──copy──│  Initialized Data    │
│  (.data) → 31           │  to    │  (.data) → d         │
├─────────────────────────┤  RAM   ├──────────────────────┤
│  Program Code (.text)   │        │      Heap Data       │
└─────────────────────────┘        └──────────────────────┘
```

### 7.3 Worked Example

```c
int a, b;              // uninitialized globals → .bss (RAM, zeroed at startup)
const char c = 123;    // constant → .const (Flash, read-only)
int d = 31;            // initialized global → .data (init value in Flash, variable in RAM)

void main(void) {
    int e;             // local variable → Stack (RAM)
    char f[32];        // local array → Stack (RAM)
    e = d + 7;         // instruction → .text (Flash)
    a = e + 29999;     // instruction → .text (Flash)
    strcpy(f, "Hello!"); // "Hello!" string → .const (Flash), f → Stack (RAM)
}
```

**Where each element is stored:**

| Element | Section | Memory | Why |
|---|---|---|---|
| `a`, `b` | `.bss` | RAM (zeroed at startup) | Uninitialized globals |
| `c = 123` | `.const` | Flash (read-only) | Constant, never changes |
| `d = 31` | `.data` | Initial value in Flash, variable copy in RAM | Initialized global, can be modified |
| `e`, `f` | Stack | RAM | Local variables (automatic allocation) |
| `"Hello!"` | `.const` | Flash (read-only) | String literal constant |
| Instructions | `.text` | Flash | Program code |
| `strcpy` | `.text` (library) | Flash | C library code linked in |

### 7.4 Why is `.data` in Both Flash and RAM?

- The **initial value** (e.g., `31` for variable `d`) must survive power cycles → stored in **Flash** (non-volatile)
- But `d` is a **modifiable variable** → it needs a **writable copy in RAM** at runtime
- The **C start-up routine** copies the initial values from Flash to RAM before `main()` begins
- `.bss` variables don't need initial values stored in Flash — they are simply **zeroed in RAM** by the startup code

---

## 8. C Run-Time Start-Up Module

### 8.1 What Happens After Reset

After reset, the MCU must:

1. **Initialize hardware** (clock configuration, peripheral setup, etc.)
2. **Initialize the C/C++ runtime environment**:
	- Set up **heap memory**
	- **Copy `.data` section** initial values from Flash to RAM
	- **Fill `.bss` section** with zeros in RAM
	- Set up the **stack pointer**
3. **Call `main()`** to start the application

### 8.2 Start-Up Data Flow

```
Flash ROM                              RAM
┌───────────────────────────┐          ┌────────────────────────┐
│ Startup & Runtime Library │          │        Stack           │
│ Code                      │          │       (e, f)           │
├───────────────────────────┤          ├────────────────────────┤
│ Constant Data             │          │  Zero-Initialized Data │
│ (c: 123, "Hello!")        │          │     (a, b)             │
├───────────────────────────┤  copy →  ├────────────────────────┤
│ Initialization Data       │─────────→│  Initialized Data      │
│ (31)                      │          │     (d)                │
├───────────────────────────┤          ├────────────────────────┤
│ Program Code              │  fill 0→ │       Heap Data        │
└───────────────────────────┘          └────────────────────────┘
```

- `.data` initial values are **copied** from Flash to RAM
- `.bss` section is **filled with zeros** in RAM
- Constants (`.const`) stay in Flash and are read directly from there
- Local variables live on the stack — they are **not initialized** by the startup code (they get values when the function executes)

---

## 9. Loading Program Image

- **Loading**: the process of transferring the executable image from the **host** (development machine) onto the **target** (embedded system)
- The entire executable image is **burned** (programmed) into ROM or Flash memory using special equipment
- Every time code changes (bug fixes, new features), the Flash must be **reprogrammed**

### 9.1 Programming Interface

- **JTAG (Joint Test Action Group)**: a standard debug/programming interface used to download code to the target's Flash memory
- JTAG also supports **on-chip debugging**: setting breakpoints, inspecting registers, stepping through code

---

## 10. Booting Procedure (Detailed Step-by-Step)

### 10.1 Key CPU Registers

Two CPU registers are critical during boot:

- **IP (Instruction Pointer)**: points to the **next instruction** to execute (code in `.text` section)
	- In ARM terminology, this is the **PC (Program Counter)**
- **SP (Stack Pointer)**: points to the **next free address** on the stack
	- Must be set appropriately at start-up — the stack is created in RAM

### 10.2 Boot Steps

```
ROM (Flash)              RAM
┌──────────────┐         ┌──────────────┐
│ Reset Vector │─(1)─→ IP│              │
├──────────────┤         │              │
│    .text     │←(2)─ IP │              │
├──────────────┤         │              │
│    .data     │──(3)───→│    .data     │ (copy)
├──────────────┤         ├──────────────┤
│    .bss      │  (4)───→│    .bss      │ (reserve, zero)
└──────────────┘         ├──────────────┤
                    (5)──→│    stack     │←── SP
                         └──────────────┘
```

**Step-by-step:**

1. **Step 1**: IP is hardwired to execute the first instruction in memory — the **reset vector**
	- The reset vector is at a predefined, hard-wired address (address `0x00000000` for the MSP, `0x00000004` for the reset vector itself)

2. **Step 2**: The reset vector is a **jump instruction** that redirects IP to the first instruction of the `.text` section in ROM (the bootstrap/startup code)
	- The reason for this indirection: keep the reset vector small

3. **Step 3**: The `.data` section is **copied** from ROM to RAM
	- Because `.data` contains initialized variables that need to be both **readable and writable** at runtime

4. **Step 4**: Space is **reserved** in RAM for the `.bss` section
	- Nothing is transferred from ROM because `.bss` content is empty (all zeros)
	- The startup code fills this region with zeros

5. **Step 5**: **Stack space** is reserved in RAM, and the **SP register** is set to point to the beginning (top) of the newly created stack

6. **Step 6 (implicit)**: Boot completes — the CPU continues to execute code in the `.text` section, eventually calling `main()`

---

## 11. Linker

### 11.1 Role of the Linker

- The **linker** creates a single **executable image** for the target embedded system
- It **merges sections** from different object files into **program segments**
- The linker is controlled by **linker directives** (also called linker commands), specified in a **linker command file** (also called a **linker script**)

```
C/C++ Source ──→ Compiler ──→ Object Files ──┐
Assembly     ──→ Assembler ──→ Object Files ──┤
                              C Libraries   ──┤
                                              ▼
                                           Linker ──→ Executable Image (Binary)
```

### 11.2 Linker Command File

The linker command file uses **directives** to control how sections are combined and placed in memory. The two most common directives are:

#### 11.2.1 MEMORY Directive

- **Purpose**: describes the target system's **physical memory map**
- Defines the **types** of physical memory, their **start addresses**, and their **sizes**
- The developer must know the addressable physical memory on the target system

**Syntax:**

```
MEMORY {
    area-name : org = start-address, len = number-of-bytes
    ...
}
```

**Example:**

```
MEMORY {
    ROM:   origin = 0x0000h, length = 0x0020h
    FLASH: origin = 0x0040h, length = 0x1000h
    RAM:   origin = 0x1000h, length = 0x10000h
}
```

This describes a target system with:

```
Memory Map
┌──────────┐ 0x1FFFF
│   RAM    │ (64 KB)
├──────────┤ 0x10000
│          │
│  (gap)   │
│          │
├──────────┤ 0x0103F
│  FLASH   │ (4 KB)
├──────────┤ 0x00040
│  (gap)   │
├──────────┤ 0x0001F
│   ROM    │ (32 bytes)
└──────────┘ 0x00000
```

#### 11.2.2 SECTION Directive

- **Purpose**: tells the linker:
	- Which **input sections** (from object files) to combine into which **output sections**
	- Which output sections to **group together** and allocate in **contiguous memory**
	- **Where to place** each section (in which memory area)

**Syntax:**

```
SECTION {
    output-section-name : { contents } > area-name
    ...
    GROUP {
        [ALIGN(expression)]
        section-definition
        ...
    } > area-name
}
```

### 11.3 Linker Example (Walkthrough)

**Scenario**: two object files (`file1.o` and `file2.o`) with the following sections:

```
file1.o                    file2.o
┌──────────────────┐       ┌──────────────────┐
│ Code/data        │       │ code (.text)     │
│ loader section   │       │ code (my_section)│
│ .text section    │       │ .data section    │
│ .data section    │       │ .bss section     │
│ .bss section     │       └──────────────────┘
└──────────────────┘
```

**Linker command file:**

```
MEMORY {
    ROM:   origin = 0x0000h, length = 0x0020h
    FLASH: origin = 0x0040h, length = 0x1000h
    RAM:   origin = 0x1000h, length = 0x10000h
}

SECTION {
    .text : {
        my_section
        *(.text)
    }
    loader : > FLASH
    GROUP ALIGN (4) : {
        .data : {}
        .bss : {}
    } > RAM
}
```

**What each directive does:**

1. **`.text` section**: combines `my_section` and all `.text` sections from all object files into the final output `.text` section
	- `*(.text)` means "take the `.text` section from every object file"
	- `my_section` is placed first, followed by all `.text` sections

2. **`loader : > FLASH`**: places the `loader` section into **FLASH** memory

3. **`GROUP ALIGN(4) : { .data : {} .bss : {} } > RAM`**: groups `.data` and `.bss` sections together and allocates them in **contiguous physical RAM**, aligned on a **4-byte boundary**
	- `ALIGN(4)` ensures the group starts at an address divisible by 4 (important for 32-bit word-aligned access)

**Resulting executable image:**

```
Executable Image
┌─────────────────────────┐
│ Code/data (file1.o)     │
│ loader section          │  → placed in FLASH
├─────────────────────────┤
│ .text (file1.o)         │
│ .text (file2.o)         │
│ .my_section (file2.o)   │  → .text output section
├─────────────────────────┤
│ .data (file1.o)         │
│ .data (file2.o)         │  → .data section ─┐
├─────────────────────────┤                    ├── GROUP in RAM
│ .bss (file1.o)          │                    │   (4-byte aligned)
│ .bss (file2.o)          │  → .bss section  ──┘
└─────────────────────────┘
```

---

## 12. Summary

- **Program-generation flow**: Compile → Assemble → Link → Download to Flash
- **Program image** = Vector Table + Start-up Code + Program Code + C Library Code
- **Vector table**: starts at `0x00000000`, holds initial MSP and exception handler addresses
- **Boot sequence**: Read MSP → Read Reset Vector → Jump to startup code → Initialize `.data` (copy from Flash) → Zero `.bss` → Set up stack → Call `main()`
- **Memory layout**:
	- **Flash (Code Region)**: `.text`, `.const`, `.data` initial values, startup code
	- **RAM (SRAM Region)**: `.data` (runtime copy), `.bss` (zeroed), stack, heap
- **Section types**: `.text` (code), `.data` (initialized globals), `.bss` (uninitialized globals), `.const` (constants)
- **Linker**: merges object files into a single executable, controlled by linker directives (`MEMORY` and `SECTION`)
- **MEMORY directive**: describes physical memory layout (type, origin, length)
- **SECTION directive**: controls how input sections map to output sections and where they are placed
- **Heap** is generally avoided in embedded systems due to fragmentation and unpredictability
- **JTAG**: standard interface for programming Flash and on-chip debugging