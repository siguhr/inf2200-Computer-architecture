


import unittest
from cpuElement import CPUElement
from testElement import TestElement

class IDEX(CPUElement):
    def connect(self, inputSources, outputValueNames, control, outputSignalNames):
        '''
        Connect mux to input sources and controller
        
        Note that the first inputSource is input zero, and the second is input 1
        '''
        CPUElement.connect(self, inputSources, outputValueNames, control, outputSignalNames)
        
        assert(len(inputSources) == 7), 'IDEX should have seven inputs'
        assert(len(outputValueNames) == 7), 'IDEX has 7 output'
        assert(len(control) == 9), 'IDEX has 9 control signal'
        assert(len(outputSignalNames) == 9), 'IDEX have 9 control output'

        #input
        self.input_0 = inputSources[0][1]   # pcAddress  
        self.input_1 = inputSources[1][1]   # ReadData 1
        self.input_2 = inputSources[2][1]   # ReadData 2
        self.input_3 = inputSources[3][1]   # signExtend
        self.input_4 = inputSources[4][1]   # instruction [20-16] ->mux(1/2)
        self.input_5 = inputSources[5][1]   # instruction [15-11] ->mux(2/2)
        self.input_6 = inputSources[6][1]   # jump



        #output
        self.output_0 = outputValueNames[0] #pcAddress
        self.output_1 = outputValueNames[1] #add input (1/2)
        self.output_2 = outputValueNames[2] #mux input (1/2)

        self.output_3 = outputValueNames[3] #ALUcontrol input

        self.output_4 = outputValueNames[4] #reg mux input (1/2)
        self.output_5 = outputValueNames[5] #reg mux input (2/2)
        self.output_6 = outputValueNames[6] #jump

        

        #control-signal-inn
        self.control_0 = control[0][1]  #RegDst
        self.control_1 = control[1][1]  # ALUSrc
        self.control_2 = control[2][1]  # MemtoReg
        self.control_3 = control[3][1]  # RegWrite
        self.control_4 = control[4][1]  # MemRead
        self.control_5 = control[5][1]  # MemWrite
        self.control_6 = control[6][1]  # Branch
        self.control_7 = control[7][1]  # ALUOp
        self.control_8 = control[8][1]  # Jump


        #control-signal-out
        self.output_control_0 = outputSignalNames[0]  #RegDst
        self.output_control_1 = outputSignalNames[1]  #ALUSrc
        self.output_control_2 = outputSignalNames[2]  #MemtoReg
        self.output_control_3 = outputSignalNames[3]  #RegWrite
        self.output_control_4 = outputSignalNames[4]  #MemRead
        self.output_control_5 = outputSignalNames[5]  #MemWrite
        self.output_control_6 = outputSignalNames[6]  #Branch
        self.output_control_7 = outputSignalNames[7]  #ALUOp
        self.output_control_8 = outputSignalNames[8]  #Jump   

    

        # "RegDst", "ALUSrc", "MemtoReg", "RegWrite", "MemRead", "MemWrite", "Branch", "ALUOp", "Jump"


    def writeOutput(self):

        #print("Input:", self.inputValues)

        
        


        self.outputValues[self.output_0] = self.inputValues[self.input_0]
        self.outputValues[self.output_1] = self.inputValues[self.input_1]
        self.outputValues[self.output_2] = self.inputValues[self.input_2]

        self.outputValues[self.output_3] = self.inputValues[self.input_3]

        self.outputValues[self.output_4] = self.inputValues[self.input_4]
        self.outputValues[self.output_5] = self.inputValues[self.input_5]
        self.outputValues[self.output_6] = self.inputValues[self.input_6]

        #print("Output", self.outputValues)
        #print(self.outputValues[self.output_6])

    def setControlSignals(self):

        #print("ControlSignals inn:", self.controlSignals)
        #print("RegDest inn: ", self.controlSignals[self.control_0])
        #print("RegDest out: ", self.outputControlSignals[self.output_control_0])

        self.outputControlSignals[self.output_control_0] = self.controlSignals[self.control_0]
        self.outputControlSignals[self.output_control_1] = self.controlSignals[self.control_1]
        self.outputControlSignals[self.output_control_2] = self.controlSignals[self.control_2]
        self.outputControlSignals[self.output_control_3] = self.controlSignals[self.control_3]
        self.outputControlSignals[self.output_control_4] = self.controlSignals[self.control_4]
        self.outputControlSignals[self.output_control_5] = self.controlSignals[self.control_5]
        self.outputControlSignals[self.output_control_6] = self.controlSignals[self.control_6]
        self.outputControlSignals[self.output_control_7] = self.controlSignals[self.control_7]
        self.outputControlSignals[self.output_control_8] = self.controlSignals[self.control_8]
        
        #print("ControlSignals out:", self.outputControlSignals)
       
        
        