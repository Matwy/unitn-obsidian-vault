---
date: 2026/02/09
tags:
Materia: "[[Embedded]]"
pdf: "[[Lecture-4.pdf]]"
---
# Lecture 4 – Processors and I/O

---

## 1. Input and Output Devices

- In an embedded system, the processor communicates with the outside world through **I/O devices** (peripherals)
- On the Cortex-M4, peripherals are mapped into the **Peripheral Region** (`0x40000000` – `0x5FFFFFFF`) of the memory map
- Common on-chip peripherals include: **Timer**, **UART**, **GPIO**
- External devices (LCD, SD card, external SRAM/FLASH) are accessed through the **External RAM** and **External Device** regions
- The Cortex-M4 also has a **Private Peripheral Bus (PPB)** region hosting the **SCS**, **NVIC**, and **Debug Controller**
- Communication between the CPU and peripherals happens over **AHB/APB** buses (Advanced High-performance Bus / Advanced Peripheral Bus)

---

## 2. Programming Input and Output

### 2.1 Device Registers

- The CPU communicates with I/O devices by **reading and writing device registers**
- Each device typically has several registers:
	- **Data registers**: hold data values that are being transferred to/from the device; can be readable, writable, or both
	- **Status registers**: provide information about the device's current operation (e.g., whether the current operation has been completed); typically **read-only**

```
         ┌──────────────────┐
         │       CPU        │
         └────────┬─────────┘
                  │ Data/Address Bus
         ┌────────┴─────────┐
         │     Device       │
         │  ┌─────────────┐ │
         │  │Status Register│ │
         │  ├─────────────┤ │
         │  │Data Register │ │
         │  └─────────────┘ │
         │    Mechanism     │
         └──────────────────┘
```

### 2.2 Two Ways to Access Device Registers

There are two fundamental approaches to access I/O device registers:

#### 2.2.1 I/O Instructions (Port-Mapped I/O)

- Use **special, dedicated instructions** for input and output
- Example: `IN` and `OUT` instructions on the Intel x86 architecture
- Provides a **separate address space** for I/O devices (different from memory address space)
- Requires separate address lines for I/O
- **Not used** on ARM processors

#### 2.2.2 Memory-Mapped I/O

- **Maps device registers to addresses** in the normal memory address space
- Programs use the CPU's standard **memory read (`LDR`) and write (`STR`) instructions** to communicate with devices
- No special I/O instructions needed — the same instructions used for memory access work for I/O
- **ARM processors use memory-mapped I/O exclusively**

**Comparison:**

| Feature | Port-Mapped I/O | Memory-Mapped I/O |
|---|---|---|
| Instructions | Special I/O instructions (`IN`/`OUT`) | Normal load/store (`LDR`/`STR`) |
| Address space | Separate I/O address space | Shared with memory |
| Hardware | Separate address lines | No extra hardware |
| Used by | Intel x86 | ARM, most modern architectures |

---

## 3. Memory-Mapped I/O on ARM

### 3.1 Assembly Example

```asm
DEV1 EQU 0x1000          ; define device register address
LDR  r1, #DEV1           ; load device address into r1
LDR  r0, [r1]            ; read from device register (load value at address in r1)
LDR  r0, #8              ; set up value 8 to write
STR  r0, [r1]            ; write value 8 to device register
```

- `EQU` defines a symbolic name for the device's address
- `LDR r0, [r1]` reads the device register (same as reading a memory location)
- `STR r0, [r1]` writes to the device register (same as writing to a memory location)

### 3.2 C Language Example

- In C, we use **pointers** to manipulate device register addresses
- We can define simple read/write functions:

```c
int read(char *location) {
    return *location;         // dereference pointer to read from address
}

void write(char *location, char newval) {
    (*location) = newval;     // dereference pointer to write to address
}
```

- Usage:

```c
#define DEV1 0x1000
...
dev_status = read(DEV1);   // read device register at address 0x1000
write(DEV1, 8);            // write value 8 to device register at address 0x1000
```

