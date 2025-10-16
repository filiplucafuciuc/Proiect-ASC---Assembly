.data
    introducere: .asciz "%d\n"
    ikkk: .asciz "%d\n" 
    afisare: .asciz "%d: (%d, %d)\n"
    afisareget: .asciz "(%d, %d)\n"
    nr_op: .long 0
    operatie: .long 0
    nr_fisiere: .long 0
    descriptor: .long 0
    dimensiune: .long 0
    nr_blocuri: .long 0
    v: .space 1024
    dreapta: .long 0
.text
.global main

et_operatii:
    
    pop %ecx
    addl $1, %ecx

    push %ecx
    cmpl nr_op, %ecx
    jg et_final

    push $operatie
    push $introducere
    call scanf
    add $8, %esp

    movl operatie, %eax

    cmpl $1, %eax
    je et_operatia1

    cmp $2, %eax
    je et_operatia2

    cmp $3, %eax
    je et_operatia3

    cmp $4, %eax
    je et_operatia4

    jmp et_final
et_operatia1:
    lea v, %edi
    push $nr_fisiere
    push $introducere
    call scanf
    add $8, %esp
    
    xorl %ecx, %ecx
    push %ecx
    xorl %ebx, %ebx 
    jmp et_fisiere1
et_fisiere1:
    pop %ecx
    add $1, %ecx
    cmp nr_fisiere, %ecx
    jg et_terminat1
    push %ecx

    push $descriptor
    push $introducere
    call scanf
    add $8, %esp

    push $dimensiune
    push $introducere
    call scanf
    add $8, %esp

    movl dimensiune, %eax
    cmp $8, %eax
    jle et_pregatim_sa_testam_existenta_in_vector1

    cmp $8192, %eax
    jg et_pregatim_sa_testam_existenta_in_vector1

    xorl %edx, %edx
    xorl %eax, %eax
    movl dimensiune, %eax
    movl $8, %ecx
    divl %ecx
    cmpl $0, %edx
    jg et_exista_rest
    movl %eax, nr_blocuri

    xorl %ecx, %ecx 

    xorl %ebx, %ebx

    xorl %esi, %esi 

    jmp et_adaugare
et_exista_rest:

    addl $1, %eax
    movl %eax, nr_blocuri

    xorl %ecx, %ecx

    xorl %ebx, %ebx

    xorl %esi, %esi 

    jmp et_adaugare
et_adaugare:
    cmp $1024, %ebx
    jge et_pregatim_sa_testam_existenta_in_vector1


    movb (%edi, %ebx, 1), %dl
    cmpb $0, %dl
    jnz et_mergem_la_urm 

    cmpl $0, %esi
    jg et_continuare_bloc1
    
    movl %ebx, %ecx
    jmp et_continuare_bloc1
et_pregatim_sa_testam_existenta_in_vector1:
    xorl %ebx, %ebx 
    xorl %edx, %edx
    xorl %eax, %eax
    movl descriptor, %eax
    lea v, %edi
    jmp et_testam_existenta_in_vector1
et_testam_existenta_in_vector1:
    cmp $1024, %ebx
    jge et_afisare_zero1

    movb (%edi, %ebx, 1), %dl
    cmpb %dl, %al
    je et_fisiere1
et_afisare_zero1:
    push $0
    push $0
    push %eax
    push $afisare
    call printf
    addl $16, %esp
    jmp et_fisiere1

et_continuare_bloc1:
    addl $1, %esi

    cmpl %esi, nr_blocuri
    jg et_mergem_la_urm1 

    cmpl %esi, nr_blocuri
    jg et_nu_incape1

    movl %ecx, %eax
    addl %esi, %eax
    subl $1, %eax
    movl %eax, dreapta

    movl %ecx, %edx
    movl %ecx, %eax
    addl nr_blocuri, %eax
    movl %eax, nr_blocuri
    

    jmp et_scris_in_v1
et_nu_incape1:
    xorl %ecx, %ecx
    xorl %esi, %esi
    addl $1, %ebx
    jmp et_adaugare
et_scris_in_v1:
    cmpl nr_blocuri, %edx
    jge et_afisare_interval1
    movl descriptor, %eax
    movb %al, (%edi, %edx, 1)
    addl $1, %edx
    jmp et_scris_in_v1
et_afisare_interval1:

    push dreapta
    push %ecx
    push descriptor
    push $afisare
    call printf
    add $16, %esp

    addl $1, %ebx

    jmp et_fisiere1
et_mergem_la_urm:
    addl $1, %ebx
    xorl %esi, %esi
    jmp et_adaugare
et_mergem_la_urm1:
    addl $1, %ebx
    jmp et_adaugare
et_terminat1:
    jmp et_operatii
