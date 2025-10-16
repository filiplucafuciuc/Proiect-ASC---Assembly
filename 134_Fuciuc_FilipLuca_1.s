.data
    introducere_1: .asciz "%d\n"
    introducere_2: .asciz "((%d, %d), (%d, %d))\n"
    afisare_1: .asciz "%d\n"
    afisare_2: .asciz "((%d, %d), (%d, %d))\n"
    afisare_3: .asciz "%d: ((%d, %d), (%d, %d))\n"
    v: .space 1048576
    nr_operatii: .long 0
    nr_blocuri: .long 0
    nr_op: .long 0
    operatie: .long 0
    nr_fisiere: .long 0
    descriptor: .long 0
    dimensiune: .long 0
    dreapta: .long 0
    aux1: .long 0
    aux2: .long 0
.text
.global main

et_operatii:
    pop %ecx
    addl $1, %ecx

    
    push %ecx
    cmpl nr_op, %ecx
    jg et_final

    push $operatie
    push $introducere_1
    call scanf
    add $8, %esp

    movl operatie, %eax
    
    cmpl $1, %eax
    je et_operatia1

    cmpl $2, %eax
    je et_operatia2

    cmpl $3, %eax
    je et_operatia3

    cmp $4, %eax
    je et_operatia4

    jmp et_final
et_operatia1:
    lea v, %edi
    push $nr_fisiere
    push $introducere_1
    call scanf
    add $8, %esp
    
    xorl %ecx, %ecx
    push %ecx

    xorl %ebx, %ebx 
    xorl %esi, %esi 

    jmp et_fisiere1
et_fisiere1:
    pop %ecx
    add $1, %ecx
    cmpl nr_fisiere, %ecx
    jg et_terminat1
    push %ecx

    push $descriptor
    push $introducere_1
    call scanf
    add $8, %esp



    push $dimensiune
    push $introducere_1
    call scanf
    add $8, %esp

    
    movl dimensiune, %edx
    movl descriptor, %ecx
    push %ecx
    cmp $8192, %edx
    jg et_dimensiune_prea_mare1
    pop %ecx
    xorl %ecx, %ecx

    xorl %edx, %edx
    movl dimensiune, %eax
    movl $8, %ecx
    divl %ecx
    cmpl $0, %edx
    jg et_exista_rest
    movl %eax, nr_blocuri

    xorl %ecx, %ecx 
    xorl %eax, %eax

    xorl %ebx, %ebx

    jmp et_adaugare
et_exista_rest:
    addl $1, %eax
    movl %eax, nr_blocuri

    xorl %ecx, %ecx 
    xorl %eax, %eax 

    xorl %ebx, %ebx

    jmp et_adaugare
et_dimensiune_prea_mare1:
    pop %ecx
    push $0
    push $0
    push $0
    push $0
    push %ecx
    push $afisare_3
    call printf
    addl $24, %esp
    jmp et_fisiere1
et_adaugare:
    cmp $1048576, %ebx
    jge et_fisiere1 

    cmp $0, %ebx
    je et_primul_el1

    push %ecx
    push %eax
    
    xorl %edx, %edx
    movl %ebx, %eax
    movl $1024, %ecx
    div %ecx
    
    pop %eax
    pop %ecx
    cmp $0, %edx
    je et_linia_urm1
    

    movb (%edi, %ebx, 1), %dl
    cmpb $0, %dl
    jnz et_mergem_la_urm

    cmpl $0, %eax
    jg et_continuare_bloc1

    movl %ebx, %ecx
    jmp et_continuare_bloc1

et_primul_el1:
    movb (%edi, %ebx, 1), %dl
    cmpb $0, %dl
    jnz et_mergem_la_urm

    cmpl $0, %eax
    jg et_continuare_bloc1

    movl %ebx, %ecx
    jmp et_continuare_bloc1
et_linia_urm1:
    cmp nr_blocuri, %eax
    je et_inghesuit1

    addl $1, %esi
    xorl %eax, %eax
    xorl %ecx, %ecx

    movb (%edi, %ebx, 1), %dl
    cmpb $0, %dl
    jnz et_mergem_la_urm

    cmpl $0, %eax
    jg et_continuare_bloc1

    movl %ebx, %ecx
    jmp et_continuare_bloc1

et_inghesuit1:
    movl %ecx, %edx
    addl %eax, %edx
    subl $1, %edx
    movl %edx, dreapta

    
    movl %ecx, %edx
    addl nr_blocuri, %edx
    movl %edx, nr_blocuri
    movl %ecx, %edx
    

    jmp et_scris_in_v1
