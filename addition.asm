.data
		m1 : .asciiz "\n Enter first Number"  
		m2 : .asciiz "\n Enter second Number" 
		m3 : .asciiz "\n Enter Number" 

.text
		
		main :
			 
			li $s0 , 0       	# set flag is zero
			li $t2 , 0       	# load immidate register $t2 0
 			li $t4 , 1   		# load immidate register $t4 1
 			
			jal addition		# call function addition 
			
			li $v0, 2
			mov.d $f12,$f8  # print Result
			syscall
			
			li $v0,10 
					       #terminate program 
			syscall
		addition :   			#declare function addition
			beq $s0,$t2,add_n       # check if $s0 == $t2 , jumb -> label add_n
						#else
			la $a0,m1               # ask user to enter  num 
			li $v0,4		
			syscall
			
		        li $v0,6		# get user input (float number)
		        syscall  
		        mov.d $f4 ,$f0		# f4 gets $f0 -> (user input)
			add.s $f8,$f8,$f4       # add the user input to the perivous result 
			j e			# jump to label e 
		add_n:                         
			la $a0,m1               
						# print the m1 (ask user to enter first num)
			li $v0,4		
			syscall
				
			li $v0,6		# get the user input
			syscall
			mov.d  $f4,$f0		# set f4 = user input
			la $a0,m2		
						# print m2 (ask user to enter 2nd num )
			li $v0,4
			syscall
				
			li $v0,6		# get user input 
			syscall
			mov.d $f6,$f0		# set f6 = user input
			add.s $f8,$f4,$f6       # sum f4 , f4 (user input ) store the result in f8
			add $s0,$t2,$t4		# set $s0  = 1 (flag)
		e : 
			jr $ra			# function return
