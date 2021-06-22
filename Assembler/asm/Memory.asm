# all numbers in hex format
# we always start by reset signal
#this is a commented line
.ORG 0  #this means the the following line would be  at address  0 , and this is the reset address
10
#you should ignore empty lines

.ORG 2  #this is the interrupt address
100

.ORG 10
in R2        #R2=19 add 19 in R2         	#10
in R3        #R3=FFFF                    	#11
in R4        #R4=F320                    	#12
LDM R1,5     #R1=5                       	#13
PUSH R1      #SP=FFFFFFFC,M[FFFFFFFE]=5 	#15
PUSH R2      #SP=FFFFFFFA,M[FFFFFFFC]=19	#16
POP R1       #SP=FFFFFFFC,R1=19         	#17
POP R2       #SP=FFFFFFFE,R2=5          	#18
in R5        #R5= 10                     	#19
NOP											#1A				LOAD USE
STD R2,200(R5)   #M[210]=5               	#1B
STD R1,202(R5)   #M[212]=19              	#1D
LDD R3,202(R5)   #R3=19                  	#1F
LDD R4,200(R5)   #R4=5                   	#21
