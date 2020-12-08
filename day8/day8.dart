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

  while(true) {
    // Get current instruction
    dynamic instruction = instructions[pc];
    
    if (ran.containsKey(pc)) { print("Challenge 1: $acc"); }
    ran[pc] = instruction;
    
    dynamic command = instruction.substring(0,3); 
    dynamic sign = instruction.substring(4,5) == '+' ? 1 : -1;
    dynamic val = int.parse(instruction.substring(5,instruction.length));

    switch(command) {
      // Update program counter
      update:
      case "nop": { pc += 1; }
        break;
      // Update Accumulator
      case "acc": { acc += val * sign;}
        continue update;
      // Jump program counter
      case "jmp": { pc += val * sign; }
        break;
      // Exit
      default:    { return 0; }
    }
  }
}
