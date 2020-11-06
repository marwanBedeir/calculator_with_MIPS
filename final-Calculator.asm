.data 
space:.asciiz " "
welcome0:.asciiz"\n\n Select Your Option :\n"
welcome:.asciiz"\n\n  1-Multiplication\n  2-Division\n  3-Power\n  4-Addition\n  5-Subtraction\n  6-Factorial\n  7-Factorization\n  8-Clear result\n  9-Exit\n"
message1:.asciiz " enter first number : "
message2:.asciiz " enter second number : "
message3:.asciiz" enter number : "
message4:.asciiz "\n\n Result is : "
clearScreen:.asciiz "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
erorrMessage:.asciiz "\n\n Can't divide by Zero\n"
factErorr:.asciiz"\n\n Number is negative  in a Factorial operation :\n"
main_erorr:.asciiz "\n\n Please choose an option from the available options\n"
negative:.asciiz "\n\n number must be positive: "
factorizationMess:.asciiz "\n\n Factors are: "
float_0:.float 0.0
float_1:.float 1.0
.text
	# main procedure 
main:
	lwc1 $f10,float_0 # load f10 with zero
	li $s0, 0 # set  flag to 0
	
	li $v0, 4
	la $a0,welcome0
	syscall	#print message for user
	
	li $v0, 4
	la $a0,welcome
	syscall	#print list of operations
	
	li $v0,5
	syscall
	move $s2,$v0	#recieve user choice
		
		
	main_loop:	
		beq $s2,9,main_exit	#if user choice = 9 , branch to exit
		bne $s2,1,notMul	#if not 1 branch
		jal multiplication	#jump to multiplication function
		j exit_if		
		
	notMul:
		bne $s2,2,notDiv	#if user choice not 2,branch						
		jal division		#jump to division function
		j exit_if	
	
	notDiv:
		bne $s2,3,notPow	#if choice not equal to 3, branch					
		jal power		#jump to power
		j exit_if
	
	notPow:
		bne $s2,4,notAdd	#if not 4 ,branch					
		jal addition		#jump to addition function
		j exit_if	
	
	notAdd:
		bne $s2,5,notSub	# if not subtraction , branch			
		jal subtraction		#jump to subtraction function
		j exit_if		
	
	notSub:
		bne $s2,6,notFac	# if not factorial , branch				
		jal factorial		#jump to factorial function
		j exit_if
	
	notFac:
		bne $s2,7,notFactoriz   #if not Factorization,branch
		jal factorization	#jump to factorial function
		j exit_if
	notFactoriz:	
		bne $s2,8,notClear	#if not clear,branch				
		li $s0,0		#clear flag 
		lwc1 $f8,float_0	#clear Result
		j exit_if	
	
	notClear:
		li $v0, 4	
		la $a0,main_erorr
		syscall	#print error message if no option selected
		j exit_if
																																																																																																																											
	exit_if:
		#li $v0, 4
		#la $a0,clearScreen #clear the screen
		#syscall	
		
		li $v0, 4
		la $a0,message4 # for print message	
		syscall										
																																					
		li $v0, 2
		mov.d $f12,$f8  # print Result
		syscall
		
		li $v0, 4
		la $a0,welcome0
		syscall	#print message for user
		
		li $v0, 4
		la $a0,welcome
		syscall		# print list of operations again
	
		li $v0,5
		syscall
		move $s2,$v0
		j main_loop	# get user choice
		
	main_exit:	# exit program
	
		li $v0,10 # close program
		syscall

