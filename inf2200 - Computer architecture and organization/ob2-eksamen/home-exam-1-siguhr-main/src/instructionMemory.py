

import unittest
from common import Break
from cpuElement import CPUElement
from memory import Memory
from testElement import TestElement


class InstructionMemory(Memory):
  def __init__(self, filename):
    Memory.__init__(self, filename)
  
  def connect(self, inputSources, outputValueNames, control, outputSignalNames):
    CPUElement.connect(self, inputSources, outputValueNames, control, outputSignalNames)

    # Remove this and replace with your implementation!
    # raise AssertionError("connect not implemented in class InstructionMemory!");
    assert (len(inputSources) == 1), 'Instruction memory should have one input'
    assert (len(outputValueNames) == 1), 'Instruction memory has only one output'
    assert (len(control) == 0), 'Instruction memory has no control signal'
    assert (len(outputSignalNames) == 0), 'Instruction memory does not have any control output'

    self.input_pcAddress = inputSources[0][1]
    self.output_Instruction = outputValueNames[0]

  def stop(self):

    for addre in self.inputValues.values():
      stopInstruction = int(self.memory[addre])
      
    print("stopIN:", stopInstruction)
    
  
    if stopInstruction == 13:
      
      return False
    else:
      
      return True
    
  def writeOutput(self):

    

        #####
        print(self.inputValues)
        PCaddress = int(self.inputValues[self.input_pcAddress])
        
        
        


        for PCaddress in self.inputValues.values():
            self.outputValues[self.output_Instruction] = int(self.memory[PCaddress])

        instruction = '0x' + hex(self.outputValues[self.output_Instruction])[2:].zfill(8)
        print(self.outputValues, instruction)
        
        
        

            
        
        #print(self.outputValues)
  


class TestInstructionMemory(unittest.TestCase):
  def setUp(self):
    self.InsMem = InstructionMemory("add.mem")
    self.testInput = TestElement()
    self.testOutput = TestElement()

    self.testInput.connect(
      [],
      ["address"],
      [],
      []
    )

    self.InsMem.connect(
      [(self.testInput, "address")],
      ["Instruction"],
      [],
      []
    )

    self.testOutput.connect(
      [(self.InsMem, "Instruction")],
      [],
      [],
      []
    )

  def test_correct_behavior(self):
    self.testInput.setOutputValue("address", "0b00111100000100001100000000000000")

    self.InsMem.readInput()
    self.InsMem.writeOutput()
    self.testOutput.readInput()
    output = self.testOutput.inputValues["Instruction"]

    print(output)

    self.assertEqual(output, format(int(hex(0x8d6b0008), 16), "#034b"))


if __name__ == '__main__':
  unittest.main()
