[org 0x7c00]

; Function enters here, assuming dx stores a 16-bit number
hex_print_func:
  pusha
  mov   cl, 0d0
  mov   bx, HEX_OUT   ; cl will point to the element of the hex string to set
  add   bx, 0d2       ; move past '0x', leave us pointing at first position

; The main mathematics of the function
hex_print_main:
  mov   ah, dh
  shr   ax, 0d4
  cmp   ah, 0d10 ; if less than 10, ASCII requires adding 0x30
  jl    hex_print_is_int
  add   ah, 0x37 ; if more than 10, ASCII requires adding 0x37

; Handles pointer assignment and counters
hex_print_cleanup:
  mov   [bx], ah ; assign value at pointer
  add   bx, 0d1  ; increment pointer
  shl   dx, 0d4  ; shift paramter by 4
  add   cl, 0d1  ; increment loop counter
  cmp   cl, 0d4  ; if loop counter is 4, end
  jne   hex_print_main

; done! Print output and end
hex_print_end: 
  mov   bx, HEX_OUT
  call  string_print_func
  popa
  ret

hex_print_is_int:
  add   ah, 0x30
  jmp   hex_print_cleanup
