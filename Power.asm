.data
float_0: 	.float 0.0
float_1: 	.float 1.0
message1: .asciiz "enter first  number:"
message2: .asciiz "enter second number:"
message_1: .asciiz "enter power number:"

.text

main:	li $s0,0 # flag set to 0
	jal	power
	
	li $v0,2
	mov.d $f12,$f8
	syscall
	
	li $v0,10
	syscall	

# 			Power Function
 
power: 
	li	$t2,1    #load t2 with 1 
	lwc1 	$f10 , float_0 #load f10 with zero
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
		lwc1	$f5 , float_1	      # loop vairable
	 	lwc1	$f21, float_1	#load f21 with 1
	 loop1:	c.le.s	$f5,$f0		# check if loop variable less than second number 
	 	bc1f	Exit		#Exit if false 
	 	mul.s	$f8,$f8,$f4	# else multiply first number by itself 
	 	add.s	$f5,$f5,$f21	#increment loop variable by one
	 	j	loop1		# loop back to condition
	 
	#second number is negative
less_than:	lwc1	$f21, float_1 #load f21 with 1
		neg.s	$f0,$f0 # make the second number a positive number
		
		lwc1 	$f8 , float_1 #load result with 1
		lwc1	$f5 , float_1	      # loop vairable
		
	 loop2:	c.le.s 	$f5,$f0		# check if loop variable less than second number 
	 	bc1f	Exit2		#Exit if false 
	 	mul.s	$f8,$f8,$f4	# else multiply first number by itself 
	 	add.s	$f5,$f5,$f21	#increment loop variable by one
	 	j	loop2		# loop back to condition		 		
	 	
Exit:		li	$s0,1	# set flag to 1
		jr	$ra 

Exit2:		div.s 	$f8,$f21,$f8	# get result = 1/result 
		li	$s0,1	# set flag to 1
		jr	$ra		
		
	# continue calculations on a previous result
later:	li $v0,4	
	la $a0,message_1	# ask for a number
	syscall
	
	li $v0,6
	syscall	
	mov.s $f4,$f0        #get the  number
		
	c.lt.s $f4,$f10 # check  entered number less than 0
	bc1f 	more_than_1	#	 case entered number is positive 
	bc1t	less_than	# 	case entered number is negative
	
	#entered number is positive 
more_than_1:		lwc1 	$f7 , float_1 	  #load temp with 1
			lwc1	$f5 , float_1	  # loop vairable
	 		lwc1	$f21,float_1
	 		
	 loop1_1:	c.le.s	$f5,$f4		# check if loop variable less than entered number 
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

Exit2_2:	div.s 	$f8,$f21,$f7	# get result = 1/result 
		li	$s0,1		# set flag to 1
		jr	$ra		# return to main