division:
		bnez $s0,else1 # if flag != 0	branch


		li $v0, 4
		la $a0, message1  # ask for first number
		syscall

		li $v0, 6
		syscall           #get first number from the user
		mov.d $f4,$f0

		li $v0, 4
		la $a0, message2 # ask for second number
		syscall

		li $v0, 6
		syscall         # get second number from user
		mov.d $f6,$f0

		
		c.eq.d $f6,$f10 # if y != 0 
		bc1t else2

			div.s $f8,$f4,$f6 #	divide x by y

			li $s0, 1 #set flag to 1 , to continue on this result
		
		j exit2
 
		else2:

			li $v0, 4
			la $a0, erorrMessage # print erorrMessage
			syscall	# can't divide by a zero
			
			lwc1 $f8,float_0 # set result to zero
			
			li $s0,0  #set flag to 0

		exit2:

	j exit1 #end if

	else1:

		li $v0, 4
		la $a0, message3 # print message3
		syscall # ask for  a number

		li $v0, 6
		syscall
		mov.d $f6,$f0        #scan y from the user


		c.eq.d $f6,$f10 # if y == 0
		bc1t else3
 			
 			# if y != 0

			div.s $f8,$f8,$f6 #x/y

			li $s0, 1	# set flag to 1
		
		j exit3 #end if
 
		else3:

			li $v0, 4
			la $a0, erorrMessage # print erorrMessage
			syscall # can't divid by a zero
			
			lwc1 $f8,float_0 # set result to 0
			
			li $s0,0 #set flag to 0
			
			j exit4 #end if
			
			exit4:
		exit3: 
	exit1:

	jr $ra # return to main function
	
	
	# subtraction function 

subtraction:
  		bnez $s0,selse1 # if flag == 0
  		li $v0 4 #print message 1
  		la $a0 message1
  		syscall # ask for the  first number

  		li $v0 6 #read number 1
  		syscall
  		mov.d $f4,$f0


  		li $v0 4 #print message 2
  		la $a0 message2
  		syscall #ask for second number 

  		li $v0 6   #read number 2
  		syscall
  		mov.d $f6,$f0



  		sub.s $f8,$f4,$f6 #subtract f6 from f4
  
  		li $s0,1 # set flag = 1
		j sexit  # jumb to exit

  	selse1:
    		li $v0 4  # print message 3
    		la $a0 message3
    		syscall # ask for a number

    		li $v0 6 #read the number
    		syscall
    		mov.d $f4,$f0 

    		sub.s $f8,$f8,$f4 # subtract previous result from entered number

  		sexit: #end if

		jr $ra # return to main function


		# multiplication function
multiplication: 

    		bnez $s0,melse	#begining of if 
    
   		li $v0,4
    		la $a0,message1		#print (enter first number :)
    		syscall
    
    		li $v0, 6			#scan first number
    		syscall			
    		mov.d $f4,$f0		#transfer value to $f4
   
    
    		li $v0,4
   		la $a0,message2		#print (enter second number :)
    		syscall
    
    		li $v0,6			#scan second number
    		syscall			
   		mov.d $f6,$f0		#transfer value to $f6
    
    		mul.s $f8,$f4,$f6		#do multiplication equation


    		li $s0,1			#make flag equal 1
    
    		j mexit			#end if
    
    melse:
    
   	 	li $v0,4
   	 	la $a0,message3			#print (enter number : )
   	 	syscall
    
  	  	li $v0, 6			#scan number
 	  	syscall			
    	  	mov.d $f4,$f0			#transfer value to $f4

   	 	mul.s $f8,$f8,$f4		#do multiplication equation
   
   
     
     mexit:		#end function


		jr $ra		#return to main function

	#Power function
power: 
	li	$t2,1    #load t2 with 1 
	beq 	$s0,$zero,first	# if flag is 0
	beq	$s0,$t2,later	# flag is 1
 
first : li $v0,4	
	la $a0,message1	# ask for first number
	syscall
	
	li $v0,6
	syscall	
	mov.s $f4,$f0        #get first number
	
	li $v0,4
	la $a0,message2	#ask for second number
	syscall
	
	li $v0,6
	syscall	 	#get second number
		
	
	c.lt.s $f0,$f10 # check  second number less than 0
	bc1f 	more_than	#	 case second number is positive 
	bc1t	less_than	# 	case second numberis negative
	
	#second number is positive  
more_than:	lwc1 	$f8 , float_1 #load result with 1
		lwc1	$f5 , float_1	 # loop vairable = 1
	 	lwc1	$f21, float_1	#load f21 with 1
	 loop1:	c.le.s	$f5,$f0		# check if loop variable less than or equal second number 
	 	bc1f	Exit		#Exit if false 
	 	mul.s	$f8,$f8,$f4	# else multiply first number by itself 
	 	add.s	$f5,$f5,$f21	#increment loop variable by one
	 	j	loop1		# loop back to condition
	 
	#second number is negative
