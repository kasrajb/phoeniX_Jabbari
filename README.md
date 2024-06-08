
# Computer Organization - Spring 2024 - IUST
==============================================================
## Assembly Assignment 1

- Student Name : Kasra Jabbari
- Team Members: Armita Hemmati - Kasra Jabbari
- Student ID: 99411254
- Date: 04/03/1403

## Part One

### Quicksort

#### Introduction
Quicksort is a highly efficient sorting technique that divides a large data array into smaller ones. A vast array is divided into two arrays, one containing values smaller than the provided value, say pivot, on which the partition is based. The other contains values greater than the pivot value.

The program consists of 5 main sections :
1. **Initialization**: Loading initial values and preparing the array example to be sorted.
2. **Execution**: Setting up the pointers and loading the first pivot element.
3. **Partition Function**: Partitioning the array around the pivot.
4. **Left and Right Sorting**: Recursively sorting the sub-arrays on either side of the pivot.
5. **Exit**: Halting the program.

#### Detailed Explanation

1. **Initialization**:
    - Values are loaded into memory addresses to form the array `[9, 6, 3, 12, 10, 7]`.

    ```assembly
    li a0, 0x0
    li a1, 9
    sw a1, 0(a0)

    li a0, 0x4
    li a1, 6
    sw a1, 0(a0)

    li a0, 0x8
    li a1, 3
    sw a1, 0(a0)

    li a0, 0xc
    li a1, 12
    sw a1, 0(a0)

    li a0, 0x10
    li a1, 10
    sw a1, 0(a0)

    li a0, 0x14
    li a1, 7
    sw a1, 0(a0)
    ```

2. **Main Execution**:
    - Initial pointers and the first pivot element are set up, then the partitioning process starts.

    ```assembly
    start:
        li a2, 4
        li t6, 0x0
        li a7 , 0x0
        lw t0, 0(a0)
    ```

3. **Partition Function**:
    - The array is partitioned around the pivot element. Elements are rearranged such that all elements less than the pivot are on the left, and elements greater than the pivot are on the right.

    ```assembly
    loop:
        lw t1, 0(t6)
        bge t0, t1, pointer
        
    pointer:
        lw s9, 0(t6)
        lw t3, 4(a7)
        ble t3, t0, swap
        addi a7, a7, 4
        j pointer

    swap:
        sw t3, 0(t6) 
        sw t1, 4(a7)
        addi a7, a7, 4
        beq a7, a0, right
        addi t6, t6, 4
        j loop
    ```

4. **Right Sorting**:
    - Recursively partition the right sub-array.

    ```assembly
    right:
        addi s1, t6, -4
        lw a3, 0(s1)       # new pivot in right
        li a5, 0x0 
        li s3, 0x0

    loop_r:
        lw a4, 0(a5) 
        bge a4, a3, pointer_r
        addi a5, a5, 4
        j loop_r

    pointer_r:
        lw s2, 4(a5)
        ble s2, a3, swap_r
        addi s3, s3, 4
        j pointer_r

    swap_r:
        sw s2, 0(a5)
        sw a4, 4(s3)
        addi s3, s3, 4
        beq s3, s1, left
        addi a5, a5, 4
        j loop_r
    ```

5. **Left Sorting**:
    - Recursively partition the left sub-array.

    ```assembly
    left:
        lw s4, 0(a0)         # new pivot in left
        addi s5, t6, 4
        addi s6, t6, 4

    loop_l:
        lw s7, 0(s5)         
        bge s7, s4, pointer_l
        addi s5, s5, 4

    pointer_l:
        lw s0, 0(s5)
        lw s8, 4(s6)
        ble s8, s4, swap_l
        addi s6, s6, 4
        j pointer_l

    swap_l:
        sw s8, 0(s5)
        sw s7, 4(s6)
        addi s6, s6, 4
        beq s6, a0, END
    ```

6. **Exit**:
    - The program halts with an `ebreak` instruction.

    ```assembly
    END:
       ebreak
    ```

#### Waveform
Here is the Waveform of the code:

