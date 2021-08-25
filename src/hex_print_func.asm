[org 0x7c00]

; Function enters here, assuming dx stores a 16-bit number
hex_print_func:
  pusha
  mov   bx, HEX_OUT ; cl will point to the element of the hex string to set
  add   bx, 0d2       ; move past '0x', leave us pointing at first position

  ; first char
  mov   ah, dh
  shr   ax, 0d4
  ;cmp   ah, 0d10
  ;jl    hex_print_is_int
  ;jge   hex_print_is_char
  add   ah, 0x30
  mov   [bx], ah
  add   bx, 0d1
  
  ; second char
  mov   ah, al
  shr   ax, 0d4
  ;jl    hex_print_is_int
  ;jge   hex_print_is_char
  add   ah, 0x37
  mov   [bx], ah
  add   bx, 0d1

  ; done!
  mov   bx, HEX_OUT
  call  string_print_func
  popa
  ret

hex_print_is_int:
  add   ah, 0x30
  ret

hex_print_is_char:
  add   ah, 0x37
  ret


