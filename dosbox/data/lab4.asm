        model  SMALL
        stack  100h

        dataseg
INPSTR  db 80, ?, 80 dup(?) 				; ����� �����
OUTSTR  db 7 dup(?), '$'				; ����� ������

        codeseg
        startupcode
        lea    	DX, INPSTR
        mov    	AH, 0Ah					; ���� ������
        int    	21h
        xor    	AX, AX					; ��������� AX
        lea    	BX, INPSTR+1				; � BX ����� ������  
        xor    	CX, CX					; ��������� CX
        mov 	DI, 0
	mov	SI, 0	
	mov 	DX, 0
next:
	inc     BX
	mov     AL, [BX]				; ������� BX ��������� ����     
        cmp     AL, 0Dh					; ���������� �� ����� ������
	je	NC2					; �����, ��� �� NC2
	cmp     AL, ' '					; ���������� �� ������       
        je      NC					; ������, ��� �� NC
	inc	CH                                      ; CH + 1
        sub     AL, '0'					; CH - ���� �� ������ �����
	mov	SI, DI
	sal	DI, 3
	sal	SI, 1					; � DI �� ������� ���� �����
	add	DI, SI                                  ; ���� �������� �������� ��� �������� �����
        add	DI, AX
	jmp	next
NC:     
	cmp	CH,0
	je	next
NC2:
	cmp	CL,0					; ����� ����, ��� �� �������� ������ ����� �� ����������� CL
	jne	notfirst                                ; ��� ��������, ����� �����, ����� ��� ����� ����������
	inc	CL                                      ; DX � DI
	inc 	CH					
	mov	DX,DI
	mov	DI,0
	xor	CH,CH
	cmp	AX, 0Dh					; ���������� AX �� ����� ������ 
	je	exit					; ���� ��, ���������� �� ����� exit
	jmp 	next
notfirst:
	cmp	CH,0
	je	exit
	xor 	CH,CH
	cmp	DI,DX					; ���� ������ ������� ������ �������
	jnl	nextstep 					
	mov	DX,DI					; �� � DX �� ������� ������� �����
nextstep:
	xor	DI,DI					; ��������� DI
	cmp	AX, 0Dh					; ���������� AX �� ����� ������
	je	exit					; ���� ��, ��������� �� ����� exit
	jmp 	next
exit:   
	lea	BX, OUTSTR + 7                          ; BX ����� ������
	mov	AX,DX					; � AX �������� �������
	mov 	CL,10					; � CL �������� �������
cicl:	
        mov	DX,0
	dec	BX
	div	CX					; � AX ����� ������� 
	add	DL,'0'                                  ; � DX ����� �������
	mov	[BX],DL                                 ; � CX ����� 10, ����� ������ ��� ����������� ���� ������
	cmp	AX,0
	jne	cicl					; ���� AX �� 0 ����������
	dec	BX
	mov	DX, 0Dh					; ������� ������� � ������ ������� ������
	mov	[BX], DL
	mov	AH, 09h					; ������� � �������
	int	21h
QUIT:   exitcode  0
        end
