TITLE Add and Subtract, Version 2         (AddSub2.asm)

; This program encrypts and decrypts text


INCLUDE Irvine32.inc

.data

msgprompt BYTE "Please enter a word: ",0

key BYTE "NIGERDELTA", 0  ;key
;key2 BYTE "KINGDOMHEARTS", 0 ;KEY2 flips between the two

sln BYTE "HEYA", 0        ;txt
wrd BYTE "----", 0        ;code

ans BYTE "----", 0        ;finale
pt2 BYTE "----", 0        ;finalept2  


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.code

genKey PROC    ;generates the key
mov ecx, 8
mov esi, 0


    L1:
       mov al, key[esi]
       mov wrd[esi], al
       sub ecx,1
       add esi,1
       cmp ecx, 0
       Loop L1

ret
genKey ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

encrypt PROC    ; Encryption takes place here
mov ecx, 4
mov esi, 0


    L2:
        mov dx, 0

        movzx ax, key[esi]   ;key[i]
        movzx di, sln[esi]   ;sln[i]

        add ax, di           ;adds them
        mov bx, 26
        div bx               ;mod 26
        add dx, 'A'
        mov ans[esi], dl     ;ans[i]

        ;mov al, ans
        ;call writechar
        ;pop eax

        add esi,1            ;incriments
        cmp ecx, 0           ;compares, if zero end loop
        Loop L2

ret
encrypt endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
decrypt PROC ; Decryption takes place here
mov ecx, 4
mov esi, 0

    L3:
        mov dx, 0

        movzx di, wrd[esi]   ;wrd[i]
        movzx ax, ans[esi]   ;ans[i]
        sub ax, di           ;subtracts them
        add ax, 26

        mov bx, 26
        div bx              ;mod 26

        add dx, 'A'
        mov pt2[esi], dl     ;ans[i]

        add esi, 1           ;incriments
        cmp ecx, 0           ;compares, if zero end loop
        Loop L3

ret 
decrypt endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main PROC
call genKey
call encrypt
call decrypt

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

invoke ExitProcess,0
main endp
end main

;
;   for(i = 4; i < 0; i++){
;  
;   x = (sln[i] + wrd[i]) %26
;   
;   ans[i] = x + 'A'
;   
;   for(int i = 4; i < 0; i++){
;    x = (sln[i] - wrd[i]) %26           
;         ans[i] = x + 'A'                    
;     }
;
