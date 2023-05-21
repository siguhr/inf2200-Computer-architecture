import unittest
from cpuElement import CPUElement
import common
from testElement import TestElement


class SignExtend(CPUElement):
    def connect(self, inputSources, outputValueNames, control, outputSignalNames):
        CPUElement.connect(self, inputSources, outputValueNames, control, outputSignalNames)

        assert (len(inputSources) == 1), 'SignExtend has one input'
        assert (len(outputValueNames) == 1), 'SignExtend has one output'
        assert (len(control) == 0), 'SignExtend has no control signal'
        assert (len(outputSignalNames) == 0), 'SignExtend has no control output'

        self.input_Data = inputSources[0][1]
        self.SiEx_output_Data = outputValueNames[0]


    def writeOutput(self):
        #print("Input", self.inputValues)


        inputAddress = self.inputValues[self.input_Data]
        if inputAddress[2] == "0000001000001000":   #"1": #
            extend = "0000000000000000" 
            sum =  format(int(inputAddress, 2), "016b") + extend 
        
            print("sum1:", sum)
        
        else:
            extend = "0000000000000000"
            sum =   extend + format(int(inputAddress, 2), "016b")
            print("sum2:", sum)

        self.outputValues[self.SiEx_output_Data] = sum

        
        
        #print("BiCode:", self.outputValues)
        #print("SignExtend - Output: ", self.outputValues[self.SiEx_output_Data])

class TestSigExtend(unittest.TestCase):
    def setUp(self):
        self.siEx = SignExtend()
        self.testInput = TestElement()
        self.testOutput = TestElement()
        
        self.testInput.connect(
            [],
            ['dataA'],
            [],
            []
        )
        
        self.siEx.connect(
            [(self.testInput, 'dataA')], 
            ['siExData'],
            [],
            []
        )
        
        self.testOutput.connect(
            [(self.siEx, 'siExData')],
            [],
            [],
            []
        )
    
    def test_correct_behavior(self):
        self.testInput.setOutputValue("dataA", bin(32768))

        self.siEx.readInput()
        self.siEx.readControlSignals()
        self.siEx.writeOutput()
        self.testOutput.readInput()
        output = self.testOutput.inputValues["siExData"]

        self.assertEqual(output, format(int(bin(32768), 2), "#034b"))
        

        
if __name__ == '__main__':
    unittest.main()