---

## 4. Busy-Wait I/O (Polling)

### 4.1 Concept

- **Problem**: I/O devices are typically **much slower** than the CPU — they may require many cycles to complete an operation
- **Busy-wait (polling)**: the CPU continuously reads the device's **status register** to check whether the I/O operation is finished
- The CPU is **blocked** during this time — it cannot do any other useful work
- Simple to implement but **very inefficient** in terms of CPU utilization

### 4.2 Example 1: Writing a String to an Output Device

**Setup:**
- Output device has two registers:
	- **Data register** (`OUT_CHAR` at `0x1000`): where the character to be written is placed
	- **Status register** (`OUT_STATUS` at `0x1001`): indicates device state
		- `1` = device is **busy** writing
		- `0` = write has been **completed**

```c
#define OUT_CHAR   0x1000  // output device character register
#define OUT_STATUS 0x1001  // output device status register
...
char *mystring = "Hello, world.";  // string to write
char *current_char;                // pointer to current position in string

current_char = mystring;           // point to the head of string

while (*current_char != '\0') {           // until null terminator
    write(OUT_CHAR, *current_char);       // send character to device
    while (read(OUT_STATUS) != 0);        // BUSY-WAIT: keep checking until done
    current_char++;                       // advance to next character
}
```

**How it works:**
1. Send a character to the data register
2. Enter the inner `while` loop: continuously read the status register
3. When status becomes `0` (write complete), exit the inner loop
4. Move to the next character and repeat
5. The CPU is **stuck in the inner loop** doing nothing useful while waiting

### 4.3 Example 2: Reading from Input and Writing to Output

**Setup:**
- Input device: `IN_DATA` at `0x1000`, `IN_STATUS` at `0x1001`
- Output device: `OUT_DATA` at `0x1100`, `OUT_STATUS` at `0x1101`
- **Input status register**: set to `1` by the device when a new character has been read (we must set it back to `0` to allow the next read)
- **Output status register**: we set it to `1` to start writing, then wait for the device to set it back to `0` when done

```c
#define IN_DATA    0x1000
#define IN_STATUS  0x1001
#define OUT_DATA   0x1100
#define OUT_STATUS 0x1101
...
while (TRUE) {                              // perform operation forever
    while (read(IN_STATUS) == 0);           // WAIT: until input is ready
    achar = (char)read(IN_DATA);            // read the character
    write(OUT_DATA, achar);                 // write character to output
    write(OUT_STATUS, 1);                   // turn on output device
    while (read(OUT_STATUS) != 0);          // WAIT: until output is done
}
```

**Problem**: the CPU spends most of its time in the busy-wait loops, unable to perform any other computation.

---

## 5. Interrupts

### 5.1 Motivation

- **Busy-wait I/O is inefficient**: the CPU wastes cycles polling status registers
- **Solution**: the **interrupt mechanism** allows I/O devices to **signal the CPU** when they need attention
- The CPU can do useful work and only respond to the device when it actually needs service
- Interrupts **force** the execution of a particular piece of code (the **interrupt handler** or **ISR — Interrupt Service Routine**)

### 5.2 How Interrupts Work

**Signaling:**
1. When an I/O device wants service from the CPU, it **asserts the interrupt request (IRQ) signal**
2. When the CPU is ready to handle the request, it **asserts the interrupt acknowledge signal**

**CPU Behavior:**
- The CPU checks the **IRQ line at every instruction**
- If an interrupt request has been asserted, the CPU:
	1. **Saves the return address** (current PC value) onto the stack — just like a subroutine call
	2. **Does NOT fetch** the next instruction pointed to by the current PC
	3. **Sets the PC** to the beginning of the appropriate **interrupt handler**
- After the interrupt handler finishes, the saved PC is restored and the main program resumes