et_final:
    add $4, %esp

    pushl $0
    call fflush
    popl %eax
    
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80

et_final_afisare:
    ret  

et_operatia2:
    push $descriptor
    push $introducere
    call scanf
    add $8, %esp

    lea v, %edi
    xorl %ecx, %ecx 
    xorl %esi, %esi
    xorl %ebx, %ebx 
    jmp et_cautare2
et_cautare2:
    cmp $1024, %ebx
    jge et_verif2

    movb (%edi,%ebx,1), %dl
    movl descriptor, %eax
    cmpb %al, %dl
    jne et_mergem_la_urm2
    addl $1, %esi
    addl $1, %ebx
    cmp $0, %ecx
    je et_setare_stanga2
    jmp et_cautare2
et_setare_stanga2:
    movl %ebx, %ecx
    subl $1, %ecx
    jmp et_cautare2
et_mergem_la_urm2:
    addl $1, %ebx
    cmp $0, %esi
    jg et_afisare2
    jmp et_cautare2
et_verif2:
    cmp $0, %esi
    je et_nu_exista_in_v

    jmp et_afisare2
et_nu_exista_in_v:
    push $0
    push $0
    push $afisareget
    call printf
    addl $12, %esp
    
    jmp et_operatii
et_afisare2:
    cmp $1, %ecx
    je et_scazut_stanga2
    movl %ecx, %edx
    addl %esi, %edx
    subl $1, %edx

    pushl %edx
    pushl %ecx
    push $afisareget
    call printf
    addl $12, %esp

    jmp et_operatii
et_scazut_stanga2:
    subl $1, %ecx
    jmp et_afisare2

et_operatia3:
    push $descriptor
    push $introducere
    call scanf
    add $8, %esp

    lea v, %edi
    xorl %ecx, %ecx 
    xorl %esi, %esi 
    xorl %ebx, %ebx 
    xorl %eax, %eax
    jmp et_cautare3
et_cautare3:
    cmp $1024, %ebx
    jge et_pregatire_afisare3

    movb (%edi, %ebx, 1), %dl
    movl descriptor, %eax
    cmpb %al, %dl
    jne et_mergem_la_urm3
    
    movb $0, (%edi, %ebx, 1)
    addl $1, %ebx
    jmp et_cautare3
et_mergem_la_urm3:
    addl $1, %ebx
    jmp et_cautare3
et_pregatire_afisare3:
    xorl %ebx, %ebx 
    xorl %edx, %edx
    xorl %eax, %eax 
    xorl %esi, %esi 
    xorl %ecx, %ecx 

    jmp et_afisare3 
et_afisare3:
    cmp $1024, %ebx
    jge et_temporar3 
    movb (%edi, %ebx, 1), %dl
    cmpl %eax, %edx
    jne et_verif3
    cmpl $0, %edx
    je et_trecem_peste_zerouri3
    addl $1, %esi
    addl $1, %ebx
    jmp et_afisare3
et_temporar3:
    cmp $0, %esi
    jg et_verif3

    jmp et_operatii
et_trecem_peste_zerouri3:
    addl $1, %ebx
    jmp et_afisare3
et_verif3:
    cmpl $0, %eax
    je et_actualizare3

    addl %ecx, %esi
    subl $1, %esi
    push %esi
    
    push %ecx
    push %eax
    push $afisare
    call printf
    addl $16, %esp

    movl %edx, %eax
    movl %ebx, %ecx 
    
    xorl %esi, %esi 
    jmp et_afisare3
et_actualizare3:
    movl %edx, %eax
    movl $1, %esi 
    movl %ebx, %ecx
    addl $1, %ebx
    jmp et_afisare3
et_operatia4:
    lea v, %edi
    xorl %ecx, %ecx 
    xorl %esi, %esi 
    xorl %eax, %eax
    xorl %ebx, %ebx 
    xorl %edx, %edx
    jmp et_cautare4
et_cautare4:
    cmp $1024, %ebx
    jge et_punem_zerouri4
    
    movb (%edi, %ebx, 1), %dl
    cmp $0, %edx
    jg et_mutam4
    addl $1, %ebx
    jmp et_cautare4
et_mutam4:
    movb (%edi, %ebx, 1), %dl
    movb %dl, (%edi, %ecx, 1)
    addl $1, %ecx
    addl $1, %ebx
    jmp et_cautare4
et_punem_zerouri4:
    cmp $1024, %ecx
    jge et_pregatire_afisare3
    movb $0, (%edi, %ecx, 1)
    addl $1, %ecx
    jmp et_punem_zerouri4

main:
    push $nr_op
    push $introducere
    call scanf
    add $8, %esp

    xorl %ecx, %ecx
    push %ecx
    jmp et_operatii