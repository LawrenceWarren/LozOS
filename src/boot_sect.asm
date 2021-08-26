;
; A simple boot sector program that prints a message then loops forever.

[org 0x7c00] ; Tells the assembler where this code will be loaded

  mov [BOOT_DRIVE], dl    ; BIOS stores our boot drive in DL , so it ’s
                          ; best to remember this for later.

  mov bp, 0x8000          ; Here we set our stack safely out of the
  mov sp, bp              ; way , at 0 x8000









  ; Reading some extra sectors into memory

  mov bx, 0x9000          ; Load 5 sectors to 0x0000 (ES):0x9000 (BX)
  mov dh, 2               ; from the boot disk.

  mov dl, [BOOT_DRIVE]
  call disk_load
  
  mov dx, [0x9000]        ; Print out the first loaded word, which
  call hex_print_func     ; we expect to be 0xdada, stored
                          ; at address 0x9000
  
  mov dx, [0x9000 + 512]  ; Also , print the first word from the
  call hex_print_func     ; 2nd loaded sector : should be 0 xface

  jmp   $ ; Hang

%include "src/string_print_func.asm"
%include "src/hex_print_func.asm"
%include "src/disk_load.asm"

; Data
HELLO_MSG:
  db  'Hello, World!', 0

GOODBYE_MSG:
  db  'Goodbye, world!', 0

HEX_OUT:
  db '0x0000', 0

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

times 256 dw 0xdada
times 256 dw 0xface