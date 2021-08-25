[org 0x7c00]

; Function enters here, assuming dx stores a 16-bit number
hex_print_func:
  pusha
  mov   bx, HEX_OUT ; cl will point to the element of the hex string to set
  add   bx, 0d2       ; move past '0x', leave us pointing at first position

  ; first char
  mov   ax, 0x0000
  mov   ah, dh
  and   ah, 0xf0
  shr   ah, 0d4
  add   ah, 0d48
  mov   [bx], ah
  add   bx, 0d1

  ; second char
  ; mov   ax, 0x0000
  ; mov   ah, dh
  ; and   ah, 0x0f
  ; shr   ah, 0d4
  ; add   ah, 0d65
  ; mov   [bx], ah
  ; add   bx, 0d1


  ; done!
  mov   bx, HEX_OUT
  call  string_print_func
  popa
  ret

hex_print_is_int:
  ret

hex_print_is_char:
  ret



; This is C code for doing what we want

; std::string view_chararr2hexstrbe(int count,
;                                   unsigned char* values,
;                                   bool prepend = false) {
;   char ret[count * 2 + 1];
;   char* ptr = ret;
; 
;   while (count--) {
;     g_snprintf(ptr, 3, "%02X", (int)values[count]);
;     ptr += 2;  // Step string pointer
;   }
; 
;   if (prepend) {
;     return std::string(ret).insert(0, "0x");
;   } else {
;     return std::string(ret);
;   }
; }