```
         ┌──────────────────┐
         │       CPU        │
         └───┬──────────┬───┘
    IRQ ─────┘          └───── Interrupt Acknowledge
             │          │
         ┌───┴──────────┴───┐
         │      Device      │
         │  Status | Data   │
         └──────────────────┘
```

### 5.3 Interrupt Control Flow

```
Main Program          Interrupt
    │                    │
    │  (executing)       │
    │                    │
    ├─── IRQ asserted ◄──┤
    │                    │
    │  Save PC to stack  │
    │  Jump to handler ──┤
    │                    │  Execute ISR
    │                    │  (read data, clear status, etc.)
    │                    │
    │  ◄── Return ───────┤
    │  Restore PC        │
    │                    │
    │  (resume execution)│
    ▼                    ▼
```

- **Key point**: interrupts change the **control flow** of the CPU asynchronously — they can occur at any time during program execution

---

## 6. Interrupt Examples

### 6.1 Basic Interrupts: Copy Input to Output

**Approach**: use two global variables to communicate between the interrupt handler and the main program:
- `achar`: holds the character received from the input device
- `gotchar`: a flag that signals when a new character has been received

**Interrupt Handlers:**

```c
// Called when IN_STATUS is 1 (new character available)
void input_handler() {
    achar = read(IN_DATA);     // get character from device
    gotchar = TRUE;            // signal to main program
    write(IN_STATUS, 0);       // reset status to allow next transfer
}

// Called when OUT_STATUS is 0 (output complete)
void output_handler() {
    // don't have to do anything
}
```

**Main Program:**

```c
main() {
    while (TRUE) {                      // read then write forever
        if (gotchar) {                  // check if a character was received
            write(OUT_DATA, achar);     // send character to output device
            write(OUT_STATUS, 1);       // initiate write
            gotchar = FALSE;            // reset flag
        }
    }
}
```

**Limitation**: the main program still **polls** the `gotchar` flag in a loop — it doesn't do any other useful work. This is better than busy-wait I/O (the input is handled by the ISR), but the foreground program is still not free.

### 6.2 Interrupts with Circular Buffer (Full Solution)

**Goal**: decouple input and output completely from the main program using a **circular (wraparound) buffer** so the foreground program can do useful work.

#### 6.2.1 Circular Buffer Concept

- A fixed-size array used as a queue with **head** and **tail** pointers
- **tail**: points to where the next character will be **added** (write position)
- **head**: points to where the next character will be **removed** (read position)
- When a pointer reaches the end of the array, it **wraps around** to the beginning

```
Initial state (empty):     After adding 'a','b','c','d','e','f','g':

 head,tail                  head                           tail
  ↓                          ↓                              ↓
 [ ][ ][ ][ ][ ][ ][ ][ ]  [a][b][c][d][e][f][g][ ]

After removing 'a':        After adding 'h' (wrap-around):

     head               tail       head        tail
      ↓                  ↓          ↓            ↓
 [ ][b][c][d][e][f][g][ ]  [h][b][c][d][e][f][g][ ]
```

- **Empty condition**: `head == tail`
- **Full condition**: `(tail + 1) % BUF_SIZE == head` (one slot is always kept empty to distinguish full from empty)

#### 6.2.2 Buffer Implementation

```c
#define BUF_SIZE 8
char io_buf[BUF_SIZE];                // character buffer
int buf_head = 0, buf_tail = 0;       // current positions
int error = 0;                        // set to 1 if buffer overflows

int empty_buffer() {                  // returns TRUE if buffer is empty
    return buf_head == buf_tail;
}

int full_buffer() {                   // returns TRUE if buffer is full
    return (buf_tail + 1) % BUF_SIZE == buf_head;
}

int nchars() {                        // returns number of characters in buffer
    if (buf_head >= buf_tail)
        return buf_head - buf_tail;
    else
        return BUF_SIZE - buf_tail - buf_head;
}
```

