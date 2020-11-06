.data
  message1 : .asciiz "\n enter first number :"
  message2 :.asciiz"\n enter second number :"
  message3:.asciiz"\n enter number :"
.text
  main:
   li $s0,0 # flag = 0
   jal Subtraction #call Subtraction

   li $v0,2 
   mov.d $f12,$f8 #load result from f8
   syscall

   li $v0,10   #terminate program
   syscall
   
   
 Subtraction:
  bnez $s0,else1 # if flag == 0
  li $v0 4 #print message 1
  la $a0 message1
  syscall

  li $v0 6 #read number 1
  syscall
  mov.d $f4,$f0


  li $v0 4 #print message 2
  la $a0 message2
  syscall 

  li $v0 6   #read number 2
  syscall
  mov.d $f6,$f0



  sub.s $f8,$f4,$f6 #subtract f6 from f4
  
  li $s0,1 # flag = 1
j exit  # jumb to exit

  else1:
    li $v0 4  # print message 3
    la $a0 message3
    syscall

    li $v0 6 #read number 1
    syscall
    mov.d $f4,$f0 

    sub.s $f8,$f8,$f4

  exit: #end if

jr $ra # return to main function