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
print(freq, IR)
x = np.linspace(0, 1.5*max(freq),2000)
y_ir = np.zeros(x.shape)
y_raman = np.zeros(x.shape)
gamma = 3.5
freq = np.array(freq)
IR = np.array(IR)
for f,ir,raman in zip(freq,IR, Raman):
	temp = 1/pi* gamma/((x-f)**2+gamma**2)
	y_ir+=ir*temp
	y_raman += raman*temp
	print(f,ir)
plt.plot(x,y_ir,label="Raman spectrum %s"%sys.argv[1][:-4])
plt.xlim(min(freq)*0.75, max(freq)*1.25)
plt.ylim(0,max(y_ir)*1.2)
plt.xlabel("Frequency, cm-1")
plt.ylabel("Raman intensity")
plt.legend()
plt.savefig("IR_%s"%sys.argv[1][:-4]+'.pdf')

plt.clf()

plt.plot(x,y_raman,label="IR spectrum %s"%sys.argv[1][:-4])
plt.xlim(min(freq)*0.75, max(freq)*1.25)
plt.xlabel("Frequency, cm-1")
plt.ylabel("IR intensity")
plt.legend()
plt.savefig("Raman_%s"%sys.argv[1][:-4]+'.pdf')