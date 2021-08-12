;
; A simple boot sector program that prints a message then loops forever.
; to build, run ./make

%include "hex_print_func.asm"

[org 0x7c00] ; Tells the assembler where this code will be loaded

  mov   bx, HELLO_MSG   ; Use BX as a parameter to our function , so
  call  hex_print_func ; we can specify the address of a string.

  mov   bx, GOODBYE_MSG
  call  hex_print_func

  jmp   $ ; Hang

  times 510-($-$$) db 0 ; When compiled , our program must fit into 512 bytes ,
                        ; with the last two bytes being the magic number ,
                        ; so here , tell our assembly compiler to pad out our
                        ; program with enough zero bytes (db 0) to bring us to the
                        ; 510 th byte.

  dw  0xaa55 ; Last two bytes ( one word ) form the magic number ,
            ; so BIOS knows we are a boot sector.

; Data
HELLO_MSG:
  db  'Hello, World!', 0

GOODBYE_MSG:
  db  'Goodbye, now', 0