'''
Implements base class for memory elements.

Note that since both DataMemory and InstructionMemory are subclasses of the Memory
class, they will read the same memory file containing both instructions and data
memory initially, but the two memory elements are treated separately, each with its
own, isolated copy of the data from the memory file.

Code written for inf-2200, University of Tromso
'''

import unittest
from cpuElement import CPUElement
import common

class Memory(CPUElement):
    def __init__(self, filename):
    
        # Dictionary mapping memory addresses to data
        # Both key and value must be of type 'long'
        self.memory = {}
        
        self.initializeMemory(filename)
    
    def initializeMemory(self, filename):
        '''
        Helper function that reads initializes the data memory by reading input
        data from a file.
        '''


        #########

        caracters = 0
        tuple = []

        #mem file read
        with open(filename) as f:
            #text
            for line in f:
                #caracter
                for caracter in line.split():
                    # if line not = 0
                    if line[0] != "0":
                        pass
                   

                    else:
                        #1
                        if caracters == 0:
                            tuple.append(caracter)
                            caracters = 1

                        #2
                        elif caracters == 1:
                            tuple.append(caracter)
                            caracters = 2

                        #3
                        if caracters == 2:
                            self.memory[int(tuple[0], base=16)] = int(tuple[1], base=16)
                            caracters = 0
                            tuple.pop(1)
                            tuple.pop(0)
                            break




        
    def printAll(self):
        for key in sorted(self.memory.keys()):
            print("%s\t=> %s\t(%s)" % (hex(int(key)), common.fromUnsignedWordToSignedWord(self.memory[key]), hex(int(self.memory[key]))))

class TestMemory(unittest.TestCase):
    def setUp(self):
        self.memory = Memory("add.mem")
        self.file = open("add.mem", "r")
        self.memAddress = None
        self.binCode = None
    
    def test_correct_behavior(self):
        for line in self.file:
            data = line.split("\t")

            if data[0][0] != "#":
                self.memAddress = data[0]
                self.binCode = data[1]
        
        test_case = self.memory.memory[self.memAddress]
        self.assertEqual(test_case, self.binCode)

        self.file.close()

if __name__ == '__main__':
  unittest.main()



            

        