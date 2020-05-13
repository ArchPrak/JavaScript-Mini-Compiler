
def move(line):
    res=[]
    #print("line 2:",line[2])
    if line[2].isnumeric():
        op1= '#' + line[2]
        st1="MOV r0, "+ op1
    else:
        op1=line[2]
        st1="LDR r0, "+ op1
    dest=line[0]
    
    res.append(st1)
    res.append("STR r0, " + dest)
    return res

def notst(line):
    dest=line[0]
    src=line[3]

    res=[]
    res.append("LDR r0, "+src)
    res.append("CMP r0, #0")
    res.append("MOVEQ r1, #1")
    res.append("MOVGT r1, #0")
    res.append("STR r1, "+dest)

    return res

def ifst(line):
    cvar=line[1]        # condition variable
    label=line[3]       # label to branch to
    res=[]
    if cvar.isnumeric():
        res.append("CMP #"+cvar+", #0")
        res.append("BNE "+ label)
    else:
        res.append("LDR r0,"+ cvar)
        res.append("CMP r0, #0")
        res.append("BNE "+ label)
    return res

def relop(line):
    dest=line[0]
    #print("line [2] : ",line[2])
    if line[2].isnumeric():
        op1= "#"+line[2]
    else:
        op1=line[2]
    if line[4].isnumeric():
        op2="#"+line[4]
    else:
        op2=line[4]
    res=[]    
    res.append("CMP "+ op1+ " , " + op2)

    if line[3]=='<':
        opn1="MOVLT r0, "
        opn2="MOVGE r0, "
    
    elif line[3]=='<=':
        opn1="MOVLE r0, "
        opn2="MOVGT r0, "
        
    elif line[3]=='==':
        opn1="MOVEQ r0, "
        opn2="MVNEQ r0, "
    
    elif line[3]=='>':
        opn1="MOVGT r0, "
        opn2="MOVLE r0, "
        
    elif line[3]=='>=':
        opn1="MOVGE r0, "
        opn2="MOVLE r0, "
        
    elif line[3]=='!=':
        opn1="MVNEQ r0, "
        opn2="MOVEQ r0, "
        
    res.append(opn1 + "#1")
    res.append(opn2 + "#0")
    res.append("STR r0, "+dest)
    return res


#c= a+b
#ldr r0,a
#ldr r1,b
#add r2,r1,r0
#str r2, c
def operation(line):    
    
    dest=line[0]
    if line[2].isnumeric():
        op1= "#"+line[2]
    else:
        op1=line[2]
    if line[4].isnumeric():
        op2="#"+line[4]
    else:
        op2=line[4]
        
    
    if line[3]=='+':
        op='ADD'
    elif line[3]=='-':
        op='SUB'
    elif line[3]=='*':
        op='MUL'    
    
    
    res=[]
    res.append("LDR r1, "+ op1)
    res.append("LDR r2, "+ op2)
    res.append(op+" r3, r1, r2")
    res.append("STR r3, "+ dest)
    return res

#to decide which function is to be called
def entry(line):
    
    relops=set(['>=','>','<','<=','==','!='])
    mops=set(['-','+','*'])
    line=line.split()
    #print("input: ",line)
    res=[]
    if len(line)==2:
        if line[0]=='goto':       # goto L1  
            line[0]='BR'
            res=line
        else:
            res=[line[0]+line[1]] # L0:
    elif '=' in line:
        if len(line)==3:
            res=move(line)
        elif line[3] in relops:
            res=relop(line)
        elif line[3] in mops:
            res=operation(line)
        elif 'not' in line:
            res=notst(line)
    elif 'if' in line:
        res=ifst(line)
    return res

# fetching optimised ICG as input #####################

f1=open("optout.txt")
lines=f1.readlines()

# preprocessing ######################

for i in range(len(lines)):
    if "After dead code" in lines[i]:
        pos=i
        break
j=pos+2
oicg=[]
myinp=[]
final=[]
while(j<len(lines)):
    oicg.append(lines[j].strip())
    j+=1

for line in oicg:
    line=line.replace("(","")
    line=line.replace(")","")
    line=line.replace("'","")
    myinp.append(" ".join(line.split(",")))    

# assembly code generation ###########################

for line in myinp:
    final.append(entry(line))
    #print(line)

# output #############################

for i in range(len(final)):
    print("LINE:     "+myinp[i])
    print("-------------------------------------------------")
    print("\n".join(final[i]))
    print("-------------------------------------------------")
    print()
    print()    


