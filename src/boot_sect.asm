;
; A simple boot sector program that prints a message then loops forever.

[org 0x7c00] ; Tells the assembler where this code will be loaded

  mov bp, 0x9000          ; Here we set our stack safely out of the
  mov sp, bp              ; way , at 0x8000

  mov bx, MSG_REAL_MODE
  call string_print_func

  call switch_to_pm ; Note that we never return from here.

  jmp $

%include "src/string_print_func_32.asm"
%include "src/string_print_func.asm"
%include "src/gdt.asm"
%include "src/switch_to_pm.asm"

[bits 32]

; This is where we arrive after switching to and initialising protected mode.
BEGIN_PM:
  mov ebx, MSG_PROT_MODE
  call string_print_func_32 ; Use our 32 - bit print routine.

  jmp $ ; Hang

  ; Global variables
MSG_REAL_MODE:
  db 'Started in 16-bit Real Mode', 0
MSG_PROT_MODE:
  db 'Successfully landed in 32-bit Protected Mode', 0
  


  ; Bootsector padding
  times 510-($-$$) db 0
  dw 0xaa55











