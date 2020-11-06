
.data
float_0:.float 0
float_1:.float 1
message3: .asciiz"\n enter number :"
factErorr: .asciiz"\n Number is negative  in a Factorial Operation\n :"
.text

lwc1  $f10 , float_0
lwc1 $f21 , float_1 
lwc1 $f22 , float_1 #i

#addi $t2 , $zero , 1 #result


            
bne $s0,$zero,Else  #if flag ==0

lwc1 $f8 , float_1 #result
li $v0 , 4   #print
la $a0 , message3
syscall

li $v0,6   #scan
syscall
mov.d $f4,$f0



#ble $f4, $zero , else  
c.le.s $f4, $f10 
bc1t else

#loop : bgt $t1 , $t0 , EXIT
#mul $t2,$t2,$t1
#addi $t1,$t1,1
#j loop
loop :c.le.s $f22, $f4 
bc1f EXITloop
mul.s $f8 , $f8 , $f22
add.s $f22 , $f22 , $f21
j loop 
EXITloop : 

li $s0 ,1 #make flag 1 
j Exit

else : li $v0 , 4   #print
la $a0 , factErorr
syscall

lwc1 $f8 , float_0 #result

Exit :
j Exit1
 Else :
 
 
 c.le.d $f8,$f10 #if Result <=0
 bc1t else2 # if true go to else2 
lwc1 $f22 , float_1 #make i =1
lwc1 $f3 , float_1 #make result =1  

loop1 : c.le.s $f22 , $f8 # if i <= Result 
bc1f EXITloop2
mul.s $f3,$f3,$f22    # result = result * i 
add.s $f22 , $f22 , $f21
j loop1
 EXITloop2 :
   mov.d $f8 , $f3   # Result = result
j Exit1

else2: 
li $v0 , 4   #print
la $a0 , factErorr
syscall

lwc1 $f8 , float_0 #result make it 0 
Exit1:

 
li $v0 ,2   # print result 
mov.d $f12 , $f8
syscall 