et_continuare_bloc1:
    addl $1, %eax
    cmpl %eax, nr_blocuri
    jg et_mergem_la_urm1

    cmpl %eax, nr_blocuri
    jg et_nu_incape1

    movl %ecx, %edx
    addl %eax, %edx
    subl $1, %edx
    movl %edx, dreapta

    
    movl %ecx, %edx
    addl nr_blocuri, %edx
    movl %edx, nr_blocuri
    movl %ecx, %edx
    

    jmp et_scris_in_v1
et_nu_incape1:

    xorl %ecx, %ecx
    xorl %eax, %eax
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
    

    xorl %edx, %edx
    movl %ebx, %eax
    push %ecx
    movl $1024, %ecx
    divl %ecx
    pop %ecx
    push %edx
    push %eax
    xorl %edx, %edx
    movl %ecx, %eax
    push %ecx
    movl $1024, %ecx
    divl %ecx
    pop %ecx
    push %edx
    push %eax
    push descriptor
    push $afisare_3
    call printf
    addl $24, %esp

    xorl %ebx, %ebx

    jmp et_fisiere1
et_mergem_la_urm:
    addl $1, %ebx
    xorl %eax, %eax
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

et_operatia2:
    push $descriptor
    push $introducere_1
    call scanf
    add $8, %esp

    lea v, %edi
    xorl %ecx, %ecx 
    xorl %esi, %esi 
    xorl %ebx, %ebx 
    jmp et_cautare2
et_cautare2:
    cmp $1048576, %ebx
    jge et_nu_exista_in_v

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
et_nu_exista_in_v:
    push $0
    push $0
    push $0
    push $0
    push $afisare_2
    call printf
    addl $20, %esp
    
    jmp et_operatii
et_afisare2:
    cmp $1, %ecx
    je et_scazut_stanga2
    movl %ecx, %edx
    addl %esi, %edx
    subl $1, %edx

    push %ecx

    movl %edx, %eax
    xorl %edx, %edx
    movl $1024, %ebx
    div %ebx

    pop %ecx

    push %edx
    push %eax

    movl %ecx, %eax
    xorl %edx, %edx
    movl $1024, %ebx
    div %ebx
    push %edx
    push %eax

    push $afisare_2
    call printf
    addl $20, %esp


    xorl %ecx, %ecx
    jmp et_operatii
et_scazut_stanga2:
    subl $1, %ecx
    jmp et_afisare2

et_operatia3:
    push $descriptor
    push $introducere_1
    call scanf
    addl $8, %esp

    lea v, %edi
    xorl %ecx, %ecx 
    xorl %esi, %esi 
    xorl %ebx, %ebx 
    jmp et_cautare3
et_cautare3:
    cmp $1048576, %ebx
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
    cmp $1048576, %ebx
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
    jmp et_operatii
et_trecem_peste_zerouri3:
    addl $1, %ebx
    xorl %esi, %esi
    jmp et_afisare3
et_verif3:
    cmpl $0, %eax
    je et_actualizare3

    movl %eax, descriptor
    
    movl %edx, aux1
    movl %ebx, aux2

    addl %ecx, %esi
    subl $1, %esi

    push %ecx

    movl %esi, %eax
    xorl %edx, %edx
    movl $1024, %ebx
    div %ebx

    pop %ecx

    push %edx
    push %eax

    movl %ecx, %eax
    xorl %edx, %edx
    movl $1024, %ebx
    div %ebx
    push %edx
    push %eax

    movl descriptor, %eax
    push %eax

    
    push $afisare_3
    call printf
    addl $24, %esp
    

    movl aux1, %edx
    movl aux2, %ebx

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
    xorl %ebx, %ebx
    xorl %esi, %esi 
    xorl %ecx, %ecx 
    xorl %eax, %eax 
    xorl %edx, %edx

    movl $0, aux1                           

    lea v, %edi

    jmp et_cautare4
et_cautare4:
    cmp $1048576, %ebx
    jge et_terminat4

    movb (%edi, %ebx, 1), %dl
    cmp %eax, %edx
    je et_verificare4
    cmp $0, %eax
    je et_setare_stanga_dupa_zero4
    
    jmp et_terminare_interval4
et_trecem_peste_zerouri4:
    addl $1, %ebx
    xorl %esi, %esi
    jmp et_cautare4
et_verificare4:
    cmp $0, %edx
    je et_trecem_peste_zerouri4
    addl $1, %esi 
    addl $1, %ebx
    movl %edx, %eax
    jmp et_cautare4
et_setare_stanga_dupa_zero4:
    movl %ebx, %ecx
    movl %edx, %eax
    addl $1, %esi
    addl $1, %ebx
    jmp et_cautare4
