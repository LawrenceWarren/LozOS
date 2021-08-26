;
; A simple boot sector program that prints a message then loops forever.

[org 0x7c00] ; Tells the assembler where this code will be loaded

  mov [BOOT_DRIVE], dl    ; BIOS stores our boot drive in DL , so it ’s
                          ; best to remember this for later.

  mov bp, 0x8000          ; Here we set our stack safely out of the
  mov sp, bp              ; way , at 0 x8000

  mov   bx, HELLO_MSG
  call  string_print_func

  mov   bx, GOODBYE_MSG
  call  string_print_func

  mov   dx, 0x1fb6
  call  hex_print_func

  jmp   $ ; Hang

%include "src/string_print_func.asm"
%include "src/hex_print_func.asm"

; Data
HELLO_MSG:
  db  'Hello, World!', 0

GOODBYE_MSG:
  db  'Goodbye, world!', 0

HEX_OUT:
  db '0x0000',0

; Global variables
BOOT_DRIVE: 
  db 0

; PUT NOTHING BELOW HERE!

  times 510-($-$$) db 0 ; When compiled , our program must fit into 512 bytes ,
                        ; with the last two bytes being the magic number ,
                        ; so here , tell our assembly compiler to pad out our
                        ; program with enough zero bytes (db 0) to bring us to the
                        ; 510 th byte.

  dw  0xaa55 ; Last two bytes ( one word ) form the magic number ,
            ; so BIOS knows we are a boot sector.
