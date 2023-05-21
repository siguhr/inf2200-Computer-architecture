'''
Code written for inf-2200, University of Tromso
'''

from cpuElement import CPUElement

class PC(CPUElement):
    def __init__(self, baseaddr):
        self.baseaddr = baseaddr
    
    def connect(self, inputSources, outputValueNames, control, outputSignalNames):
        CPUElement.connect(self, inputSources, outputValueNames, control, outputSignalNames)
        
        assert(len(inputSources) == 1), 'PC should have one input'
        assert(len(outputValueNames) == 1), 'PC has only one output'
        assert(len(control) == 0), 'PC has no control input'
        assert(len(outputSignalNames) == 0), 'PC should not have any control output'
        
        self.inputField_newPcAddress = inputSources[0][1]
        self.outputField_pcAddress = outputValueNames[0]
        
        self.inputValues[self.inputField_newPcAddress] = self.baseaddr # initialize PC
        print("input: " , self.inputValues )

        self.binaddress = bin(self.inputValues[self.inputField_newPcAddress])[0:6]


    def writeOutput (self):
        self.outputValues[self.outputField_pcAddress] = self.inputValues[self.inputField_newPcAddress]
        #print("Address int:", self.outputValues)
        #print("Address hex:", hex(self.outputValues))
        #print("input: " , self.inputValues )

    def currentAddress (self):
        return self.inputValues[self.inputField_newPcAddress]
        