et_terminare_interval4:
    movl %eax, descriptor
    movl %esi, nr_blocuri
    push %eax
    push %ebx
    push %edx

    addl %ecx, %esi

    movl %ecx, %ebx
    lea v, %edi

    jmp et_un_fel_de_delete4

et_un_fel_de_delete4:
    cmp %esi, %ebx
    jge et_terminat_un_fel_de_delete4
    movb $0, (%edi, %ebx, 1)
    addl $1, %ebx
    jmp et_un_fel_de_delete4
et_terminat_un_fel_de_delete4:
    xorl %ebx, %ebx
    xorl %eax, %eax
    xorl %ecx, %ecx
    xorl %esi, %esi
    xorl %edx, %edx

    movl aux1, %ebx                   

    jmp et_un_fel_de_adaugat4
et_un_fel_de_adaugat4:
    cmp $1048576, %ebx
    jge et_continuam_defrag4 

    cmp $0, %ebx
    je et_primul_el4

    push %ecx
    push %eax
    xorl %edx, %edx
    movl %ebx, %eax
    movl $1024, %ecx
    div %ecx
    
    pop %eax
    pop %ecx
    cmp $0, %edx
    je et_linia_urm4
    

    movb (%edi, %ebx, 1), %dl
    cmpb $0, %dl
    jnz et_mergem_la_urm4

    cmpl $0, %eax
    jg et_continuare_bloc4

    movl %ebx, %ecx
    jmp et_continuare_bloc4

et_primul_el4:
    movb (%edi, %ebx, 1), %dl
    cmpb $0, %dl
    jnz et_mergem_la_urm4

    cmpl $0, %eax
    jg et_continuare_bloc4

    movl %ebx, %ecx
    jmp et_continuare_bloc4
et_linia_urm4:
    cmp nr_blocuri, %eax
    je et_inghesuit4

    addl $1, %esi
    xorl %eax, %eax
    xorl %ecx, %ecx

    movb (%edi, %ebx, 1), %dl
    cmpb $0, %dl
    jnz et_mergem_la_urm4

    cmpl $0, %eax
    jg et_continuare_bloc4

    movl %ebx, %ecx
    jmp et_continuare_bloc4

et_inghesuit4:
    movl %ecx, %edx
    addl %eax, %edx
    subl $1, %edx
    movl %edx, dreapta

    
    movl %ecx, %edx
    addl nr_blocuri, %edx

    movl %edx, nr_blocuri
    movl %ecx, %edx
    
    jmp et_scris_in_v4 
et_continuare_bloc4:
    addl $1, %eax
    cmpl %eax, nr_blocuri
    jg et_mergem_la_urm44

    cmpl %eax, nr_blocuri
    jg et_nu_incape4

    movl %ecx, %edx
    addl %eax, %edx
    subl $1, %edx
    movl %edx, dreapta

    movl %ecx, %edx
    addl nr_blocuri, %edx

    movl %edx, aux1                            
  
    movl %edx, nr_blocuri
    movl %ecx, %edx
    

    jmp et_scris_in_v4 
et_nu_incape4:
    xorl %ecx, %ecx
    xorl %eax, %eax
    addl $1, %ebx
    
    jmp et_un_fel_de_adaugat4
et_scris_in_v4:
    cmpl nr_blocuri, %edx
    jge et_afisare_interval4
    movl descriptor, %eax
    movb %al, (%edi, %edx, 1)
    addl $1, %edx
    jmp et_scris_in_v4
et_afisare_interval4:

    xorl %edx, %edx
    movl %ebx, %eax
    push %ecx
    movl $1024, %ecx
    divl %ecx
    pop %ecx
    push %edx
    push %eax
    xorl %edx, %edx
    movl %ecx, %eax
    push %ecx
    movl $1024, %ecx
    divl %ecx
    pop %ecx
    push %edx
    push %eax
    push descriptor
    push $afisare_3
    call printf
    addl $24, %esp

    xorl %ebx, %ebx

    jmp et_continuam_defrag4
et_mergem_la_urm4:
    addl $1, %ebx
    xorl %eax, %eax
    jmp et_un_fel_de_adaugat4
et_mergem_la_urm44:
    addl $1, %ebx
    jmp et_un_fel_de_adaugat4

et_continuam_defrag4:
    
    pop %edx
    pop %ebx
    pop %eax
    
    xorl %eax, %eax
    xorl %esi, %esi
    movl %edx, %eax 
    movl %ebx, %ecx
    addl $1, %ebx
    movl $1, %esi
    
    xorl %edx, %edx
    jmp et_cautare4
et_terminat4:
    jmp et_operatii
main:
    push $nr_op
    push $introducere_1
    call scanf
    add $8, %esp

    xorl %ecx, %ecx
    push %ecx
    jmp et_operatii