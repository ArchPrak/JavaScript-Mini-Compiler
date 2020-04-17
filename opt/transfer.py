f1=open("icgout.txt","r")
f2=open("inp.txt","w")
lines=f1.readlines()
for i in range(len(lines)):
    if 'Parsing Complete' in lines[i]:
        pos=i+1
        break

for i in range(pos,len(lines)):
    #print(type(lines[i]),lines[i])
    lines[i]=lines[i].replace(" (null) "," NULL ")
    f2.write(lines[i])
