[org 0x7c00]

hex_print_func:
  mov   ah, 0x0e ; int =10/ ah =0 x0e -> BIOS tele - type output
  mov   al, [bx]
  jmp   main_loop

main_loop:
  cmp   al, 0
  je    end
  int   0x10 ; print the character in al
  add   bx, 1 ; pointer arithmetic
  mov   al, [bx]
  jmp   main_loop

end:
  ret