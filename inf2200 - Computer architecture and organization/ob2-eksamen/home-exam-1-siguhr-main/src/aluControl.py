
import unittest
from cpuElement import CPUElement
from testElement import TestElement

class ALUControl(CPUElement):
    def connect(self, inputSources, outputValueNames, control, outputSignalNames):
        '''
        Connect ALUControl to input source and output
        '''
        CPUElement.connect(self, inputSources, outputValueNames, control, outputSignalNames)

        assert(len(inputSources) == 1), 'ALUControl has only one input'
        assert(len(outputValueNames) == 0), 'ALUControl does not have any output'
        assert(len(control) == 1), 'ALUControl has one control signal'
        assert(len(outputSignalNames) == 1), 'ALUControl has one control output'

        self.inputZero = inputSources[0][1]
        self.controlName = control[0][1]
        self.signalName = outputSignalNames[0]

    def writeOutput(self):
        pass
        # print("Input:", self.inputValues[self.inputZero])
        # print("Control signal: ", self.controlSignals[self.controlName]) 
        

    def setControlSignals(self):
        ALUOp = self.controlSignals[self.controlName]
        Funct = int(self.inputValues[self.inputZero][26:32])
        print("6LSB:", Funct)

        if ALUOp == "00":                                           
            self.outputControlSignals[self.signalName] = 3     
        elif ALUOp == "001":                                           
            self.outputControlSignals[self.signalName] = 14  
        elif ALUOp == "002":                                           
            self.outputControlSignals[self.signalName] = 15         


        elif ALUOp == "01":                                        
            self.outputControlSignals[self.signalName] = 16 
        elif ALUOp == "11":                                        
            self.outputControlSignals[self.signalName] = 17            

        elif ALUOp == "10":                                         #From function field
            if Funct == "100000": #32:
                self.outputControlSignals[self.signalName] = 2 #"0010" add
            elif Funct == "100010": #34
                self.outputControlSignals[self.signalName] = 6      # sub
            elif Funct == "100100": #36
                self.outputControlSignals[self.signalName] = 0 #"0000" and
            elif Funct == "100101": #37
                self.outputControlSignals[self.signalName] = 1      # or
            elif Funct == "100111": #39
                self.outputControlSignals[self.signalName] = 12     # nor
            elif Funct == "101010": #42:
                self.outputControlSignals[self.signalName] = 7      # slt
            elif Funct == "100001": 
                self.outputControlSignals[self.signalName] = 8      # Addu
            elif Funct == "100011": 
                self.outputControlSignals[self.signalName] = 9      # Subu  

        # print(self.outputControlSignals)
        

class TestALU_Control(unittest.TestCase):
    def setUp(self):
        self.ALUCo = ALUControl()
        self.testInput = TestElement()
        self.testOutput = TestElement()

        self.testInput.connect(
            [],
            ['data'],                           #funct
            [],
            ['alucontrolSignal']               #ALUop
        )

        self.ALUCo.connect(
            [(self.testInput, 'data')],                 #inn->funct
            [],
            [(self.testInput, 'alucontrolSignal')],    #kontrollsignal->ALUop
            ['alucontrolOutput']
        )

        self.testOutput.connect(
            [],
            [],
            [(self.ALUCo, 'alucontrolOutput')],
            []
        )

  