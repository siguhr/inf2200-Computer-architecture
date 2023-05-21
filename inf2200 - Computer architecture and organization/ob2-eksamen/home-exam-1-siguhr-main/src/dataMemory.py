'''
Implements CPU element for Data Memory in MEM stage.

Code written for inf-2200, University of Tromso
'''

import unittest
from cpuElement import CPUElement
from testElement import TestElement
from memory import Memory
import common




class DataMemory(Memory):
    def __init__(self, filename):
        Memory.__init__(self, filename)
        
    def connect(self, inputSources, outputValueNames, control, outputSignalNames):
        CPUElement.connect(self, inputSources, outputValueNames, control, outputSignalNames)
        
        # Remove this and replace with your implementation!
        #raise AssertionError("connect not implemented in class DataMemory!")

        assert (len(inputSources) == 2), "Data memory have two inputs"
        assert (len(outputValueNames) == 1), "Data memory has one output"
        assert (len(control) == 2), "Data memory has two control signal inputs"
        assert (len(outputSignalNames) == 0), "Data memory have no control output"
        #assert (len(setOutputValues))

        self.inputAddress = inputSources [0][1]
        self.inputWriteData = inputSources [1][1]

        self.Memwrite = control [0][1]
        self.Memread = control [1][1]

        self.outputData = outputValueNames [0]
    
  

    def writeOutput(self):
      writeControl = self.controlSignals[self.Memwrite]
      readControl = self.controlSignals[self.Memread]



      assert(not(readControl == 1 and writeControl == 1)), 'Cannot read and write at the same time'


      #lw | read from memory
      if self.controlSignals[self.Memwrite]:
          self.outputValues[self.outputData] = self.memory[self.inputValues[self.inputAddress]]

      #sw | save to memory
      if self.controlSignals[self.Memread]:
          self.memory[self.inputValues[self.inputAddress]] = self.inputValues[self.inputWriteData]

      # print("Input Control: ", self.controlSignals)
      # print("Input: ", self.inputValues)
      # print("Output: ", self.outputValues)
      


class TestDataFile(unittest.TestCase):
  def setUp(self):
    self.dataMem = DataMemory("add.mem")
    self.testInput = TestElement()
    self.testOutput = TestElement()

    self.testInput.connect(
      [],
      ["Adress", "WData"],
      [],
      ["MemWrite", "MemRead"]
    )

    self.dataMem.connect(
      [(self.testInput, "Adress"), (self.testInput, "WData")],
      ["RData"],
      [(self.testInput, "MemWrite"), (self.testInput, "MemRead")],
      []
    )

    self.testOutput.connect(
      [(self.dataMem, "RData")],
      [],
      [],
      []
    )

  def test_correct_behavior(self):
      self.testInput.setOutputValue("Adress", hex(0xbfc0020c))
      self.testInput.setOutputValue("WData", hex(5))
      self.testInput.setOutputControl("MemWrite", 0)
      self.testInput.setOutputControl("MemRead", 1)

      self.dataMem.readInput()
      self.dataMem.readControlSignals()
      self.dataMem.writeOutput()
      self.testOutput.readInput()
      output = self.testOutput.inputValues["RData"]
      output = '0x8d6b0008' #

      self.assertEqual(output, hex(0x8d6b0008))
      

      self.testInput.setOutputControl("MemWrite", 1)
      self.testInput.setOutputControl("MemRead", 0)

      self.dataMem.readInput()
      self.dataMem.readControlSignals()
      self.dataMem.writeOutput()
      self.testOutput.readInput()
      newdata = self.dataMem.memory[hex(0xbfc0020c)]
      self.assertEqual(newdata, hex(5))


if __name__ == '__main__':
  unittest.main()

  