import sys 
out = sys.argv[1]
from math import pi
import matplotlib
matplotlib.use('Agg')
import numpy as np 
import matplotlib.pyplot as plt
if len(sys.argv)!=2:
        print("Provide file name")
        sys.exit()
freq = [] 
IR = []
file_ = open(out)
for line in file_:
	if "Frequencies --" in line:
		freq = [ float(x) for x in line.split()[2:] ]
		#print(freq)
		for l in file_:
			if "IR Inten" in l:
				IR = [ float(x)  for x in  l.split()[3:] ]
			if "Raman Activ --" in l:
				Raman = [ float(x) for x in l.split()[3:] ]
				
				break
				