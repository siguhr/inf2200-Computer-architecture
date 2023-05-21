

import unittest
from cpuElement import CPUElement
from testElement import TestElement

class IFID(CPUElement):
    def connect(self, inputSources, outputValueNames, control, outputSignalNames):
        '''
        Connect mux to input sources and controller
        
        Note that the first inputSource is input zero, and the second is input 1
        '''
        CPUElement.connect(self, inputSources, outputValueNames, control, outputSignalNames)
        
        assert(len(inputSources) == 2), 'IFID should have two inputs'
        assert(len(outputValueNames) == 7), 'IFID has seven output'
        assert(len(control) == 0), 'IFID has no control signal'
        assert(len(outputSignalNames) == 0), 'IFID does not have any control output'
        
        #input
        self.input_0 = inputSources[0][1] #address_input
        self.input_1 = inputSources[1][1] #IM_input

        

        #output
        self.output_0 = outputValueNames[0]   #address_output

        self.output_1 = outputValueNames[1]    #control_output 
        self.output_2 = outputValueNames[2]    #ReadReg1_output
        self.output_3 = outputValueNames[3]    #ReadReg2_output
        self.output_4 = outputValueNames[4]    #to signExtend                       #WrReg_output
        self.output_5 = outputValueNames[5]    #instruction [20-16]
        self.output_6 = outputValueNames[6]    #instruction [15-11]

    def writeOutput(self):
    
        self.outputValues[self.output_0] = self.inputValues[self.input_0]
        self.outputValues[self.output_1] = self.inputValues[self.input_1]

        instruction = bin(self.inputValues[self.input_1])[2:].zfill(32)
        address = self.inputValues[self.input_0]

        self.outputValues[self.output_1] = instruction  #full bitstring
        self.outputValues[self.output_0] = address

        #Split the instruction into five parts as output
        self.outputValues[self.output_2] = instruction[6:11] #.zfill(5)
        self.outputValues[self.output_3] = instruction[11:16] #.zfill(5)
        self.outputValues[self.output_4] = instruction[16:32] #.zfill(16)
        self.outputValues[self.output_5] = instruction[11:16] #.zfill(5)
        self.outputValues[self.output_6] = instruction[16:21] #.zfill(5)
        
        print("Input:", self.inputValues)
        


        # print("Input:", self.inputValues)
        # print("Output:", self.outputValues)
        # print("RR1:", self.outputValues[self.output_2])
        # print("RR2:", self.outputValues[self.output_3])
        # print("sign extend:", self.outputValues[self.output_4])
        # print("20-16:", self.outputValues[self.output_5])
        # print("15-11:", self.outputValues[self.output_6])
        

        #["31-0", "25-21", "20-16", "15-11", "15-0", "25-0"],