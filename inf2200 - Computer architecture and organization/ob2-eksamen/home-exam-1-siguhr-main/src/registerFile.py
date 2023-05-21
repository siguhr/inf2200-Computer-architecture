'''
Code written for inf-2200, University of Tromso
'''

import unittest
from cpuElement import CPUElement
import common
from testElement import TestElement


class RegisterFile(CPUElement):
    
    def __init__(self):
        # Dictionary mapping register number to register value
        self.register = {}

        self.registerNames = ['$zero', '$at', '$v0', '$v1', '$a0', '$a1', '$a2', '$a3',
                            '$t0', '$t1', '$t2', '$t3', '$t4', '$t5', '$t6', '$t7',
                            '$s0', '$s1', '$s2', '$s3', '$s4', '$s5', '$s6', '$s7',
                            '$t8', '$t9', '$k0', '$k1', '$gp', '$sp', '$fp', '$ra']

         # All registers default to 0
        for i in range(0, 32):
            self.register[i] = 0 


    def connect(self, inputSources, outputValueNames, control, outputSignalNames):
        CPUElement.connect(self, inputSources,outputValueNames, control, outputSignalNames)


        assert(len(inputSources) == 4), 'register should have four inputs'
        assert(len(outputValueNames) == 2), 'register has two output'
        assert(len(control) == 1), 'register has one control signal'
        assert(len(outputSignalNames) == 0), 'register has zero control output'

        self.inputZero = inputSources[0][1]           #input
        self.inputOne = inputSources[1][1]
        self.input_regiserWrite = inputSources[2][1]
        self.input_dataWrite = inputSources[3][1]

        self.RegWrite = control[0][1]                   #control signal

        self.outputZero = outputValueNames[0]         #output
        self.outputOne = outputValueNames[1]

        

    def writeOutput(self):

        

        print(self.controlSignals)
        print("Input values: ",self.inputValues)
        #print("Input WriteData ",self.inputValues[self.input_dataWrite])

        
        self.outputValues[self.outputZero] = self.inputValues[self.inputZero]
        self.outputValues[self.outputOne] = self.inputValues[self.inputOne]

        self.outputValues[self.outputZero] = self.register[int(self.outputValues[self.outputZero], base=2)]
        self.outputValues[self.outputOne] = self.register[int(self.outputValues[self.outputOne], base=2)]


        #
        
        RegWrite = self.controlSignals[self.RegWrite]

        if RegWrite == 1:
            self.register[self.inputValues[self.input_regiserWrite]] = self.inputValues[self.input_dataWrite]
          

            
       

        print("Register Write: ",self.inputValues[self.input_regiserWrite])
        print("data Write: ",self.inputValues[self.input_dataWrite])
       
        # print(self.controlSignals)
        # print("Read data1 :",int(self.outputValues[self.outputZero]))
        # print("Read data2 :",int(self.outputValues[self.outputOne]))

        
    def printAll(self):

        # Note that we won't actually use all the registers listed here...
        self.registerNames = ['$zero', '$at', '$v0', '$v1', '$a0', '$a1', '$a2', '$a3',
                            '$t0', '$t1', '$t2', '$t3', '$t4', '$t5', '$t6', '$t7',
                            '$s0', '$s1', '$s2', '$s3', '$s4', '$s5', '$s6', '$s7',
                            '$t8', '$t9', '$k0', '$k1', '$gp', '$sp', '$fp', '$ra']
        
        '''
        Print the name and value in each register.
        '''
        print()
        print("Register file")
        print("================")
        for i in range(0, 32):
            print("%s \t=> %s (%s)" % (self.registerNames[i], common.fromUnsignedWordToSignedWord(
                self.register[i]), hex(int(self.register[i]))[:-1]))
        print("================")
        print()
        print()

       

      

    


class TestRegisterFile(unittest.TestCase):
    def setUp(self):
        self.registerFile = RegisterFile()
        self.testInput = TestElement()
        self.testOutput = TestElement()
        self.testControl = TestElement() ##

        self.testInput.connect(
            [],
            ['registerOne', 'registerTwo', 'registerWrite','dataWrite'],
            [],
            ['regControl']
        )
        
        self.registerFile.connect(
            [(self.testInput, 'registerOne'), (self.testInput, 'registerTwo'), (self.testInput, 'registerWrite'), (self.testInput, 'dataWrite')],
            ['Data1', 'Data2'],
            [(self.testInput, 'regControl')],
            []
        )
        
        self.testOutput.connect(
            [(self.registerFile, 'Data1'), (self.registerFile, 'Data2')],
            [],
            [],
            []
        )

        # Implement me!
        #pass

    def test_correct_behavior(self):
        self.registerFile.register[0] = 10
        self.registerFile.register[1] = 20

        self.testInput.setOutputValue('registerOne', bin(0))
        self.testInput.setOutputValue('registerTwo', bin(1))
        self.testInput.setOutputValue('registerWrite', bin(0))
        self.testInput.setOutputValue('dataWrite', bin(5))

        self.testInput.setOutputValue('regControl', 0)

        self.registerFile.readInput()
        self.registerFile.readControlSignals()
        self.registerFile.writeOutput()
        self.testOutput.readInput()
        #self.testControl.setControlSignals() ## 

        output1 = self.testOutput.inputValues['Data1']
        output2 = self.testOutput.inputValues['Data2']

        self.assertEqual(output1, 10)
        self.assertEqual(output2, 20)
        self.assertEqual(self.registerFile.register[0], 10)

        self.testInput.setOutputControl('regControl', 1)

        self.registerFile.readInput()
        self.registerFile.readControlSignals()
        self.registerFile.writeOutput()
        self.testOutput.readInput()
        
        output1 = self.testOutput.inputValues['Data1']
        output2 = self.testOutput.inputValues['Data2']

        self.assertEqual(output1, 10)
        self.assertEqual(output2, 20)
        self.assertEqual(self.registerFile.register[0], bin(5))


        # Implement me!
        #pass


if __name__ == '__main__':
    unittest.main()
