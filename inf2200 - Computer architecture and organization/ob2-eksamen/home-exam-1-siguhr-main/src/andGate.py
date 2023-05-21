from cpuElement import CPUElement

class AndGate(CPUElement):
    def connect(self, inputSources, outputValueNames, control, outputSignalNames):
        CPUElement.connect(self, inputSources, outputValueNames, control, outputSignalNames)

        assert (len(inputSources) == 0), "AndGate has no input"
        assert (len(outputValueNames) == 0), "AndGate has no output"
        assert (len(control) == 2), "AndGate has two control signals"
        assert (len(outputSignalNames) == 1), "AndGate has one control output"

        self.ContSigOne = control[0][1]
        self.ContSigTwo = control[1][1]
        self.result = outputSignalNames[0]

    def writeOutput(self):
        pass # AndGate has no data output

    
    def setControlSignals(self):
        result = self.controlSignals[self.ContSigOne] and self.controlSignals[self.ContSigTwo]

        if result == 1:
            self.outputControlSignals[self.result] = 1

        else:
            self.outputControlSignals[self.result] = 0