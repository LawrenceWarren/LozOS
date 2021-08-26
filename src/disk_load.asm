; load DH sectors to ES:BX from drive DL
; DH - number of sectors
; BX - where to read them to
; DL - Disk drive number

disk_load:
  push dx         ; Store DX on stack so later we can recall
                  ; how many sectors were request to be read,
                  ; even if it is altered in the meantime

  mov ah, 0x02   ; BIOS read sector function
  mov al, dh     ; Read DH sectors
  mov ch, 0x00   ; Select cylinder 0
  mov dh, 0x00   ; Select head 0
  mov cl, 0x02   ; Start reading from second sector ( i.e.
                  ; after the boot sector )

  int 0x13        ; BIOS interrupt

  jc disk_error   ; Jump if error ( i.e. carry flag set )

  pop dx          ; Restore DX from the stack
  cmp dh, al     ; if AL ( sectors read ) != DH (sectors expected)
  jne new_error  ; display error message
  ret

disk_error:
  mov bx, DISK_ERROR_MSG
  call string_print_func
  jmp $

new_error:
  mov bx, ERROR_TWO_MSG
  call string_print_func
  jmp $

; Variables
DISK_ERROR_MSG:
  db "FUCK read error!", 0

ERROR_TWO_MSG:
  db "New error?!", 0