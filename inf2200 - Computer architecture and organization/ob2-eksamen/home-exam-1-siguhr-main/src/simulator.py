'''
Code written for inf-2200, University of Tromso
'''

import sys
from mipsSimulator import MIPSSimulator

def runSimulator(sim):
    #Replace this with your own main loop!
    run = 1

    tick = 0
    while (run):
        
        sim.tick()
        if sim.tick() == False:
            run = 0

        print("_TICK_\n = %s\n" %tick)
        #sim.tick()
        print("Int address:", sim.pc.currentAddress())
        print("Hex address;", hex(sim.pc.currentAddress()))
        print("Register: ", sim.registerFile.printAll())
        print("\nNumber of cycles: ", sim.nCycles)
       
        
        tick += 1


if __name__ == '__main__':
    assert(len(sys.argv) == 2), 'Usage: python %s memoryFile' % (sys.argv[0],)
    memoryFile = sys.argv[1]
    
    simulator = MIPSSimulator(memoryFile)
    runSimulator(simulator)

