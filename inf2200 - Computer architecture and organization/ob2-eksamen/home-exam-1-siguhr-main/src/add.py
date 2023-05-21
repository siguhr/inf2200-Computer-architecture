'''
Implements a simple CPU element for adding two integer operands.

Code written for inf-2200, University of Tromso
'''

from cpuElement import CPUElement

class Add(CPUElement):
    def connect(self, inputSources, outputValueNames, control, outputSignalNames):
        CPUElement.connect(self, inputSources, outputValueNames, control, outputSignalNames)
        
        assert(len(inputSources) == 2), 'Adder should have two inputs'
        assert(len(outputValueNames) == 1), 'Adder has only one output'
        assert(len(control) == 0), 'Adder should not have any control signal'
        assert(len(outputSignalNames) == 0), 'Adder should not have any control output'
        
        # Adder have two inputs. 
        self.TopInput = inputSources [0][1]     #pcAddress
        self.BotImput = inputSources [1][1]     #constant
        self.outputName = outputValueNames[0]   #altered pcAdress
    
        

    def writeOutput(self):
        

        total_sum = 0
        for k in self.inputValues:
            print(self.inputValues[k])
            assert (isinstance(self.inputValues[k], int) or isinstance(self.inputValues[k], int))
            total_sum += self.inputValues[k]

        self.outputValues[self.outputName] = total_sum & 0xffffffff  

        
        
        #print(self.outputValues)
        #print("Add output: ", self.outputValues)                         # Convert to 32-bit (ignore overflow)
#                                                                    # MIPS computer starts at address 0x00000000 
#                                                                       and extends in sequential, contiguous
#                                                                      order to address 0xffffffff.
