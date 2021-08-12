hex_print_func:
  mov   ah, 0x0e ; int =10/ ah =0 x0e -> BIOS tele - type output
  mov   cx, bx
  jmp   main_loop

main_loop:
  mov   al, [bx]
  cmp   al, 0 ; if character is 0, end
  je    end
  int   0x10 ; print the character in al
  mov   cx, cx+1
  jmp   hex_print_func

end:
  ret