> **Note**: with this implementation, the maximum usable capacity is `BUF_SIZE - 1` (7 out of 8 slots), because one slot must remain empty to distinguish "full" from "empty".

```c
void add_char(char achar) {           // add character at tail
    io_buf[buf_tail++] = achar;
    if (buf_tail == BUF_SIZE)         // wrap around
        buf_tail = 0;
}

char remove_char() {                  // remove character from head
    char achar;
    achar = io_buf[buf_head++];
    if (buf_head == BUF_SIZE)         // wrap around
        buf_head = 0;
    return achar;
}
```

#### 6.2.3 Interrupt Handlers with Buffer

**Input Handler** (called when a new character arrives):

```c
#define IN_DATA   0x1000
#define IN_STATUS 0x1001

void input_handler() {
    char achar;
    if (full_buffer())                         // buffer overflow → error
        error = 1;
    else {
        achar = read(IN_DATA);                 // read character from device
        add_char(achar);                       // add to circular buffer
    }
    write(IN_STATUS, 0);                       // reset status register

    // If buffer was empty before this character, start a new output transaction
    if (nchars() == 1) {                       // buffer had been empty
        write(OUT_DATA, remove_char());        // send character to output
        write(OUT_STATUS, 1);                  // turn on output device
    }
}
```

**Output Handler** (called when a character has been sent):

```c
#define OUT_DATA   0x1100
#define OUT_STATUS 0x1101

void output_handler() {
    if (!empty_buffer()) {                     // if more characters to send
        write(OUT_DATA, remove_char());        // send next character
        write(OUT_STATUS, 1);                  // turn on output device
    }
}
```

#### 6.2.4 Key Advantage: Foreground Program is Free

```
        Time ──────────────────────────────────────────►

Foreground:  ███████████████│    │██████████│    │█████████████████
                            │    │          │    │
Input ISR:                  │████│          │    │
                            │    │          │    │
Output ISR:                 │    │          │████│
```

- **All I/O is handled in the background** by the ISRs
- The **foreground program** runs without interruption (except for brief ISR preemptions) and can perform useful computation such as matrix multiplication, sensor processing, etc.
- This is a **fundamental embedded systems pattern**: interrupt-driven I/O with buffering

---

## 7. Bugs in Interrupt Code

### 7.1 Register Save/Restore Problem

- Interrupt handlers must **save any CPU register** they will modify and **restore them before exiting**
- If the handler forgets to save/restore a register, the foreground program may see a **mysteriously changed variable** (since the register was silently corrupted by the ISR)
- These bugs are **extremely hard to find** because they depend on the **timing** of the interrupt — the bug only manifests when the interrupt occurs at a specific point in the main program

### 7.2 Read-Modify-Write Race Condition

This is a classic and critical bug pattern in embedded systems:

**Scenario**: the main program wants to set bit[3] in a word at address `0x20000000`.

```asm
; Main Program — Read-Modify-Write Operation
LDR R1, =0x20000000    ; Setup address
LDR R0, [R1]           ; Read: R0 = 0x21
                        ; ──── INTERRUPT OCCURS HERE ────
ORR.W R0, #0x8         ; Modify: set bit[3] → R0 = 0x29
STR R0, [R1]           ; Write back: memory = 0x29 (WRONG!)
```

```asm
; Interrupt Service Routine (runs between Read and Write of main program)
LDR R1, =0x20000000    ; Setup same address
STR R2, [R1]           ; Write 0x79 to memory
                        ; Return to main program
```

**What happens step by step:**

1. Main program reads value `0x21` from memory into R0
2. **Interrupt fires** before the modify-write steps
3. ISR writes `0x79` to the same memory address
4. ISR returns, main program resumes
5. Main program modifies the **old** value (`0x21 | 0x08 = 0x29`) and writes `0x29` back
6. **Result**: the ISR's write of `0x79` is **lost** — overwritten by stale data

