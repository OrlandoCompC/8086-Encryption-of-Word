;Orlando Companioni
;Encrypts what the user enters 
;It then prints both the encrypted version and the decrypted version
                        
include 'emu8086.inc' 
 
org 100h     
mov dx, 25
LEA di, sourceString   ;moving the string address into di      

call GET_STRING
putc 0dh
putc 0ah
     
mov cx, dx ;Moving the counter
lea si, encryptedString         
mov al,[di]
cmp al, 'M'        ;comparing to see if the string is M
jne encrypting53
mov [val],25 ;moving 25 into the value of key /////// 
;ENCRYPTION STARTS WITH 25
encrypting25:
    mov al,[di]
    xor al,key  ; encrypting
    mov [si],al   ;Save to encryptedString
    inc di
    inc si
    loop encrypting25   
   
print:                      ;just a place to jump if needed after ecnrypting 
    lea si, encryptedString 
    call PRINT_STRING
    putc 0dh
    putc 0ah  
     
    ;DECRYPTION STARTS  
mov cx,dx   
lea di, encryptedString
lea si, decryptedString

decrypting:
    mov al,[di]
    ;decripting using XOR instruction 
    XOR al,key
    mov [si], al  
    inc si
    inc di
    loop decrypting 
    
lea si, decryptedString
call PRINT_STRING
putc 0dh
putc 0ah   
jmp finish 

 
encrypting53:     ;will jump here if first letter is not m     
mov [val],53  
 
encrypt:
    mov al, [di]
    xor al,key  ; encrypting
    mov [si],al   ;Save to encryptedString
    inc di
    inc si
    loop encrypt 
    jmp print
finish:ret
    sourceString db 26 dup(0)  
    encryptedString db 26 dup(0) 
    decryptedString db 26 dup(0)   
    val db ?  ;this variable can change but key cannot  
    key equ val
    DEFINE_GET_STRING        
    DEFINE_PRINT_STRING                


        
       