less_than:	lwc1	$f21, float_1 #load f21 with 1
		neg.s	$f0,$f0       # make the second number a positive number
		
		lwc1 	$f8 , float_1 #load result with 1
		lwc1	$f5 , float_1	      # loop vairable = 1
		
	 loop2:	c.le.s 	$f5,$f0		# check if loop variable less than or equal second number 
	 	bc1f	Exit2		#Exit if false 
	 	mul.s	$f8,$f8,$f4	# else multiply first number by itself 
	 	add.s	$f5,$f5,$f21	#increment loop variable by one
	 	j	loop2		# loop back to condition		 		
	 	
Exit:		li	$s0,1	# set flag to 1
		jr	$ra  # return to main

Exit2:		div.s 	$f8,$f21,$f8	# get result = 1/result 
		li	$s0,1	# set flag to 1
		jr	$ra	# return to main	
		
	# continue calculations on a previous result
	# flag = 1
later:	li $v0,4	
	la $a0,message3	# ask for a number
	syscall
	
	li $v0,6
	syscall	
	mov.s $f4,$f0        #get the  number
				
	c.lt.s $f4,$f10 # check  entered number less than 0
	bc1f 	more_than_1	#	 case entered number is positive 
	bc1t	less_than_1	# 	case entered number is negative
	
	#entered number is positive 
more_than_1:		lwc1 	$f7 , float_1 	  #load temp with 1
			lwc1	$f5 , float_1	  # loop vairable
	 		lwc1	$f21,float_1
	 		
	 loop1_1:	c.le.s	$f5,$f4		# check if loop variable less than or equal entered number 
	 		bc1f	Exit_1		#Exit if false 
	 		mul.s	$f7,$f7,$f8	# else multiply result   by itself 
	 		add.s	$f5,$f5,$f21	#increment loop variable with one
	 		j	loop1_1		# loop back to condition
	 
	 #entered number is a negative number
less_than_1:		lwc1	$f21, float_1
			neg.s	$f4,$f4 # make the entered number a negative number 
			
			lwc1 	$f7 , float_1 #load temp with 1
			lwc1	$f5 , float_1	      # loop vairable
		
	 loop2_2:	c.le.s	$f5,$f4	# check if loop variable less than second number 
	 		bc1f	Exit2_2		#Exit if false 
	 		mul.s	$f7,$f7,$f8	# else multiply result by itself 
	 		add.s	$f5,$f5,$f21	#increment loop variable by one
	 		j	loop2_2		# loop back to condition		 		
	 	
	 	
Exit_1:		mov.s	$f8,$f7	# move temp to final result 
		li	$s0,1	# set flag to 1
		jr	$ra 	# return to main

Exit2_2:	div.s 	$f8,$f21,$f7	# set final result = 1/temp 
		li	$s0,1		# set flag to 1
jr	$ra		# return to main


		# addition function
addition :   			#declare function addition
			beq $s0,$zero,add_n       # check if $s0 == $t2 , jumb -> label add_n
						#else
			la $a0,message3               # ask user to enter  num 
			li $v0,4		
			syscall
			
		        li $v0,6		# get user input (float number)
		        syscall  
		        mov.d $f4 ,$f0		# f4 gets $f0 -> (user input)
		        
			add.s $f8,$f8,$f4       # add the user input to the perivous result 
			
			j e			# jump to label e 
		add_n:                         
			la $a0,message1               				
			li $v0,4		# print the m1 (ask user to enter first num)
			syscall
				
			li $v0,6		# get the user input
			syscall
			mov.d  $f4,$f0		# set f4 = user input
			
			la $a0,message2				
			li $v0,4		# print m2 (ask user to enter 2nd num )	
			syscall
				
			li $v0,6		# get user input 
			syscall
			mov.d $f6,$f0		# set f6 = user input
			
			add.s $f8,$f4,$f6       # sum f4 , f4 (user input ) store the result in f8
			
			li $s0,1		# set $s0  = 1 (flag)
		e : 
			jr $ra			# function return
		
		
	# factorial function
