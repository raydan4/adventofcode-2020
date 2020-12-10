import 'dart:io';
import 'dart:collection';

int main() {
  // Read file
  File file = new File('day8.input');
  List<String> instructions = file.readAsLinesSync();
  
  // Data for program execution
  HashMap ran = new HashMap<int, String>();
  int acc = 0;
  int pc = 0;

  // Data for program correction
  Queue candidates = new Queue();
  for (var i = 0; i < instructions.length; i++) {
    if (instructions[i].startsWith("nop") || instructions[i].startsWith("jmp")) {
      candidates.add(i);
    }
  }
  int candidate = -1;

  while(true) {
    if (ran.containsKey(pc) || pc < 0 || pc > instructions.length - 1) {
      // Only print challenge 1 result once
      if (candidate == -1) { print("Challenge 1: $acc"); }

      // Clear execution variables
      ran.clear();
      acc = 0;
      pc = 0;

      // Update modification candidate
      candidates.removeFirst();
      candidate = candidates.first;      
    }
    // If command is last line of input program ran successfully
    if (pc == instructions.length -1) { print("Challenge 2: $acc"); return 0; }

    // Get current instruction
    dynamic instruction = instructions[pc];
    
    // Note that instruction being ran
    ran[pc] = instruction;
  
    // Split instruction 
    // Command is first three characters
    dynamic cmd = instruction.substring(0,3);
    // Will multiply by 1 if sign is '+', -1 if sign is '-'
    dynamic sign = instruction[4] == '+' ? 1 : -1;
    // Value is integer at end
    dynamic val = int.parse(instruction.substring(5,instruction.length));

    // If this is the next line to try flipping nop/jmp, flip the command
    if (pc == candidate) { cmd = cmd == "jmp" ? "nop": "jmp"; }

    switch(cmd) {
      // Update program counter
      update:
      case "nop": { pc ++; }
        break;
      // Update Accumulator
      case "acc": { acc += val * sign; }
        continue update;
      // Jump program counter
      case "jmp": { pc += val * sign; }
        break;
      // Exit
      default:    { return 0; }
    }
  }
}