```
Main Program:   Read (0x21)          Modify (0x29)    Write (0x29)
                    │                     │                │
                    │ ◄── INTERRUPT ──►   │                │
                    │                     │                │
ISR:                │     Write (0x79)    │                │
                    │                     │                │
Memory:         0x21 ──→ 0x79 ──────────────────────→ 0x29 (BUG! 0x79 lost)
```

**This is called a race condition**: the outcome depends on the relative timing of the main program and the ISR.

> **Key takeaway**: any **non-atomic read-modify-write** operation on shared data is vulnerable to corruption by interrupts. Solutions include disabling interrupts during critical sections or using hardware-supported atomic operations (like **bit-banding**, covered in Lecture 2).

---

## 8. Interrupt Priorities and Vectors

### 8.1 Multiple Interrupt Sources

- Most real systems have **multiple I/O devices**, each capable of generating interrupts
- The system needs a way to:
	- Determine **which device** caused the interrupt
	- Decide **which interrupt to handle first** when multiple are pending

### 8.2 Interrupt Priorities

- **Interrupt priorities**: a mechanism to recognize some interrupts as **more important** than others
- Example priority assignment in an automotive system:

| Device | Priority |
|---|---|
| Airbag Sensor | HIGHEST |
| Brake Sensor | HIGH |
| Fuel Level Sensor | MEDIUM |
| Real-Time Clock | LOW |

- Higher-priority devices get serviced first when multiple interrupts are pending simultaneously

### 8.3 Programmable Interrupt Controller (PIC)

- The **PIC** is a hardware component that manages multiple interrupt sources
- It **prioritizes** all incoming interrupt requests and presents only the **highest-priority** interrupt to the CPU at any given time
- The CPU only sees a single interrupt input from the PIC

```
Airbag Sensor ────┐
Brake Sensor  ────┤
Fuel Sensor   ────┼──→ [ PIC ] ──→ Interrupt Vector ──→ [ CPU ]
RTC           ────┘
```

### 8.4 Nested Interrupts

- **Nested interrupts**: a higher-priority interrupt source can **preempt** (interrupt) the processing of a lower-priority interrupt handler
- Example: if the Brake Sensor ISR is running and the Airbag Sensor triggers, the CPU suspends the Brake ISR and runs the Airbag ISR first, then returns to finish the Brake ISR

```
Main Program:  ████│                              │████
                   │                              │
Low ISR:           │████│                  │██████│
                   │    │                  │
High ISR:          │    │██████████████████│
```

### 8.5 Interrupt Acknowledge

- When the PIC signals an interrupt to the CPU, the device knows its request was accepted by seeing **its own priority number** on the interrupt acknowledge lines
- After acknowledgment, the device sends its **interrupt vector number** to the CPU

### 8.6 Interrupt Masking

- **Interrupt masking**: ensures that a **lower-priority interrupt does not preempt** a higher-priority handler
- When an interrupt is acknowledged:
	- The CPU stores the **priority level** of that interrupt in an **internal register**
- When a subsequent interrupt is received:
	- Its priority is **compared** against the stored priority register
	- It is acknowledged **only if it has a higher priority** than the one currently being handled
- This prevents priority inversion (a low-priority ISR interrupting a high-priority one)

### 8.7 Non-Maskable Interrupt (NMI)

- The **NMI** is the highest-priority interrupt in the system
- It **cannot be turned off** (disabled/masked) — it is always active
- Typically reserved for **critical, system-level events**:
	- Power failure detection (to save critical state to non-volatile memory)
	- Hardware fault detection
	- Turning off I/O devices safely before power loss

### 8.8 Interrupt Vectors

- After a device is acknowledged, it sends its **interrupt vector number** to the CPU
- The vector number is an **index** into the **Interrupt Vector Table** stored in memory
- Each entry in the vector table contains the **memory address** of the corresponding interrupt handler (ISR)

