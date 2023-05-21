

import unittest
from cpuElement import CPUElement
from testElement import TestElement

class EXMEM(CPUElement):
    def connect(self, inputSources, outputValueNames, control, outputSignalNames):
        '''
        Connect mux to input sources and controller
        
        Note that the first inputSource is input zero, and the second is input 1
        '''
        CPUElement.connect(self, inputSources, outputValueNames, control, outputSignalNames)
        
        assert(len(inputSources) == 4), 'EXMEM should have 4 inputs'
        assert(len(outputValueNames) == 4), 'EXMEM has 4 output'
        assert(len(control) == 6), 'EXMEM has 6 control signal'
        assert(len(outputSignalNames) == 6), 'EXMEM have 6 control output'

        #input
        self.input_0 = inputSources[0][1]
        self.input_1 = inputSources[1][1]
        self.input_2 = inputSources[2][1]
        self.input_3 = inputSources[3][1]

        #output
        self.output_0 = outputValueNames[0] #AdressToMux
        self.output_1 = outputValueNames[1] #DataMemAddress
        self.output_2 = outputValueNames[2] #DataMemWriteData
        self.output_3 = outputValueNames[3] #RegWriteData
        
        #contol-inn
        self.control_0 = control[0][1]  #Branch
        self.control_1 = control[1][1]  #Zero
        self.control_2 = control[2][1]  #MemWrite
        self.control_3 = control[3][1]  #MemRead
        self.control_4 = control[4][1]  #MemToReg
        self.control_5 = control[5][1]  #RegWrite

        #control-out
        self.output_control_0 = outputSignalNames[0]  #Branch
        self.output_control_1 = outputSignalNames[1]  #Zero
        self.output_control_2 = outputSignalNames[2]  #MemWrite
        self.output_control_3 = outputSignalNames[3]  #MemRead
        self.output_control_4 = outputSignalNames[4]  #MemToReg
        self.output_control_5 = outputSignalNames[5]  #RegWrite

        

    def writeOutput(self):
        self.outputValues[self.output_0] = self.inputValues[self.input_0]
        self.outputValues[self.output_1] = int(self.inputValues[self.input_1], base=2)
        self.outputValues[self.output_2] = self.inputValues[self.input_2]
        self.outputValues[self.output_3] = self.inputValues[self.input_3]

        # print("Input:", self.inputValues)
        # print("Input:", self.outputValues)

    def setControlSignals(self):
        self.outputControlSignals[self.output_control_0] = self.controlSignals[self.control_0]
        self.outputControlSignals[self.output_control_1] = self.controlSignals[self.control_1]
        self.outputControlSignals[self.output_control_2] = self.controlSignals[self.control_2]
        self.outputControlSignals[self.output_control_3] = self.controlSignals[self.control_3]
        self.outputControlSignals[self.output_control_4] = self.controlSignals[self.control_4]
        self.outputControlSignals[self.output_control_5] = self.controlSignals[self.control_5]
        
        # print("Input control:", self.controlSignals)
        # print("Output control:", self.outputControlSignals)