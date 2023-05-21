from cpuElement import CPUElement


class JMPAddress(CPUElement):
  def connect(self, inputSources, outputValueNames, control, outputSignalNames):
    CPUElement.connect(self, inputSources, outputValueNames, control, outputSignalNames)

    assert(len(inputSources) == 2), 'Adder should have two inputs'
    assert(len(outputValueNames) == 1), 'Adder has only one output'
    assert(len(control) == 0), 'Adder should not have any control signal'
    assert(len(outputSignalNames) == 0), 'Adder should not have any control output'

    self.inputZero = inputSources[0][1]
    self.inputOne = inputSources[1][1]

    self.outputName = outputValueNames[0]

  def writeOutput(self):
    
    print("Input pcAddressinput:", self.inputValues[self.inputZero])
    print("Input shift:", self.inputValues[self.inputOne])
    


    
    
    pcAddress = bin(self.inputValues[self.inputZero])[2:6]
    #print("pcAddressBit:", pcAddress)

    shiftAddress = bin(self.inputValues[self.inputOne])[2:32]
    #print("ShiftAddressBit:", shiftAddress)

    BFC00200 = (pcAddress + shiftAddress)
    #print("BFC00200:", BFC00200)

    BFC00200int = int(BFC00200, 2)
    #print("BFC00200int:", BFC00200int)

    self.outputValues[self.outputName] = BFC00200int

    
    print("Output:", self.outputValues)
    

    
  

    