![1000018533](https://github.com/MMDPiri/phoeniX_MohPir_99411218/assets/169598509/b433a5e4-3837-4c48-9031-07cde02755df)

## Part Two

### Square Root

#### Introduction
In mathematics, a square root function is defined as a one-to-one function that takes a non-negative number as an input and returns the square root of the given input number. The integer square root of a number \( n \) is the largest integer \( x \) such that \( x^2 \leq n \).

#### Detailed Description

The algorithm implemented is an iterative method to find the integer square root using bitwise operations and comparison. It checks each bit of the number to determine the correct square root.

#### Assembly Code

The provided RISC-V assembly code for calculating the integer square root is as follows:

```assembly
_start:    
    li s2, 0b11001        # Input number is 11001 or 25 in decimal
    
    call sqrt             # Call the sqrt function

sqrt:
    addi sp, sp, -8       # Allocate space on stack for local variables
    sw ra, 0(sp)          # Save return address on stack
    sw s2, 5(sp)          # Save input number on stack

    li s4, 0              # Initialize result to 0
    li t1, 1              # Initialize bit mask to t1
    li t2, 0b00001        # Initialize the number which we want to calculate the square of it
    li a1, 0              # Initialize the index
    
sqar:
    and  a3, t2, t1       
    beqz a3, skip
    sll  a3, t2, a1       
    add  s4, s4, a3       

skip:
    slli t1, t1, 1        
    addi a1, a1, 1        
    li a5, 5              
    blt a1, a5, sqar      
    mv a6, s4             
    j comp                

comp:
    blt a6, s2, num_inc   
    beq a6, s2, end       

num_inc:
    addi t2, t2, 1        
    li a1, 0              
    li t1, 1              
    li s4, 0              
    j sqar               

end:
    mv s5, t2             # The answer is saved in register s5
    lw ra, 0(sp)          # Restore return address
    addi sp, sp, 8        # Deallocate stack space
    ebreak
```

### Explanation

1. **Initialization**:
    - `li s2, 0b11001`: Loads the input integer 25 into the register `s2`. Number 25 is the sample integer for which we intend to calculate the square root.

2. **Function Call**:
    - `call sqrt`: Calls the `sqrt` function to compute the integer square root.

3. **Square Root Calculation**:
    - **Stack Setup**:
        - `addi sp, sp, -8`: Allocates space on the stack for local variables.
        - `sw ra, 0(sp)`: Saves the return address on the stack.
        - `sw s2, 5(sp)`: Saves the input number on the stack.
    - **Initialization**:
        - `li s4, 0`: Initializes the result to 0.
        - `li t1, 1`: Initializes the bit mask to 1.
        - `li t2, 0b00001`: Initializes the number to be squared.
        - `li a1, 0`: Initializes the index.
    - **Square Calculation Loop**:
        - `and a3, t2, t1`: Performs bitwise AND to check the bit at position `a1`.
        - `beqz a3, skip`: If the result is zero, skip to the next iteration.
        - `sll a3, t2, a1`: Shifts the number left by `a1` positions.
        - `add s4, s4, a3`: Adds the shifted number to the result.
    - **Index Update**:
        - `slli t1, t1, 1`: Shifts the bit mask left by 1.
        - `addi a1, a1, 1`: Increments the index.
        - `li a5, 5`: Sets the loop limit to 5 iterations.
        - `blt a1, a5, sqar`: If the index is less than 5, continue the loop.
        - `mv a6, s4`: Moves the result to `a6`.
        - `j comp`: Jumps to the comparison section.

4. **Comparison**:
    - `comp`:
        - `blt a6, s2, num_inc`: If the result is less than the input, increment the number and repeat the calculation.
        - `beq a6, s2, end`: If the result equals the input, end the calculation.

5. **Increment Number**:
    - `num_inc`:
        - `addi t2, t2, 1`: Increments the number to be squared.
        - `li a1, 0`: Resets the index.
        - `li t1, 1`: Resets the bit mask.
        - `li s4, 0`: Resets the result.
        - `j sqar`: Repeats the square calculation loop.

6. **End**:
    - `end`:
        - `mv s5, t2`: Moves the final result to `s5`.
        - `lw ra, 0(sp)`: Restores the return address.
        - `addi sp, sp, 8`: Deallocates the stack space.
        - `ebreak`: Ends the program execution.

##### Example

For the given code, the input number is 25. The integer square root of 25 is 5, since \( 5^2 = 25 \).

![1000018534](https://github.com/MMDPiri/phoeniX_MohPir_99411218/assets/169598509/48c8fc20-0b5c-4e51-9a24-57ddd6bfd69b)
