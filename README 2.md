This set of files is the given files for the CE/CZ3001 project.

1. There are two phases of the project, you should separately demonstrate a working design using the phase 1 memories and the phase 2 memories.
2. *DO NOT* Modify the memories in any way. If you modify the memories, you will not receive credit for a design that uses incorrectly modified files.

Over time, This readme will be added to with Frequently Asked Questions or common problems.

1. Common problem: Modifying the ALU for flags but using them as a latch -- your ALU module should not have a clock input or "save" the flags.
You should *always* compute the values of flags inside the ALU, but a control signal from your control module should decide when to save those combinational
outputs into special flags registers (flip-flops) using the control signal as an enable.

2. I don't understand what the EXEC instruction does -- the EXEC instruction is a special instruction that can indirectly execute a single instruction
from anywhere in the program before returning to the normal execution path. The indirect instruction performs the work, except if it is a branch or jump
instruction -- because the EXEC specifies that we *always* return to the normal execution path afterwards, a branch or jump instruction has no effect because
we neither execute the instruction sequentially after the branch/jump nor execute the target.

3. What is the purpose of LLB/LHB instructions? -- LLB and LHB allow us to specify in source code to load register values instead of needing to have all possible
values that we want to load already stored somewhere in memory. Because we have 16-bit data and 16-bit instructions, but need 4-bits to specify the opcode and 4-bits
for the destination, there are only 8-bits remaining to specify an immediate value and thus we need two instructions -- one to load the high byte and the other
to load the low byte.

4. Why does LLB sign-extend? -- LLB and LHB allow us to load immediate values; however, if we're trying to load a value that's small, we shouldn't be forced
to use two instructions just to make sure that the whole register is the right value. Thus, if we sign-extend the value in LLB, we can load any value between
-128 and +127 using only one instruction, and we only have to use a second instruction (LHB) if we want to load a value outside that range.

5. How do I implement LHB? -- LHB requires a few logical sub-operations to merge together the 8-bit immediate and the existing register value. This can be done
in multiple ways including: (1) Make sure that the lower 8-bits of the shifted immediate are 1 and the upper 8-bits of the register are 1, AND the two together
(2) make sure that the lower 8-bits of the shifted immediate are 0 and the upper 8-bits of the register are 0, OR the two together, (3) create a special functional
unit that just concatenates the bits appopriately. --> Any of these (plus others) are valid ways of solving the problem, but each has it's own minor differences
in how to write a correct hardware description and integrate the description into the rest of your design

6. Why do we have different memories for phase 1 and phase 2? In phase 1, we simplify your problems in designing the pipeline, bypassing and hazard detection
by separating the instruction and data memories so that you don't have to think about contention for a shared resource. In addition, because the latencies are
both single cycle, you don't have to think about stalling the pipeline to wait for instruction fetch or a data memory operation because the memory is always
ready. In phase 2, we add the shared memory with a > 1 cycle latency to be more realistic about real CPUs. Real CPUs would also have instruction and data caches
to help reduce the problems of sharing one memory, but we aren't requiring you to implement caching for this project.

