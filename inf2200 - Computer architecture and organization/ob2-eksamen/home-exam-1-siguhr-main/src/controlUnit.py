
import unittest
from testElement import TestElement
from alu import ALU
from cpuElement import CPUElement
import random

class ControlUnit(CPUElement):
  '''
  Random control unit. It randomly sets it's output signal
  '''
  def connect(self, inputSources, outputValueNames, control, outputSignalNames):
    CPUElement.connect(self, inputSources, outputValueNames, control, outputSignalNames)

    assert(len(inputSources) == 1), 'Random control has one input'
    assert(len(outputValueNames) == 0), 'Random control does not have output'
    assert(len(control) == 0), 'Random control does not have any control signals'
    assert(len(outputSignalNames) == 9), 'Random control has eleven control outputs'

    self.input_Instruction = inputSources[0][1]

    self.signal_Regdest = outputSignalNames[0]
    self.signal_Regwrite = outputSignalNames[1]
    self.signal_ALUsrc = outputSignalNames[2]
    self.signal_ALUOp = outputSignalNames[3]
    self.signal_Memwrite = outputSignalNames[4]
    self.signal_Memtoreg = outputSignalNames[5]
    self.signal_Memread = outputSignalNames[6]
    
    self.signal_Andgate = outputSignalNames[7]
    self.signal_Jmpctrl = outputSignalNames[8]
   

    self.signalNames = ["RegDst", "RegWrite", "ALUSrc", "ALUOp", "MemWrite", "MemtoReg", "MemRead",  "Branch",  "Jump"]
    
    
    #self.signal_Luictrl = outputSignalNames[10]
    #self.signal_ALUtype = outputSignalNames[7]


  def writeOutput(self):
    pass # randomControl has no data output
    #print(self.inputValues)
    
    

  def setControlSignals(self):

        OPcode = self.inputValues[self.input_Instruction][0:6]

        

        #Set all controls to zero by default every cycle
        for signals in self.signalNames:
            self.outputControlSignals[signals] = 0

        

        

        #J type
        if OPcode == '000010':
            self.outputControlSignals['Jump'] = 1
            print("J")

        #R type
        elif OPcode == '000000':
            self.outputControlSignals['RegDst'] = 1
            self.outputControlSignals['RegWrite'] = 1
            self.outputControlSignals['ALUOp'] = '10'
#I types

        #Branch equal
        elif OPcode == '000100':
            self.outputControlSignals['Branch'] = 1
            self.outputControlSignals['ALUOp'] = '01'

        #Branch not equal
        elif OPcode == '000101':
            self.outputControlSignals['Branch'] = 1
            self.outputControlSignals['ALUOp'] = '11'

        #Load upper immediate
        elif OPcode == '001111':
            self.outputControlSignals['RegWrite'] = 1
            self.outputControlSignals['ALUSrc'] = 1
            self.outputControlSignals['ALUOp'] = '001'

        #Load word
        elif OPcode == '100011':
            #self.outputControlSignals['MemWrite'] = 1
            self.outputControlSignals['MemRead'] = 1
            self.outputControlSignals['MemtoReg'] = 1
            self.outputControlSignals['RegWrite'] = 1
            self.outputControlSignals['ALUSrc'] = 1
            self.outputControlSignals['ALUOp'] = '00'

        #Store word
        elif OPcode == '101011':
            self.outputControlSignals['MemWrite'] = 1
            self.outputControlSignals['ALUSrc'] = 1
            self.outputControlSignals['ALUOp'] = '00'

        #Add immediate
        elif OPcode == '001000':
            self.outputControlSignals['ALUSrc'] = 1
            self.outputControlSignals['RegWrite'] = 1
            self.outputControlSignals['ALUOp'] = '002'

        #Add immediate unsigned
        elif OPcode == '001001':
            self.outputControlSignals['ALUSrc'] = 1
            self.outputControlSignals['RegWrite'] = 1
            self.outputControlSignals['ALUOp'] = '00'

        else:
           raise("OPcode not supported.")

        # print("ControlSignals:", self.outputControlSignals)


    

class TestDataFile(unittest.TestCase):
  def setUp(self):
    self.controlunit = ControlUnit()
    self.testInput = TestElement()
    self.testOutput = TestElement()
    self.testALU = ALU()

    self.testInput.connect(
      [],
      ["Instruction"],
      [],
      []
    )

    self.controlunit.connect(
      [(self.testInput, "Instruction")],
      [],
      [],
      ["Regdest", "Regwrite", "ALUsrc", "ALUop", "Memwrite",
       "Memtoreg", "Memread", "Andgate", "Jmpctr"]
    )

    self.testOutput.connect(
      [],
      [],
      [(self.controlunit, "Regdest"), (self.controlunit, "Regwrite"),
       (self.controlunit, "ALUsrc"), (self.controlunit, "ALUop"),
       (self.controlunit, "Memwrite"), (self.controlunit, "Memtoreg"),
       (self.controlunit, "Memread"), 
       (self.controlunit, "Andgate"), (self.controlunit, "Jmpctrl")],
      []
    )


  def test_correct_behavior(self):
      self.testInput.setOutputValue("Instruction", hex(0x01495020))
      self.controlunit.readInput()
      self.controlunit.setControlSignals()
      self.testOutput.readInput()


if __name__ == '__main__':
  unittest.main()


########################
