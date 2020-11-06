.data

	str1:.asciiz "\n enter first number :"
	str2:.asciiz "\n enter second number :"
	str3:.asciiz "\n enter number :"

.text
main:
    li $s0,0 #make flag equal zero 

    jal multiplication # call multiplication function
    
    li $v0, 2	
    mov.d $f12,$f8	#print result
    syscall
    
    li $v0,10		#terminate the program
    syscall
    
    
    
multiplication: #begining of multiplication function

    bnez $s0,else	#begining of if 
    
   	li $v0,4
    	la $a0,str1		#print (enter first number :)
    	syscall
    
    	li $v0, 6			#scan first number
    	syscall			
    	mov.d $f4,$f0		#transfer value to $f4
   
    
    	li $v0,4
   	la $a0,str2		#print (enter second number :)
    	syscall
    
    	li $v0,6			#scan second number
    	syscall			
   	mov.d $f6,$f0		#transfer value to $f6
    


    	mul.s $f8,$f4,$f6		#do multiplication equation




    	li $s0,1			#make flag equal 1
    
    	j exit			#end if
    
    else:
    
   	 li $v0,4
   	 la $a0,str3			#print (enter number :)
   	 syscall
    
  	  li $v0, 6			#scan number
 	  syscall			
    	  mov.d $f4,$f0			#transfer value to $f4


   	 mul.s $f8,$f8,$f4		#do multiplication equation
   
   
     
     exit:		#end function


     jr $ra		#return to main function