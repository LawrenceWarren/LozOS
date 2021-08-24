[org 0x7c00]

; Function enters here, assuming dx stores a 16-bit number
hex_print_func:
  pusha
  mov   ah, 0x0e ; int =10/ ah =0 x0e -> BIOS tele - type output
  jmp   hex_print_main_loop

hex_print_main_loop:
  ; TODO: manipulate chars at HEX_OUT
  jmp   hex_print_end

hex_print_end:
  mov   bx, HEX_OUT
  call  string_print_func
  popa
  ret


HEX_OUT:
  db '0x0000',0