```
Interrupt Vector Table (in memory)
┌──────────┬──────────────────┐
│ Vector 0 │ → Handler 1 addr │
├──────────┼──────────────────┤
│ Vector 1 │ → Handler 2 addr │
├──────────┼──────────────────┤
│ Vector 2 │ → Handler 3 addr │
├──────────┼──────────────────┤
│ Vector 3 │ → Handler 4 addr │
└──────────┴──────────────────┘

Handler 1:          Handler 2:
void handler1() {   void handler2() {
    ...                 ...
}                   }
```

- The CPU uses the vector number to look up the correct handler address and jumps to it

---

## 9. Overhead of Interrupts

### 9.1 Sources of Overhead

Interrupts are not free — they introduce several sources of overhead:

1. **Branch penalty**: changing the PC to jump to the ISR (and back) incurs pipeline penalties
2. **Automatic register saving**: the hardware may automatically push some CPU registers onto the stack — this takes extra clock cycles
3. **Interrupt acknowledge + vector fetch**: the CPU must communicate with the PIC and obtain the vector number — extra cycles
4. **ISR register save/restore**: the interrupt handler itself must save and restore any additional CPU registers it uses (beyond those automatically saved by hardware)
5. **Return from interrupt**: restoring the automatically saved state and returning to the main program incurs another branch penalty

### 9.2 Interrupt Timing

```
◄──── Interrupt Latency ────►◄──── Processing Time ────►
                              │                          │
IRQ asserted                  ISR starts                 ISR ends
│                             │                          │
├─────────────────────────────┼──────────────────────────┤
│                             │                          │
◄──────────── Interrupt Response Time ──────────────────►

◄───────────────── Time Between Interrupts ─────────────────────────►
```

- **Interrupt latency**: the time from when the IRQ is asserted to when the ISR begins executing (includes hardware state saving, vector fetch, pipeline flush)
	- **Cannot be reduced by the programmer** — it is determined by the hardware
- **Processing time**: the time the ISR takes to execute its code (reading data, updating buffers, etc.)
	- **Can be optimized by the programmer** — keep ISRs short and fast
- **Interrupt response time**: latency + processing time (total time from IRQ to ISR completion)
- **Time between interrupts**: the interval between consecutive interrupt requests from the same source
	- If the response time exceeds the time between interrupts, the system **cannot keep up** and will miss interrupts

> **Design rule**: ISRs should be as **short and fast** as possible. Do the minimum work necessary (read data, set a flag, update a buffer) and let the main program handle complex processing.

---

## 10. Summary

- **I/O device registers**: data registers (hold values) and status registers (indicate device state), accessed by the CPU
- **Memory-mapped I/O**: device registers mapped to memory addresses, accessed with normal `LDR`/`STR` instructions (ARM approach)
- **Port-mapped I/O**: separate address space with special `IN`/`OUT` instructions (x86 approach)
- **Busy-wait (polling)**: CPU continuously reads status register waiting for device — simple but **very inefficient**
- **Interrupts**: devices signal the CPU asynchronously via IRQ — CPU saves PC, jumps to ISR, then returns
	- Much more efficient: CPU can do useful work between interrupts
- **Circular buffer**: key data structure for interrupt-driven I/O, decouples input/output handling from the main program
- **Race conditions**: non-atomic read-modify-write operations on shared data can be corrupted by interrupts occurring between the read and write steps
- **Interrupt priorities**: higher-priority interrupts are serviced first; managed by a **PIC (Programmable Interrupt Controller)**
- **Nested interrupts**: higher-priority ISRs can preempt lower-priority ISRs
- **Interrupt masking**: prevents lower-priority interrupts from preempting higher-priority handlers
- **NMI (Non-Maskable Interrupt)**: highest priority, cannot be disabled, reserved for critical events (e.g., power failure)
- **Interrupt vector table**: array in memory holding addresses of ISRs; the device provides a vector number as an index
- **Interrupt overhead**: latency (hardware, not programmable) + processing time (keep ISRs short); if response time > time between interrupts, the system misses events