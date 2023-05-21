'''
Code written for inf-2200, University of Tromso
'''

#from common import B
from pc import PC
from add import Add
from mux import Mux
from instructionMemory import InstructionMemory


from registerFile import RegisterFile
from dataMemory import DataMemory
from constant import Constant
from randomControl import RandomControl

from controlUnit import ControlUnit
from alu import ALU
from signExtend import SignExtend
from andGate import AndGate
from shiftLeftTwo import LeftShiftTwo
from jmpAddress import JMPAddress
from aluControl import ALUControl


from randomControl import RandomControl

#### ny ####
from IFID import IFID
from IDEX import IDEX
from EXMEM import EXMEM
from MEMWB import MEMWB

class MIPSSimulator():
    '''Main class for MIPS pipeline simulator.

    Provides the main method tick(), which runs pipeline
    for one clock cycle.

    '''

    def __init__(self, memoryFile):
        self.nCycles = 0  # Used to hold number of clock cycles spent executing instructions

        self.dataMemory = DataMemory(memoryFile)
        self.instructionMemory = InstructionMemory(memoryFile)
        self.registerFile = RegisterFile()

        self.alu = ALU()
        self.aluControl = ALUControl()    ###
        self.controlUnit = ControlUnit()
        
        self.signExtend = SignExtend()
        self.andGate = AndGate()
        #self.breaker = Breaker() 

        self.constant3 = Constant(3)
        self.constant4 = Constant(4)
        self.randomControl = RandomControl()

        self.pcMux1 = Mux()
        self.pcMux2 = Mux()
        self.regMux = Mux()
        self.aluMux = Mux()
        self.resultMux = Mux()
        #self.luiMux = Mux()

        self.jmpAddress = JMPAddress()
        self.shiftBranch = LeftShiftTwo()
        self.shiftJump = LeftShiftTwo()

        #self.adder = Add()
        self.Mux2Adder = Add() #?
        self.pcAdder = Add()

        #vurder
        #self.splitt = Splitter()
        self.ifid = IFID()
        self.idex = IDEX()
        self.exmem = EXMEM()
        self.memwb = MEMWB()
        

        self.pc = PC(0xbfc00000)    #self.startAddress())



        self.elements = [self.constant4, self.pcAdder, self.instructionMemory,  self.ifid,                             #  Element order
                         self.registerFile, self.signExtend,  self.shiftJump, self.jmpAddress, self.controlUnit,       
                         self.idex, self.aluControl, self.aluMux, self.alu, self.shiftBranch, self.Mux2Adder, 
                         self.regMux, self.exmem, self.pcMux1, self.pcMux2, self.dataMemory, self.andGate, self.memwb,
                         self.resultMux, self.registerFile]                       


        self._connectCPUElements()

    def _connectCPUElements(self):          # Element connection

        ######### step A #########

    

        self.constant4.connect(
            [],
            ['constant'],
            [],
            []
        )


        self.randomControl.connect(
            [],
            [],
            [],
            ['randomSignal']
        )

        #Connects pcMux2 with pc. output = pcadress (new pcAddress)
        self.pc.connect(
            [(self.pcMux2, 'muxOut')],
            ['pcAddress'],
            [],
            []
        )


        #Connects pcAdder to IF/ID register
        self.pcAdder.connect(
            [(self.pc, 'pcAddress'),(self.constant4, 'constant')],
            ['sum'],
            [],
            []
        )

       
        self.pcMux2.connect(
            [(self.pcMux1, 'ResultMux2'), (self.idex, "jump")],
            ['muxOut'],
            [(self.idex, 'Jump')],
            []
        )


        

        self.instructionMemory.connect(
            [(self.pc, "pcAddress")],
            ["Instruction"],
            [],
            []
        )


        ######### step IF/ID ##########

        self.ifid.connect(
            [(self.pcAdder, "sum"), (self.instructionMemory, "Instruction")],
            ["pcAddress", "control_input", "ReadReg1", "ReadReg2", "signExtend", 
             "instruction20-16", "instruction15-11"],
            [],
            []
        )

         ######### step B ##########

        self.registerFile.connect(
            [(self.ifid, "ReadReg1"), (self.ifid, "ReadReg2"), (self.memwb, "WriteRegister"), (self.resultMux, "WriteData")],   ###################
            ["Read1", "Read2"],
            [(self.memwb, "RegWrite")],
            []
        )


        self.signExtend.connect(
            [(self.ifid, "signExtend")],
            ["ExtendedValue"],
            [],
            []
        )

        self.controlUnit.connect(
            [(self.ifid, "control_input")], #31-0
            [],
            [],
            ['RegDst', 'ALUSrc', 'MemToReg',
            'RegWrite', 'MemRead', 'MemWrite',
            'Branch', 'ALUOp', 'Jump']
        )


        

        ######### step ID/EX ##########

        self.idex.connect(
            [(self.ifid, "pcAddress"), (self.registerFile, "Read1"), (self.registerFile, "Read2"),
             (self.signExtend, "ExtendedValue"),  (self.ifid, "instruction20-16"),
             (self.ifid, "instruction15-11"), (self.jmpAddress, "ResultJump")],
            ["pcAddress", "ALUInput1_exmem", "ALUInput2_mux", "ALUcontrol_Mux_ShiftBranch", "regMux1", "regMux2", "jump"],
            [(self.controlUnit, "RegDst"), (self.controlUnit, "ALUSrc"), (self.controlUnit, "MemToReg"), 
             (self.controlUnit, "RegWrite"),(self.controlUnit, "MemRead"), (self.controlUnit, "MemWrite"),
             (self.controlUnit, "Branch"),(self.controlUnit, "ALUOp"), (self.controlUnit, "Jump")],
             ["RegDst", "ALUSrc", "MemToReg", "RegWrite", "MemRead", "MemWrite", "Branch", "ALUOp", "Jump"] #["RegDst", "ALUSrc", "MemToReg", "RegWrite", "MemRead", "MemWrite", "Branch", "ALUOp", "Jump"] 
        )       

        ######### step C ##########

        self.regMux.connect(
            [(self.idex, "regMux1"), (self.idex, "regMux2")],
            ["WReg"],
            [(self.controlUnit, "RegDst")],
            []
        )

        
        self.shiftBranch.connect(
            [(self.idex, "ALUcontrol_Mux_ShiftBranch")],
            ["ShiftedValue"],
            [],
            []
        )



        self.Mux2Adder.connect(
            [(self.idex, "pcAddress"), (self.shiftBranch, "ShiftedValue")],
            ["branchSum"],
            [],
            []
        )


        self.aluMux.connect(
            [(self.idex, "ALUInput2_mux"),(self.idex, "ALUcontrol_Mux_ShiftBranch") ],          #(self., "LuiOutput")],
            ["aluMuxInput"],
            [(self.idex, "ALUSrc")], #ALUOp
            []
        )

        self.aluControl.connect(
            [(self.idex, "ALUcontrol_Mux_ShiftBranch")],
            [],
            [(self.idex, "ALUOp")],
            ["ALUOp"]
        )

        self.alu.connect(
            [(self.idex, "ALUInput1_exmem"), (self.aluMux, "aluMuxInput")],
            ["Result_alu"],
            [(self.aluControl, "ALUOp")],
            ["Zero"]
        )

        ######### step EX/MEM ##########

        self.exmem.connect(
            [(self.Mux2Adder, "branchSum"), (self.alu, "Result_alu"), (self.idex, "ALUInput1_exmem"),
             (self.regMux, "WReg")],
            ["AdressToMux1", "DataMemAddress", "DataMemWriteData", "WReg"],
            [(self.alu, "Zero"), (self.idex, "Branch"), (self.idex, "MemWrite"), 
             (self.idex, "MemRead"), (self.idex, "MemToReg"), (self.idex, "RegWrite")],
            ["Zero", "Branch", "MemWrite", "MemRead", "MemToReg", "WriteBack"]
        )
        
        ######### step D #########

        self.dataMemory.connect(
            [(self.exmem, "DataMemAddress"), (self.exmem, "DataMemWriteData")],
            ["ReadData"],
            [(self.exmem, "MemWrite"), (self.exmem, "MemRead")],
            []
        )

        self.andGate.connect(                                   
            [],
            [],
            [(self.exmem, "Branch"), (self.exmem, "Zero")],         
            ["PCMuxSelect"]
        )

        self.pcMux1.connect(
            [(self.idex, "pcAddress"), (self.exmem, "AdressToMux1")],
            ["ResultMux2"],
            [(self.andGate, "PCMuxSelect")],
            []
        )


        ####### Jump ########



        self.shiftJump.connect(
            [(self.ifid, "control_input")],
            ["ShiftedValue"],
            [],
            []
        )

        
       
        self.jmpAddress.connect(
            [(self.ifid, "pcAddress"), (self.shiftJump, "ShiftedValue")],
            ["ResultJump"],
            [],
            []
        )
        
        ####### MEM/WB ########

        self.memwb.connect(
            [(self.dataMemory, "ReadData"), (self.exmem, "DataMemAddress"), (self.exmem, "WReg")],
            ["resultMux1", "resultMux2", "WriteRegister"],
            [(self.exmem, "MemToReg"), (self.exmem,"WriteBack")],
            ["MemToReg", "RegWrite"]
        )


        ##############################        


        self.resultMux.connect(
            [(self.memwb, "resultMux1"), (self.memwb, "resultMux2")],
            ["WriteData"],
            [(self.controlUnit, "MemToReg")],
            []
        )



    



    def startAddress(self):
        '''
        Returns first Instruction from Instruction memory
        '''
        return next(iter(sorted(self.insMem.memory.keys())))

    def clockCycles(self):
        '''Returns the number of clock cycles spent executing instructions.'''

        return self.nCycles

    def dataMemory(self):
        '''Returns dictionary, mapping memory addresses to data, holding
        data memory after instructions have finished executing.'''

        return self.dataMemory.memory

    def registerFile(self):
        '''Returns dictionary, mapping register numbers to data, holding
        register file after instructions have finished executing.'''

        return self.registerFile.register

    def printDataMemory(self):
        self.dataMemory.printAll()

    def printRegisterFile(self):
        self.registerFile.printAll()

    def tick(self):
        '''Execute one clock cycle of pipeline.'''

        self.nCycles += 1

        # The following is just a small sample implementation
        self.pc.writeOutput()

        for elem in self.elements:

            

            print("\ncurrt_elem = %s" %elem.__class__.__name__)
            elem.readControlSignals()
            elem.readInput()
            if elem.__class__.__name__ == "InstructionMemory":
                if InstructionMemory.stop(elem) == False:
                    return False
            elem.writeOutput()  
            elem.setControlSignals()

        self.pc.readInput()   #fra pc base address -> resten av elementene -> pc update og looper den


        