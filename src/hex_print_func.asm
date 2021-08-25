[org 0x7c00]

; Function enters here, assuming dx stores a 16-bit number
hex_print_func:
  pusha
  mov   bx, HEX_OUT ; cl will point to the element of the hex string to set
  add   bx, 2       ; move past '0x', leave us pointing at first position
  


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