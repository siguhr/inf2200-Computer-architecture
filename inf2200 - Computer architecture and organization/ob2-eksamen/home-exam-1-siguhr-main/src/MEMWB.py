
import unittest
from cpuElement import CPUElement
from testElement import TestElement

class MEMWB(CPUElement):
    def connect(self, inputSources, outputValueNames, control, outputSignalNames):
        '''
        Connect mux to input sources and controller
        
        Note that the first inputSource is input zero, and the second is input 1
        '''
        CPUElement.connect(self, inputSources, outputValueNames, control, outputSignalNames)
        
        assert(len(inputSources) == 3), 'MEMWB should have 3 inputs'
        assert(len(outputValueNames) == 3), 'MEMWB has 3 output'
        assert(len(control) == 2), 'MEMWB has 2 signal'
        assert(len(outputSignalNames) == 2), 'MEMWB have 2 control output'

        #input
        self.input_0 = inputSources[0][1]   # ReadData  
        self.input_1 = inputSources[1][1]   # Ex/MEM
        self.input_2 = inputSources[2][1]   # RegWriteData
        
        #output
        self.output_0 = outputValueNames[0] # MuxInput1
        self.output_1 = outputValueNames[1] # MuxInput2
        self.output_2 = outputValueNames[2] # RegWriteData

        #contol-inn
        self.control_0 = control[0][1]  #MemToReg
        self.control_1 = control[1][1]  #RegWriteData

        #control-out
        self.output_control_0 = outputSignalNames[0]  #MemToReg
        self.output_control_1 = outputSignalNames[1]  #RegWriteData

    def writeOutput(self):

        #print("Input: ", self.inputValues)

        self.outputValues[self.output_0] = self.inputValues[self.input_0]
        self.outputValues[self.output_1] = self.inputValues[self.input_1]
        self.outputValues[self.output_2] = int(self.inputValues[self.input_2], base=2)

        #print("Output: ", self.outputValues)
    
    def setControlSignals(self):
        self.outputControlSignals[self.output_control_0] = self.controlSignals[self.control_0]
        self.outputControlSignals[self.output_control_1] = self.controlSignals[self.control_1]