factorial:
			lwc1 $f21 , float_1 # load f21 with 1
			lwc1 $f22 , float_1 # loop variable


			bne $s0,$zero,fElse  #if flag ==0

			lwc1 $f8 , float_1 # load result with 1
		
			li $v0 , 4   #print
			la $a0 , message3
			syscall	# ask for a number

			li $v0,6   #scan x from user
			syscall
			mov.d $f4,$f0	# get the number



  
			c.lt.s $f4, $f10	# check if entered number is < 0 
			bc1t felse

		# number is positive or equal to zero
	floop :		c.le.s $f22, $f4 
			bc1f fEXITloop
			mul.s $f8 , $f8 , $f22
			add.s $f22 , $f22 , $f21
			j floop
		 
	fEXITloop : 	li $s0 ,1 #make flag 1 
			j fExit

	felse : 	
			li $v0 , 4   #print erorr message
			la $a0 , factErorr
			syscall

			lwc1 $f8 , float_0 #result
				
			li $s0,0  #set flag to 0

	fExit :
			j fExit1
 
 	fElse :
 			c.lt.s $f8,$f10 #if Result < 0
 			bc1t felse2 # if true go to else2 
			lwc1 $f22 , float_1 #make i =1
			lwc1 $f24 , float_1 #make result =1  

	floop1 : 
			c.le.s $f22 , $f8 # if i <= Result 
			bc1f fEXITloop2
			mul.s $f24,$f24,$f22    # result = result * i 
			add.s $f22 , $f22 , $f21
			j floop1
 fEXITloop2 :
   			mov.d $f8 , $f24   # Result = result
			j fExit1

	felse2: 
			li $v0 , 4   #print error on a negative number in factorial
			la $a0 , factErorr
			syscall

			lwc1 $f8 , float_0 #result make it 0 
				
			li $s0,0  #set flag to 0
	
	fExit1:
			jr $ra
	
	
factorization:
			li $t0 , 1 # loop variable
			bne $s0,$zero,facElse # not equal to zero branch

			li $v0 , 4   #ask the user for the input
			la $a0 , message3
			syscall


			li $v0,5   #scan the number
			syscall
			move $t1,$v0

			ble $t1 , $zero ,error55  #if number less than or equal zero go to error

			li $v0 , 4   #print string 
			la $a0 , factorizationMess
			syscall

loop11 : 	bgt $t0 ,$t1 , EXITloop22   # if i<= number terminat the program 
		rem $t9 , $t1 , $t0                #compute remainder
		bne $t9 , $zero ,jump66                     #if remainder ==0
		
		li $v0 , 1                  # then print i 
		move $a0, $t0                           
		syscall

		li $v0, 4
		la $a0,space
		syscall	#take a space
  
jump66:

		addi $t0 , $t0 ,1                            # i = i+1 
 		j loop11 
EXITloop22 :
		j exitfromtheprogram

facElse :

		mov.d $f28,$f8 #for casting 
		cvt.w.s $f28 , $f28 
		mfc1 $s6,$f28 

		ble $s6 ,$zero , error55 #if result less than or = 0 go to error 

		li $v0 , 4   #print string 
		la $a0 , factorizationMess
		syscall

forloop : 	
		bgt $t0 ,$s6 , EXITfromloop #if i <=result
		
		rem $t9 , $s6 , $t0       #copmute remainder
		
		bne $t9 , $zero ,jump33    # if remainder ==0 
		
		li $v0 , 1                   
		move $a0, $t0                  #print i 
		syscall 

		li $v0, 4
		la $a0,space
		syscall	#take a space
  

jump33:
		addi $t0 , $t0 ,1 
 		j forloop 
EXITfromloop :
		j exitfromtheprogram 

error55:
		li $v0 , 4   #print string 
		la $a0 , negative
		syscall 
		
		lwc1 $f8 , float_0 # clear the Result
		li $s0,0 # set flag to 0
exitfromtheprogram :

	jr $ra
