; ======================================================================
; TAMAGOTCHI P1 MASTER DISASSEMBLY
; Generated with Deep Annotation Engine
; ======================================================================

0x000:  FA2  LD_A_MN  0x02        ; Load A from direct RAM address 0x02
0x001:  C87  UNKNOWN              ; Unrecognized instruction: 0xC87
0x002:  E10  LD_R_I   B, #0       ; Load B with immediate value #0
0x003:  A80  ADD_R_Q  A, A        ; Add value of A to register A (RESET_VECTOR)
0x004:  A80  ADD_R_Q  A, A        ; Add value of A to register A (RESET_VECTOR)
0x005:  A95  ADC_R_Q  B, B        ; Add value of B plus Carry to register B
0x006:  512  CALZ     0x112       ; Call subroutine at 0x112 if Zero flag is set
0x007:  E50  PSET     16          ; Set NP (New Page) to 16 for the next jump/call
0x008:  020  JP       0x1020      ; Jump to address 0x1020
0x009:  FC4  UNKNOWN              ; Unrecognized instruction: 0xFC4
0x00A:  FC5  UNKNOWN              ; Unrecognized instruction: 0xFC5
0x00B:  FC6  UNKNOWN              ; Unrecognized instruction: 0xFC6
0x00C:  FC0  PUSH_R               ; Push registers A, B and Flags to the stack
0x00D:  5EF  CALZ     0x10EF      ; Call subroutine at 0x10EF if Zero flag is set
0x00E:  B7D  LD_X     0x7D        ; Set X pointer to RAM address 0x7D
0x00F:  E2F  LD_R_I   [X], #15    ; Load [X] with immediate value #15
0x010:  F48  UNKNOWN              ; Unrecognized instruction: 0xF48
0x011:  01A  JP       0x101A      ; Jump to address 0x101A
0x012:  FC4  UNKNOWN              ; Unrecognized instruction: 0xFC4
0x013:  FC5  UNKNOWN              ; Unrecognized instruction: 0xFC5
0x014:  FC6  UNKNOWN              ; Unrecognized instruction: 0xFC6
0x015:  FC0  PUSH_R               ; Push registers A, B and Flags to the stack
0x016:  5EF  CALZ     0x10EF      ; Call subroutine at 0x10EF if Zero flag is set
0x017:  B7D  LD_X     0x7D        ; Set X pointer to RAM address 0x7D
0x018:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0x019:  F57  UNKNOWN              ; Unrecognized instruction: 0xF57
0x01A:  FD0  POP_R                ; Pop registers A, B and Flags from the stack
0x01B:  FD6  UNKNOWN              ; Unrecognized instruction: 0xFD6
0x01C:  FD5  UNKNOWN              ; Unrecognized instruction: 0xFD5
0x01D:  FD4  UNKNOWN              ; Unrecognized instruction: 0xFD4
0x01E:  FDF  RET                  ; Return to caller
0x01F:  B02  LD_X     0x02        ; Set X pointer to RAM address 0x02
0x020:  53C  CALZ     0x103C      ; Call subroutine at 0x103C if Zero flag is set
0x021:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x022:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x023:  B26  LD_X     0x26        ; Set X pointer to RAM address 0x26
0x024:  512  CALZ     0x1012      ; Call subroutine at 0x1012 if Zero flag is set
0x025:  EE2  UNKNOWN              ; Unrecognized instruction: 0xEE2
0x026:  EC6  LD_R_Q   B, [X]      ; Copy value from [X] into B
0x027:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x028:  509  CALZ     0x1009      ; Call subroutine at 0x1009 if Zero flag is set
0x029:  EE8  UNKNOWN              ; Unrecognized instruction: 0xEE8
0x02A:  EC9  LD_R_Q   [X], B      ; Copy value from B into [X]
0x02B:  FDF  RET                  ; Return to caller
0x02C:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x02D:  E90  UNKNOWN              ; Unrecognized instruction: 0xE90
0x02E:  822  LD_Y     0x22        ; Set Y pointer to RAM address 0x22
0x02F:  512  CALZ     0x1012      ; Call subroutine at 0x1012 if Zero flag is set
0x030:  EAB  UNKNOWN              ; Unrecognized instruction: 0xEAB
0x031:  EF0  INC_Y                ; Increment the Y pointer by 1
0x032:  EA7  UNKNOWN              ; Unrecognized instruction: 0xEA7
0x033:  509  CALZ     0x1009      ; Call subroutine at 0x1009 if Zero flag is set
0x034:  FDF  RET                  ; Return to caller
0x035:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x036:  E90  UNKNOWN              ; Unrecognized instruction: 0xE90
0x037:  823  LD_Y     0x23        ; Set Y pointer to RAM address 0x23
0x038:  EC3  LD_R_Q   A, [Y]      ; Copy value from [Y] into A
0x039:  822  LD_Y     0x22        ; Set Y pointer to RAM address 0x22
0x03A:  AD3  UNKNOWN              ; Unrecognized instruction: 0xAD3
0x03B:  FDF  RET                  ; Return to caller
0x03C:  42C  CALL     0x102C      ; Call subroutine at 0x102C
0x03D:  435  CALL     0x1035      ; Call subroutine at 0x1035
0x03E:  73D  JP_NZ    0x103D      ; Jump to 0x103D if Zero flag is clear (result was non-zero)
0x03F:  FDF  RET                  ; Return to caller
0x040:  5EF  CALZ     0x10EF      ; Call subroutine at 0x10EF if Zero flag is set
0x041:  B2A  LD_X     0x2A        ; Set X pointer to RAM address 0x2A
0x042:  900  LBPX     #0          ; Load constant #0 into [X]
0x043:  E01  LD_R_I   A, #1       ; Load A with immediate value #1
0x044:  E10  LD_R_I   B, #0       ; Load B with immediate value #0
0x045:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x046:  B00  LD_X     0x00        ; Set X pointer to RAM address 0x00
0x047:  900  LBPX     #0          ; Load constant #0 into [X]
0x048:  900  LBPX     #0          ; Load constant #0 into [X]
0x049:  900  LBPX     #0          ; Load constant #0 into [X]
0x04A:  900  LBPX     #0          ; Load constant #0 into [X]
0x04B:  900  LBPX     #0          ; Load constant #0 into [X]
0x04C:  900  LBPX     #0          ; Load constant #0 into [X]
0x04D:  900  LBPX     #0          ; Load constant #0 into [X]
0x04E:  900  LBPX     #0          ; Load constant #0 into [X]
0x04F:  C1F  ADD_R_I  B, #15      ; Add immediate #15 to register B
0x050:  747  JP_NZ    0x1047      ; Jump to 0x1047 if Zero flag is clear (result was non-zero)
0x051:  FDF  RET                  ; Return to caller
0x052:  E44  PSET     4           ; Set NP (New Page) to 4 for the next jump/call
0x053:  486  CALL     0x486       ; Call subroutine at 0x486
0x054:  E44  PSET     4           ; Set NP (New Page) to 4 for the next jump/call
0x055:  400  CALL     0x400       ; Call subroutine at 0x400
0x056:  5EF  CALZ     0x4EF       ; Call subroutine at 0x4EF if Zero flag is set
0x057:  B2A  LD_X     0x2A        ; Set X pointer to RAM address 0x2A
0x058:  E9A  UNKNOWN              ; Unrecognized instruction: 0xE9A
0x059:  EE0  INC_X                ; Increment the X pointer by 1
0x05A:  E96  UNKNOWN              ; Unrecognized instruction: 0xE96
0x05B:  E01  LD_R_I   A, #1       ; Load A with immediate value #1
0x05C:  E90  UNKNOWN              ; Unrecognized instruction: 0xE90
0x05D:  E0E  LD_R_I   A, #14      ; Load A with immediate value #14
0x05E:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x05F:  B00  LD_X     0x00        ; Set X pointer to RAM address 0x00
0x060:  48D  CALL     0x48D       ; Call subroutine at 0x48D
0x061:  F5E  RCF                  ; Reset (clear) Carry Flag
0x062:  A27  UNKNOWN              ; Unrecognized instruction: 0xA27
0x063:  B80  LD_X     0x80        ; Set X pointer to RAM address 0x80
0x064:  48D  CALL     0x48D       ; Call subroutine at 0x48D
0x065:  F5E  RCF                  ; Reset (clear) Carry Flag
0x066:  A28  UNKNOWN              ; Unrecognized instruction: 0xA28
0x067:  B12  LD_X     0x12        ; Set X pointer to RAM address 0x12
0x068:  48D  CALL     0x48D       ; Call subroutine at 0x48D
0x069:  F5E  RCF                  ; Reset (clear) Carry Flag
0x06A:  A27  UNKNOWN              ; Unrecognized instruction: 0xA27
0x06B:  B92  LD_X     0x92        ; Set X pointer to RAM address 0x92
0x06C:  48D  CALL     0x48D       ; Call subroutine at 0x48D
0x06D:  F5E  RCF                  ; Reset (clear) Carry Flag
0x06E:  A28  UNKNOWN              ; Unrecognized instruction: 0xA28
0x06F:  B48  LD_X     0x48        ; Set X pointer to RAM address 0x48 (MEM_SICK_LEVEL)
0x070:  F41  SCF                  ; Set Carry Flag
0x071:  49F  CALL     0x49F       ; Call subroutine at 0x49F
0x072:  B3E  LD_X     0x3E        ; Set X pointer to RAM address 0x3E
0x073:  F41  SCF                  ; Set Carry Flag
0x074:  4A7  CALL     0x4A7       ; Call subroutine at 0x4A7
0x075:  F5E  RCF                  ; Reset (clear) Carry Flag
0x076:  A27  UNKNOWN              ; Unrecognized instruction: 0xA27
0x077:  BC8  LD_X     0xC8        ; Set X pointer to RAM address 0xC8
0x078:  F41  SCF                  ; Set Carry Flag
0x079:  49F  CALL     0x49F       ; Call subroutine at 0x49F
0x07A:  BBE  LD_X     0xBE        ; Set X pointer to RAM address 0xBE
0x07B:  F41  SCF                  ; Set Carry Flag
0x07C:  4A7  CALL     0x4A7       ; Call subroutine at 0x4A7
0x07D:  F5E  RCF                  ; Reset (clear) Carry Flag
0x07E:  A28  UNKNOWN              ; Unrecognized instruction: 0xA28
0x07F:  B36  LD_X     0x36        ; Set X pointer to RAM address 0x36
0x080:  F41  SCF                  ; Set Carry Flag
0x081:  4A3  CALL     0x4A3       ; Call subroutine at 0x4A3
0x082:  B2E  LD_X     0x2E        ; Set X pointer to RAM address 0x2E
0x083:  F41  SCF                  ; Set Carry Flag
0x084:  4A3  CALL     0x4A3       ; Call subroutine at 0x4A3
0x085:  F5E  RCF                  ; Reset (clear) Carry Flag
0x086:  A27  UNKNOWN              ; Unrecognized instruction: 0xA27
0x087:  BB6  LD_X     0xB6        ; Set X pointer to RAM address 0xB6
0x088:  F41  SCF                  ; Set Carry Flag
0x089:  4A3  CALL     0x4A3       ; Call subroutine at 0x4A3
0x08A:  BAE  LD_X     0xAE        ; Set X pointer to RAM address 0xAE
0x08B:  F41  SCF                  ; Set Carry Flag
0x08C:  0A3  JP       0x4A3       ; Jump to address 0x4A3
0x08D:  48F  CALL     0x48F       ; Call subroutine at 0x48F
0x08E:  EE0  INC_X                ; Increment the X pointer by 1
0x08F:  EFB  UNKNOWN              ; Unrecognized instruction: 0xEFB
0x090:  EE0  INC_X                ; Increment the X pointer by 1
0x091:  EFB  UNKNOWN              ; Unrecognized instruction: 0xEFB
0x092:  EE0  INC_X                ; Increment the X pointer by 1
0x093:  EFB  UNKNOWN              ; Unrecognized instruction: 0xEFB
0x094:  EE0  INC_X                ; Increment the X pointer by 1
0x095:  EFB  UNKNOWN              ; Unrecognized instruction: 0xEFB
0x096:  EE0  INC_X                ; Increment the X pointer by 1
0x097:  EFB  UNKNOWN              ; Unrecognized instruction: 0xEFB
0x098:  EE0  INC_X                ; Increment the X pointer by 1
0x099:  EFB  UNKNOWN              ; Unrecognized instruction: 0xEFB
0x09A:  EE0  INC_X                ; Increment the X pointer by 1
0x09B:  EFB  UNKNOWN              ; Unrecognized instruction: 0xEFB
0x09C:  EE0  INC_X                ; Increment the X pointer by 1
0x09D:  EFB  UNKNOWN              ; Unrecognized instruction: 0xEFB
0x09E:  FDF  RET                  ; Return to caller
0x09F:  EFB  UNKNOWN              ; Unrecognized instruction: 0xEFB
0x0A0:  EE0  INC_X                ; Increment the X pointer by 1
0x0A1:  EFB  UNKNOWN              ; Unrecognized instruction: 0xEFB
0x0A2:  A1C  UNKNOWN              ; Unrecognized instruction: 0xA1C
0x0A3:  EFB  UNKNOWN              ; Unrecognized instruction: 0xEFB
0x0A4:  EE0  INC_X                ; Increment the X pointer by 1
0x0A5:  EFB  UNKNOWN              ; Unrecognized instruction: 0xEFB
0x0A6:  A1C  UNKNOWN              ; Unrecognized instruction: 0xA1C
0x0A7:  EFB  UNKNOWN              ; Unrecognized instruction: 0xEFB
0x0A8:  EE0  INC_X                ; Increment the X pointer by 1
0x0A9:  EFB  UNKNOWN              ; Unrecognized instruction: 0xEFB
0x0AA:  A1C  UNKNOWN              ; Unrecognized instruction: 0xA1C
0x0AB:  EFB  UNKNOWN              ; Unrecognized instruction: 0xEFB
0x0AC:  EE0  INC_X                ; Increment the X pointer by 1
0x0AD:  EFB  UNKNOWN              ; Unrecognized instruction: 0xEFB
0x0AE:  A1C  UNKNOWN              ; Unrecognized instruction: 0xA1C
0x0AF:  EFB  UNKNOWN              ; Unrecognized instruction: 0xEFB
0x0B0:  EE0  INC_X                ; Increment the X pointer by 1
0x0B1:  EFB  UNKNOWN              ; Unrecognized instruction: 0xEFB
0x0B2:  FDF  RET                  ; Return to caller
0x0B3:  5EF  CALZ     0x4EF       ; Call subroutine at 0x4EF if Zero flag is set
0x0B4:  B4A  LD_X     0x4A        ; Set X pointer to RAM address 0x4A (MEM_SLEEPING)
0x0B5:  DA8  UNKNOWN              ; Unrecognized instruction: 0xDA8
0x0B6:  FDF  RET                  ; Return to caller
0x0B7:  5F2  CALZ     0x4F2       ; Call subroutine at 0x4F2 if Zero flag is set
0x0B8:  0BF  JP       0x4BF       ; Jump to address 0x4BF
0x0B9:  5EF  CALZ     0x4EF       ; Call subroutine at 0x4EF if Zero flag is set
0x0BA:  0BF  JP       0x4BF       ; Jump to address 0x4BF
0x0BB:  894  LD_Y     0x94        ; Set Y pointer to RAM address 0x94
0x0BC:  E1F  LD_R_I   B, #15      ; Load B with immediate value #15
0x0BD:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x0BE:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x0BF:  B7B  LD_X     0x7B        ; Set X pointer to RAM address 0x7B
0x0C0:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x0C1:  6CD  JP_Z     0x4CD       ; Jump to 0x4CD if Zero flag is set (result was zero)
0x0C2:  B32  LD_X     0x32        ; Set X pointer to RAM address 0x32
0x0C3:  512  CALZ     0x412       ; Call subroutine at 0x412 if Zero flag is set
0x0C4:  900  LBPX     #0          ; Load constant #0 into [X]
0x0C5:  B36  LD_X     0x36        ; Set X pointer to RAM address 0x36
0x0C6:  EBA  UNKNOWN              ; Unrecognized instruction: 0xEBA
0x0C7:  EE0  INC_X                ; Increment the X pointer by 1
0x0C8:  EB6  UNKNOWN              ; Unrecognized instruction: 0xEB6
0x0C9:  B58  LD_X     0x58        ; Set X pointer to RAM address 0x58
0x0CA:  EE8  UNKNOWN              ; Unrecognized instruction: 0xEE8
0x0CB:  EC9  LD_R_Q   [X], B      ; Copy value from B into [X]
0x0CC:  509  CALZ     0x409       ; Call subroutine at 0x409 if Zero flag is set
0x0CD:  FDF  RET                  ; Return to caller
0x0CE:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x0CF:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x0D0:  B2A  LD_X     0x2A        ; Set X pointer to RAM address 0x2A
0x0D1:  940  LBPX     #40         ; Load constant #64 into [X]
0x0D2:  B3A  LD_X     0x3A        ; Set X pointer to RAM address 0x3A
0x0D3:  FDF  RET                  ; Return to caller
0x0D4:  512  CALZ     0x412       ; Call subroutine at 0x412 if Zero flag is set
0x0D5:  EF3  UNKNOWN              ; Unrecognized instruction: 0xEF3
0x0D6:  0DB  JP       0x4DB       ; Jump to address 0x4DB
0x0D7:  512  CALZ     0x412       ; Call subroutine at 0x412 if Zero flag is set
0x0D8:  EF3  UNKNOWN              ; Unrecognized instruction: 0xEF3
0x0D9:  AD3  UNKNOWN              ; Unrecognized instruction: 0xAD3
0x0DA:  EF0  INC_Y                ; Increment the Y pointer by 1
0x0DB:  AD3  UNKNOWN              ; Unrecognized instruction: 0xAD3
0x0DC:  509  CALZ     0x409       ; Call subroutine at 0x409 if Zero flag is set
0x0DD:  FDF  RET                  ; Return to caller
0x0DE:  5CE  CALZ     0x4CE       ; Call subroutine at 0x4CE if Zero flag is set
0x0DF:  940  LBPX     #40         ; Load constant #64 into [X]
0x0E0:  E47  PSET     7           ; Set NP (New Page) to 7 for the next jump/call
0x0E1:  092  JP       0x792       ; Jump to address 0x792
0x0E2:  B12  LD_X     0x12        ; Set X pointer to RAM address 0x12
0x0E3:  F44  SDF                  ; Set Decimal Flag
0x0E4:  C21  ADD_R_I  [X], #1     ; Add immediate #1 to register [X]
0x0E5:  EE0  INC_X                ; Increment the X pointer by 1
0x0E6:  C60  UNKNOWN              ; Unrecognized instruction: 0xC60
0x0E7:  DE6  CP_R_I   [X], #6     ; Compare register [X] with immediate value #6
0x0E8:  2EA  JP_C     0x7EA       ; Jump to 0x7EA if Carry flag is set (overflow occurred)
0x0E9:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0x0EA:  F5B  RDF                  ; Reset (clear) Decimal Flag
0x0EB:  FDF  RET                  ; Return to caller
0x0EC:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x0ED:  E47  PSET     7           ; Set NP (New Page) to 7 for the next jump/call
0x0EE:  0C0  JP       0x7C0       ; Jump to address 0x7C0
0x0EF:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x0F0:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x0F1:  FDF  RET                  ; Return to caller
0x0F2:  E10  LD_R_I   B, #0       ; Load B with immediate value #0
0x0F3:  E81  UNKNOWN              ; Unrecognized instruction: 0xE81
0x0F4:  FDF  RET                  ; Return to caller
0x0F5:  E01  LD_R_I   A, #1       ; Load A with immediate value #1
0x0F6:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x0F7:  FDF  RET                  ; Return to caller
0x0F8:  B5D  LD_X     0x5D        ; Set X pointer to RAM address 0x5D (MEM_LIFECYCLE)
0x0F9:  DE1  CP_R_I   [X], #1     ; Compare register [X] with immediate value #1
0x0FA:  FDF  RET                  ; Return to caller
0x0FB:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x0FC:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x0FD:  B48  LD_X     0x48        ; Set X pointer to RAM address 0x48 (MEM_SICK_LEVEL)
0x0FE:  DA8  UNKNOWN              ; Unrecognized instruction: 0xDA8
0x0FF:  FDF  RET                  ; Return to caller

; =========================================================
; ROUTINE: RESET_VECTOR
; Location: 0x100 (Page 1, Step 00)
; Trigger:  Power on / Reset
; Logic:    Initialize registers and jump to main loop
; =========================================================

0x100:  010  JP       0x710       ; Jump to address 0x710
0x101:  016  JP       0x716       ; Jump to address 0x716
0x102:  01D  JP       0x71D       ; Jump to address 0x71D
0x103:  016  JP       0x716       ; Jump to address 0x716
0x104:  016  JP       0x716       ; Jump to address 0x716
0x105:  016  JP       0x716       ; Jump to address 0x716
0x106:  016  JP       0x716       ; Jump to address 0x716
0x107:  016  JP       0x716       ; Jump to address 0x716
0x108:  016  JP       0x716       ; Jump to address 0x716
0x109:  016  JP       0x716       ; Jump to address 0x716
0x10A:  016  JP       0x716       ; Jump to address 0x716
0x10B:  016  JP       0x716       ; Jump to address 0x716
0x10C:  06F  JP       0x76F       ; Jump to address 0x76F
0x10D:  016  JP       0x716       ; Jump to address 0x716
0x10E:  016  JP       0x716       ; Jump to address 0x716
0x10F:  016  JP       0x716       ; Jump to address 0x716
0x110:  F50  UNKNOWN              ; Unrecognized instruction: 0xF50
0x111:  E0F  LD_R_I   A, #15      ; Load A with immediate value #15
0x112:  FE0  UNKNOWN              ; Unrecognized instruction: 0xFE0
0x113:  FF0  UNKNOWN              ; Unrecognized instruction: 0xFF0
0x114:  E42  PSET     2           ; Set NP (New Page) to 2 for the next jump/call
0x115:  02A  JP       0x22A       ; Jump to address 0x22A
0x116:  FCA  UNKNOWN              ; Unrecognized instruction: 0xFCA
0x117:  FC0  PUSH_R               ; Push registers A, B and Flags to the stack
0x118:  FC1  PUSH_R               ; Push registers A, B and Flags to the stack
0x119:  FC4  UNKNOWN              ; Unrecognized instruction: 0xFC4
0x11A:  FC5  UNKNOWN              ; Unrecognized instruction: 0xFC5
0x11B:  FC6  UNKNOWN              ; Unrecognized instruction: 0xFC6
0x11C:  05B  JP       0x25B       ; Jump to address 0x25B
0x11D:  FCA  UNKNOWN              ; Unrecognized instruction: 0xFCA
0x11E:  FC0  PUSH_R               ; Push registers A, B and Flags to the stack
0x11F:  FC1  PUSH_R               ; Push registers A, B and Flags to the stack
0x120:  FC4  UNKNOWN              ; Unrecognized instruction: 0xFC4
0x121:  FC5  UNKNOWN              ; Unrecognized instruction: 0xFC5
0x122:  FC6  UNKNOWN              ; Unrecognized instruction: 0xFC6
0x123:  F5B  RDF                  ; Reset (clear) Decimal Flag
0x124:  E0F  LD_R_I   A, #15      ; Load A with immediate value #15
0x125:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x126:  B00  LD_X     0x00        ; Set X pointer to RAM address 0x00
0x127:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x128:  B76  LD_X     0x76        ; Set X pointer to RAM address 0x76
0x129:  901  LBPX     #1          ; Load constant #1 into [X]
0x12A:  921  LBPX     #21         ; Load constant #33 into [X]
0x12B:  B12  LD_X     0x12        ; Set X pointer to RAM address 0x12
0x12C:  E21  LD_R_I   [X], #1     ; Load [X] with immediate value #1
0x12D:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x12E:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x12F:  B57  LD_X     0x57        ; Set X pointer to RAM address 0x57
0x130:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x131:  633  JP_Z     0x233       ; Jump to 0x233 if Zero flag is set (result was zero)
0x132:  C2F  ADD_R_I  [X], #15    ; Add immediate #15 to register [X]
0x133:  B3C  LD_X     0x3C        ; Set X pointer to RAM address 0x3C
0x134:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x135:  64A  JP_Z     0x24A       ; Jump to 0x24A if Zero flag is set (result was zero)
0x136:  F44  SDF                  ; Set Decimal Flag
0x137:  B2E  LD_X     0x2E        ; Set X pointer to RAM address 0x2E
0x138:  E21  LD_R_I   [X], #1     ; Load [X] with immediate value #1
0x139:  B10  LD_X     0x10        ; Set X pointer to RAM address 0x10
0x13A:  C21  ADD_R_I  [X], #1     ; Add immediate #1 to register [X]
0x13B:  EE0  INC_X                ; Increment the X pointer by 1
0x13C:  C60  UNKNOWN              ; Unrecognized instruction: 0xC60
0x13D:  DE6  CP_R_I   [X], #6     ; Compare register [X] with immediate value #6
0x13E:  249  JP_C     0x249       ; Jump to 0x249 if Carry flag is set (overflow occurred)
0x13F:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x140:  5E4  CALZ     0x2E4       ; Call subroutine at 0x2E4 if Zero flag is set
0x141:  247  JP_C     0x247       ; Jump to 0x247 if Carry flag is set (overflow occurred)
0x142:  B14  LD_X     0x14        ; Set X pointer to RAM address 0x14
0x143:  EE2  UNKNOWN              ; Unrecognized instruction: 0xEE2
0x144:  EE6  UNKNOWN              ; Unrecognized instruction: 0xEE6
0x145:  B14  LD_X     0x14        ; Set X pointer to RAM address 0x14
0x146:  4F4  CALL     0x2F4       ; Call subroutine at 0x2F4
0x147:  E4C  PSET     12          ; Set NP (New Page) to 12 for the next jump/call
0x148:  47A  CALL     0xC7A       ; Call subroutine at 0xC7A
0x149:  F5B  RDF                  ; Reset (clear) Decimal Flag
0x14A:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x14B:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x14C:  B2F  LD_X     0x2F        ; Set X pointer to RAM address 0x2F
0x14D:  C21  ADD_R_I  [X], #1     ; Add immediate #1 to register [X]
0x14E:  EE0  INC_X                ; Increment the X pointer by 1
0x14F:  F28  UNKNOWN              ; Unrecognized instruction: 0xF28
0x150:  C60  UNKNOWN              ; Unrecognized instruction: 0xC60
0x151:  35B  JP_NC    0xC5B       ; Jump to 0xC5B if Carry flag is clear (no overflow)
0x152:  E0F  LD_R_I   A, #15      ; Load A with immediate value #15
0x153:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x154:  B70  LD_X     0x70        ; Set X pointer to RAM address 0x70
0x155:  DA3  UNKNOWN              ; Unrecognized instruction: 0xDA3
0x156:  65B  JP_Z     0xC5B       ; Jump to 0xC5B if Zero flag is set (result was zero)
0x157:  4E5  CALL     0xCE5       ; Call subroutine at 0xCE5
0x158:  65B  JP_Z     0xC5B       ; Jump to 0xC5B if Zero flag is set (result was zero)
0x159:  B70  LD_X     0x70        ; Set X pointer to RAM address 0x70
0x15A:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0x15B:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x15C:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x15D:  B7D  LD_X     0x7D        ; Set X pointer to RAM address 0x7D
0x15E:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x15F:  668  JP_Z     0xC68       ; Jump to 0xC68 if Zero flag is set (result was zero)
0x160:  FD6  UNKNOWN              ; Unrecognized instruction: 0xFD6
0x161:  FD5  UNKNOWN              ; Unrecognized instruction: 0xFD5
0x162:  FD4  UNKNOWN              ; Unrecognized instruction: 0xFD4
0x163:  FD1  POP_R                ; Pop registers A, B and Flags from the stack
0x164:  FD0  POP_R                ; Pop registers A, B and Flags from the stack
0x165:  FDA  UNKNOWN              ; Unrecognized instruction: 0xFDA
0x166:  F48  UNKNOWN              ; Unrecognized instruction: 0xF48
0x167:  FDF  RET                  ; Return to caller
0x168:  FD6  UNKNOWN              ; Unrecognized instruction: 0xFD6
0x169:  FD5  UNKNOWN              ; Unrecognized instruction: 0xFD5
0x16A:  FD4  UNKNOWN              ; Unrecognized instruction: 0xFD4
0x16B:  FD1  POP_R                ; Pop registers A, B and Flags from the stack
0x16C:  FD0  POP_R                ; Pop registers A, B and Flags from the stack
0x16D:  FDA  UNKNOWN              ; Unrecognized instruction: 0xFDA
0x16E:  FDF  RET                  ; Return to caller
0x16F:  FCA  UNKNOWN              ; Unrecognized instruction: 0xFCA
0x170:  FC0  PUSH_R               ; Push registers A, B and Flags to the stack
0x171:  FC1  PUSH_R               ; Push registers A, B and Flags to the stack
0x172:  FC4  UNKNOWN              ; Unrecognized instruction: 0xFC4
0x173:  FC5  UNKNOWN              ; Unrecognized instruction: 0xFC5
0x174:  FC6  UNKNOWN              ; Unrecognized instruction: 0xFC6
0x175:  F5B  RDF                  ; Reset (clear) Decimal Flag
0x176:  4A0  CALL     0xCA0       ; Call subroutine at 0xCA0
0x177:  E0F  LD_R_I   A, #15      ; Load A with immediate value #15
0x178:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x179:  B02  LD_X     0x02        ; Set X pointer to RAM address 0x02
0x17A:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A

; =========================================================
; ROUTINE: PROCESS_HUNGER_CHANGE
; Location: 0x17B (Page 1, Step 7B)
; Trigger:  Feeding or Tick
; Logic:    Modifies Hunger level [0x40] and updates internal counters
; =========================================================

0x17B:  B40  LD_X     0x40        ; Set X pointer to RAM address 0x40 (MEM_HUNGER)
0x17C:  EC6  LD_R_Q   B, [X]      ; Copy value from [X] into B
0x17D:  D1F  UNKNOWN              ; Unrecognized instruction: 0xD1F
0x17E:  C97  UNKNOWN              ; Unrecognized instruction: 0xC97
0x17F:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x180:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x181:  B5A  LD_X     0x5A        ; Set X pointer to RAM address 0x5A
0x182:  C21  ADD_R_I  [X], #1     ; Add immediate #1 to register [X]
0x183:  B22  LD_X     0x22        ; Set X pointer to RAM address 0x22
0x184:  C2F  ADD_R_I  [X], #15    ; Add immediate #15 to register [X]
0x185:  EE0  INC_X                ; Increment the X pointer by 1
0x186:  C6F  UNKNOWN              ; Unrecognized instruction: 0xC6F
0x187:  28A  JP_C     0xC8A       ; Jump to 0xC8A if Carry flag is set (overflow occurred)
0x188:  B22  LD_X     0x22        ; Set X pointer to RAM address 0x22
0x189:  900  LBPX     #0          ; Load constant #0 into [X]
0x18A:  B26  LD_X     0x26        ; Set X pointer to RAM address 0x26
0x18B:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x18C:  EE9  UNKNOWN              ; Unrecognized instruction: 0xEE9
0x18D:  AE1  UNKNOWN              ; Unrecognized instruction: 0xAE1
0x18E:  AC1  UNKNOWN              ; Unrecognized instruction: 0xAC1
0x18F:  AD8  UNKNOWN              ; Unrecognized instruction: 0xAD8
0x190:  B3D  LD_X     0x3D        ; Set X pointer to RAM address 0x3D
0x191:  F09  UNKNOWN              ; Unrecognized instruction: 0xF09
0x192:  697  JP_Z     0xC97       ; Jump to 0xC97 if Zero flag is set (result was zero)
0x193:  EC9  LD_R_Q   [X], B      ; Copy value from B into [X]
0x194:  B3E  LD_X     0x3E        ; Set X pointer to RAM address 0x3E
0x195:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0x196:  09F  JP       0xC9F       ; Jump to address 0xC9F
0x197:  B3E  LD_X     0x3E        ; Set X pointer to RAM address 0x3E
0x198:  C21  ADD_R_I  [X], #1     ; Add immediate #1 to register [X]
0x199:  79F  JP_NZ    0xC9F       ; Jump to 0xC9F if Zero flag is clear (result was non-zero)
0x19A:  E28  LD_R_I   [X], #8     ; Load [X] with immediate value #8
0x19B:  B3F  LD_X     0x3F        ; Set X pointer to RAM address 0x3F
0x19C:  AC6  UNKNOWN              ; Unrecognized instruction: 0xAC6
0x19D:  B27  LD_X     0x27        ; Set X pointer to RAM address 0x27
0x19E:  AD9  UNKNOWN              ; Unrecognized instruction: 0xAD9
0x19F:  05B  JP       0xC5B       ; Jump to address 0xC5B
0x1A0:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x1A1:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x1A2:  B32  LD_X     0x32        ; Set X pointer to RAM address 0x32
0x1A3:  C2F  ADD_R_I  [X], #15    ; Add immediate #15 to register [X]
0x1A4:  EE0  INC_X                ; Increment the X pointer by 1
0x1A5:  C6F  UNKNOWN              ; Unrecognized instruction: 0xC6F
0x1A6:  3AB  JP_NC    0xCAB       ; Jump to 0xCAB if Carry flag is clear (no overflow)
0x1A7:  B34  LD_X     0x34        ; Set X pointer to RAM address 0x34
0x1A8:  DA8  UNKNOWN              ; Unrecognized instruction: 0xDA8
0x1A9:  7D7  JP_NZ    0xCD7       ; Jump to 0xCD7 if Zero flag is clear (result was non-zero)
0x1AA:  FDF  RET                  ; Return to caller
0x1AB:  B36  LD_X     0x36        ; Set X pointer to RAM address 0x36
0x1AC:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x1AD:  C22  ADD_R_I  [X], #2     ; Add immediate #2 to register [X]
0x1AE:  EE0  INC_X                ; Increment the X pointer by 1
0x1AF:  EC6  LD_R_Q   B, [X]      ; Copy value from [X] into B
0x1B0:  C60  UNKNOWN              ; Unrecognized instruction: 0xC60
0x1B1:  B32  LD_X     0x32        ; Set X pointer to RAM address 0x32
0x1B2:  E4E  PSET     14          ; Set NP (New Page) to 14 for the next jump/call
0x1B3:  47C  CALL     0xE7C       ; Call subroutine at 0xE7C
0x1B4:  A56  UNKNOWN              ; Unrecognized instruction: 0xA56
0x1B5:  6C1  JP_Z     0xEC1       ; Jump to 0xEC1 if Zero flag is set (result was zero)
0x1B6:  B59  LD_X     0x59        ; Set X pointer to RAM address 0x59
0x1B7:  DEF  CP_R_I   [X], #15    ; Compare register [X] with immediate value #15
0x1B8:  6C1  JP_Z     0xEC1       ; Jump to 0xEC1 if Zero flag is set (result was zero)
0x1B9:  B58  LD_X     0x58        ; Set X pointer to RAM address 0x58
0x1BA:  C2F  ADD_R_I  [X], #15    ; Add immediate #15 to register [X]
0x1BB:  EE0  INC_X                ; Increment the X pointer by 1
0x1BC:  C6F  UNKNOWN              ; Unrecognized instruction: 0xC6F
0x1BD:  2C1  JP_C     0xEC1       ; Jump to 0xEC1 if Carry flag is set (overflow occurred)
0x1BE:  B36  LD_X     0x36        ; Set X pointer to RAM address 0x36
0x1BF:  97D  LBPX     #7D         ; Load constant #125 into [X]
0x1C0:  0AB  JP       0xEAB       ; Jump to address 0xEAB
0x1C1:  B34  LD_X     0x34        ; Set X pointer to RAM address 0x34
0x1C2:  DA8  UNKNOWN              ; Unrecognized instruction: 0xDA8
0x1C3:  7D7  JP_NZ    0xED7       ; Jump to 0xED7 if Zero flag is clear (result was non-zero)
0x1C4:  B38  LD_X     0x38        ; Set X pointer to RAM address 0x38
0x1C5:  958  LBPX     #58         ; Load constant #88 into [X]
0x1C6:  E0F  LD_R_I   A, #15      ; Load A with immediate value #15
0x1C7:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x1C8:  B71  LD_X     0x71        ; Set X pointer to RAM address 0x71
0x1C9:  CE1  UNKNOWN              ; Unrecognized instruction: 0xCE1
0x1CA:  FC4  UNKNOWN              ; Unrecognized instruction: 0xFC4
0x1CB:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x1CC:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x1CD:  B34  LD_X     0x34        ; Set X pointer to RAM address 0x34
0x1CE:  EE2  UNKNOWN              ; Unrecognized instruction: 0xEE2
0x1CF:  EC6  LD_R_Q   B, [X]      ; Copy value from [X] into B
0x1D0:  FD4  UNKNOWN              ; Unrecognized instruction: 0xFD4
0x1D1:  B74  LD_X     0x74        ; Set X pointer to RAM address 0x74
0x1D2:  EE8  UNKNOWN              ; Unrecognized instruction: 0xEE8
0x1D3:  EC9  LD_R_Q   [X], B      ; Copy value from B into [X]
0x1D4:  B54  LD_X     0x54        ; Set X pointer to RAM address 0x54 (MEM_AGE)
0x1D5:  CA7  UNKNOWN              ; Unrecognized instruction: 0xCA7
0x1D6:  FDF  RET                  ; Return to caller
0x1D7:  B38  LD_X     0x38        ; Set X pointer to RAM address 0x38
0x1D8:  C2F  ADD_R_I  [X], #15    ; Add immediate #15 to register [X]
0x1D9:  EE0  INC_X                ; Increment the X pointer by 1
0x1DA:  C6F  UNKNOWN              ; Unrecognized instruction: 0xC6F
0x1DB:  E0F  LD_R_I   A, #15      ; Load A with immediate value #15
0x1DC:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x1DD:  2E0  JP_C     0xEE0       ; Jump to 0xEE0 if Carry flag is set (overflow occurred)
0x1DE:  B71  LD_X     0x71        ; Set X pointer to RAM address 0x71
0x1DF:  CAE  UNKNOWN              ; Unrecognized instruction: 0xCAE
0x1E0:  B54  LD_X     0x54        ; Set X pointer to RAM address 0x54 (MEM_AGE)
0x1E1:  CE8  UNKNOWN              ; Unrecognized instruction: 0xCE8
0x1E2:  FDF  RET                  ; Return to caller
0x1E3:  E0F  LD_R_I   A, #15      ; Load A with immediate value #15
0x1E4:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x1E5:  B73  LD_X     0x73        ; Set X pointer to RAM address 0x73
0x1E6:  E26  LD_R_I   [X], #6     ; Load [X] with immediate value #6
0x1E7:  FFB  UNKNOWN              ; Unrecognized instruction: 0xFFB
0x1E8:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x1E9:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0x1EA:  C88  UNKNOWN              ; Unrecognized instruction: 0xC88
0x1EB:  FDF  RET                  ; Return to caller
0x1EC:  B75  LD_X     0x75        ; Set X pointer to RAM address 0x75
0x1ED:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x1EE:  EE8  UNKNOWN              ; Unrecognized instruction: 0xEE8
0x1EF:  EE9  UNKNOWN              ; Unrecognized instruction: 0xEE9
0x1F0:  B57  LD_X     0x57        ; Set X pointer to RAM address 0x57
0x1F1:  EE9  UNKNOWN              ; Unrecognized instruction: 0xEE9
0x1F2:  521  CALZ     0xE21       ; Call subroutine at 0xE21 if Zero flag is set
0x1F3:  FDF  RET                  ; Return to caller
0x1F4:  C01  ADD_R_I  A, #1       ; Add immediate #1 to register A
0x1F5:  C50  UNKNOWN              ; Unrecognized instruction: 0xC50
0x1F6:  DD1  CP_R_I   B, #1       ; Compare register B with immediate value #1
0x1F7:  2FD  JP_C     0xEFD       ; Jump to 0xEFD if Carry flag is set (overflow occurred)
0x1F8:  7FB  JP_NZ    0xEFB       ; Jump to 0xEFB if Zero flag is clear (result was non-zero)
0x1F9:  DC8  CP_R_I   A, #8       ; Compare register A with immediate value #8
0x1FA:  2FD  JP_C     0xEFD       ; Jump to 0xEFD if Carry flag is set (overflow occurred)
0x1FB:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x1FC:  E10  LD_R_I   B, #0       ; Load B with immediate value #0
0x1FD:  EE8  UNKNOWN              ; Unrecognized instruction: 0xEE8
0x1FE:  EE9  UNKNOWN              ; Unrecognized instruction: 0xEE9
0x1FF:  FDF  RET                  ; Return to caller
0x200:  556  CALZ     0xE56       ; Call subroutine at 0xE56 if Zero flag is set
0x201:  521  CALZ     0xE21       ; Call subroutine at 0xE21 if Zero flag is set
0x202:  DC5  CP_R_I   A, #5       ; Compare register A with immediate value #5
0x203:  606  JP_Z     0xE06       ; Jump to 0xE06 if Zero flag is set (result was zero)
0x204:  D91  UNKNOWN              ; Unrecognized instruction: 0xD91
0x205:  FDF  RET                  ; Return to caller
0x206:  512  CALZ     0xE12       ; Call subroutine at 0xE12 if Zero flag is set
0x207:  5EF  CALZ     0xEEF       ; Call subroutine at 0xEEF if Zero flag is set
0x208:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x209:  E90  UNKNOWN              ; Unrecognized instruction: 0xE90
0x20A:  B10  LD_X     0x10        ; Set X pointer to RAM address 0x10
0x20B:  872  LD_Y     0x72        ; Set Y pointer to RAM address 0x72
0x20C:  427  CALL     0xE27       ; Call subroutine at 0xE27
0x20D:  F50  UNKNOWN              ; Unrecognized instruction: 0xF50
0x20E:  E0F  LD_R_I   A, #15      ; Load A with immediate value #15
0x20F:  FE0  UNKNOWN              ; Unrecognized instruction: 0xFE0
0x210:  FF0  UNKNOWN              ; Unrecognized instruction: 0xFF0
0x211:  442  CALL     0xE42       ; Call subroutine at 0xE42
0x212:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x213:  E90  UNKNOWN              ; Unrecognized instruction: 0xE90
0x214:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x215:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x216:  810  LD_Y     0x10        ; Set Y pointer to RAM address 0x10
0x217:  B72  LD_X     0x72        ; Set X pointer to RAM address 0x72
0x218:  427  CALL     0xE27       ; Call subroutine at 0xE27
0x219:  509  CALZ     0xE09       ; Call subroutine at 0xE09 if Zero flag is set
0x21A:  880  LD_Y     0x80        ; Set Y pointer to RAM address 0x80
0x21B:  5BC  CALZ     0xEBC       ; Call subroutine at 0xEBC if Zero flag is set
0x21C:  E47  PSET     7           ; Set NP (New Page) to 7 for the next jump/call
0x21D:  461  CALL     0x761       ; Call subroutine at 0x761
0x21E:  E44  PSET     4           ; Set NP (New Page) to 4 for the next jump/call
0x21F:  465  CALL     0x465       ; Call subroutine at 0x465
0x220:  B3C  LD_X     0x3C        ; Set X pointer to RAM address 0x3C
0x221:  E2F  LD_R_I   [X], #15    ; Load [X] with immediate value #15
0x222:  521  CALZ     0x421       ; Call subroutine at 0x421 if Zero flag is set
0x223:  D87  UNKNOWN              ; Unrecognized instruction: 0xD87
0x224:  722  JP_NZ    0x422       ; Jump to 0x422 if Zero flag is clear (result was non-zero)
0x225:  E45  PSET     5           ; Set NP (New Page) to 5 for the next jump/call
0x226:  017  JP       0x517       ; Jump to address 0x517
0x227:  E52  PSET     18          ; Set NP (New Page) to 18 for the next jump/call
0x228:  022  JP       0x1222      ; Jump to address 0x1222
0x229:  FDF  RET                  ; Return to caller
0x22A:  E41  PSET     1           ; Set NP (New Page) to 1 for the next jump/call
0x22B:  4E3  CALL     0x1E3       ; Call subroutine at 0x1E3
0x22C:  72F  JP_NZ    0x12F       ; Jump to 0x12F if Zero flag is clear (result was non-zero)
0x22D:  B70  LD_X     0x70        ; Set X pointer to RAM address 0x70
0x22E:  E21  LD_R_I   [X], #1     ; Load [X] with immediate value #1
0x22F:  E0F  LD_R_I   A, #15      ; Load A with immediate value #15
0x230:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x231:  B40  LD_X     0x40        ; Set X pointer to RAM address 0x40 (MEM_HUNGER)
0x232:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x233:  E90  UNKNOWN              ; Unrecognized instruction: 0xE90
0x234:  870  LD_Y     0x70        ; Set Y pointer to RAM address 0x70
0x235:  ECE  LD_R_Q   [Y], [X]    ; Copy value from [X] into [Y]
0x236:  CB7  UNKNOWN              ; Unrecognized instruction: 0xCB7
0x237:  442  CALL     0x142       ; Call subroutine at 0x142
0x238:  509  CALZ     0x109       ; Call subroutine at 0x109 if Zero flag is set
0x239:  880  LD_Y     0x80        ; Set Y pointer to RAM address 0x80
0x23A:  5BC  CALZ     0x1BC       ; Call subroutine at 0x1BC if Zero flag is set
0x23B:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x23C:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x23D:  B70  LD_X     0x70        ; Set X pointer to RAM address 0x70
0x23E:  DE3  CP_R_I   [X], #3     ; Compare register [X] with immediate value #3
0x23F:  656  JP_Z     0x156       ; Jump to 0x156 if Zero flag is set (result was zero)
0x240:  E49  PSET     9           ; Set NP (New Page) to 9 for the next jump/call
0x241:  07F  JP       0x97F       ; Jump to address 0x97F
0x242:  E51  PSET     17          ; Set NP (New Page) to 17 for the next jump/call
0x243:  0E0  JP       0x11E0      ; Jump to address 0x11E0
0x244:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x245:  E1E  LD_R_I   B, #14      ; Load B with immediate value #14
0x246:  545  CALZ     0x1145      ; Call subroutine at 0x1145 if Zero flag is set
0x247:  E01  LD_R_I   A, #1       ; Load A with immediate value #1
0x248:  E10  LD_R_I   B, #0       ; Load B with immediate value #0
0x249:  545  CALZ     0x1145      ; Call subroutine at 0x1145 if Zero flag is set
0x24A:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x24B:  E17  LD_R_I   B, #7       ; Load B with immediate value #7
0x24C:  545  CALZ     0x1145      ; Call subroutine at 0x1145 if Zero flag is set
0x24D:  E0E  LD_R_I   A, #14      ; Load A with immediate value #14
0x24E:  E15  LD_R_I   B, #5       ; Load B with immediate value #5
0x24F:  545  CALZ     0x1145      ; Call subroutine at 0x1145 if Zero flag is set
0x250:  E15  LD_R_I   B, #5       ; Load B with immediate value #5
0x251:  B80  LD_X     0x80        ; Set X pointer to RAM address 0x80
0x252:  547  CALZ     0x1147      ; Call subroutine at 0x1147 if Zero flag is set
0x253:  E52  PSET     18          ; Set NP (New Page) to 18 for the next jump/call
0x254:  000  JP       0x1200      ; Jump to address 0x1200
0x255:  FDF  RET                  ; Return to caller
0x256:  B2C  LD_X     0x2C        ; Set X pointer to RAM address 0x2C
0x257:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x258:  8FF  LD_Y     0xFF        ; Set Y pointer to RAM address 0xFF
0x259:  E12  LD_R_I   B, #2       ; Load B with immediate value #2
0x25A:  46B  CALL     0x126B      ; Call subroutine at 0x126B
0x25B:  B2C  LD_X     0x2C        ; Set X pointer to RAM address 0x2C
0x25C:  95A  LBPX     #5A         ; Load constant #90 into [X]
0x25D:  8A5  LD_Y     0xA5        ; Set Y pointer to RAM address 0xA5
0x25E:  E11  LD_R_I   B, #1       ; Load B with immediate value #1
0x25F:  46B  CALL     0x126B      ; Call subroutine at 0x126B
0x260:  B2C  LD_X     0x2C        ; Set X pointer to RAM address 0x2C
0x261:  9A5  LBPX     #A5         ; Load constant #165 into [X]
0x262:  85A  LD_Y     0x5A        ; Set Y pointer to RAM address 0x5A
0x263:  E14  LD_R_I   B, #4       ; Load B with immediate value #4
0x264:  46B  CALL     0x126B      ; Call subroutine at 0x126B
0x265:  B2C  LD_X     0x2C        ; Set X pointer to RAM address 0x2C
0x266:  900  LBPX     #0          ; Load constant #0 into [X]
0x267:  E12  LD_R_I   B, #2       ; Load B with immediate value #2
0x268:  481  CALL     0x1281      ; Call subroutine at 0x1281
0x269:  E49  PSET     9           ; Set NP (New Page) to 9 for the next jump/call
0x26A:  07F  JP       0x97F       ; Jump to address 0x97F
0x26B:  F90  LD_MN_B  0x00        ; Store B into direct RAM address 0x00
0x26C:  5F5  CALZ     0x9F5       ; Call subroutine at 0x9F5 if Zero flag is set
0x26D:  B00  LD_X     0x00        ; Set X pointer to RAM address 0x00
0x26E:  EB4  UNKNOWN              ; Unrecognized instruction: 0xEB4
0x26F:  EB9  UNKNOWN              ; Unrecognized instruction: 0xEB9
0x270:  EE8  UNKNOWN              ; Unrecognized instruction: 0xEE8
0x271:  EE8  UNKNOWN              ; Unrecognized instruction: 0xEE8
0x272:  EE9  UNKNOWN              ; Unrecognized instruction: 0xEE9
0x273:  EE9  UNKNOWN              ; Unrecognized instruction: 0xEE9
0x274:  A40  UNKNOWN              ; Unrecognized instruction: 0xA40
0x275:  770  JP_NZ    0x970       ; Jump to 0x970 if Zero flag is clear (result was non-zero)
0x276:  A50  UNKNOWN              ; Unrecognized instruction: 0xA50
0x277:  770  JP_NZ    0x970       ; Jump to 0x970 if Zero flag is clear (result was non-zero)
0x278:  E47  PSET     7           ; Set NP (New Page) to 7 for the next jump/call
0x279:  4E1  CALL     0x7E1       ; Call subroutine at 0x7E1
0x27A:  556  CALZ     0x756       ; Call subroutine at 0x756 if Zero flag is set
0x27B:  521  CALZ     0x721       ; Call subroutine at 0x721 if Zero flag is set
0x27C:  FB0  LD_B_MN  0x00        ; Load B from direct RAM address 0x00
0x27D:  F01  UNKNOWN              ; Unrecognized instruction: 0xF01
0x27E:  77B  JP_NZ    0x77B       ; Jump to 0x77B if Zero flag is clear (result was non-zero)
0x27F:  5BB  CALZ     0x7BB       ; Call subroutine at 0x7BB if Zero flag is set
0x280:  FDF  RET                  ; Return to caller
0x281:  F90  LD_MN_B  0x00        ; Store B into direct RAM address 0x00
0x282:  5F5  CALZ     0x7F5       ; Call subroutine at 0x7F5 if Zero flag is set
0x283:  B00  LD_X     0x00        ; Set X pointer to RAM address 0x00
0x284:  901  LBPX     #1          ; Load constant #1 into [X]
0x285:  A48  UNKNOWN              ; Unrecognized instruction: 0xA48
0x286:  784  JP_NZ    0x784       ; Jump to 0x784 if Zero flag is clear (result was non-zero)
0x287:  980  LBPX     #80         ; Load constant #128 into [X]
0x288:  A40  UNKNOWN              ; Unrecognized instruction: 0xA40
0x289:  787  JP_NZ    0x787       ; Jump to 0x787 if Zero flag is clear (result was non-zero)
0x28A:  B00  LD_X     0x00        ; Set X pointer to RAM address 0x00
0x28B:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x28C:  B3E  LD_X     0x3E        ; Set X pointer to RAM address 0x3E
0x28D:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x28E:  B80  LD_X     0x80        ; Set X pointer to RAM address 0x80
0x28F:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x290:  BBE  LD_X     0xBE        ; Set X pointer to RAM address 0xBE
0x291:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x292:  078  JP       0x778       ; Jump to address 0x778
0x293:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x294:  5ED  CALZ     0x7ED       ; Call subroutine at 0x7ED if Zero flag is set
0x295:  540  CALZ     0x740       ; Call subroutine at 0x740 if Zero flag is set
0x296:  521  CALZ     0x721       ; Call subroutine at 0x721 if Zero flag is set
0x297:  5CE  CALZ     0x7CE       ; Call subroutine at 0x7CE if Zero flag is set
0x298:  9C4  LBPX     #C4         ; Load constant #196 into [X]
0x299:  E45  PSET     5           ; Set NP (New Page) to 5 for the next jump/call
0x29A:  4A6  CALL     0x5A6       ; Call subroutine at 0x5A6
0x29B:  E15  LD_R_I   B, #5       ; Load B with immediate value #5
0x29C:  F95  LD_MN_B  0x05        ; Store B into direct RAM address 0x05
0x29D:  FA4  LD_A_MN  0x04        ; Load A from direct RAM address 0x04
0x29E:  DC6  CP_R_I   A, #6       ; Compare register A with immediate value #6
0x29F:  2A1  JP_C     0x5A1       ; Jump to 0x5A1 if Carry flag is set (overflow occurred)
0x2A0:  C03  ADD_R_I  A, #3       ; Add immediate #3 to register A
0x2A1:  F84  LD_MN_A  0x04        ; Store A into direct RAM address 0x04
0x2A2:  5F5  CALZ     0x5F5       ; Call subroutine at 0x5F5 if Zero flag is set
0x2A3:  BE2  LD_X     0xE2        ; Set X pointer to RAM address 0xE2
0x2A4:  F74  UNKNOWN              ; Unrecognized instruction: 0xF74
0x2A5:  FA4  LD_A_MN  0x04        ; Load A from direct RAM address 0x04
0x2A6:  AF0  UNKNOWN              ; Unrecognized instruction: 0xAF0
0x2A7:  E05  LD_R_I   A, #5       ; Load A with immediate value #5
0x2A8:  AF0  UNKNOWN              ; Unrecognized instruction: 0xAF0
0x2A9:  E45  PSET     5           ; Set NP (New Page) to 5 for the next jump/call
0x2AA:  4EF  CALL     0x5EF       ; Call subroutine at 0x5EF
0x2AB:  F75  UNKNOWN              ; Unrecognized instruction: 0xF75
0x2AC:  7A4  JP_NZ    0x5A4       ; Jump to 0x5A4 if Zero flag is clear (result was non-zero)
0x2AD:  556  CALZ     0x556       ; Call subroutine at 0x556 if Zero flag is set
0x2AE:  E4F  PSET     15          ; Set NP (New Page) to 15 for the next jump/call
0x2AF:  400  CALL     0xF00       ; Call subroutine at 0xF00
0x2B0:  7C0  JP_NZ    0xFC0       ; Jump to 0xFC0 if Zero flag is clear (result was non-zero)
0x2B1:  51F  CALZ     0xF1F       ; Call subroutine at 0xF1F if Zero flag is set
0x2B2:  D92  UNKNOWN              ; Unrecognized instruction: 0xD92
0x2B3:  E45  PSET     5           ; Set NP (New Page) to 5 for the next jump/call
0x2B4:  708  JP_NZ    0x508       ; Jump to 0x508 if Zero flag is clear (result was non-zero)
0x2B5:  DC5  CP_R_I   A, #5       ; Compare register A with immediate value #5
0x2B6:  E45  PSET     5           ; Set NP (New Page) to 5 for the next jump/call
0x2B7:  653  JP_Z     0x553       ; Jump to 0x553 if Zero flag is set (result was zero)
0x2B8:  B7C  LD_X     0x7C        ; Set X pointer to RAM address 0x7C
0x2B9:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x2BA:  E45  PSET     5           ; Set NP (New Page) to 5 for the next jump/call
0x2BB:  608  JP_Z     0x508       ; Jump to 0x508 if Zero flag is set (result was zero)
0x2BC:  B2E  LD_X     0x2E        ; Set X pointer to RAM address 0x2E
0x2BD:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x2BE:  6B1  JP_Z     0x5B1       ; Jump to 0x5B1 if Zero flag is set (result was zero)
0x2BF:  097  JP       0x597       ; Jump to address 0x597
0x2C0:  E43  PSET     3           ; Set NP (New Page) to 3 for the next jump/call
0x2C1:  407  CALL     0x307       ; Call subroutine at 0x307
0x2C2:  093  JP       0x393       ; Jump to address 0x393
0x2C3:  521  CALZ     0x321       ; Call subroutine at 0x321 if Zero flag is set
0x2C4:  AD1  UNKNOWN              ; Unrecognized instruction: 0xAD1
0x2C5:  D87  UNKNOWN              ; Unrecognized instruction: 0xD87
0x2C6:  6CD  JP_Z     0x3CD       ; Jump to 0x3CD if Zero flag is set (result was zero)
0x2C7:  B77  LD_X     0x77        ; Set X pointer to RAM address 0x77
0x2C8:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x2C9:  DC0  CP_R_I   A, #0       ; Compare register A with immediate value #0
0x2CA:  6CD  JP_Z     0x3CD       ; Jump to 0x3CD if Zero flag is set (result was zero)
0x2CB:  B57  LD_X     0x57        ; Set X pointer to RAM address 0x57
0x2CC:  EC8  LD_R_Q   [X], A      ; Copy value from A into [X]
0x2CD:  B29  LD_X     0x29        ; Set X pointer to RAM address 0x29
0x2CE:  DA4  UNKNOWN              ; Unrecognized instruction: 0xDA4
0x2CF:  6D9  JP_Z     0x3D9       ; Jump to 0x3D9 if Zero flag is set (result was zero)
0x2D0:  5BB  CALZ     0x3BB       ; Call subroutine at 0x3BB if Zero flag is set
0x2D1:  B76  LD_X     0x76        ; Set X pointer to RAM address 0x76
0x2D2:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x2D3:  B75  LD_X     0x75        ; Set X pointer to RAM address 0x75
0x2D4:  C21  ADD_R_I  [X], #1     ; Add immediate #1 to register [X]
0x2D5:  F08  UNKNOWN              ; Unrecognized instruction: 0xF08
0x2D6:  2EE  JP_C     0x3EE       ; Jump to 0x3EE if Carry flag is set (overflow occurred)
0x2D7:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0x2D8:  0EE  JP       0x3EE       ; Jump to address 0x3EE
0x2D9:  DA2  UNKNOWN              ; Unrecognized instruction: 0xDA2
0x2DA:  6DF  JP_Z     0x3DF       ; Jump to 0x3DF if Zero flag is set (result was zero)
0x2DB:  5BB  CALZ     0x3BB       ; Call subroutine at 0x3BB if Zero flag is set
0x2DC:  F5E  RCF                  ; Reset (clear) Carry Flag
0x2DD:  F42  SZF                  ; Set Zero Flag
0x2DE:  0F0  JP       0x3F0       ; Jump to address 0x3F0
0x2DF:  DA1  UNKNOWN              ; Unrecognized instruction: 0xDA1
0x2E0:  6E5  JP_Z     0x3E5       ; Jump to 0x3E5 if Zero flag is set (result was zero)
0x2E1:  5BB  CALZ     0x3BB       ; Call subroutine at 0x3BB if Zero flag is set
0x2E2:  F41  SCF                  ; Set Carry Flag
0x2E3:  F42  SZF                  ; Set Zero Flag
0x2E4:  0F0  JP       0x3F0       ; Jump to address 0x3F0
0x2E5:  B57  LD_X     0x57        ; Set X pointer to RAM address 0x57
0x2E6:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x2E7:  7EE  JP_NZ    0x3EE       ; Jump to 0x3EE if Zero flag is clear (result was non-zero)
0x2E8:  B77  LD_X     0x77        ; Set X pointer to RAM address 0x77
0x2E9:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x2EA:  6EE  JP_Z     0x3EE       ; Jump to 0x3EE if Zero flag is set (result was zero)
0x2EB:  F41  SCF                  ; Set Carry Flag
0x2EC:  F5D  RZF                  ; Reset (clear) Zero Flag
0x2ED:  0F0  JP       0x3F0       ; Jump to address 0x3F0
0x2EE:  F5E  RCF                  ; Reset (clear) Carry Flag
0x2EF:  F5D  RZF                  ; Reset (clear) Zero Flag
0x2F0:  B75  LD_X     0x75        ; Set X pointer to RAM address 0x75
0x2F1:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x2F2:  FDF  RET                  ; Return to caller
0x2F3:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x2F4:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x2F5:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x2F6:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x2F7:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x2F8:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x2F9:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x2FA:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x2FB:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x2FC:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x2FD:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x2FE:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x2FF:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x300:  FDF  RET                  ; Return to caller
0x301:  00C  JP       0x30C       ; Jump to address 0x30C
0x302:  01C  JP       0x31C       ; Jump to address 0x31C
0x303:  024  JP       0x324       ; Jump to address 0x324
0x304:  029  JP       0x329       ; Jump to address 0x329
0x305:  04B  JP       0x34B       ; Jump to address 0x34B
0x306:  074  JP       0x374       ; Jump to address 0x374
0x307:  5F2  CALZ     0x3F2       ; Call subroutine at 0x3F2 if Zero flag is set
0x308:  B5C  LD_X     0x5C        ; Set X pointer to RAM address 0x5C
0x309:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x30A:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0x30B:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0x30C:  B4A  LD_X     0x4A        ; Set X pointer to RAM address 0x4A (MEM_SLEEPING)
0x30D:  E2F  LD_R_I   [X], #15    ; Load [X] with immediate value #15
0x30E:  B5D  LD_X     0x5D        ; Set X pointer to RAM address 0x5D (MEM_LIFECYCLE)
0x30F:  EC6  LD_R_Q   B, [X]      ; Copy value from [X] into B
0x310:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x311:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x312:  B04  LD_X     0x04        ; Set X pointer to RAM address 0x04
0x313:  DD1  CP_R_I   B, #1       ; Compare register B with immediate value #1
0x314:  617  JP_Z     0x317       ; Jump to 0x317 if Zero flag is set (result was zero)
0x315:  900  LBPX     #0          ; Load constant #0 into [X]
0x316:  018  JP       0x318       ; Jump to address 0x318
0x317:  93D  LBPX     #3D         ; Load constant #61 into [X]
0x318:  E08  LD_R_I   A, #8       ; Load A with immediate value #8
0x319:  8A5  LD_Y     0xA5        ; Set Y pointer to RAM address 0xA5
0x31A:  5B7  CALZ     0x3B7       ; Call subroutine at 0x3B7 if Zero flag is set
0x31B:  FDF  RET                  ; Return to caller
0x31C:  B5D  LD_X     0x5D        ; Set X pointer to RAM address 0x5D (MEM_LIFECYCLE)
0x31D:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x31E:  E90  UNKNOWN              ; Unrecognized instruction: 0xE90
0x31F:  808  LD_Y     0x08        ; Set Y pointer to RAM address 0x08
0x320:  DE1  CP_R_I   [X], #1     ; Compare register [X] with immediate value #1
0x321:  727  JP_NZ    0x327       ; Jump to 0x327 if Zero flag is clear (result was non-zero)
0x322:  E3D  LD_R_I   [Y], #13    ; Load [Y] with immediate value #13
0x323:  018  JP       0x318       ; Jump to address 0x318
0x324:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x325:  E90  UNKNOWN              ; Unrecognized instruction: 0xE90
0x326:  809  LD_Y     0x09        ; Set Y pointer to RAM address 0x09
0x327:  E31  LD_R_I   [Y], #1     ; Load [Y] with immediate value #1
0x328:  016  JP       0x316       ; Jump to address 0x316
0x329:  B4B  LD_X     0x4B        ; Set X pointer to RAM address 0x4B
0x32A:  FC2  PUSH_R               ; Push registers A, B and Flags to the stack
0x32B:  E2F  LD_R_I   [X], #15    ; Load [X] with immediate value #15
0x32C:  E04  LD_R_I   A, #4       ; Load A with immediate value #4
0x32D:  E18  LD_R_I   B, #8       ; Load B with immediate value #8
0x32E:  802  LD_Y     0x02        ; Set Y pointer to RAM address 0x02
0x32F:  4D5  CALL     0x3D5       ; Call subroutine at 0x3D5
0x330:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x331:  E90  UNKNOWN              ; Unrecognized instruction: 0xE90
0x332:  84B  LD_Y     0x4B        ; Set Y pointer to RAM address 0x4B
0x333:  FD3  POP_R                ; Pop registers A, B and Flags from the stack
0x334:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x335:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x336:  B06  LD_X     0x06        ; Set X pointer to RAM address 0x06
0x337:  9B4  LBPX     #B4         ; Load constant #180 into [X]
0x338:  85D  LD_Y     0x5D        ; Set Y pointer to RAM address 0x5D (MEM_LIFECYCLE)
0x339:  DF1  CP_R_I   [Y], #1     ; Compare register [Y] with immediate value #1
0x33A:  73D  JP_NZ    0x33D       ; Jump to 0x33D if Zero flag is clear (result was non-zero)
0x33B:  B06  LD_X     0x06        ; Set X pointer to RAM address 0x06
0x33C:  919  LBPX     #19         ; Load constant #25 into [X]
0x33D:  84D  LD_Y     0x4D        ; Set Y pointer to RAM address 0x4D (MEM_POOP)
0x33E:  C31  ADD_R_I  [Y], #1     ; Add immediate #1 to register [Y]
0x33F:  DF8  CP_R_I   [Y], #8     ; Compare register [Y] with immediate value #8
0x340:  24A  JP_C     0x34A       ; Jump to 0x34A if Carry flag is set (overflow occurred)
0x341:  E38  LD_R_I   [Y], #8     ; Load [Y] with immediate value #8
0x342:  848  LD_Y     0x48        ; Set Y pointer to RAM address 0x48 (MEM_SICK_LEVEL)
0x343:  DB8  UNKNOWN              ; Unrecognized instruction: 0xDB8
0x344:  74A  JP_NZ    0x34A       ; Jump to 0x34A if Zero flag is clear (result was non-zero)
0x345:  B0D  LD_X     0x0D        ; Set X pointer to RAM address 0x0D
0x346:  512  CALZ     0x312       ; Call subroutine at 0x312 if Zero flag is set
0x347:  900  LBPX     #0          ; Load constant #0 into [X]
0x348:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0x349:  509  CALZ     0x309       ; Call subroutine at 0x309 if Zero flag is set
0x34A:  FDF  RET                  ; Return to caller
0x34B:  E03  LD_R_I   A, #3       ; Load A with immediate value #3
0x34C:  8AE  LD_Y     0xAE        ; Set Y pointer to RAM address 0xAE
0x34D:  5B7  CALZ     0x3B7       ; Call subroutine at 0x3B7 if Zero flag is set
0x34E:  4FC  CALL     0x3FC       ; Call subroutine at 0x3FC
0x34F:  E13  LD_R_I   B, #3       ; Load B with immediate value #3
0x350:  E48  PSET     8           ; Set NP (New Page) to 8 for the next jump/call
0x351:  49E  CALL     0x89E       ; Call subroutine at 0x89E
0x352:  4FC  CALL     0x8FC       ; Call subroutine at 0x8FC
0x353:  5EF  CALZ     0x8EF       ; Call subroutine at 0x8EF if Zero flag is set
0x354:  B50  LD_X     0x50        ; Set X pointer to RAM address 0x50 (MEM_CHARACTER)
0x355:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x356:  E4D  PSET     13          ; Set NP (New Page) to 13 for the next jump/call
0x357:  4C6  CALL     0xDC6       ; Call subroutine at 0xDC6
0x358:  B51  LD_X     0x51        ; Set X pointer to RAM address 0x51 (MEM_BEHAVIOR_MISTAKE)
0x359:  EC6  LD_R_Q   B, [X]      ; Copy value from [X] into B
0x35A:  B42  LD_X     0x42        ; Set X pointer to RAM address 0x42 (MEM_NEGLECT)
0x35B:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x35C:  B90  LD_X     0x90        ; Set X pointer to RAM address 0x90
0x35D:  F02  UNKNOWN              ; Unrecognized instruction: 0xF02
0x35E:  EE0  INC_X                ; Increment the X pointer by 1
0x35F:  262  JP_C     0xD62       ; Jump to 0xD62 if Carry flag is set (overflow occurred)
0x360:  F06  UNKNOWN              ; Unrecognized instruction: 0xF06
0x361:  366  JP_NC    0xD66       ; Jump to 0xD66 if Carry flag is clear (no overflow)
0x362:  EE0  INC_X                ; Increment the X pointer by 1
0x363:  EE0  INC_X                ; Increment the X pointer by 1
0x364:  EE0  INC_X                ; Increment the X pointer by 1
0x365:  05D  JP       0xD5D       ; Jump to address 0xD5D
0x366:  EE0  INC_X                ; Increment the X pointer by 1
0x367:  EE2  UNKNOWN              ; Unrecognized instruction: 0xEE2
0x368:  EC6  LD_R_Q   B, [X]      ; Copy value from [X] into B
0x369:  B50  LD_X     0x50        ; Set X pointer to RAM address 0x50 (MEM_CHARACTER)
0x36A:  EC8  LD_R_Q   [X], A      ; Copy value from A into [X]
0x36B:  B5D  LD_X     0x5D        ; Set X pointer to RAM address 0x5D (MEM_LIFECYCLE)
0x36C:  EC9  LD_R_Q   [X], B      ; Copy value from B into [X]
0x36D:  E44  PSET     4           ; Set NP (New Page) to 4 for the next jump/call
0x36E:  465  CALL     0x465       ; Call subroutine at 0x465
0x36F:  E14  LD_R_I   B, #4       ; Load B with immediate value #4
0x370:  E48  PSET     8           ; Set NP (New Page) to 8 for the next jump/call
0x371:  49E  CALL     0x89E       ; Call subroutine at 0x89E
0x372:  E4D  PSET     13          ; Set NP (New Page) to 13 for the next jump/call
0x373:  0D2  JP       0xDD2       ; Jump to address 0xDD2
0x374:  5EC  CALZ     0xDEC       ; Call subroutine at 0xDEC if Zero flag is set
0x375:  4FC  CALL     0xDFC       ; Call subroutine at 0xDFC
0x376:  5EF  CALZ     0xDEF       ; Call subroutine at 0xDEF if Zero flag is set
0x377:  B74  LD_X     0x74        ; Set X pointer to RAM address 0x74
0x378:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x379:  B48  LD_X     0x48        ; Set X pointer to RAM address 0x48 (MEM_SICK_LEVEL)
0x37A:  900  LBPX     #0          ; Load constant #0 into [X]
0x37B:  9F0  LBPX     #F0         ; Load constant #240 into [X]
0x37C:  900  LBPX     #0          ; Load constant #0 into [X]
0x37D:  B5D  LD_X     0x5D        ; Set X pointer to RAM address 0x5D (MEM_LIFECYCLE)
0x37E:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x37F:  F86  LD_MN_A  0x06        ; Store A into direct RAM address 0x06
0x380:  8BF  LD_Y     0xBF        ; Set Y pointer to RAM address 0xBF
0x381:  5BC  CALZ     0xDBC       ; Call subroutine at 0xDBC if Zero flag is set
0x382:  4D2  CALL     0xDD2       ; Call subroutine at 0xDD2
0x383:  4D2  CALL     0xDD2       ; Call subroutine at 0xDD2
0x384:  4D2  CALL     0xDD2       ; Call subroutine at 0xDD2
0x385:  4D2  CALL     0xDD2       ; Call subroutine at 0xDD2
0x386:  8C4  LD_Y     0xC4        ; Set Y pointer to RAM address 0xC4
0x387:  5BC  CALZ     0xDBC       ; Call subroutine at 0xDBC if Zero flag is set
0x388:  4D2  CALL     0xDD2       ; Call subroutine at 0xDD2
0x389:  8C9  LD_Y     0xC9        ; Set Y pointer to RAM address 0xC9
0x38A:  5BC  CALZ     0xDBC       ; Call subroutine at 0xDBC if Zero flag is set
0x38B:  4D2  CALL     0xDD2       ; Call subroutine at 0xDD2
0x38C:  5EF  CALZ     0xDEF       ; Call subroutine at 0xDEF if Zero flag is set
0x38D:  B5D  LD_X     0x5D        ; Set X pointer to RAM address 0x5D (MEM_LIFECYCLE)
0x38E:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0x38F:  B4E  LD_X     0x4E        ; Set X pointer to RAM address 0x4E
0x390:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x391:  69E  JP_Z     0xD9E       ; Jump to 0xD9E if Zero flag is set (result was zero)
0x392:  4D7  CALL     0xDD7       ; Call subroutine at 0xDD7
0x393:  B1B  LD_X     0x1B        ; Set X pointer to RAM address 0x1B
0x394:  53C  CALZ     0xD3C       ; Call subroutine at 0xD3C if Zero flag is set
0x395:  B48  LD_X     0x48        ; Set X pointer to RAM address 0x48 (MEM_SICK_LEVEL)
0x396:  52C  CALZ     0xD2C       ; Call subroutine at 0xD2C if Zero flag is set
0x397:  4D7  CALL     0xDD7       ; Call subroutine at 0xDD7
0x398:  540  CALZ     0xD40       ; Call subroutine at 0xD40 if Zero flag is set
0x399:  4E4  CALL     0xDE4       ; Call subroutine at 0xDE4
0x39A:  535  CALZ     0xD35       ; Call subroutine at 0xD35 if Zero flag is set
0x39B:  797  JP_NZ    0xD97       ; Jump to 0xD97 if Zero flag is clear (result was non-zero)
0x39C:  B1B  LD_X     0x1B        ; Set X pointer to RAM address 0x1B
0x39D:  53C  CALZ     0xD3C       ; Call subroutine at 0xD3C if Zero flag is set
0x39E:  8CE  LD_Y     0xCE        ; Set Y pointer to RAM address 0xCE
0x39F:  5BC  CALZ     0xDBC       ; Call subroutine at 0xDBC if Zero flag is set
0x3A0:  521  CALZ     0xD21       ; Call subroutine at 0xD21 if Zero flag is set
0x3A1:  540  CALZ     0xD40       ; Call subroutine at 0xD40 if Zero flag is set
0x3A2:  5F2  CALZ     0xDF2       ; Call subroutine at 0xDF2 if Zero flag is set
0x3A3:  B80  LD_X     0x80        ; Set X pointer to RAM address 0x80
0x3A4:  C28  ADD_R_I  [X], #8     ; Add immediate #8 to register [X]
0x3A5:  EC6  LD_R_Q   B, [X]      ; Copy value from [X] into B
0x3A6:  B3A  LD_X     0x3A        ; Set X pointer to RAM address 0x3A
0x3A7:  900  LBPX     #0          ; Load constant #0 into [X]
0x3A8:  E03  LD_R_I   A, #3       ; Load A with immediate value #3
0x3A9:  4EE  CALL     0xDEE       ; Call subroutine at 0xDEE
0x3AA:  5F2  CALZ     0xDF2       ; Call subroutine at 0xDF2 if Zero flag is set
0x3AB:  B3A  LD_X     0x3A        ; Set X pointer to RAM address 0x3A
0x3AC:  920  LBPX     #20         ; Load constant #32 into [X]
0x3AD:  E04  LD_R_I   A, #4       ; Load A with immediate value #4
0x3AE:  4ED  CALL     0xDED       ; Call subroutine at 0xDED
0x3AF:  E42  PSET     2           ; Set NP (New Page) to 2 for the next jump/call
0x3B0:  400  CALL     0x200       ; Call subroutine at 0x200
0x3B1:  6A1  JP_Z     0x2A1       ; Jump to 0x2A1 if Zero flag is set (result was zero)
0x3B2:  5BB  CALZ     0x2BB       ; Call subroutine at 0x2BB if Zero flag is set
0x3B3:  5F5  CALZ     0x2F5       ; Call subroutine at 0x2F5 if Zero flag is set
0x3B4:  BD0  LD_X     0xD0        ; Set X pointer to RAM address 0xD0
0x3B5:  E11  LD_R_I   B, #1       ; Load B with immediate value #1
0x3B6:  E09  LD_R_I   A, #9       ; Load A with immediate value #9
0x3B7:  4D0  CALL     0x2D0       ; Call subroutine at 0x2D0
0x3B8:  E10  LD_R_I   B, #0       ; Load B with immediate value #0
0x3B9:  E91  UNKNOWN              ; Unrecognized instruction: 0xE91
0x3BA:  854  LD_Y     0x54        ; Set Y pointer to RAM address 0x54 (MEM_AGE)
0x3BB:  EF3  UNKNOWN              ; Unrecognized instruction: 0xEF3
0x3BC:  B50  LD_X     0x50        ; Set X pointer to RAM address 0x50 (MEM_CHARACTER)
0x3BD:  4D0  CALL     0x2D0       ; Call subroutine at 0x2D0
0x3BE:  E10  LD_R_I   B, #0       ; Load B with immediate value #0
0x3BF:  EC3  LD_R_Q   A, [Y]      ; Copy value from [Y] into A
0x3C0:  DC0  CP_R_I   A, #0       ; Compare register A with immediate value #0
0x3C1:  6C4  JP_Z     0x2C4       ; Jump to 0x2C4 if Zero flag is set (result was zero)
0x3C2:  B40  LD_X     0x40        ; Set X pointer to RAM address 0x40 (MEM_HUNGER)

; =========================================================
; ROUTINE: CHECK_HUNGER_NEGLECT
; Location: 0x3C3 (Page 3, Step C3)
; Trigger:  Main timer tick
; Logic:    If Hunger hearts == 0, proceed to neglect timer check
; =========================================================

0x3C3:  4D0  CALL     0x2D0       ; Call subroutine at 0x2D0
0x3C4:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x3C5:  E12  LD_R_I   B, #2       ; Load B with immediate value #2
0x3C6:  E4A  PSET     10          ; Set NP (New Page) to 10 for the next jump/call
0x3C7:  4F0  CALL     0xAF0       ; Call subroutine at 0xAF0
0x3C8:  E42  PSET     2           ; Set NP (New Page) to 2 for the next jump/call
0x3C9:  400  CALL     0x200       ; Call subroutine at 0x200
0x3CA:  6C8  JP_Z     0x2C8       ; Jump to 0x2C8 if Zero flag is set (result was zero)
0x3CB:  5BB  CALZ     0x2BB       ; Call subroutine at 0x2BB if Zero flag is set
0x3CC:  E1E  LD_R_I   B, #14      ; Load B with immediate value #14
0x3CD:  E45  PSET     5           ; Set NP (New Page) to 5 for the next jump/call
0x3CE:  400  CALL     0x500       ; Call subroutine at 0x500
0x3CF:  0A1  JP       0x5A1       ; Jump to address 0x5A1
0x3D0:  E47  PSET     7           ; Set NP (New Page) to 7 for the next jump/call
0x3D1:  0A5  JP       0x7A5       ; Jump to address 0x7A5 (EXTRACT_HEART_COUNT)
0x3D2:  E0A  LD_R_I   A, #10      ; Load A with immediate value #10
0x3D3:  E1A  LD_R_I   B, #10      ; Load B with immediate value #10
0x3D4:  805  LD_Y     0x05        ; Set Y pointer to RAM address 0x05
0x3D5:  E48  PSET     8           ; Set NP (New Page) to 8 for the next jump/call
0x3D6:  0A9  JP       0x8A9       ; Jump to address 0x8A9
0x3D7:  540  CALZ     0x840       ; Call subroutine at 0x840 if Zero flag is set
0x3D8:  5EF  CALZ     0x8EF       ; Call subroutine at 0x8EF if Zero flag is set
0x3D9:  FB6  LD_B_MN  0x06        ; Load B from direct RAM address 0x06
0x3DA:  B5D  LD_X     0x5D        ; Set X pointer to RAM address 0x5D (MEM_LIFECYCLE)
0x3DB:  EC9  LD_R_Q   [X], B      ; Copy value from B into [X]
0x3DC:  E04  LD_R_I   A, #4       ; Load A with immediate value #4
0x3DD:  B00  LD_X     0x00        ; Set X pointer to RAM address 0x00
0x3DE:  E4A  PSET     10          ; Set NP (New Page) to 10 for the next jump/call
0x3DF:  4BD  CALL     0xABD       ; Call subroutine at 0xABD
0x3E0:  FA1  LD_A_MN  0x01        ; Load A from direct RAM address 0x01
0x3E1:  B3A  LD_X     0x3A        ; Set X pointer to RAM address 0x3A
0x3E2:  900  LBPX     #0          ; Load constant #0 into [X]
0x3E3:  4ED  CALL     0xAED       ; Call subroutine at 0xAED
0x3E4:  5F2  CALZ     0xAF2       ; Call subroutine at 0xAF2 if Zero flag is set
0x3E5:  B5D  LD_X     0x5D        ; Set X pointer to RAM address 0x5D (MEM_LIFECYCLE)
0x3E6:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0x3E7:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x3E8:  B3A  LD_X     0x3A        ; Set X pointer to RAM address 0x3A
0x3E9:  920  LBPX     #20         ; Load constant #32 into [X]
0x3EA:  4ED  CALL     0xAED       ; Call subroutine at 0xAED
0x3EB:  556  CALZ     0xA56       ; Call subroutine at 0xA56 if Zero flag is set
0x3EC:  FDF  RET                  ; Return to caller
0x3ED:  E10  LD_R_I   B, #0       ; Load B with immediate value #0
0x3EE:  FC1  PUSH_R               ; Push registers A, B and Flags to the stack
0x3EF:  5F2  CALZ     0xAF2       ; Call subroutine at 0xAF2 if Zero flag is set
0x3F0:  FD1  POP_R                ; Pop registers A, B and Flags from the stack
0x3F1:  FC1  PUSH_R               ; Push registers A, B and Flags to the stack
0x3F2:  FC0  PUSH_R               ; Push registers A, B and Flags to the stack
0x3F3:  E49  PSET     9           ; Set NP (New Page) to 9 for the next jump/call
0x3F4:  428  CALL     0x928       ; Call subroutine at 0x928
0x3F5:  FD0  POP_R                ; Pop registers A, B and Flags from the stack
0x3F6:  5F2  CALZ     0x9F2       ; Call subroutine at 0x9F2 if Zero flag is set
0x3F7:  FD1  POP_R                ; Pop registers A, B and Flags from the stack
0x3F8:  B3B  LD_X     0x3B        ; Set X pointer to RAM address 0x3B
0x3F9:  C28  ADD_R_I  [X], #8     ; Add immediate #8 to register [X]
0x3FA:  E49  PSET     9           ; Set NP (New Page) to 9 for the next jump/call
0x3FB:  039  JP       0x939       ; Jump to address 0x939
0x3FC:  E49  PSET     9           ; Set NP (New Page) to 9 for the next jump/call
0x3FD:  006  JP       0x906       ; Jump to address 0x906
0x3FE:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x3FF:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x400:  5EF  CALZ     0x9EF       ; Call subroutine at 0x9EF if Zero flag is set
0x401:  B4B  LD_X     0x4B        ; Set X pointer to RAM address 0x4B
0x402:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x403:  71B  JP_NZ    0x91B       ; Jump to 0x91B if Zero flag is clear (result was non-zero)
0x404:  5F5  CALZ     0x9F5       ; Call subroutine at 0x9F5 if Zero flag is set
0x405:  E90  UNKNOWN              ; Unrecognized instruction: 0xE90
0x406:  B00  LD_X     0x00        ; Set X pointer to RAM address 0x00
0x407:  880  LD_Y     0x80        ; Set Y pointer to RAM address 0x80
0x408:  E6F  LDPX_MX  #F          ; Load constant #15 into [X] and increment X
0x409:  E7F  LDPY_MY  #F          ; Load constant #15 into [Y] and increment Y
0x40A:  A44  UNKNOWN              ; Unrecognized instruction: 0xA44
0x40B:  208  JP_C     0x908       ; Jump to 0x908 if Carry flag is set (overflow occurred)
0x40C:  5B3  CALZ     0x9B3       ; Call subroutine at 0x9B3 if Zero flag is set
0x40D:  61A  JP_Z     0x91A       ; Jump to 0x91A if Zero flag is set (result was zero)
0x40E:  C21  ADD_R_I  [X], #1     ; Add immediate #1 to register [X]
0x40F:  CE8  UNKNOWN              ; Unrecognized instruction: 0xCE8
0x410:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x411:  E8C  UNKNOWN              ; Unrecognized instruction: 0xE8C
0x412:  C81  UNKNOWN              ; Unrecognized instruction: 0xC81
0x413:  C00  ADD_R_I  A, #0       ; Add immediate #0 to register A
0x414:  E11  LD_R_I   B, #1       ; Load B with immediate value #1
0x415:  E81  UNKNOWN              ; Unrecognized instruction: 0xE81
0x416:  E12  LD_R_I   B, #2       ; Load B with immediate value #2
0x417:  B20  LD_X     0x20        ; Set X pointer to RAM address 0x20
0x418:  E47  PSET     7           ; Set NP (New Page) to 7 for the next jump/call
0x419:  4A5  CALL     0x7A5       ; Call subroutine at 0x7A5 (EXTRACT_HEART_COUNT)
0x41A:  FDF  RET                  ; Return to caller
0x41B:  5B3  CALZ     0x7B3       ; Call subroutine at 0x7B3 if Zero flag is set
0x41C:  62A  JP_Z     0x72A       ; Jump to 0x72A if Zero flag is set (result was zero)
0x41D:  C21  ADD_R_I  [X], #1     ; Add immediate #1 to register [X]
0x41E:  CE8  UNKNOWN              ; Unrecognized instruction: 0xCE8
0x41F:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x420:  E8C  UNKNOWN              ; Unrecognized instruction: 0xE8C
0x421:  C81  UNKNOWN              ; Unrecognized instruction: 0xC81
0x422:  C0A  ADD_R_I  A, #10      ; Add immediate #10 to register A
0x423:  E11  LD_R_I   B, #1       ; Load B with immediate value #1
0x424:  E81  UNKNOWN              ; Unrecognized instruction: 0xE81
0x425:  E13  LD_R_I   B, #3       ; Load B with immediate value #3
0x426:  B30  LD_X     0x30        ; Set X pointer to RAM address 0x30
0x427:  E47  PSET     7           ; Set NP (New Page) to 7 for the next jump/call
0x428:  4A5  CALL     0x7A5       ; Call subroutine at 0x7A5 (EXTRACT_HEART_COUNT)
0x429:  032  JP       0x732       ; Jump to address 0x732
0x42A:  5FB  CALZ     0x7FB       ; Call subroutine at 0x7FB if Zero flag is set
0x42B:  632  JP_Z     0x732       ; Jump to 0x732 if Zero flag is set (result was zero)
0x42C:  5F5  CALZ     0x7F5       ; Call subroutine at 0x7F5 if Zero flag is set
0x42D:  B30  LD_X     0x30        ; Set X pointer to RAM address 0x30
0x42E:  E12  LD_R_I   B, #2       ; Load B with immediate value #2
0x42F:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x430:  E47  PSET     7           ; Set NP (New Page) to 7 for the next jump/call
0x431:  4A5  CALL     0x7A5       ; Call subroutine at 0x7A5 (EXTRACT_HEART_COUNT)
0x432:  5EF  CALZ     0x7EF       ; Call subroutine at 0x7EF if Zero flag is set
0x433:  B7E  LD_X     0x7E        ; Set X pointer to RAM address 0x7E
0x434:  C21  ADD_R_I  [X], #1     ; Add immediate #1 to register [X]
0x435:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x436:  E8C  UNKNOWN              ; Unrecognized instruction: 0xE8C
0x437:  C81  UNKNOWN              ; Unrecognized instruction: 0xC81
0x438:  C0E  ADD_R_I  A, #14      ; Add immediate #14 to register A
0x439:  F84  LD_MN_A  0x04        ; Store A into direct RAM address 0x04
0x43A:  B4D  LD_X     0x4D        ; Set X pointer to RAM address 0x4D (MEM_POOP)
0x43B:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x43C:  DC8  CP_R_I   A, #8       ; Compare register A with immediate value #8
0x43D:  23F  JP_C     0x73F       ; Jump to 0x73F if Carry flag is set (overflow occurred)
0x43E:  E08  LD_R_I   A, #8       ; Load A with immediate value #8
0x43F:  F83  LD_MN_A  0x03        ; Store A into direct RAM address 0x03
0x440:  C0D  ADD_R_I  A, #13      ; Add immediate #13 to register A
0x441:  356  JP_NC    0x756       ; Jump to 0x756 if Carry flag is clear (no overflow)
0x442:  E8C  UNKNOWN              ; Unrecognized instruction: 0xE8C
0x443:  C83  UNKNOWN              ; Unrecognized instruction: 0xC83
0x444:  C01  ADD_R_I  A, #1       ; Add immediate #1 to register A
0x445:  800  LD_Y     0x00        ; Set Y pointer to RAM address 0x00
0x446:  E94  UNKNOWN              ; Unrecognized instruction: 0xE94
0x447:  5F5  CALZ     0x7F5       ; Call subroutine at 0x7F5 if Zero flag is set
0x448:  E90  UNKNOWN              ; Unrecognized instruction: 0xE90
0x449:  B00  LD_X     0x00        ; Set X pointer to RAM address 0x00
0x44A:  EEB  UNKNOWN              ; Unrecognized instruction: 0xEEB
0x44B:  EF0  INC_Y                ; Increment the Y pointer by 1
0x44C:  A44  UNKNOWN              ; Unrecognized instruction: 0xA44
0x44D:  24A  JP_C     0x74A       ; Jump to 0x74A if Carry flag is set (overflow occurred)
0x44E:  F5E  RCF                  ; Reset (clear) Carry Flag
0x44F:  A04  UNKNOWN              ; Unrecognized instruction: 0xA04
0x450:  F5E  RCF                  ; Reset (clear) Carry Flag
0x451:  A24  UNKNOWN              ; Unrecognized instruction: 0xA24
0x452:  EEB  UNKNOWN              ; Unrecognized instruction: 0xEEB
0x453:  EF0  INC_Y                ; Increment the Y pointer by 1
0x454:  A4C  UNKNOWN              ; Unrecognized instruction: 0xA4C
0x455:  252  JP_C     0x752       ; Jump to 0x752 if Carry flag is set (overflow occurred)
0x456:  5F5  CALZ     0x7F5       ; Call subroutine at 0x7F5 if Zero flag is set
0x457:  BB0  LD_X     0xB0        ; Set X pointer to RAM address 0xB0
0x458:  F63  UNKNOWN              ; Unrecognized instruction: 0xF63
0x459:  F73  UNKNOWN              ; Unrecognized instruction: 0xF73
0x45A:  664  JP_Z     0x764       ; Jump to 0x764 if Zero flag is set (result was zero)
0x45B:  E11  LD_R_I   B, #1       ; Load B with immediate value #1
0x45C:  FA4  LD_A_MN  0x04        ; Load A from direct RAM address 0x04
0x45D:  E47  PSET     7           ; Set NP (New Page) to 7 for the next jump/call
0x45E:  4A5  CALL     0x7A5       ; Call subroutine at 0x7A5 (EXTRACT_HEART_COUNT)
0x45F:  F5E  RCF                  ; Reset (clear) Carry Flag
0x460:  A07  UNKNOWN              ; Unrecognized instruction: 0xA07
0x461:  259  JP_C     0x759       ; Jump to 0x759 if Carry flag is set (overflow occurred)
0x462:  A0F  UNKNOWN              ; Unrecognized instruction: 0xA0F
0x463:  059  JP       0x759       ; Jump to address 0x759
0x464:  FDF  RET                  ; Return to caller
0x465:  5EF  CALZ     0x7EF       ; Call subroutine at 0x7EF if Zero flag is set
0x466:  B5F  LD_X     0x5F        ; Set X pointer to RAM address 0x5F
0x467:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x468:  B66  LD_X     0x66        ; Set X pointer to RAM address 0x66
0x469:  900  LBPX     #0          ; Load constant #0 into [X]
0x46A:  B5D  LD_X     0x5D        ; Set X pointer to RAM address 0x5D (MEM_LIFECYCLE)
0x46B:  EE6  UNKNOWN              ; Unrecognized instruction: 0xEE6
0x46C:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x46D:  B6E  LD_X     0x6E        ; Set X pointer to RAM address 0x6E
0x46E:  E4A  PSET     10          ; Set NP (New Page) to 10 for the next jump/call
0x46F:  4BD  CALL     0xABD       ; Call subroutine at 0xABD
0x470:  B5D  LD_X     0x5D        ; Set X pointer to RAM address 0x5D (MEM_LIFECYCLE)
0x471:  EE6  UNKNOWN              ; Unrecognized instruction: 0xEE6
0x472:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x473:  B00  LD_X     0x00        ; Set X pointer to RAM address 0x00
0x474:  484  CALL     0xA84       ; Call subroutine at 0xA84
0x475:  E10  LD_R_I   B, #0       ; Load B with immediate value #0
0x476:  FA1  LD_A_MN  0x01        ; Load A from direct RAM address 0x01
0x477:  C0B  ADD_R_I  A, #11      ; Add immediate #11 to register A
0x478:  C58  UNKNOWN              ; Unrecognized instruction: 0xC58
0x479:  B6A  LD_X     0x6A        ; Set X pointer to RAM address 0x6A
0x47A:  482  CALL     0xA82       ; Call subroutine at 0xA82
0x47B:  E10  LD_R_I   B, #0       ; Load B with immediate value #0
0x47C:  FA0  LD_A_MN  0x00        ; Load A from direct RAM address 0x00
0x47D:  C00  ADD_R_I  A, #0       ; Add immediate #0 to register A
0x47E:  C5C  UNKNOWN              ; Unrecognized instruction: 0xC5C
0x47F:  B64  LD_X     0x64        ; Set X pointer to RAM address 0x64
0x480:  E4B  PSET     11          ; Set NP (New Page) to 11 for the next jump/call
0x481:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0x482:  E49  PSET     9           ; Set NP (New Page) to 9 for the next jump/call
0x483:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0x484:  E4B  PSET     11          ; Set NP (New Page) to 11 for the next jump/call
0x485:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0x486:  5EF  CALZ     0xBEF       ; Call subroutine at 0xBEF if Zero flag is set
0x487:  B5F  LD_X     0x5F        ; Set X pointer to RAM address 0x5F
0x488:  C2F  ADD_R_I  [X], #15    ; Add immediate #15 to register [X]
0x489:  296  JP_C     0xB96       ; Jump to 0xB96 if Carry flag is set (overflow occurred)
0x48A:  B64  LD_X     0x64        ; Set X pointer to RAM address 0x64
0x48B:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x48C:  C21  ADD_R_I  [X], #1     ; Add immediate #1 to register [X]
0x48D:  EE0  INC_X                ; Increment the X pointer by 1
0x48E:  EC6  LD_R_Q   B, [X]      ; Copy value from [X] into B
0x48F:  C60  UNKNOWN              ; Unrecognized instruction: 0xC60
0x490:  B62  LD_X     0x62        ; Set X pointer to RAM address 0x62
0x491:  4E3  CALL     0xBE3       ; Call subroutine at 0xBE3
0x492:  B62  LD_X     0x62        ; Set X pointer to RAM address 0x62
0x493:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x494:  B5F  LD_X     0x5F        ; Set X pointer to RAM address 0x5F
0x495:  EC8  LD_R_Q   [X], A      ; Copy value from A into [X]
0x496:  B66  LD_X     0x66        ; Set X pointer to RAM address 0x66
0x497:  C2F  ADD_R_I  [X], #15    ; Add immediate #15 to register [X]
0x498:  EE0  INC_X                ; Increment the X pointer by 1
0x499:  C6F  UNKNOWN              ; Unrecognized instruction: 0xC6F
0x49A:  2A8  JP_C     0xBA8       ; Jump to 0xBA8 if Carry flag is set (overflow occurred)
0x49B:  B6A  LD_X     0x6A        ; Set X pointer to RAM address 0x6A
0x49C:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x49D:  C22  ADD_R_I  [X], #2     ; Add immediate #2 to register [X]
0x49E:  EE0  INC_X                ; Increment the X pointer by 1
0x49F:  EC6  LD_R_Q   B, [X]      ; Copy value from [X] into B
0x4A0:  C60  UNKNOWN              ; Unrecognized instruction: 0xC60
0x4A1:  B66  LD_X     0x66        ; Set X pointer to RAM address 0x66
0x4A2:  4E5  CALL     0xBE5       ; Call subroutine at 0xBE5
0x4A3:  B67  LD_X     0x67        ; Set X pointer to RAM address 0x67
0x4A4:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x4A5:  CA0  UNKNOWN              ; Unrecognized instruction: 0xCA0
0x4A6:  B70  LD_X     0x70        ; Set X pointer to RAM address 0x70
0x4A7:  EC8  LD_R_Q   [X], A      ; Copy value from A into [X]
0x4A8:  B68  LD_X     0x68        ; Set X pointer to RAM address 0x68
0x4A9:  EE2  UNKNOWN              ; Unrecognized instruction: 0xEE2
0x4AA:  EE6  UNKNOWN              ; Unrecognized instruction: 0xEE6
0x4AB:  D81  UNKNOWN              ; Unrecognized instruction: 0xD81
0x4AC:  6B2  JP_Z     0xBB2       ; Jump to 0xBB2 if Zero flag is set (result was zero)
0x4AD:  C8E  UNKNOWN              ; Unrecognized instruction: 0xC8E
0x4AE:  B6C  LD_X     0x6C        ; Set X pointer to RAM address 0x6C
0x4AF:  A82  ADD_R_Q  A, [X]      ; Add value of [X] to register A
0x4B0:  EE0  INC_X                ; Increment the X pointer by 1
0x4B1:  A96  ADC_R_Q  B, [X]      ; Add value of [X] plus Carry to register B
0x4B2:  B6C  LD_X     0x6C        ; Set X pointer to RAM address 0x6C
0x4B3:  EE8  UNKNOWN              ; Unrecognized instruction: 0xEE8
0x4B4:  EE9  UNKNOWN              ; Unrecognized instruction: 0xEE9
0x4B5:  B3A  LD_X     0x3A        ; Set X pointer to RAM address 0x3A
0x4B6:  EE8  UNKNOWN              ; Unrecognized instruction: 0xEE8
0x4B7:  EE9  UNKNOWN              ; Unrecognized instruction: 0xEE9
0x4B8:  B70  LD_X     0x70        ; Set X pointer to RAM address 0x70
0x4B9:  DA8  UNKNOWN              ; Unrecognized instruction: 0xDA8
0x4BA:  6CB  JP_Z     0xBCB       ; Jump to 0xBCB if Zero flag is set (result was zero)
0x4BB:  B63  LD_X     0x63        ; Set X pointer to RAM address 0x63
0x4BC:  EC6  LD_R_Q   B, [X]      ; Copy value from [X] into B
0x4BD:  B6E  LD_X     0x6E        ; Set X pointer to RAM address 0x6E
0x4BE:  D92  UNKNOWN              ; Unrecognized instruction: 0xD92
0x4BF:  6C1  JP_Z     0xBC1       ; Jump to 0xBC1 if Zero flag is set (result was zero)
0x4C0:  B6F  LD_X     0x6F        ; Set X pointer to RAM address 0x6F
0x4C1:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x4C2:  B70  LD_X     0x70        ; Set X pointer to RAM address 0x70
0x4C3:  EC6  LD_R_Q   B, [X]      ; Copy value from [X] into B
0x4C4:  A85  ADD_R_Q  B, B        ; Add value of B to register B
0x4C5:  A85  ADD_R_Q  B, B        ; Add value of B to register B
0x4C6:  B63  LD_X     0x63        ; Set X pointer to RAM address 0x63
0x4C7:  AE6  UNKNOWN              ; Unrecognized instruction: 0xAE6
0x4C8:  C98  UNKNOWN              ; Unrecognized instruction: 0xC98
0x4C9:  E49  PSET     9           ; Set NP (New Page) to 9 for the next jump/call
0x4CA:  428  CALL     0x928       ; Call subroutine at 0x928
0x4CB:  5EF  CALZ     0x9EF       ; Call subroutine at 0x9EF if Zero flag is set
0x4CC:  B3B  LD_X     0x3B        ; Set X pointer to RAM address 0x3B
0x4CD:  C28  ADD_R_I  [X], #8     ; Add immediate #8 to register [X]
0x4CE:  B70  LD_X     0x70        ; Set X pointer to RAM address 0x70
0x4CF:  DA4  UNKNOWN              ; Unrecognized instruction: 0xDA4
0x4D0:  6E2  JP_Z     0x9E2       ; Jump to 0x9E2 if Zero flag is set (result was zero)
0x4D1:  B63  LD_X     0x63        ; Set X pointer to RAM address 0x63
0x4D2:  EC6  LD_R_Q   B, [X]      ; Copy value from [X] into B
0x4D3:  B6E  LD_X     0x6E        ; Set X pointer to RAM address 0x6E
0x4D4:  D91  UNKNOWN              ; Unrecognized instruction: 0xD91
0x4D5:  6D7  JP_Z     0x9D7       ; Jump to 0x9D7 if Zero flag is set (result was zero)
0x4D6:  B6F  LD_X     0x6F        ; Set X pointer to RAM address 0x6F
0x4D7:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x4D8:  B70  LD_X     0x70        ; Set X pointer to RAM address 0x70
0x4D9:  EC6  LD_R_Q   B, [X]      ; Copy value from [X] into B
0x4DA:  A85  ADD_R_Q  B, B        ; Add value of B to register B
0x4DB:  A85  ADD_R_Q  B, B        ; Add value of B to register B
0x4DC:  B63  LD_X     0x63        ; Set X pointer to RAM address 0x63
0x4DD:  AE6  UNKNOWN              ; Unrecognized instruction: 0xAE6
0x4DE:  A85  ADD_R_Q  B, B        ; Add value of B to register B
0x4DF:  C98  UNKNOWN              ; Unrecognized instruction: 0xC98
0x4E0:  E49  PSET     9           ; Set NP (New Page) to 9 for the next jump/call
0x4E1:  439  CALL     0x939       ; Call subroutine at 0x939
0x4E2:  FDF  RET                  ; Return to caller
0x4E3:  E4B  PSET     11          ; Set NP (New Page) to 11 for the next jump/call
0x4E4:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0x4E5:  E49  PSET     9           ; Set NP (New Page) to 9 for the next jump/call
0x4E6:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0x4E7:  B40  LD_X     0x40        ; Set X pointer to RAM address 0x40 (MEM_HUNGER)
0x4E8:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x4E9:  E48  PSET     8           ; Set NP (New Page) to 8 for the next jump/call
0x4EA:  40D  CALL     0x80D       ; Call subroutine at 0x80D
0x4EB:  BC0  LD_X     0xC0        ; Set X pointer to RAM address 0xC0
0x4EC:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x4ED:  E48  PSET     8           ; Set NP (New Page) to 8 for the next jump/call
0x4EE:  40D  CALL     0x80D       ; Call subroutine at 0x80D
0x4EF:  5EF  CALZ     0x8EF       ; Call subroutine at 0x8EF if Zero flag is set
0x4F0:  B3A  LD_X     0x3A        ; Set X pointer to RAM address 0x3A
0x4F1:  9C4  LBPX     #C4         ; Load constant #196 into [X]
0x4F2:  E45  PSET     5           ; Set NP (New Page) to 5 for the next jump/call
0x4F3:  4A6  CALL     0x5A6       ; Call subroutine at 0x5A6
0x4F4:  B70  LD_X     0x70        ; Set X pointer to RAM address 0x70
0x4F5:  E04  LD_R_I   A, #4       ; Load A with immediate value #4
0x4F6:  E48  PSET     8           ; Set NP (New Page) to 8 for the next jump/call
0x4F7:  40D  CALL     0x80D       ; Call subroutine at 0x80D
0x4F8:  E04  LD_R_I   A, #4       ; Load A with immediate value #4
0x4F9:  E14  LD_R_I   B, #4       ; Load B with immediate value #4
0x4FA:  E4A  PSET     10          ; Set NP (New Page) to 10 for the next jump/call
0x4FB:  4F0  CALL     0xAF0       ; Call subroutine at 0xAF0
0x4FC:  E42  PSET     2           ; Set NP (New Page) to 2 for the next jump/call
0x4FD:  093  JP       0x293       ; Jump to address 0x293
0x4FE:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x4FF:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x500:  556  CALZ     0x256       ; Call subroutine at 0x256 if Zero flag is set
0x501:  5EF  CALZ     0x2EF       ; Call subroutine at 0x2EF if Zero flag is set
0x502:  B2A  LD_X     0x2A        ; Set X pointer to RAM address 0x2A
0x503:  A89  ADD_R_Q  [X], B      ; Add value of B to register [X]
0x504:  EE0  INC_X                ; Increment the X pointer by 1
0x505:  C6F  UNKNOWN              ; Unrecognized instruction: 0xC6F
0x506:  200  JP_C     0x200       ; Jump to 0x200 if Carry flag is set (overflow occurred)
0x507:  FDF  RET                  ; Return to caller
0x508:  5BB  CALZ     0x2BB       ; Call subroutine at 0x2BB if Zero flag is set
0x509:  5EC  CALZ     0x2EC       ; Call subroutine at 0x2EC if Zero flag is set
0x50A:  5CE  CALZ     0x2CE       ; Call subroutine at 0x2CE if Zero flag is set
0x50B:  496  CALL     0x296       ; Call subroutine at 0x296
0x50C:  E44  PSET     4           ; Set NP (New Page) to 4 for the next jump/call
0x50D:  486  CALL     0x486       ; Call subroutine at 0x486
0x50E:  E44  PSET     4           ; Set NP (New Page) to 4 for the next jump/call
0x50F:  400  CALL     0x400       ; Call subroutine at 0x400
0x510:  E1C  LD_R_I   B, #12      ; Load B with immediate value #12
0x511:  400  CALL     0x400       ; Call subroutine at 0x400
0x512:  B7C  LD_X     0x7C        ; Set X pointer to RAM address 0x7C
0x513:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x514:  717  JP_NZ    0x417       ; Jump to 0x417 if Zero flag is clear (result was non-zero)
0x515:  E4F  PSET     15          ; Set NP (New Page) to 15 for the next jump/call
0x516:  4EC  CALL     0xFEC       ; Call subroutine at 0xFEC
0x517:  5EF  CALZ     0xFEF       ; Call subroutine at 0xFEF if Zero flag is set
0x518:  BA0  LD_X     0xA0        ; Set X pointer to RAM address 0xA0
0x519:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x51A:  E1A  LD_R_I   B, #10      ; Load B with immediate value #10
0x51B:  5EF  CALZ     0xFEF       ; Call subroutine at 0xFEF if Zero flag is set
0x51C:  E01  LD_R_I   A, #1       ; Load A with immediate value #1
0x51D:  B7C  LD_X     0x7C        ; Set X pointer to RAM address 0x7C
0x51E:  DEF  CP_R_I   [X], #15    ; Compare register [X] with immediate value #15
0x51F:  721  JP_NZ    0xF21       ; Jump to 0xF21 if Zero flag is clear (result was non-zero)
0x520:  E08  LD_R_I   A, #8       ; Load A with immediate value #8
0x521:  E41  PSET     1           ; Set NP (New Page) to 1 for the next jump/call
0x522:  4EC  CALL     0x1EC       ; Call subroutine at 0x1EC
0x523:  BA0  LD_X     0xA0        ; Set X pointer to RAM address 0xA0
0x524:  EE2  UNKNOWN              ; Unrecognized instruction: 0xEE2
0x525:  B75  LD_X     0x75        ; Set X pointer to RAM address 0x75
0x526:  EE8  UNKNOWN              ; Unrecognized instruction: 0xEE8
0x527:  5ED  CALZ     0x1ED       ; Call subroutine at 0x1ED if Zero flag is set
0x528:  5EF  CALZ     0x1EF       ; Call subroutine at 0x1EF if Zero flag is set
0x529:  B7C  LD_X     0x7C        ; Set X pointer to RAM address 0x7C
0x52A:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x52B:  612  JP_Z     0x112       ; Jump to 0x112 if Zero flag is set (result was zero)
0x52C:  E4F  PSET     15          ; Set NP (New Page) to 15 for the next jump/call
0x52D:  400  CALL     0xF00       ; Call subroutine at 0xF00
0x52E:  74A  JP_NZ    0xF4A       ; Jump to 0xF4A if Zero flag is clear (result was non-zero)
0x52F:  E42  PSET     2           ; Set NP (New Page) to 2 for the next jump/call
0x530:  4C3  CALL     0x2C3       ; Call subroutine at 0x2C3
0x531:  FCA  UNKNOWN              ; Unrecognized instruction: 0xFCA
0x532:  FD1  POP_R                ; Pop registers A, B and Flags from the stack
0x533:  B28  LD_X     0x28        ; Set X pointer to RAM address 0x28
0x534:  DE3  CP_R_I   [X], #3     ; Compare register [X] with immediate value #3
0x535:  DE5  CP_R_I   [X], #5     ; Compare register [X] with immediate value #5
0x536:  73A  JP_NZ    0x23A       ; Jump to 0x23A if Zero flag is clear (result was non-zero)
0x537:  B29  LD_X     0x29        ; Set X pointer to RAM address 0x29
0x538:  DA5  UNKNOWN              ; Unrecognized instruction: 0xDA5
0x539:  74D  JP_NZ    0x24D       ; Jump to 0x24D if Zero flag is clear (result was non-zero)
0x53A:  D91  UNKNOWN              ; Unrecognized instruction: 0xD91
0x53B:  717  JP_NZ    0x217       ; Jump to 0x217 if Zero flag is clear (result was non-zero)
0x53C:  D92  UNKNOWN              ; Unrecognized instruction: 0xD92
0x53D:  743  JP_NZ    0x243       ; Jump to 0x243 if Zero flag is clear (result was non-zero)
0x53E:  5ED  CALZ     0x2ED       ; Call subroutine at 0x2ED if Zero flag is set
0x53F:  540  CALZ     0x240       ; Call subroutine at 0x240 if Zero flag is set
0x540:  496  CALL     0x296       ; Call subroutine at 0x296
0x541:  552  CALZ     0x252       ; Call subroutine at 0x252 if Zero flag is set
0x542:  028  JP       0x228       ; Jump to address 0x228
0x543:  5F2  CALZ     0x2F2       ; Call subroutine at 0x2F2 if Zero flag is set
0x544:  BA0  LD_X     0xA0        ; Set X pointer to RAM address 0xA0
0x545:  EC8  LD_R_Q   [X], A      ; Copy value from A into [X]
0x546:  A80  ADD_R_Q  A, A        ; Add value of A to register A
0x547:  A95  ADC_R_Q  B, B        ; Add value of B plus Carry to register B
0x548:  E47  PSET     7           ; Set NP (New Page) to 7 for the next jump/call
0x549:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0x54A:  E43  PSET     3           ; Set NP (New Page) to 3 for the next jump/call
0x54B:  407  CALL     0x307       ; Call subroutine at 0x307
0x54C:  017  JP       0x317       ; Jump to address 0x317
0x54D:  B7B  LD_X     0x7B        ; Set X pointer to RAM address 0x7B
0x54E:  D2F  UNKNOWN              ; Unrecognized instruction: 0xD2F
0x54F:  E1F  LD_R_I   B, #15      ; Load B with immediate value #15
0x550:  897  LD_Y     0x97        ; Set Y pointer to RAM address 0x97
0x551:  5C2  CALZ     0x3C2       ; Call subroutine at 0x3C2 if Zero flag is set
0x552:  017  JP       0x317       ; Jump to address 0x317
0x553:  5BB  CALZ     0x3BB       ; Call subroutine at 0x3BB if Zero flag is set
0x554:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x555:  5ED  CALZ     0x3ED       ; Call subroutine at 0x3ED if Zero flag is set
0x556:  540  CALZ     0x340       ; Call subroutine at 0x340 if Zero flag is set
0x557:  5F5  CALZ     0x3F5       ; Call subroutine at 0x3F5 if Zero flag is set
0x558:  BE0  LD_X     0xE0        ; Set X pointer to RAM address 0xE0
0x559:  E0C  LD_R_I   A, #12      ; Load A with immediate value #12
0x55A:  E10  LD_R_I   B, #0       ; Load B with immediate value #0
0x55B:  E47  PSET     7           ; Set NP (New Page) to 7 for the next jump/call
0x55C:  4A5  CALL     0x7A5       ; Call subroutine at 0x7A5 (EXTRACT_HEART_COUNT)
0x55D:  E0D  LD_R_I   A, #13      ; Load A with immediate value #13
0x55E:  E10  LD_R_I   B, #0       ; Load B with immediate value #0
0x55F:  E47  PSET     7           ; Set NP (New Page) to 7 for the next jump/call
0x560:  4A5  CALL     0x7A5       ; Call subroutine at 0x7A5 (EXTRACT_HEART_COUNT)
0x561:  5EF  CALZ     0x7EF       ; Call subroutine at 0x7EF if Zero flag is set
0x562:  B3C  LD_X     0x3C        ; Set X pointer to RAM address 0x3C
0x563:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0x564:  B10  LD_X     0x10        ; Set X pointer to RAM address 0x10
0x565:  900  LBPX     #0          ; Load constant #0 into [X]
0x566:  B3F  LD_X     0x3F        ; Set X pointer to RAM address 0x3F
0x567:  E26  LD_R_I   [X], #6     ; Load [X] with immediate value #6
0x568:  491  CALL     0x791       ; Call subroutine at 0x791
0x569:  521  CALZ     0x721       ; Call subroutine at 0x721 if Zero flag is set
0x56A:  DC0  CP_R_I   A, #0       ; Compare register A with immediate value #0
0x56B:  769  JP_NZ    0x769       ; Jump to 0x769 if Zero flag is clear (result was non-zero)
0x56C:  491  CALL     0x791       ; Call subroutine at 0x791
0x56D:  521  CALZ     0x721       ; Call subroutine at 0x721 if Zero flag is set
0x56E:  DA1  UNKNOWN              ; Unrecognized instruction: 0xDA1
0x56F:  786  JP_NZ    0x786       ; Jump to 0x786 if Zero flag is clear (result was non-zero)
0x570:  DA2  UNKNOWN              ; Unrecognized instruction: 0xDA2
0x571:  676  JP_Z     0x776       ; Jump to 0x776 if Zero flag is set (result was zero)
0x572:  5BB  CALZ     0x7BB       ; Call subroutine at 0x7BB if Zero flag is set
0x573:  5E2  CALZ     0x7E2       ; Call subroutine at 0x7E2 if Zero flag is set
0x574:  B2E  LD_X     0x2E        ; Set X pointer to RAM address 0x2E
0x575:  E2F  LD_R_I   [X], #15    ; Load [X] with immediate value #15
0x576:  B29  LD_X     0x29        ; Set X pointer to RAM address 0x29
0x577:  DA4  UNKNOWN              ; Unrecognized instruction: 0xDA4
0x578:  682  JP_Z     0x782       ; Jump to 0x782 if Zero flag is set (result was zero)
0x579:  5BB  CALZ     0x7BB       ; Call subroutine at 0x7BB if Zero flag is set
0x57A:  B14  LD_X     0x14        ; Set X pointer to RAM address 0x14
0x57B:  EE2  UNKNOWN              ; Unrecognized instruction: 0xEE2
0x57C:  EE6  UNKNOWN              ; Unrecognized instruction: 0xEE6
0x57D:  C91  UNKNOWN              ; Unrecognized instruction: 0xC91
0x57E:  B14  LD_X     0x14        ; Set X pointer to RAM address 0x14
0x57F:  E41  PSET     1           ; Set NP (New Page) to 1 for the next jump/call
0x580:  4F4  CALL     0x1F4       ; Call subroutine at 0x1F4
0x581:  085  JP       0x185       ; Jump to address 0x185
0x582:  B2E  LD_X     0x2E        ; Set X pointer to RAM address 0x2E
0x583:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x584:  66D  JP_Z     0x16D       ; Jump to 0x16D if Zero flag is set (result was zero)
0x585:  06C  JP       0x16C       ; Jump to address 0x16C
0x586:  5BB  CALZ     0x1BB       ; Call subroutine at 0x1BB if Zero flag is set
0x587:  B3F  LD_X     0x3F        ; Set X pointer to RAM address 0x3F
0x588:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0x589:  B15  LD_X     0x15        ; Set X pointer to RAM address 0x15
0x58A:  DE2  CP_R_I   [X], #2     ; Compare register [X] with immediate value #2
0x58B:  E49  PSET     9           ; Set NP (New Page) to 9 for the next jump/call
0x58C:  37F  JP_NC    0x97F       ; Jump to 0x97F if Carry flag is clear (no overflow)
0x58D:  B3C  LD_X     0x3C        ; Set X pointer to RAM address 0x3C
0x58E:  E2F  LD_R_I   [X], #15    ; Load [X] with immediate value #15
0x58F:  E42  PSET     2           ; Set NP (New Page) to 2 for the next jump/call
0x590:  093  JP       0x293       ; Jump to address 0x293
0x591:  5CE  CALZ     0x2CE       ; Call subroutine at 0x2CE if Zero flag is set
0x592:  9C4  LBPX     #C4         ; Load constant #196 into [X]
0x593:  4A6  CALL     0x2A6       ; Call subroutine at 0x2A6
0x594:  556  CALZ     0x256       ; Call subroutine at 0x256 if Zero flag is set
0x595:  FDF  RET                  ; Return to caller
0x596:  5B3  CALZ     0x2B3       ; Call subroutine at 0x2B3 if Zero flag is set
0x597:  79E  JP_NZ    0x29E       ; Jump to 0x29E if Zero flag is clear (result was non-zero)
0x598:  5FD  CALZ     0x2FD       ; Call subroutine at 0x2FD if Zero flag is set
0x599:  79C  JP_NZ    0x29C       ; Jump to 0x29C if Zero flag is clear (result was non-zero)
0x59A:  E01  LD_R_I   A, #1       ; Load A with immediate value #1
0x59B:  09F  JP       0x29F       ; Jump to address 0x29F
0x59C:  E09  LD_R_I   A, #9       ; Load A with immediate value #9
0x59D:  09F  JP       0x29F       ; Jump to address 0x29F
0x59E:  E03  LD_R_I   A, #3       ; Load A with immediate value #3
0x59F:  B5E  LD_X     0x5E        ; Set X pointer to RAM address 0x5E
0x5A0:  F08  UNKNOWN              ; Unrecognized instruction: 0xF08
0x5A1:  6A5  JP_Z     0x2A5       ; Jump to 0x2A5 if Zero flag is set (result was zero)
0x5A2:  EC8  LD_R_Q   [X], A      ; Copy value from A into [X]
0x5A3:  E44  PSET     4           ; Set NP (New Page) to 4 for the next jump/call
0x5A4:  465  CALL     0x465       ; Call subroutine at 0x465
0x5A5:  FDF  RET                  ; Return to caller
0x5A6:  5EF  CALZ     0x4EF       ; Call subroutine at 0x4EF if Zero flag is set
0x5A7:  B2E  LD_X     0x2E        ; Set X pointer to RAM address 0x2E
0x5A8:  512  CALZ     0x412       ; Call subroutine at 0x412 if Zero flag is set
0x5A9:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0x5AA:  B10  LD_X     0x10        ; Set X pointer to RAM address 0x10
0x5AB:  EE2  UNKNOWN              ; Unrecognized instruction: 0xEE2
0x5AC:  F84  LD_MN_A  0x04        ; Store A into direct RAM address 0x04
0x5AD:  EE2  UNKNOWN              ; Unrecognized instruction: 0xEE2
0x5AE:  F85  LD_MN_A  0x05        ; Store A into direct RAM address 0x05
0x5AF:  EE2  UNKNOWN              ; Unrecognized instruction: 0xEE2
0x5B0:  F86  LD_MN_A  0x06        ; Store A into direct RAM address 0x06
0x5B1:  EE2  UNKNOWN              ; Unrecognized instruction: 0xEE2
0x5B2:  F87  LD_MN_A  0x07        ; Store A into direct RAM address 0x07
0x5B3:  EE2  UNKNOWN              ; Unrecognized instruction: 0xEE2
0x5B4:  EE6  UNKNOWN              ; Unrecognized instruction: 0xEE6
0x5B5:  509  CALZ     0x409       ; Call subroutine at 0x409 if Zero flag is set
0x5B6:  B08  LD_X     0x08        ; Set X pointer to RAM address 0x08
0x5B7:  4E3  CALL     0x4E3       ; Call subroutine at 0x4E3
0x5B8:  B3A  LD_X     0x3A        ; Set X pointer to RAM address 0x3A
0x5B9:  EE2  UNKNOWN              ; Unrecognized instruction: 0xEE2
0x5BA:  E86  UNKNOWN              ; Unrecognized instruction: 0xE86
0x5BB:  E88  UNKNOWN              ; Unrecognized instruction: 0xE88
0x5BC:  5F5  CALZ     0x4F5       ; Call subroutine at 0x4F5 if Zero flag is set
0x5BD:  FA9  LD_A_MN  0x09        ; Load A from direct RAM address 0x09
0x5BE:  E8C  UNKNOWN              ; Unrecognized instruction: 0xE8C
0x5BF:  E8C  UNKNOWN              ; Unrecognized instruction: 0xE8C
0x5C0:  E8C  UNKNOWN              ; Unrecognized instruction: 0xE8C
0x5C1:  C81  UNKNOWN              ; Unrecognized instruction: 0xC81
0x5C2:  CCA  UNKNOWN              ; Unrecognized instruction: 0xCCA
0x5C3:  E10  LD_R_I   B, #0       ; Load B with immediate value #0
0x5C4:  E47  PSET     7           ; Set NP (New Page) to 7 for the next jump/call
0x5C5:  4A5  CALL     0x7A5       ; Call subroutine at 0x7A5 (EXTRACT_HEART_COUNT)
0x5C6:  E47  PSET     7           ; Set NP (New Page) to 7 for the next jump/call
0x5C7:  4B8  CALL     0x7B8       ; Call subroutine at 0x7B8
0x5C8:  F5E  RCF                  ; Reset (clear) Carry Flag
0x5C9:  A06  UNKNOWN              ; Unrecognized instruction: 0xA06
0x5CA:  FA9  LD_A_MN  0x09        ; Load A from direct RAM address 0x09
0x5CB:  C83  UNKNOWN              ; Unrecognized instruction: 0xC83
0x5CC:  7D0  JP_NZ    0x7D0       ; Jump to 0x7D0 if Zero flag is clear (result was non-zero)
0x5CD:  E47  PSET     7           ; Set NP (New Page) to 7 for the next jump/call
0x5CE:  4BC  CALL     0x7BC       ; Call subroutine at 0x7BC
0x5CF:  0D1  JP       0x7D1       ; Jump to address 0x7D1
0x5D0:  4F3  CALL     0x7F3       ; Call subroutine at 0x7F3
0x5D1:  900  LBPX     #0          ; Load constant #0 into [X]
0x5D2:  FA8  LD_A_MN  0x08        ; Load A from direct RAM address 0x08
0x5D3:  4F3  CALL     0x7F3       ; Call subroutine at 0x7F3
0x5D4:  900  LBPX     #0          ; Load constant #0 into [X]
0x5D5:  922  LBPX     #22         ; Load constant #34 into [X]
0x5D6:  900  LBPX     #0          ; Load constant #0 into [X]
0x5D7:  FA7  LD_A_MN  0x07        ; Load A from direct RAM address 0x07
0x5D8:  4F3  CALL     0x7F3       ; Call subroutine at 0x7F3
0x5D9:  900  LBPX     #0          ; Load constant #0 into [X]
0x5DA:  FA6  LD_A_MN  0x06        ; Load A from direct RAM address 0x06
0x5DB:  4F3  CALL     0x7F3       ; Call subroutine at 0x7F3
0x5DC:  900  LBPX     #0          ; Load constant #0 into [X]
0x5DD:  900  LBPX     #0          ; Load constant #0 into [X]
0x5DE:  FA5  LD_A_MN  0x05        ; Load A from direct RAM address 0x05
0x5DF:  4EF  CALL     0x7EF       ; Call subroutine at 0x7EF
0x5E0:  900  LBPX     #0          ; Load constant #0 into [X]
0x5E1:  FA4  LD_A_MN  0x04        ; Load A from direct RAM address 0x04
0x5E2:  0EF  JP       0x7EF       ; Jump to address 0x7EF
0x5E3:  DD1  CP_R_I   B, #1       ; Compare register B with immediate value #1
0x5E4:  2E9  JP_C     0x7E9       ; Jump to 0x7E9 if Carry flag is set (overflow occurred)
0x5E5:  7E8  JP_NZ    0x7E8       ; Jump to 0x7E8 if Zero flag is clear (result was non-zero)
0x5E6:  DC8  CP_R_I   A, #8       ; Compare register A with immediate value #8
0x5E7:  2E9  JP_C     0x7E9       ; Jump to 0x7E9 if Carry flag is set (overflow occurred)
0x5E8:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x5E9:  C06  ADD_R_I  A, #6       ; Add immediate #6 to register A
0x5EA:  F80  LD_MN_A  0x00        ; Store A into direct RAM address 0x00
0x5EB:  C5E  UNKNOWN              ; Unrecognized instruction: 0xC5E
0x5EC:  F91  LD_MN_B  0x01        ; Store B into direct RAM address 0x01
0x5ED:  E05  LD_R_I   A, #5       ; Load A with immediate value #5
0x5EE:  0FB  JP       0x7FB       ; Jump to address 0x7FB
0x5EF:  E10  LD_R_I   B, #0       ; Load B with immediate value #0
0x5F0:  C0A  ADD_R_I  A, #10      ; Add immediate #10 to register A
0x5F1:  C50  UNKNOWN              ; Unrecognized instruction: 0xC50
0x5F2:  0F4  JP       0x7F4       ; Jump to address 0x7F4
0x5F3:  E10  LD_R_I   B, #0       ; Load B with immediate value #0
0x5F4:  A80  ADD_R_Q  A, A        ; Add value of A to register A
0x5F5:  A95  ADC_R_Q  B, B        ; Add value of B plus Carry to register B
0x5F6:  A80  ADD_R_Q  A, A        ; Add value of A to register A
0x5F7:  A95  ADC_R_Q  B, B        ; Add value of B plus Carry to register B
0x5F8:  F80  LD_MN_A  0x00        ; Store A into direct RAM address 0x00
0x5F9:  F91  LD_MN_B  0x01        ; Store B into direct RAM address 0x01
0x5FA:  E05  LD_R_I   A, #5       ; Load A with immediate value #5
0x5FB:  F82  LD_MN_A  0x02        ; Store A into direct RAM address 0x02
0x5FC:  E40  PSET     0           ; Set NP (New Page) to 0 for the next jump/call
0x5FD:  000  JP       0x000       ; Jump to address 0x000
0x5FE:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x5FF:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x600:  5B3  CALZ     0x0B3       ; Call subroutine at 0x0B3 if Zero flag is set
0x601:  71C  JP_NZ    0x01C       ; Jump to 0x01C if Zero flag is clear (result was non-zero)
0x602:  5FB  CALZ     0x0FB       ; Call subroutine at 0x0FB if Zero flag is set
0x603:  706  JP_NZ    0x006       ; Jump to 0x006 if Zero flag is clear (result was non-zero)
0x604:  E46  PSET     6           ; Set NP (New Page) to 6 for the next jump/call
0x605:  01E  JP       0x61E       ; Jump to address 0x61E
0x606:  CA7  UNKNOWN              ; Unrecognized instruction: 0xCA7
0x607:  E08  LD_R_I   A, #8       ; Load A with immediate value #8
0x608:  E15  LD_R_I   B, #5       ; Load B with immediate value #5
0x609:  803  LD_Y     0x03        ; Set Y pointer to RAM address 0x03
0x60A:  E48  PSET     8           ; Set NP (New Page) to 8 for the next jump/call
0x60B:  4A9  CALL     0x8A9       ; Call subroutine at 0x8A9
0x60C:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x60D:  E90  UNKNOWN              ; Unrecognized instruction: 0xE90
0x60E:  83B  LD_Y     0x3B        ; Set Y pointer to RAM address 0x3B
0x60F:  5EF  CALZ     0x8EF       ; Call subroutine at 0x8EF if Zero flag is set
0x610:  B48  LD_X     0x48        ; Set X pointer to RAM address 0x48 (MEM_SICK_LEVEL)
0x611:  CE8  UNKNOWN              ; Unrecognized instruction: 0xCE8
0x612:  A8B  ADD_R_Q  [X], [Y]    ; Add value of [Y] to register [X]
0x613:  DA8  UNKNOWN              ; Unrecognized instruction: 0xDA8
0x614:  71C  JP_NZ    0x81C       ; Jump to 0x81C if Zero flag is clear (result was non-zero)
0x615:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x616:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x617:  B0D  LD_X     0x0D        ; Set X pointer to RAM address 0x0D
0x618:  838  LD_Y     0x38        ; Set Y pointer to RAM address 0x38
0x619:  512  CALZ     0x812       ; Call subroutine at 0x812 if Zero flag is set
0x61A:  599  CALZ     0x899       ; Call subroutine at 0x899 if Zero flag is set
0x61B:  509  CALZ     0x809       ; Call subroutine at 0x809 if Zero flag is set
0x61C:  E45  PSET     5           ; Set NP (New Page) to 5 for the next jump/call
0x61D:  01A  JP       0x51A       ; Jump to address 0x51A
0x61E:  E06  LD_R_I   A, #6       ; Load A with immediate value #6
0x61F:  E15  LD_R_I   B, #5       ; Load B with immediate value #5
0x620:  E48  PSET     8           ; Set NP (New Page) to 8 for the next jump/call
0x621:  4A8  CALL     0x8A8       ; Call subroutine at 0x8A8
0x622:  E45  PSET     5           ; Set NP (New Page) to 5 for the next jump/call
0x623:  01A  JP       0x51A       ; Jump to address 0x51A
0x624:  5B3  CALZ     0x5B3       ; Call subroutine at 0x5B3 if Zero flag is set
0x625:  722  JP_NZ    0x522       ; Jump to 0x522 if Zero flag is clear (result was non-zero)
0x626:  5FB  CALZ     0x5FB       ; Call subroutine at 0x5FB if Zero flag is set
0x627:  71E  JP_NZ    0x51E       ; Jump to 0x51E if Zero flag is clear (result was non-zero)
0x628:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x629:  E90  UNKNOWN              ; Unrecognized instruction: 0xE90
0x62A:  809  LD_Y     0x09        ; Set Y pointer to RAM address 0x09
0x62B:  DF0  CP_R_I   [Y], #0     ; Compare register [Y] with immediate value #0
0x62C:  71E  JP_NZ    0x51E       ; Jump to 0x51E if Zero flag is clear (result was non-zero)
0x62D:  B5E  LD_X     0x5E        ; Set X pointer to RAM address 0x5E
0x62E:  E25  LD_R_I   [X], #5     ; Load [X] with immediate value #5
0x62F:  E44  PSET     4           ; Set NP (New Page) to 4 for the next jump/call
0x630:  465  CALL     0x465       ; Call subroutine at 0x465
0x631:  540  CALZ     0x440       ; Call subroutine at 0x440 if Zero flag is set
0x632:  E44  PSET     4           ; Set NP (New Page) to 4 for the next jump/call
0x633:  486  CALL     0x486       ; Call subroutine at 0x486
0x634:  E44  PSET     4           ; Set NP (New Page) to 4 for the next jump/call
0x635:  400  CALL     0x400       ; Call subroutine at 0x400
0x636:  5EF  CALZ     0x4EF       ; Call subroutine at 0x4EF if Zero flag is set
0x637:  B90  LD_X     0x90        ; Set X pointer to RAM address 0x90
0x638:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x639:  91C  LBPX     #1C         ; Load constant #28 into [X]
0x63A:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x63B:  91C  LBPX     #1C         ; Load constant #28 into [X]
0x63C:  91D  LBPX     #1D         ; Load constant #29 into [X]
0x63D:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x63E:  91D  LBPX     #1D         ; Load constant #29 into [X]
0x63F:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x640:  8D6  LD_Y     0xD6        ; Set Y pointer to RAM address 0xD6
0x641:  5BC  CALZ     0x4BC       ; Call subroutine at 0x4BC if Zero flag is set
0x642:  5DE  CALZ     0x4DE       ; Call subroutine at 0x4DE if Zero flag is set
0x643:  556  CALZ     0x456       ; Call subroutine at 0x456 if Zero flag is set
0x644:  B0D  LD_X     0x0D        ; Set X pointer to RAM address 0x0D
0x645:  53C  CALZ     0x43C       ; Call subroutine at 0x43C if Zero flag is set
0x646:  E1C  LD_R_I   B, #12      ; Load B with immediate value #12
0x647:  E45  PSET     5           ; Set NP (New Page) to 5 for the next jump/call
0x648:  400  CALL     0x500       ; Call subroutine at 0x500
0x649:  B82  LD_X     0x82        ; Set X pointer to RAM address 0x82
0x64A:  E65  LDPX_MX  #5          ; Load constant #5 into [X] and increment X
0x64B:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x64C:  5EF  CALZ     0x5EF       ; Call subroutine at 0x5EF if Zero flag is set
0x64D:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x64E:  E90  UNKNOWN              ; Unrecognized instruction: 0xE90
0x64F:  B81  LD_X     0x81        ; Set X pointer to RAM address 0x81
0x650:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x651:  846  LD_Y     0x46        ; Set Y pointer to RAM address 0x46 (MEM_WEIGHT)
0x652:  B80  LD_X     0x80        ; Set X pointer to RAM address 0x80
0x653:  EEB  UNKNOWN              ; Unrecognized instruction: 0xEEB
0x654:  B84  LD_X     0x84        ; Set X pointer to RAM address 0x84
0x655:  E28  LD_R_I   [X], #8     ; Load [X] with immediate value #8
0x656:  845  LD_Y     0x45        ; Set Y pointer to RAM address 0x45
0x657:  EC3  LD_R_Q   A, [Y]      ; Copy value from [Y] into A
0x658:  E49  PSET     9           ; Set NP (New Page) to 9 for the next jump/call
0x659:  400  CALL     0x900       ; Call subroutine at 0x900
0x65A:  260  JP_C     0x960       ; Jump to 0x960 if Carry flag is set (overflow occurred)
0x65B:  847  LD_Y     0x47        ; Set Y pointer to RAM address 0x47
0x65C:  B80  LD_X     0x80        ; Set X pointer to RAM address 0x80
0x65D:  EEB  UNKNOWN              ; Unrecognized instruction: 0xEEB
0x65E:  B84  LD_X     0x84        ; Set X pointer to RAM address 0x84
0x65F:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0x660:  B5E  LD_X     0x5E        ; Set X pointer to RAM address 0x5E
0x661:  E25  LD_R_I   [X], #5     ; Load [X] with immediate value #5
0x662:  E44  PSET     4           ; Set NP (New Page) to 4 for the next jump/call
0x663:  465  CALL     0x465       ; Call subroutine at 0x465
0x664:  521  CALZ     0x421       ; Call subroutine at 0x421 if Zero flag is set
0x665:  B57  LD_X     0x57        ; Set X pointer to RAM address 0x57
0x666:  E2F  LD_R_I   [X], #15    ; Load [X] with immediate value #15
0x667:  897  LD_Y     0x97        ; Set Y pointer to RAM address 0x97
0x668:  5BC  CALZ     0x4BC       ; Call subroutine at 0x4BC if Zero flag is set
0x669:  540  CALZ     0x440       ; Call subroutine at 0x440 if Zero flag is set
0x66A:  E44  PSET     4           ; Set NP (New Page) to 4 for the next jump/call
0x66B:  486  CALL     0x486       ; Call subroutine at 0x486
0x66C:  4D4  CALL     0x4D4       ; Call subroutine at 0x4D4
0x66D:  554  CALZ     0x454       ; Call subroutine at 0x454 if Zero flag is set
0x66E:  521  CALZ     0x421       ; Call subroutine at 0x421 if Zero flag is set
0x66F:  DA1  UNKNOWN              ; Unrecognized instruction: 0xDA1
0x670:  7C5  JP_NZ    0x4C5       ; Jump to 0x4C5 if Zero flag is clear (result was non-zero)
0x671:  B57  LD_X     0x57        ; Set X pointer to RAM address 0x57
0x672:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x673:  6C5  JP_Z     0x4C5       ; Jump to 0x4C5 if Zero flag is set (result was zero)
0x674:  B81  LD_X     0x81        ; Set X pointer to RAM address 0x81
0x675:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x676:  77A  JP_NZ    0x47A       ; Jump to 0x47A if Zero flag is clear (result was non-zero)
0x677:  D96  UNKNOWN              ; Unrecognized instruction: 0xD96
0x678:  667  JP_Z     0x467       ; Jump to 0x467 if Zero flag is set (result was zero)
0x679:  EC9  LD_R_Q   [X], B      ; Copy value from B into [X]
0x67A:  B80  LD_X     0x80        ; Set X pointer to RAM address 0x80
0x67B:  C2F  ADD_R_I  [X], #15    ; Add immediate #15 to register [X]
0x67C:  767  JP_NZ    0x467       ; Jump to 0x467 if Zero flag is clear (result was non-zero)
0x67D:  5BB  CALZ     0x4BB       ; Call subroutine at 0x4BB if Zero flag is set
0x67E:  540  CALZ     0x440       ; Call subroutine at 0x440 if Zero flag is set
0x67F:  5EF  CALZ     0x4EF       ; Call subroutine at 0x4EF if Zero flag is set
0x680:  B84  LD_X     0x84        ; Set X pointer to RAM address 0x84
0x681:  EC6  LD_R_Q   B, [X]      ; Copy value from [X] into B
0x682:  B81  LD_X     0x81        ; Set X pointer to RAM address 0x81
0x683:  DA4  UNKNOWN              ; Unrecognized instruction: 0xDA4
0x684:  686  JP_Z     0x486       ; Jump to 0x486 if Zero flag is set (result was zero)
0x685:  D18  UNKNOWN              ; Unrecognized instruction: 0xD18
0x686:  B3A  LD_X     0x3A        ; Set X pointer to RAM address 0x3A
0x687:  910  LBPX     #10         ; Load constant #16 into [X]
0x688:  E43  PSET     3           ; Set NP (New Page) to 3 for the next jump/call
0x689:  4EE  CALL     0x3EE       ; Call subroutine at 0x3EE
0x68A:  4D4  CALL     0x3D4       ; Call subroutine at 0x3D4
0x68B:  554  CALZ     0x354       ; Call subroutine at 0x354 if Zero flag is set
0x68C:  B29  LD_X     0x29        ; Set X pointer to RAM address 0x29
0x68D:  53C  CALZ     0x33C       ; Call subroutine at 0x33C if Zero flag is set
0x68E:  5EF  CALZ     0x3EF       ; Call subroutine at 0x3EF if Zero flag is set
0x68F:  B84  LD_X     0x84        ; Set X pointer to RAM address 0x84
0x690:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x691:  696  JP_Z     0x396       ; Jump to 0x396 if Zero flag is set (result was zero)
0x692:  B83  LD_X     0x83        ; Set X pointer to RAM address 0x83
0x693:  C21  ADD_R_I  [X], #1     ; Add immediate #1 to register [X]
0x694:  4C8  CALL     0x3C8       ; Call subroutine at 0x3C8
0x695:  097  JP       0x397       ; Jump to address 0x397
0x696:  4CD  CALL     0x3CD       ; Call subroutine at 0x3CD
0x697:  5EF  CALZ     0x3EF       ; Call subroutine at 0x3EF if Zero flag is set
0x698:  B82  LD_X     0x82        ; Set X pointer to RAM address 0x82
0x699:  C2F  ADD_R_I  [X], #15    ; Add immediate #15 to register [X]
0x69A:  74C  JP_NZ    0x34C       ; Jump to 0x34C if Zero flag is clear (result was non-zero)
0x69B:  B90  LD_X     0x90        ; Set X pointer to RAM address 0x90
0x69C:  E4C  PSET     12          ; Set NP (New Page) to 12 for the next jump/call
0x69D:  4F5  CALL     0xCF5       ; Call subroutine at 0xCF5
0x69E:  B83  LD_X     0x83        ; Set X pointer to RAM address 0x83
0x69F:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x6A0:  B98  LD_X     0x98        ; Set X pointer to RAM address 0x98
0x6A1:  EC8  LD_R_Q   [X], A      ; Copy value from A into [X]
0x6A2:  E15  LD_R_I   B, #5       ; Load B with immediate value #5
0x6A3:  AA4  SUB      B, A        ; Subtract value of A from register B
0x6A4:  B9C  LD_X     0x9C        ; Set X pointer to RAM address 0x9C
0x6A5:  EC9  LD_R_Q   [X], B      ; Copy value from B into [X]
0x6A6:  8E5  LD_Y     0xE5        ; Set Y pointer to RAM address 0xE5
0x6A7:  5BC  CALZ     0xCBC       ; Call subroutine at 0xCBC if Zero flag is set
0x6A8:  5DE  CALZ     0xCDE       ; Call subroutine at 0xCDE if Zero flag is set
0x6A9:  556  CALZ     0xC56       ; Call subroutine at 0xC56 if Zero flag is set
0x6AA:  B52  LD_X     0x52        ; Set X pointer to RAM address 0x52
0x6AB:  53C  CALZ     0xC3C       ; Call subroutine at 0xC3C if Zero flag is set
0x6AC:  5EF  CALZ     0xCEF       ; Call subroutine at 0xCEF if Zero flag is set
0x6AD:  B83  LD_X     0x83        ; Set X pointer to RAM address 0x83
0x6AE:  DE3  CP_R_I   [X], #3     ; Compare register [X] with immediate value #3
0x6AF:  2B5  JP_C     0xCB5       ; Jump to 0xCB5 if Carry flag is set (overflow occurred)
0x6B0:  B41  LD_X     0x41        ; Set X pointer to RAM address 0x41 (MEM_HAPPY)
0x6B1:  E4C  PSET     12          ; Set NP (New Page) to 12 for the next jump/call
0x6B2:  4E5  CALL     0xCE5       ; Call subroutine at 0xCE5
0x6B3:  4C8  CALL     0xCC8       ; Call subroutine at 0xCC8
0x6B4:  0B6  JP       0xCB6       ; Jump to address 0xCB6
0x6B5:  4CD  CALL     0xCCD       ; Call subroutine at 0xCCD
0x6B6:  5EF  CALZ     0xCEF       ; Call subroutine at 0xCEF if Zero flag is set
0x6B7:  B46  LD_X     0x46        ; Set X pointer to RAM address 0x46 (MEM_WEIGHT)
0x6B8:  F44  SDF                  ; Set Decimal Flag
0x6B9:  C29  ADD_R_I  [X], #9     ; Add immediate #9 to register [X]
0x6BA:  EE0  INC_X                ; Increment the X pointer by 1
0x6BB:  C69  UNKNOWN              ; Unrecognized instruction: 0xC69
0x6BC:  F5B  RDF                  ; Reset (clear) Decimal Flag
0x6BD:  E46  PSET     6           ; Set NP (New Page) to 6 for the next jump/call
0x6BE:  4E5  CALL     0x6E5       ; Call subroutine at 0x6E5
0x6BF:  B29  LD_X     0x29        ; Set X pointer to RAM address 0x29
0x6C0:  DA1  UNKNOWN              ; Unrecognized instruction: 0xDA1
0x6C1:  7C5  JP_NZ    0x6C5       ; Jump to 0x6C5 if Zero flag is clear (result was non-zero)
0x6C2:  E4F  PSET     15          ; Set NP (New Page) to 15 for the next jump/call
0x6C3:  400  CALL     0xF00       ; Call subroutine at 0xF00
0x6C4:  626  JP_Z     0xF26       ; Jump to 0xF26 if Zero flag is set (result was zero)
0x6C5:  5BB  CALZ     0xFBB       ; Call subroutine at 0xFBB if Zero flag is set
0x6C6:  E45  PSET     5           ; Set NP (New Page) to 5 for the next jump/call
0x6C7:  017  JP       0x517       ; Jump to address 0x517
0x6C8:  883  LD_Y     0x83        ; Set Y pointer to RAM address 0x83
0x6C9:  5BC  CALZ     0x5BC       ; Call subroutine at 0x5BC if Zero flag is set
0x6CA:  E07  LD_R_I   A, #7       ; Load A with immediate value #7
0x6CB:  806  LD_Y     0x06        ; Set Y pointer to RAM address 0x06
0x6CC:  0D1  JP       0x5D1       ; Jump to address 0x5D1
0x6CD:  89E  LD_Y     0x9E        ; Set Y pointer to RAM address 0x9E
0x6CE:  5BC  CALZ     0x5BC       ; Call subroutine at 0x5BC if Zero flag is set
0x6CF:  E08  LD_R_I   A, #8       ; Load A with immediate value #8
0x6D0:  803  LD_Y     0x03        ; Set Y pointer to RAM address 0x03
0x6D1:  E15  LD_R_I   B, #5       ; Load B with immediate value #5
0x6D2:  E48  PSET     8           ; Set NP (New Page) to 8 for the next jump/call
0x6D3:  0A9  JP       0x8A9       ; Jump to address 0x8A9
0x6D4:  5EF  CALZ     0x8EF       ; Call subroutine at 0x8EF if Zero flag is set
0x6D5:  B81  LD_X     0x81        ; Set X pointer to RAM address 0x81
0x6D6:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x6D7:  6E4  JP_Z     0x8E4       ; Jump to 0x8E4 if Zero flag is set (result was zero)
0x6D8:  EC6  LD_R_Q   B, [X]      ; Copy value from [X] into B
0x6D9:  BB0  LD_X     0xB0        ; Set X pointer to RAM address 0xB0
0x6DA:  E07  LD_R_I   A, #7       ; Load A with immediate value #7
0x6DB:  D94  UNKNOWN              ; Unrecognized instruction: 0xD94
0x6DC:  6DF  JP_Z     0x8DF       ; Jump to 0x8DF if Zero flag is set (result was zero)
0x6DD:  B80  LD_X     0x80        ; Set X pointer to RAM address 0x80
0x6DE:  E06  LD_R_I   A, #6       ; Load A with immediate value #6
0x6DF:  E11  LD_R_I   B, #1       ; Load B with immediate value #1
0x6E0:  E81  UNKNOWN              ; Unrecognized instruction: 0xE81
0x6E1:  E12  LD_R_I   B, #2       ; Load B with immediate value #2
0x6E2:  E47  PSET     7           ; Set NP (New Page) to 7 for the next jump/call
0x6E3:  4A5  CALL     0x7A5       ; Call subroutine at 0x7A5 (EXTRACT_HEART_COUNT)
0x6E4:  FDF  RET                  ; Return to caller
0x6E5:  5EF  CALZ     0x7EF       ; Call subroutine at 0x7EF if Zero flag is set
0x6E6:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x6E7:  E90  UNKNOWN              ; Unrecognized instruction: 0xE90
0x6E8:  83D  LD_Y     0x3D        ; Set Y pointer to RAM address 0x3D
0x6E9:  4F6  CALL     0x7F6       ; Call subroutine at 0x7F6
0x6EA:  2F0  JP_C     0x7F0       ; Jump to 0x7F0 if Carry flag is set (overflow occurred)
0x6EB:  83F  LD_Y     0x3F        ; Set Y pointer to RAM address 0x3F
0x6EC:  4F6  CALL     0x7F6       ; Call subroutine at 0x7F6
0x6ED:  2F5  JP_C     0x7F5       ; Jump to 0x7F5 if Carry flag is set (overflow occurred)
0x6EE:  83E  LD_Y     0x3E        ; Set Y pointer to RAM address 0x3E
0x6EF:  0F1  JP       0x7F1       ; Jump to address 0x7F1
0x6F0:  83C  LD_Y     0x3C        ; Set Y pointer to RAM address 0x3C
0x6F1:  B46  LD_X     0x46        ; Set X pointer to RAM address 0x46 (MEM_WEIGHT)
0x6F2:  512  CALZ     0x712       ; Call subroutine at 0x712 if Zero flag is set
0x6F3:  59B  CALZ     0x79B       ; Call subroutine at 0x79B if Zero flag is set
0x6F4:  509  CALZ     0x709       ; Call subroutine at 0x709 if Zero flag is set
0x6F5:  FDF  RET                  ; Return to caller
0x6F6:  B47  LD_X     0x47        ; Set X pointer to RAM address 0x47
0x6F7:  F0B  UNKNOWN              ; Unrecognized instruction: 0xF0B
0x6F8:  2FD  JP_C     0x7FD       ; Jump to 0x7FD if Carry flag is set (overflow occurred)
0x6F9:  7FD  JP_NZ    0x7FD       ; Jump to 0x7FD if Zero flag is clear (result was non-zero)
0x6FA:  B46  LD_X     0x46        ; Set X pointer to RAM address 0x46 (MEM_WEIGHT)
0x6FB:  A3F  UNKNOWN              ; Unrecognized instruction: 0xA3F
0x6FC:  F0B  UNKNOWN              ; Unrecognized instruction: 0xF0B
0x6FD:  FDF  RET                  ; Return to caller
0x6FE:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x6FF:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x700:  E44  PSET     4           ; Set NP (New Page) to 4 for the next jump/call
0x701:  0E7  JP       0x4E7       ; Jump to address 0x4E7
0x702:  E47  PSET     7           ; Set NP (New Page) to 7 for the next jump/call
0x703:  010  JP       0x710       ; Jump to address 0x710
0x704:  E4A  PSET     10          ; Set NP (New Page) to 10 for the next jump/call
0x705:  0BE  JP       0xABE       ; Jump to address 0xABE
0x706:  E46  PSET     6           ; Set NP (New Page) to 6 for the next jump/call
0x707:  024  JP       0x624       ; Jump to address 0x624
0x708:  E46  PSET     6           ; Set NP (New Page) to 6 for the next jump/call
0x709:  000  JP       0x600       ; Jump to address 0x600
0x70A:  E4D  PSET     13          ; Set NP (New Page) to 13 for the next jump/call
0x70B:  07E  JP       0xD7E       ; Jump to address 0xD7E
0x70C:  E48  PSET     8           ; Set NP (New Page) to 8 for the next jump/call
0x70D:  014  JP       0x814       ; Jump to address 0x814
0x70E:  E4A  PSET     10          ; Set NP (New Page) to 10 for the next jump/call
0x70F:  0DA  JP       0xADA       ; Jump to address 0xADA
0x710:  5B3  CALZ     0xAB3       ; Call subroutine at 0xAB3 if Zero flag is set
0x711:  720  JP_NZ    0xA20       ; Jump to 0xA20 if Zero flag is clear (result was non-zero)
0x712:  5EF  CALZ     0xAEF       ; Call subroutine at 0xAEF if Zero flag is set
0x713:  B73  LD_X     0x73        ; Set X pointer to RAM address 0x73
0x714:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x715:  B78  LD_X     0x78        ; Set X pointer to RAM address 0x78
0x716:  EC8  LD_R_Q   [X], A      ; Copy value from A into [X]
0x717:  B90  LD_X     0x90        ; Set X pointer to RAM address 0x90
0x718:  E4B  PSET     11          ; Set NP (New Page) to 11 for the next jump/call
0x719:  4E8  CALL     0xBE8       ; Call subroutine at 0xBE8
0x71A:  E1A  LD_R_I   B, #10      ; Load B with immediate value #10
0x71B:  E4E  PSET     14          ; Set NP (New Page) to 14 for the next jump/call
0x71C:  45A  CALL     0xE5A       ; Call subroutine at 0xE5A
0x71D:  322  JP_NC    0xE22       ; Jump to 0xE22 if Carry flag is clear (no overflow)
0x71E:  E45  PSET     5           ; Set NP (New Page) to 5 for the next jump/call
0x71F:  717  JP_NZ    0x517       ; Jump to 0x517 if Zero flag is clear (result was non-zero)
0x720:  E45  PSET     5           ; Set NP (New Page) to 5 for the next jump/call
0x721:  01A  JP       0x51A       ; Jump to address 0x51A
0x722:  5F2  CALZ     0x5F2       ; Call subroutine at 0x5F2 if Zero flag is set
0x723:  B73  LD_X     0x73        ; Set X pointer to RAM address 0x73
0x724:  EE8  UNKNOWN              ; Unrecognized instruction: 0xEE8
0x725:  DC0  CP_R_I   A, #0       ; Compare register A with immediate value #0
0x726:  739  JP_NZ    0x539       ; Jump to 0x539 if Zero flag is clear (result was non-zero)
0x727:  80C  LD_Y     0x0C        ; Set Y pointer to RAM address 0x0C
0x728:  5FD  CALZ     0x5FD       ; Call subroutine at 0x5FD if Zero flag is set
0x729:  751  JP_NZ    0x551       ; Jump to 0x551 if Zero flag is clear (result was non-zero)
0x72A:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x72B:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x72C:  B09  LD_X     0x09        ; Set X pointer to RAM address 0x09
0x72D:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x72E:  751  JP_NZ    0x551       ; Jump to 0x551 if Zero flag is clear (result was non-zero)
0x72F:  5EF  CALZ     0x5EF       ; Call subroutine at 0x5EF if Zero flag is set
0x730:  B40  LD_X     0x40        ; Set X pointer to RAM address 0x40 (MEM_HUNGER)
0x731:  DEF  CP_R_I   [X], #15    ; Compare register [X] with immediate value #15
0x732:  651  JP_Z     0x551       ; Jump to 0x551 if Zero flag is set (result was zero)
0x733:  E4C  PSET     12          ; Set NP (New Page) to 12 for the next jump/call
0x734:  4E5  CALL     0xCE5       ; Call subroutine at 0xCE5
0x735:  E01  LD_R_I   A, #1       ; Load A with immediate value #1
0x736:  456  CALL     0xC56       ; Call subroutine at 0xC56
0x737:  808  LD_Y     0x08        ; Set Y pointer to RAM address 0x08
0x738:  049  JP       0xC49       ; Jump to address 0xC49
0x739:  B41  LD_X     0x41        ; Set X pointer to RAM address 0x41 (MEM_HAPPY)
0x73A:  E4C  PSET     12          ; Set NP (New Page) to 12 for the next jump/call
0x73B:  4E5  CALL     0xCE5       ; Call subroutine at 0xCE5
0x73C:  5FD  CALZ     0xCFD       ; Call subroutine at 0xCFD if Zero flag is set
0x73D:  746  JP_NZ    0xC46       ; Jump to 0xC46 if Zero flag is clear (result was non-zero)
0x73E:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x73F:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x740:  B0D  LD_X     0x0D        ; Set X pointer to RAM address 0x0D
0x741:  512  CALZ     0xC12       ; Call subroutine at 0xC12 if Zero flag is set
0x742:  E4C  PSET     12          ; Set NP (New Page) to 12 for the next jump/call
0x743:  4C8  CALL     0xCC8       ; Call subroutine at 0xCC8
0x744:  509  CALZ     0xC09       ; Call subroutine at 0xC09 if Zero flag is set
0x745:  5EF  CALZ     0xCEF       ; Call subroutine at 0xCEF if Zero flag is set
0x746:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x747:  456  CALL     0xC56       ; Call subroutine at 0xC56
0x748:  80A  LD_Y     0x0A        ; Set Y pointer to RAM address 0x0A
0x749:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x74A:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x74B:  B48  LD_X     0x48        ; Set X pointer to RAM address 0x48 (MEM_SICK_LEVEL)
0x74C:  DA1  UNKNOWN              ; Unrecognized instruction: 0xDA1
0x74D:  64F  JP_Z     0xC4F       ; Jump to 0xC4F if Zero flag is set (result was zero)
0x74E:  EF0  INC_Y                ; Increment the Y pointer by 1
0x74F:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x750:  052  JP       0xC52       ; Jump to address 0xC52
0x751:  E06  LD_R_I   A, #6       ; Load A with immediate value #6
0x752:  E15  LD_R_I   B, #5       ; Load B with immediate value #5
0x753:  E48  PSET     8           ; Set NP (New Page) to 8 for the next jump/call
0x754:  4A9  CALL     0x8A9       ; Call subroutine at 0x8A9
0x755:  012  JP       0x812       ; Jump to address 0x812
0x756:  F44  SDF                  ; Set Decimal Flag
0x757:  B46  LD_X     0x46        ; Set X pointer to RAM address 0x46 (MEM_WEIGHT)
0x758:  A88  ADD_R_Q  [X], A      ; Add value of A to register [X]
0x759:  EE0  INC_X                ; Increment the X pointer by 1
0x75A:  C60  UNKNOWN              ; Unrecognized instruction: 0xC60
0x75B:  35E  JP_NC    0x85E       ; Jump to 0x85E if Carry flag is clear (no overflow)
0x75C:  B46  LD_X     0x46        ; Set X pointer to RAM address 0x46 (MEM_WEIGHT)
0x75D:  999  LBPX     #99         ; Load constant #153 into [X]
0x75E:  F5B  RDF                  ; Reset (clear) Decimal Flag
0x75F:  E46  PSET     6           ; Set NP (New Page) to 6 for the next jump/call
0x760:  0E5  JP       0x6E5       ; Jump to address 0x6E5
0x761:  5EF  CALZ     0x6EF       ; Call subroutine at 0x6EF if Zero flag is set
0x762:  B5D  LD_X     0x5D        ; Set X pointer to RAM address 0x5D (MEM_LIFECYCLE)
0x763:  910  LBPX     #10         ; Load constant #16 into [X]
0x764:  B73  LD_X     0x73        ; Set X pointer to RAM address 0x73
0x765:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x766:  B40  LD_X     0x40        ; Set X pointer to RAM address 0x40 (MEM_HUNGER)
0x767:  E61  LDPX_MX  #1          ; Load constant #1 into [X] and increment X
0x768:  E61  LDPX_MX  #1          ; Load constant #1 into [X] and increment X
0x769:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x76A:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x76B:  B46  LD_X     0x46        ; Set X pointer to RAM address 0x46 (MEM_WEIGHT)
0x76C:  905  LBPX     #5          ; Load constant #5 into [X]
0x76D:  B54  LD_X     0x54        ; Set X pointer to RAM address 0x54 (MEM_AGE)
0x76E:  900  LBPX     #0          ; Load constant #0 into [X]
0x76F:  B48  LD_X     0x48        ; Set X pointer to RAM address 0x48 (MEM_SICK_LEVEL)
0x770:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x771:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x772:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x773:  E6F  LDPX_MX  #F          ; Load constant #15 into [X] and increment X
0x774:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x775:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x776:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x777:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x778:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x779:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x77A:  B5C  LD_X     0x5C        ; Set X pointer to RAM address 0x5C
0x77B:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x77C:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x77D:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x77E:  B00  LD_X     0x00        ; Set X pointer to RAM address 0x00
0x77F:  900  LBPX     #0          ; Load constant #0 into [X]
0x780:  902  LBPX     #2          ; Load constant #2 into [X]
0x781:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x782:  90F  LBPX     #F          ; Load constant #15 into [X]
0x783:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x784:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x785:  512  CALZ     0x612       ; Call subroutine at 0x612 if Zero flag is set
0x786:  900  LBPX     #0          ; Load constant #0 into [X]
0x787:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x788:  509  CALZ     0x609       ; Call subroutine at 0x609 if Zero flag is set
0x789:  B0F  LD_X     0x0F        ; Set X pointer to RAM address 0x0F
0x78A:  E6F  LDPX_MX  #F          ; Load constant #15 into [X] and increment X
0x78B:  B12  LD_X     0x12        ; Set X pointer to RAM address 0x12
0x78C:  E6F  LDPX_MX  #F          ; Load constant #15 into [X] and increment X
0x78D:  B15  LD_X     0x15        ; Set X pointer to RAM address 0x15
0x78E:  E65  LDPX_MX  #5          ; Load constant #5 into [X] and increment X
0x78F:  B16  LD_X     0x16        ; Set X pointer to RAM address 0x16
0x790:  928  LBPX     #28         ; Load constant #40 into [X]
0x791:  FDF  RET                  ; Return to caller
0x792:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x793:  E90  UNKNOWN              ; Unrecognized instruction: 0xE90
0x794:  5F5  CALZ     0x6F5       ; Call subroutine at 0x6F5 if Zero flag is set
0x795:  83A  LD_Y     0x3A        ; Set Y pointer to RAM address 0x3A
0x796:  E8B  UNKNOWN              ; Unrecognized instruction: 0xE8B
0x797:  EF0  INC_Y                ; Increment the Y pointer by 1
0x798:  E87  UNKNOWN              ; Unrecognized instruction: 0xE87
0x799:  890  LD_Y     0x90        ; Set Y pointer to RAM address 0x90
0x79A:  4A3  CALL     0x6A3       ; Call subroutine at 0x6A3
0x79B:  4A3  CALL     0x6A3       ; Call subroutine at 0x6A3
0x79C:  4A3  CALL     0x6A3       ; Call subroutine at 0x6A3
0x79D:  4A3  CALL     0x6A3       ; Call subroutine at 0x6A3
0x79E:  F5E  RCF                  ; Reset (clear) Carry Flag
0x79F:  A04  UNKNOWN              ; Unrecognized instruction: 0xA04
0x7A0:  4A3  CALL     0x6A3       ; Call subroutine at 0x6A3
0x7A1:  4A3  CALL     0x6A3       ; Call subroutine at 0x6A3
0x7A2:  4A3  CALL     0x6A3       ; Call subroutine at 0x6A3
0x7A3:  EF3  UNKNOWN              ; Unrecognized instruction: 0xEF3
0x7A4:  EF7  UNKNOWN              ; Unrecognized instruction: 0xEF7

; =========================================================
; ROUTINE: EXTRACT_HEART_COUNT
; Location: 0x7A5 (Page 7, Step A5)
; Trigger:  Drawing status screen or checking neglect
; Logic:    Converts raw level nibble (0-F) to heart count (0-4)
; =========================================================

0x7A5:  FC1  PUSH_R               ; Push registers A, B and Flags to the stack
0x7A6:  E10  LD_R_I   B, #0       ; Load B with immediate value #0
0x7A7:  E8C  UNKNOWN              ; Unrecognized instruction: 0xE8C
0x7A8:  E8D  UNKNOWN              ; Unrecognized instruction: 0xE8D
0x7A9:  F90  LD_MN_B  0x00        ; Store B into direct RAM address 0x00
0x7AA:  FD1  POP_R                ; Pop registers A, B and Flags from the stack
0x7AB:  DD4  CP_R_I   B, #4       ; Compare register B with immediate value #4
0x7AC:  E47  PSET     7           ; Set NP (New Page) to 7 for the next jump/call
0x7AD:  3B8  JP_NC    0x7B8       ; Jump to 0x7B8 if Carry flag is clear (no overflow)
0x7AE:  A80  ADD_R_Q  A, A        ; Add value of A to register A
0x7AF:  F5E  RCF                  ; Reset (clear) Carry Flag
0x7B0:  E8D  UNKNOWN              ; Unrecognized instruction: 0xE8D
0x7B1:  E8C  UNKNOWN              ; Unrecognized instruction: 0xE8C
0x7B2:  C00  ADD_R_I  A, #0       ; Add immediate #0 to register A
0x7B3:  C56  UNKNOWN              ; Unrecognized instruction: 0xC56
0x7B4:  F81  LD_MN_A  0x01        ; Store A into direct RAM address 0x01
0x7B5:  F92  LD_MN_B  0x02        ; Store B into direct RAM address 0x02
0x7B6:  E40  PSET     0           ; Set NP (New Page) to 0 for the next jump/call
0x7B7:  000  JP       0x000       ; Jump to address 0x000
0x7B8:  900  LBPX     #0          ; Load constant #0 into [X]
0x7B9:  900  LBPX     #0          ; Load constant #0 into [X]
0x7BA:  900  LBPX     #0          ; Load constant #0 into [X]
0x7BB:  900  LBPX     #0          ; Load constant #0 into [X]
0x7BC:  900  LBPX     #0          ; Load constant #0 into [X]
0x7BD:  900  LBPX     #0          ; Load constant #0 into [X]
0x7BE:  900  LBPX     #0          ; Load constant #0 into [X]
0x7BF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x7C0:  5F2  CALZ     0x0F2       ; Call subroutine at 0x0F2 if Zero flag is set
0x7C1:  B2C  LD_X     0x2C        ; Set X pointer to RAM address 0x2C
0x7C2:  4D5  CALL     0x0D5       ; Call subroutine at 0x0D5
0x7C3:  5B3  CALZ     0x0B3       ; Call subroutine at 0x0B3 if Zero flag is set
0x7C4:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0x7C5:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x7C6:  6CB  JP_Z     0x0CB       ; Jump to 0x0CB if Zero flag is set (result was zero)
0x7C7:  B05  LD_X     0x05        ; Set X pointer to RAM address 0x05
0x7C8:  DE4  CP_R_I   [X], #4     ; Compare register [X] with immediate value #4
0x7C9:  2D1  JP_C     0x0D1       ; Jump to 0x0D1 if Carry flag is set (overflow occurred)
0x7CA:  0E1  JP       0x0E1       ; Jump to address 0x0E1
0x7CB:  B08  LD_X     0x08        ; Set X pointer to RAM address 0x08
0x7CC:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x7CD:  7D1  JP_NZ    0x0D1       ; Jump to 0x0D1 if Zero flag is clear (result was non-zero)
0x7CE:  B09  LD_X     0x09        ; Set X pointer to RAM address 0x09
0x7CF:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x7D0:  6E1  JP_Z     0x0E1       ; Jump to 0x0E1 if Zero flag is set (result was zero)
0x7D1:  5EF  CALZ     0x0EF       ; Call subroutine at 0x0EF if Zero flag is set
0x7D2:  B2D  LD_X     0x2D        ; Set X pointer to RAM address 0x2D (MEM_ATTENTION)
0x7D3:  CE8  UNKNOWN              ; Unrecognized instruction: 0xCE8
0x7D4:  0E1  JP       0x0E1       ; Jump to address 0x0E1
0x7D5:  C08  ADD_R_I  A, #8       ; Add immediate #8 to register A
0x7D6:  C5D  UNKNOWN              ; Unrecognized instruction: 0xC5D
0x7D7:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0x7D8:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x7D9:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0x7DA:  102  UNKNOWN              ; Unrecognized instruction: 0x102
0x7DB:  104  UNKNOWN              ; Unrecognized instruction: 0x104
0x7DC:  108  UNKNOWN              ; Unrecognized instruction: 0x108
0x7DD:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0x7DE:  120  UNKNOWN              ; Unrecognized instruction: 0x120
0x7DF:  140  UNKNOWN              ; Unrecognized instruction: 0x140
0x7E0:  180  UNKNOWN              ; Unrecognized instruction: 0x180
0x7E1:  E0E  LD_R_I   A, #14      ; Load A with immediate value #14
0x7E2:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x7E3:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x7E4:  E90  UNKNOWN              ; Unrecognized instruction: 0xE90
0x7E5:  82C  LD_Y     0x2C        ; Set Y pointer to RAM address 0x2C
0x7E6:  EF3  UNKNOWN              ; Unrecognized instruction: 0xEF3
0x7E7:  EC7  LD_R_Q   B, [Y]      ; Copy value from [Y] into B
0x7E8:  B10  LD_X     0x10        ; Set X pointer to RAM address 0x10
0x7E9:  EC8  LD_R_Q   [X], A      ; Copy value from A into [X]
0x7EA:  E8C  UNKNOWN              ; Unrecognized instruction: 0xE8C
0x7EB:  B22  LD_X     0x22        ; Set X pointer to RAM address 0x22
0x7EC:  EC8  LD_R_Q   [X], A      ; Copy value from A into [X]
0x7ED:  E8C  UNKNOWN              ; Unrecognized instruction: 0xE8C
0x7EE:  B24  LD_X     0x24        ; Set X pointer to RAM address 0x24
0x7EF:  EC8  LD_R_Q   [X], A      ; Copy value from A into [X]
0x7F0:  E8C  UNKNOWN              ; Unrecognized instruction: 0xE8C
0x7F1:  B26  LD_X     0x26        ; Set X pointer to RAM address 0x26
0x7F2:  EC8  LD_R_Q   [X], A      ; Copy value from A into [X]
0x7F3:  BB9  LD_X     0xB9        ; Set X pointer to RAM address 0xB9
0x7F4:  EC9  LD_R_Q   [X], B      ; Copy value from B into [X]
0x7F5:  AF5  UNKNOWN              ; Unrecognized instruction: 0xAF5
0x7F6:  BCB  LD_X     0xCB        ; Set X pointer to RAM address 0xCB
0x7F7:  EC9  LD_R_Q   [X], B      ; Copy value from B into [X]
0x7F8:  AF5  UNKNOWN              ; Unrecognized instruction: 0xAF5
0x7F9:  BCD  LD_X     0xCD        ; Set X pointer to RAM address 0xCD
0x7FA:  EC9  LD_R_Q   [X], B      ; Copy value from B into [X]
0x7FB:  AF5  UNKNOWN              ; Unrecognized instruction: 0xAF5
0x7FC:  BCF  LD_X     0xCF        ; Set X pointer to RAM address 0xCF
0x7FD:  EC9  LD_R_Q   [X], B      ; Copy value from B into [X]
0x7FE:  FDF  RET                  ; Return to caller
0x7FF:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x800:  120  UNKNOWN              ; Unrecognized instruction: 0x120
0x801:  108  UNKNOWN              ; Unrecognized instruction: 0x108
0x802:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0x803:  140  UNKNOWN              ; Unrecognized instruction: 0x140
0x804:  102  UNKNOWN              ; Unrecognized instruction: 0x102
0x805:  180  UNKNOWN              ; Unrecognized instruction: 0x180
0x806:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0x807:  104  UNKNOWN              ; Unrecognized instruction: 0x104
0x808:  D88  UNKNOWN              ; Unrecognized instruction: 0xD88
0x809:  60B  JP_Z     0x00B       ; Jump to 0x00B if Zero flag is set (result was zero)
0x80A:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x80B:  E10  LD_R_I   B, #0       ; Load B with immediate value #0
0x80C:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0x80D:  E11  LD_R_I   B, #1       ; Load B with immediate value #1
0x80E:  E81  UNKNOWN              ; Unrecognized instruction: 0xE81
0x80F:  900  LBPX     #0          ; Load constant #0 into [X]
0x810:  900  LBPX     #0          ; Load constant #0 into [X]
0x811:  C0F  ADD_R_I  A, #15      ; Add immediate #15 to register A
0x812:  70F  JP_NZ    0x00F       ; Jump to 0x00F if Zero flag is clear (result was non-zero)
0x813:  FDF  RET                  ; Return to caller
0x814:  5EF  CALZ     0x0EF       ; Call subroutine at 0x0EF if Zero flag is set
0x815:  B80  LD_X     0x80        ; Set X pointer to RAM address 0x80
0x816:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0x817:  436  CALL     0x036       ; Call subroutine at 0x036
0x818:  5DE  CALZ     0x0DE       ; Call subroutine at 0x0DE if Zero flag is set
0x819:  5EF  CALZ     0x0EF       ; Call subroutine at 0x0EF if Zero flag is set
0x81A:  B81  LD_X     0x81        ; Set X pointer to RAM address 0x81
0x81B:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x81C:  61E  JP_Z     0x01E       ; Jump to 0x01E if Zero flag is set (result was zero)
0x81D:  467  CALL     0x067       ; Call subroutine at 0x067
0x81E:  556  CALZ     0x056       ; Call subroutine at 0x056 if Zero flag is set
0x81F:  521  CALZ     0x021       ; Call subroutine at 0x021 if Zero flag is set
0x820:  B57  LD_X     0x57        ; Set X pointer to RAM address 0x57
0x821:  E2F  LD_R_I   [X], #15    ; Load [X] with immediate value #15
0x822:  521  CALZ     0x021       ; Call subroutine at 0x021 if Zero flag is set
0x823:  B57  LD_X     0x57        ; Set X pointer to RAM address 0x57
0x824:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x825:  633  JP_Z     0x033       ; Jump to 0x033 if Zero flag is set (result was zero)
0x826:  D91  UNKNOWN              ; Unrecognized instruction: 0xD91
0x827:  733  JP_NZ    0x033       ; Jump to 0x033 if Zero flag is clear (result was non-zero)
0x828:  D96  UNKNOWN              ; Unrecognized instruction: 0xD96
0x829:  622  JP_Z     0x022       ; Jump to 0x022 if Zero flag is set (result was zero)
0x82A:  5BB  CALZ     0x0BB       ; Call subroutine at 0x0BB if Zero flag is set
0x82B:  B80  LD_X     0x80        ; Set X pointer to RAM address 0x80
0x82C:  C21  ADD_R_I  [X], #1     ; Add immediate #1 to register [X]
0x82D:  DE4  CP_R_I   [X], #4     ; Compare register [X] with immediate value #4
0x82E:  230  JP_C     0x030       ; Jump to 0x030 if Carry flag is set (overflow occurred)
0x82F:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0x830:  E4F  PSET     15          ; Set NP (New Page) to 15 for the next jump/call
0x831:  400  CALL     0xF00       ; Call subroutine at 0xF00
0x832:  617  JP_Z     0xF17       ; Jump to 0xF17 if Zero flag is set (result was zero)
0x833:  5BB  CALZ     0xFBB       ; Call subroutine at 0xFBB if Zero flag is set
0x834:  E45  PSET     5           ; Set NP (New Page) to 5 for the next jump/call
0x835:  01A  JP       0x51A       ; Jump to address 0x51A
0x836:  5F2  CALZ     0x5F2       ; Call subroutine at 0x5F2 if Zero flag is set
0x837:  E91  UNKNOWN              ; Unrecognized instruction: 0xE91
0x838:  B80  LD_X     0x80        ; Set X pointer to RAM address 0x80
0x839:  EE2  UNKNOWN              ; Unrecognized instruction: 0xEE2
0x83A:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x83B:  C0F  ADD_R_I  A, #15      ; Add immediate #15 to register A
0x83C:  C53  UNKNOWN              ; Unrecognized instruction: 0xC53
0x83D:  B90  LD_X     0x90        ; Set X pointer to RAM address 0x90
0x83E:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0x83F:  043  JP       0x543       ; Jump to address 0x543
0x840:  05C  JP       0x55C       ; Jump to address 0x55C
0x841:  083  JP       0x583       ; Jump to address 0x583
0x842:  089  JP       0x589       ; Jump to address 0x589
0x843:  918  LBPX     #18         ; Load constant #24 into [X]
0x844:  855  LD_Y     0x55        ; Set Y pointer to RAM address 0x55
0x845:  EEB  UNKNOWN              ; Unrecognized instruction: 0xEEB
0x846:  E10  LD_R_I   B, #0       ; Load B with immediate value #0
0x847:  DF0  CP_R_I   [Y], #0     ; Compare register [Y] with immediate value #0
0x848:  74A  JP_NZ    0x54A       ; Jump to 0x54A if Zero flag is clear (result was non-zero)
0x849:  E1F  LD_R_I   B, #15      ; Load B with immediate value #15
0x84A:  EE9  UNKNOWN              ; Unrecognized instruction: 0xEE9
0x84B:  854  LD_Y     0x54        ; Set Y pointer to RAM address 0x54 (MEM_AGE)
0x84C:  EEB  UNKNOWN              ; Unrecognized instruction: 0xEEB
0x84D:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x84E:  919  LBPX     #19         ; Load constant #25 into [X]
0x84F:  91A  LBPX     #1A         ; Load constant #26 into [X]
0x850:  847  LD_Y     0x47        ; Set Y pointer to RAM address 0x47
0x851:  EEB  UNKNOWN              ; Unrecognized instruction: 0xEEB
0x852:  E10  LD_R_I   B, #0       ; Load B with immediate value #0
0x853:  DF0  CP_R_I   [Y], #0     ; Compare register [Y] with immediate value #0
0x854:  756  JP_NZ    0x556       ; Jump to 0x556 if Zero flag is clear (result was non-zero)
0x855:  E1F  LD_R_I   B, #15      ; Load B with immediate value #15
0x856:  EE9  UNKNOWN              ; Unrecognized instruction: 0xEE9
0x857:  846  LD_Y     0x46        ; Set Y pointer to RAM address 0x46 (MEM_WEIGHT)
0x858:  EEB  UNKNOWN              ; Unrecognized instruction: 0xEEB
0x859:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x85A:  91B  LBPX     #1B         ; Load constant #27 into [X]
0x85B:  FDF  RET                  ; Return to caller
0x85C:  934  LBPX     #34         ; Load constant #52 into [X]
0x85D:  935  LBPX     #35         ; Load constant #53 into [X]
0x85E:  936  LBPX     #36         ; Load constant #54 into [X]
0x85F:  937  LBPX     #37         ; Load constant #55 into [X]
0x860:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x861:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x862:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x863:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x864:  881  LD_Y     0x81        ; Set Y pointer to RAM address 0x81
0x865:  E31  LD_R_I   [Y], #1     ; Load [Y] with immediate value #1
0x866:  FDF  RET                  ; Return to caller
0x867:  5F5  CALZ     0x5F5       ; Call subroutine at 0x5F5 if Zero flag is set
0x868:  BC2  LD_X     0xC2        ; Set X pointer to RAM address 0xC2
0x869:  93D  LBPX     #3D         ; Load constant #61 into [X]
0x86A:  47D  CALL     0x57D       ; Call subroutine at 0x57D
0x86B:  943  LBPX     #43         ; Load constant #67 into [X]
0x86C:  47D  CALL     0x57D       ; Call subroutine at 0x57D
0x86D:  93D  LBPX     #3D         ; Load constant #61 into [X]
0x86E:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x86F:  E90  UNKNOWN              ; Unrecognized instruction: 0xE90
0x870:  843  LD_Y     0x43        ; Set Y pointer to RAM address 0x43 (MEM_DISCIPLINE)
0x871:  EC3  LD_R_Q   A, [Y]      ; Copy value from [Y] into A
0x872:  DC0  CP_R_I   A, #0       ; Compare register A with immediate value #0
0x873:  775  JP_NZ    0x575       ; Jump to 0x575 if Zero flag is clear (result was non-zero)
0x874:  E01  LD_R_I   A, #1       ; Load A with immediate value #1
0x875:  F80  LD_MN_A  0x00        ; Store A into direct RAM address 0x00
0x876:  BC6  LD_X     0xC6        ; Set X pointer to RAM address 0xC6
0x877:  F70  UNKNOWN              ; Unrecognized instruction: 0xF70
0x878:  682  JP_Z     0x582       ; Jump to 0x582 if Zero flag is set (result was zero)
0x879:  95A  LBPX     #5A         ; Load constant #90 into [X]
0x87A:  EE0  INC_X                ; Increment the X pointer by 1
0x87B:  EE0  INC_X                ; Increment the X pointer by 1
0x87C:  077  JP       0x577       ; Jump to address 0x577
0x87D:  E0E  LD_R_I   A, #14      ; Load A with immediate value #14
0x87E:  F80  LD_MN_A  0x00        ; Store A into direct RAM address 0x00
0x87F:  942  LBPX     #42         ; Load constant #66 into [X]
0x880:  F70  UNKNOWN              ; Unrecognized instruction: 0xF70
0x881:  77F  JP_NZ    0x57F       ; Jump to 0x57F if Zero flag is clear (result was non-zero)
0x882:  FDF  RET                  ; Return to caller
0x883:  92E  LBPX     #2E         ; Load constant #46 into [X]
0x884:  92F  LBPX     #2F         ; Load constant #47 into [X]
0x885:  930  LBPX     #30         ; Load constant #48 into [X]
0x886:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x887:  840  LD_Y     0x40        ; Set Y pointer to RAM address 0x40 (MEM_HUNGER)
0x888:  08C  JP       0x58C       ; Jump to address 0x58C
0x889:  E4B  PSET     11          ; Set NP (New Page) to 11 for the next jump/call
0x88A:  4F8  CALL     0xBF8       ; Call subroutine at 0xBF8
0x88B:  841  LD_Y     0x41        ; Set Y pointer to RAM address 0x41 (MEM_HAPPY)
0x88C:  E04  LD_R_I   A, #4       ; Load A with immediate value #4
0x88D:  DFF  CP_R_I   [Y], #15    ; Compare register [Y] with immediate value #15
0x88E:  394  JP_NC    0xB94       ; Jump to 0xB94 if Carry flag is clear (no overflow)
0x88F:  EC3  LD_R_Q   A, [Y]      ; Copy value from [Y] into A
0x890:  C01  ADD_R_I  A, #1       ; Add immediate #1 to register A
0x891:  E8C  UNKNOWN              ; Unrecognized instruction: 0xE8C
0x892:  E8C  UNKNOWN              ; Unrecognized instruction: 0xE8C
0x893:  C83  UNKNOWN              ; Unrecognized instruction: 0xC83
0x894:  E14  LD_R_I   B, #4       ; Load B with immediate value #4
0x895:  DC0  CP_R_I   A, #0       ; Compare register A with immediate value #0
0x896:  799  JP_NZ    0xB99       ; Jump to 0xB99 if Zero flag is clear (result was non-zero)
0x897:  91D  LBPX     #1D         ; Load constant #29 into [X]
0x898:  09B  JP       0xB9B       ; Jump to address 0xB9B
0x899:  C0F  ADD_R_I  A, #15      ; Add immediate #15 to register A
0x89A:  91C  LBPX     #1C         ; Load constant #28 into [X]
0x89B:  C1F  ADD_R_I  B, #15      ; Add immediate #15 to register B
0x89C:  795  JP_NZ    0xB95       ; Jump to 0xB95 if Zero flag is clear (result was non-zero)
0x89D:  FDF  RET                  ; Return to caller
0x89E:  800  LD_Y     0x00        ; Set Y pointer to RAM address 0x00
0x89F:  FC1  PUSH_R               ; Push registers A, B and Flags to the stack
0x8A0:  FC8  UNKNOWN              ; Unrecognized instruction: 0xFC8
0x8A1:  FC9  UNKNOWN              ; Unrecognized instruction: 0xFC9
0x8A2:  E45  PSET     5           ; Set NP (New Page) to 5 for the next jump/call
0x8A3:  496  CALL     0x596       ; Call subroutine at 0x596
0x8A4:  FD9  UNKNOWN              ; Unrecognized instruction: 0xFD9
0x8A5:  FD8  UNKNOWN              ; Unrecognized instruction: 0xFD8
0x8A6:  5EF  CALZ     0x5EF       ; Call subroutine at 0x5EF if Zero flag is set
0x8A7:  0AD  JP       0x5AD       ; Jump to address 0x5AD
0x8A8:  800  LD_Y     0x00        ; Set Y pointer to RAM address 0x00
0x8A9:  FC1  PUSH_R               ; Push registers A, B and Flags to the stack
0x8AA:  5F2  CALZ     0x5F2       ; Call subroutine at 0x5F2 if Zero flag is set
0x8AB:  B5E  LD_X     0x5E        ; Set X pointer to RAM address 0x5E
0x8AC:  EE8  UNKNOWN              ; Unrecognized instruction: 0xEE8
0x8AD:  B57  LD_X     0x57        ; Set X pointer to RAM address 0x57
0x8AE:  FD2  POP_R                ; Pop registers A, B and Flags from the stack
0x8AF:  EB8  UNKNOWN              ; Unrecognized instruction: 0xEB8
0x8B0:  EB5  UNKNOWN              ; Unrecognized instruction: 0xEB5
0x8B1:  BA6  LD_X     0xA6        ; Set X pointer to RAM address 0xA6
0x8B2:  E4E  PSET     14          ; Set NP (New Page) to 14 for the next jump/call
0x8B3:  40D  CALL     0xE0D       ; Call subroutine at 0xE0D
0x8B4:  BAA  LD_X     0xAA        ; Set X pointer to RAM address 0xAA
0x8B5:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x8B6:  E44  PSET     4           ; Set NP (New Page) to 4 for the next jump/call
0x8B7:  465  CALL     0x465       ; Call subroutine at 0x465
0x8B8:  521  CALZ     0x421       ; Call subroutine at 0x421 if Zero flag is set
0x8B9:  540  CALZ     0x440       ; Call subroutine at 0x440 if Zero flag is set
0x8BA:  E44  PSET     4           ; Set NP (New Page) to 4 for the next jump/call
0x8BB:  486  CALL     0x486       ; Call subroutine at 0x486
0x8BC:  5EF  CALZ     0x4EF       ; Call subroutine at 0x4EF if Zero flag is set
0x8BD:  E90  UNKNOWN              ; Unrecognized instruction: 0xE90
0x8BE:  BAA  LD_X     0xAA        ; Set X pointer to RAM address 0xAA
0x8BF:  C2F  ADD_R_I  [X], #15    ; Add immediate #15 to register [X]
0x8C0:  2D5  JP_C     0x4D5       ; Jump to 0x4D5 if Carry flag is set (overflow occurred)
0x8C1:  BA6  LD_X     0xA6        ; Set X pointer to RAM address 0xA6
0x8C2:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x8C3:  C22  ADD_R_I  [X], #2     ; Add immediate #2 to register [X]
0x8C4:  EE0  INC_X                ; Increment the X pointer by 1
0x8C5:  EC6  LD_R_Q   B, [X]      ; Copy value from [X] into B
0x8C6:  C60  UNKNOWN              ; Unrecognized instruction: 0xC60
0x8C7:  BA2  LD_X     0xA2        ; Set X pointer to RAM address 0xA2
0x8C8:  E4E  PSET     14          ; Set NP (New Page) to 14 for the next jump/call
0x8C9:  40D  CALL     0xE0D       ; Call subroutine at 0xE0D
0x8CA:  BA2  LD_X     0xA2        ; Set X pointer to RAM address 0xA2
0x8CB:  8A8  LD_Y     0xA8        ; Set Y pointer to RAM address 0xA8
0x8CC:  EEE  UNKNOWN              ; Unrecognized instruction: 0xEEE
0x8CD:  EF0  INC_Y                ; Increment the Y pointer by 1
0x8CE:  ECE  LD_R_Q   [Y], [X]    ; Copy value from [X] into [Y]
0x8CF:  CB3  UNKNOWN              ; Unrecognized instruction: 0xCB3
0x8D0:  8AA  LD_Y     0xAA        ; Set Y pointer to RAM address 0xAA
0x8D1:  ECE  LD_R_Q   [Y], [X]    ; Copy value from [X] into [Y]
0x8D2:  E8F  UNKNOWN              ; Unrecognized instruction: 0xE8F
0x8D3:  E8F  UNKNOWN              ; Unrecognized instruction: 0xE8F
0x8D4:  CB3  UNKNOWN              ; Unrecognized instruction: 0xCB3
0x8D5:  BA8  LD_X     0xA8        ; Set X pointer to RAM address 0xA8
0x8D6:  DEF  CP_R_I   [X], #15    ; Compare register [X] with immediate value #15
0x8D7:  7DB  JP_NZ    0xEDB       ; Jump to 0xEDB if Zero flag is clear (result was non-zero)
0x8D8:  EE0  INC_X                ; Increment the X pointer by 1
0x8D9:  DE3  CP_R_I   [X], #3     ; Compare register [X] with immediate value #3
0x8DA:  6F4  JP_Z     0xEF4       ; Jump to 0xEF4 if Zero flag is set (result was zero)
0x8DB:  8A4  LD_Y     0xA4        ; Set Y pointer to RAM address 0xA4
0x8DC:  E8B  UNKNOWN              ; Unrecognized instruction: 0xE8B
0x8DD:  EF0  INC_Y                ; Increment the Y pointer by 1
0x8DE:  E87  UNKNOWN              ; Unrecognized instruction: 0xE87
0x8DF:  85D  LD_Y     0x5D        ; Set Y pointer to RAM address 0x5D (MEM_LIFECYCLE)
0x8E0:  DF1  CP_R_I   [Y], #1     ; Compare register [Y] with immediate value #1
0x8E1:  7F0  JP_NZ    0xEF0       ; Jump to 0xEF0 if Zero flag is clear (result was non-zero)
0x8E2:  EA4  UNKNOWN              ; Unrecognized instruction: 0xEA4
0x8E3:  DC0  CP_R_I   A, #0       ; Compare register A with immediate value #0
0x8E4:  6E6  JP_Z     0xEE6       ; Jump to 0xEE6 if Zero flag is set (result was zero)
0x8E5:  CC8  UNKNOWN              ; Unrecognized instruction: 0xCC8
0x8E6:  E84  UNKNOWN              ; Unrecognized instruction: 0xE84
0x8E7:  F5E  RCF                  ; Reset (clear) Carry Flag
0x8E8:  A18  UNKNOWN              ; Unrecognized instruction: 0xA18
0x8E9:  A0F  UNKNOWN              ; Unrecognized instruction: 0xA0F
0x8EA:  EA4  UNKNOWN              ; Unrecognized instruction: 0xEA4
0x8EB:  CC8  UNKNOWN              ; Unrecognized instruction: 0xCC8
0x8EC:  DCF  CP_R_I   A, #15      ; Compare register A with immediate value #15
0x8ED:  7F0  JP_NZ    0xEF0       ; Jump to 0xEF0 if Zero flag is clear (result was non-zero)
0x8EE:  F5E  RCF                  ; Reset (clear) Carry Flag
0x8EF:  A01  UNKNOWN              ; Unrecognized instruction: 0xA01
0x8F0:  5F5  CALZ     0xEF5       ; Call subroutine at 0xEF5 if Zero flag is set
0x8F1:  8A8  LD_Y     0xA8        ; Set Y pointer to RAM address 0xA8
0x8F2:  E47  PSET     7           ; Set NP (New Page) to 7 for the next jump/call
0x8F3:  4A3  CALL     0x7A3       ; Call subroutine at 0x7A3
0x8F4:  554  CALZ     0x754       ; Call subroutine at 0x754 if Zero flag is set
0x8F5:  521  CALZ     0x721       ; Call subroutine at 0x721 if Zero flag is set
0x8F6:  B57  LD_X     0x57        ; Set X pointer to RAM address 0x57
0x8F7:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x8F8:  6FF  JP_Z     0x7FF       ; Jump to 0x7FF if Zero flag is set (result was zero)
0x8F9:  B74  LD_X     0x74        ; Set X pointer to RAM address 0x74
0x8FA:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0x8FB:  6B9  JP_Z     0x7B9       ; Jump to 0x7B9 if Zero flag is set (result was zero)
0x8FC:  D97  UNKNOWN              ; Unrecognized instruction: 0xD97
0x8FD:  6B9  JP_Z     0x7B9       ; Jump to 0x7B9 if Zero flag is set (result was zero)
0x8FE:  5BB  CALZ     0x7BB       ; Call subroutine at 0x7BB if Zero flag is set
0x8FF:  FDF  RET                  ; Return to caller
0x900:  DC0  CP_R_I   A, #0       ; Compare register A with immediate value #0
0x901:  605  JP_Z     0x705       ; Jump to 0x705 if Zero flag is set (result was zero)
0x902:  B5A  LD_X     0x5A        ; Set X pointer to RAM address 0x5A
0x903:  F41  SCF                  ; Set Carry Flag
0x904:  A98  ADC_R_Q  [X], A      ; Add value of A plus Carry to register [X]
0x905:  FDF  RET                  ; Return to caller
0x906:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x907:  F82  LD_MN_A  0x02        ; Store A into direct RAM address 0x02
0x908:  E08  LD_R_I   A, #8       ; Load A with immediate value #8
0x909:  F83  LD_MN_A  0x03        ; Store A into direct RAM address 0x03
0x90A:  413  CALL     0x713       ; Call subroutine at 0x713
0x90B:  556  CALZ     0x756       ; Call subroutine at 0x756 if Zero flag is set
0x90C:  B01  LD_X     0x01        ; Set X pointer to RAM address 0x01
0x90D:  53C  CALZ     0x73C       ; Call subroutine at 0x73C if Zero flag is set
0x90E:  F62  UNKNOWN              ; Unrecognized instruction: 0xF62
0x90F:  F73  UNKNOWN              ; Unrecognized instruction: 0xF73
0x910:  70A  JP_NZ    0x70A       ; Jump to 0x70A if Zero flag is clear (result was non-zero)
0x911:  540  CALZ     0x740       ; Call subroutine at 0x740 if Zero flag is set
0x912:  FDF  RET                  ; Return to caller
0x913:  5EF  CALZ     0x7EF       ; Call subroutine at 0x7EF if Zero flag is set
0x914:  B00  LD_X     0x00        ; Set X pointer to RAM address 0x00
0x915:  FA2  LD_A_MN  0x02        ; Load A from direct RAM address 0x02
0x916:  E48  PSET     8           ; Set NP (New Page) to 8 for the next jump/call
0x917:  408  CALL     0x808       ; Call subroutine at 0x808
0x918:  5F5  CALZ     0x8F5       ; Call subroutine at 0x8F5 if Zero flag is set
0x919:  B00  LD_X     0x00        ; Set X pointer to RAM address 0x00
0x91A:  FA0  LD_A_MN  0x00        ; Load A from direct RAM address 0x00
0x91B:  FB1  LD_B_MN  0x01        ; Load B from direct RAM address 0x01
0x91C:  F5E  RCF                  ; Reset (clear) Carry Flag
0x91D:  AD8  UNKNOWN              ; Unrecognized instruction: 0xAD8
0x91E:  EE0  INC_X                ; Increment the X pointer by 1
0x91F:  AD8  UNKNOWN              ; Unrecognized instruction: 0xAD8
0x920:  EE0  INC_X                ; Increment the X pointer by 1
0x921:  AD9  UNKNOWN              ; Unrecognized instruction: 0xAD9
0x922:  EE0  INC_X                ; Increment the X pointer by 1
0x923:  AD9  UNKNOWN              ; Unrecognized instruction: 0xAD9
0x924:  A11  UNKNOWN              ; Unrecognized instruction: 0xA11
0x925:  A00  UNKNOWN              ; Unrecognized instruction: 0xA00
0x926:  31D  JP_NC    0x81D       ; Jump to 0x81D if Carry flag is clear (no overflow)
0x927:  FDF  RET                  ; Return to caller
0x928:  F80  LD_MN_A  0x00        ; Store A into direct RAM address 0x00
0x929:  F93  LD_MN_B  0x03        ; Store B into direct RAM address 0x03
0x92A:  B5D  LD_X     0x5D        ; Set X pointer to RAM address 0x5D (MEM_LIFECYCLE)
0x92B:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x92C:  E10  LD_R_I   B, #0       ; Load B with immediate value #0
0x92D:  B01  LD_X     0x01        ; Set X pointer to RAM address 0x01
0x92E:  E4C  PSET     12          ; Set NP (New Page) to 12 for the next jump/call
0x92F:  479  CALL     0xC79       ; Call subroutine at 0xC79
0x930:  FA1  LD_A_MN  0x01        ; Load A from direct RAM address 0x01
0x931:  FB0  LD_B_MN  0x00        ; Load B from direct RAM address 0x00
0x932:  A81  ADD_R_Q  A, B        ; Add value of B to register A
0x933:  FB2  LD_B_MN  0x02        ; Load B from direct RAM address 0x02
0x934:  C50  UNKNOWN              ; Unrecognized instruction: 0xC50
0x935:  B24  LD_X     0x24        ; Set X pointer to RAM address 0x24
0x936:  E4C  PSET     12          ; Set NP (New Page) to 12 for the next jump/call
0x937:  479  CALL     0xC79       ; Call subroutine at 0xC79
0x938:  049  JP       0xC49       ; Jump to address 0xC49
0x939:  F80  LD_MN_A  0x00        ; Store A into direct RAM address 0x00
0x93A:  F93  LD_MN_B  0x03        ; Store B into direct RAM address 0x03
0x93B:  B5D  LD_X     0x5D        ; Set X pointer to RAM address 0x5D (MEM_LIFECYCLE)
0x93C:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x93D:  E10  LD_R_I   B, #0       ; Load B with immediate value #0
0x93E:  B01  LD_X     0x01        ; Set X pointer to RAM address 0x01
0x93F:  E4D  PSET     13          ; Set NP (New Page) to 13 for the next jump/call
0x940:  47D  CALL     0xD7D       ; Call subroutine at 0xD7D
0x941:  FA1  LD_A_MN  0x01        ; Load A from direct RAM address 0x01
0x942:  FB0  LD_B_MN  0x00        ; Load B from direct RAM address 0x00
0x943:  A81  ADD_R_Q  A, B        ; Add value of B to register A
0x944:  FB2  LD_B_MN  0x02        ; Load B from direct RAM address 0x02
0x945:  C50  UNKNOWN              ; Unrecognized instruction: 0xC50
0x946:  B24  LD_X     0x24        ; Set X pointer to RAM address 0x24
0x947:  E4D  PSET     13          ; Set NP (New Page) to 13 for the next jump/call
0x948:  47D  CALL     0xD7D       ; Call subroutine at 0xD7D
0x949:  FA3  LD_A_MN  0x03        ; Load A from direct RAM address 0x03
0x94A:  C88  UNKNOWN              ; Unrecognized instruction: 0xC88
0x94B:  B25  LD_X     0x25        ; Set X pointer to RAM address 0x25
0x94C:  AE8  UNKNOWN              ; Unrecognized instruction: 0xAE8
0x94D:  E49  PSET     9           ; Set NP (New Page) to 9 for the next jump/call
0x94E:  04F  JP       0x94F       ; Jump to address 0x94F
0x94F:  5EF  CALZ     0x9EF       ; Call subroutine at 0x9EF if Zero flag is set
0x950:  F80  LD_MN_A  0x00        ; Store A into direct RAM address 0x00
0x951:  B24  LD_X     0x24        ; Set X pointer to RAM address 0x24
0x952:  EE2  UNKNOWN              ; Unrecognized instruction: 0xEE2
0x953:  EE6  UNKNOWN              ; Unrecognized instruction: 0xEE6
0x954:  C97  UNKNOWN              ; Unrecognized instruction: 0xC97
0x955:  C03  ADD_R_I  A, #3       ; Add immediate #3 to register A
0x956:  C50  UNKNOWN              ; Unrecognized instruction: 0xC50
0x957:  DD8  CP_R_I   B, #8       ; Compare register B with immediate value #8
0x958:  37E  JP_NC    0x97E       ; Jump to 0x97E if Carry flag is clear (no overflow)
0x959:  F92  LD_MN_B  0x02        ; Store B into direct RAM address 0x02
0x95A:  F81  LD_MN_A  0x01        ; Store A into direct RAM address 0x01
0x95B:  B3A  LD_X     0x3A        ; Set X pointer to RAM address 0x3A
0x95C:  EE2  UNKNOWN              ; Unrecognized instruction: 0xEE2
0x95D:  EE6  UNKNOWN              ; Unrecognized instruction: 0xEE6
0x95E:  E88  UNKNOWN              ; Unrecognized instruction: 0xE88
0x95F:  E85  UNKNOWN              ; Unrecognized instruction: 0xE85
0x960:  5F5  CALZ     0x9F5       ; Call subroutine at 0x9F5 if Zero flag is set
0x961:  500  CALZ     0x900       ; Call subroutine at 0x900 if Zero flag is set
0x962:  5EF  CALZ     0x9EF       ; Call subroutine at 0x9EF if Zero flag is set
0x963:  B25  LD_X     0x25        ; Set X pointer to RAM address 0x25
0x964:  DA8  UNKNOWN              ; Unrecognized instruction: 0xDA8
0x965:  67E  JP_Z     0x97E       ; Jump to 0x97E if Zero flag is set (result was zero)
0x966:  B3A  LD_X     0x3A        ; Set X pointer to RAM address 0x3A
0x967:  EE2  UNKNOWN              ; Unrecognized instruction: 0xEE2
0x968:  EE6  UNKNOWN              ; Unrecognized instruction: 0xEE6
0x969:  E88  UNKNOWN              ; Unrecognized instruction: 0xE88
0x96A:  E85  UNKNOWN              ; Unrecognized instruction: 0xE85
0x96B:  C0E  ADD_R_I  A, #14      ; Add immediate #14 to register A
0x96C:  E98  UNKNOWN              ; Unrecognized instruction: 0xE98
0x96D:  C51  UNKNOWN              ; Unrecognized instruction: 0xC51
0x96E:  E95  UNKNOWN              ; Unrecognized instruction: 0xE95
0x96F:  5F5  CALZ     0x9F5       ; Call subroutine at 0x9F5 if Zero flag is set
0x970:  E90  UNKNOWN              ; Unrecognized instruction: 0xE90
0x971:  E08  LD_R_I   A, #8       ; Load A with immediate value #8
0x972:  F80  LD_MN_A  0x00        ; Store A into direct RAM address 0x00
0x973:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x974:  EEB  UNKNOWN              ; Unrecognized instruction: 0xEEB
0x975:  EFC  UNKNOWN              ; Unrecognized instruction: 0xEFC
0x976:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x977:  EEB  UNKNOWN              ; Unrecognized instruction: 0xEEB
0x978:  ECC  LD_R_Q   [Y], A      ; Copy value from A into [Y]
0x979:  F5E  RCF                  ; Reset (clear) Carry Flag
0x97A:  A3D  UNKNOWN              ; Unrecognized instruction: 0xA3D
0x97B:  A2F  UNKNOWN              ; Unrecognized instruction: 0xA2F
0x97C:  F70  UNKNOWN              ; Unrecognized instruction: 0xF70
0x97D:  773  JP_NZ    0x973       ; Jump to 0x973 if Zero flag is clear (result was non-zero)
0x97E:  FDF  RET                  ; Return to caller
0x97F:  E47  PSET     7           ; Set NP (New Page) to 7 for the next jump/call
0x980:  461  CALL     0x761       ; Call subroutine at 0x761
0x981:  E44  PSET     4           ; Set NP (New Page) to 4 for the next jump/call
0x982:  465  CALL     0x465       ; Call subroutine at 0x465
0x983:  5EC  CALZ     0x4EC       ; Call subroutine at 0x4EC if Zero flag is set
0x984:  540  CALZ     0x440       ; Call subroutine at 0x440 if Zero flag is set
0x985:  552  CALZ     0x452       ; Call subroutine at 0x452 if Zero flag is set
0x986:  521  CALZ     0x421       ; Call subroutine at 0x421 if Zero flag is set
0x987:  DA2  UNKNOWN              ; Unrecognized instruction: 0xDA2
0x988:  684  JP_Z     0x484       ; Jump to 0x484 if Zero flag is set (result was zero)
0x989:  E45  PSET     5           ; Set NP (New Page) to 5 for the next jump/call
0x98A:  053  JP       0x553       ; Jump to address 0x553
0x98B:  19B  UNKNOWN              ; Unrecognized instruction: 0x19B
0x98C:  19E  UNKNOWN              ; Unrecognized instruction: 0x19E
0x98D:  1B1  UNKNOWN              ; Unrecognized instruction: 0x1B1
0x98E:  1BE  UNKNOWN              ; Unrecognized instruction: 0x1BE
0x98F:  1C3  UNKNOWN              ; Unrecognized instruction: 0x1C3
0x990:  1CE  UNKNOWN              ; Unrecognized instruction: 0x1CE
0x991:  1D3  UNKNOWN              ; Unrecognized instruction: 0x1D3
0x992:  1DC  UNKNOWN              ; Unrecognized instruction: 0x1DC
0x993:  1E5  UNKNOWN              ; Unrecognized instruction: 0x1E5
0x994:  1EC  UNKNOWN              ; Unrecognized instruction: 0x1EC
0x995:  1F1  UNKNOWN              ; Unrecognized instruction: 0x1F1
0x996:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x997:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x998:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x999:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x99A:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x99B:  9CF  LBPX     #CF         ; Load constant #207 into [X]
0x99C:  910  LBPX     #10         ; Load constant #16 into [X]
0x99D:  19B  UNKNOWN              ; Unrecognized instruction: 0x19B
0x99E:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x99F:  112  UNKNOWN              ; Unrecognized instruction: 0x112
0x9A0:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x9A1:  112  UNKNOWN              ; Unrecognized instruction: 0x112
0x9A2:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x9A3:  114  UNKNOWN              ; Unrecognized instruction: 0x114
0x9A4:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x9A5:  112  UNKNOWN              ; Unrecognized instruction: 0x112
0x9A6:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x9A7:  112  UNKNOWN              ; Unrecognized instruction: 0x112
0x9A8:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x9A9:  112  UNKNOWN              ; Unrecognized instruction: 0x112
0x9AA:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x9AB:  114  UNKNOWN              ; Unrecognized instruction: 0x114
0x9AC:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x9AD:  112  UNKNOWN              ; Unrecognized instruction: 0x112
0x9AE:  9C7  LBPX     #C7         ; Load constant #199 into [X]
0x9AF:  908  LBPX     #8          ; Load constant #8 into [X]
0x9B0:  1AE  UNKNOWN              ; Unrecognized instruction: 0x1AE
0x9B1:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x9B2:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0x9B3:  9C1  LBPX     #C1         ; Load constant #193 into [X]
0x9B4:  1FB  UNKNOWN              ; Unrecognized instruction: 0x1FB
0x9B5:  9F0  LBPX     #F0         ; Load constant #240 into [X]
0x9B6:  10C  UNKNOWN              ; Unrecognized instruction: 0x10C
0x9B7:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x9B8:  108  UNKNOWN              ; Unrecognized instruction: 0x108
0x9B9:  9F2  LBPX     #F2         ; Load constant #242 into [X]
0x9BA:  107  UNKNOWN              ; Unrecognized instruction: 0x107
0x9BB:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x9BC:  914  LBPX     #14         ; Load constant #20 into [X]
0x9BD:  1B1  UNKNOWN              ; Unrecognized instruction: 0x1B1
0x9BE:  9C5  LBPX     #C5         ; Load constant #197 into [X]
0x9BF:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0x9C0:  9C1  LBPX     #C1         ; Load constant #193 into [X]
0x9C1:  90E  LBPX     #E          ; Load constant #14 into [X]
0x9C2:  1BE  UNKNOWN              ; Unrecognized instruction: 0x1BE
0x9C3:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x9C4:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0x9C5:  9C2  LBPX     #C2         ; Load constant #194 into [X]
0x9C6:  1FD  UNKNOWN              ; Unrecognized instruction: 0x1FD
0x9C7:  9F3  LBPX     #F3         ; Load constant #243 into [X]
0x9C8:  105  UNKNOWN              ; Unrecognized instruction: 0x105
0x9C9:  9C1  LBPX     #C1         ; Load constant #193 into [X]
0x9CA:  1FD  UNKNOWN              ; Unrecognized instruction: 0x1FD
0x9CB:  9F3  LBPX     #F3         ; Load constant #243 into [X]
0x9CC:  903  LBPX     #3          ; Load constant #3 into [X]
0x9CD:  1C3  UNKNOWN              ; Unrecognized instruction: 0x1C3
0x9CE:  9C5  LBPX     #C5         ; Load constant #197 into [X]
0x9CF:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0x9D0:  9D0  LBPX     #D0         ; Load constant #208 into [X]
0x9D1:  910  LBPX     #10         ; Load constant #16 into [X]
0x9D2:  1CE  UNKNOWN              ; Unrecognized instruction: 0x1CE
0x9D3:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x9D4:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0x9D5:  9C3  LBPX     #C3         ; Load constant #195 into [X]
0x9D6:  1FF  UNKNOWN              ; Unrecognized instruction: 0x1FF
0x9D7:  9F7  LBPX     #F7         ; Load constant #247 into [X]
0x9D8:  103  UNKNOWN              ; Unrecognized instruction: 0x103
0x9D9:  9C2  LBPX     #C2         ; Load constant #194 into [X]
0x9DA:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x9DB:  1D3  UNKNOWN              ; Unrecognized instruction: 0x1D3
0x9DC:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x9DD:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0x9DE:  9C2  LBPX     #C2         ; Load constant #194 into [X]
0x9DF:  1FD  UNKNOWN              ; Unrecognized instruction: 0x1FD
0x9E0:  9F5  LBPX     #F5         ; Load constant #245 into [X]
0x9E1:  105  UNKNOWN              ; Unrecognized instruction: 0x105
0x9E2:  9C1  LBPX     #C1         ; Load constant #193 into [X]
0x9E3:  9FD  LBPX     #FD         ; Load constant #253 into [X]
0x9E4:  1DC  UNKNOWN              ; Unrecognized instruction: 0x1DC
0x9E5:  9C7  LBPX     #C7         ; Load constant #199 into [X]
0x9E6:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0x9E7:  9D3  LBPX     #D3         ; Load constant #211 into [X]
0x9E8:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0x9E9:  9CB  LBPX     #CB         ; Load constant #203 into [X]
0x9EA:  910  LBPX     #10         ; Load constant #16 into [X]
0x9EB:  1E5  UNKNOWN              ; Unrecognized instruction: 0x1E5
0x9EC:  9C7  LBPX     #C7         ; Load constant #199 into [X]
0x9ED:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0x9EE:  9F7  LBPX     #F7         ; Load constant #247 into [X]
0x9EF:  910  LBPX     #10         ; Load constant #16 into [X]
0x9F0:  1EC  UNKNOWN              ; Unrecognized instruction: 0x1EC
0x9F1:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x9F2:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0x9F3:  9C1  LBPX     #C1         ; Load constant #193 into [X]
0x9F4:  112  UNKNOWN              ; Unrecognized instruction: 0x112
0x9F5:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x9F6:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0x9F7:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x9F8:  112  UNKNOWN              ; Unrecognized instruction: 0x112
0x9F9:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x9FA:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0x9FB:  9C1  LBPX     #C1         ; Load constant #193 into [X]
0x9FC:  112  UNKNOWN              ; Unrecognized instruction: 0x112
0x9FD:  9C7  LBPX     #C7         ; Load constant #199 into [X]
0x9FE:  910  LBPX     #10         ; Load constant #16 into [X]
0x9FF:  1FD  UNKNOWN              ; Unrecognized instruction: 0x1FD
0xA00:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA01:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0xA02:  121  UNKNOWN              ; Unrecognized instruction: 0x121
0xA03:  133  UNKNOWN              ; Unrecognized instruction: 0x133
0xA04:  144  UNKNOWN              ; Unrecognized instruction: 0x144
0xA05:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA06:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA07:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA08:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA09:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA0A:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA0B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA0C:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA0D:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA0E:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA0F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA10:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA11:  115  UNKNOWN              ; Unrecognized instruction: 0x115
0xA12:  112  UNKNOWN              ; Unrecognized instruction: 0x112
0xA13:  133  UNKNOWN              ; Unrecognized instruction: 0x133
0xA14:  143  UNKNOWN              ; Unrecognized instruction: 0x143
0xA15:  145  UNKNOWN              ; Unrecognized instruction: 0x145
0xA16:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA17:  141  UNKNOWN              ; Unrecognized instruction: 0x141
0xA18:  161  UNKNOWN              ; Unrecognized instruction: 0x161
0xA19:  113  UNKNOWN              ; Unrecognized instruction: 0x113
0xA1A:  133  UNKNOWN              ; Unrecognized instruction: 0x133
0xA1B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA1C:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA1D:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA1E:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA1F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA20:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA21:  115  UNKNOWN              ; Unrecognized instruction: 0x115
0xA22:  103  UNKNOWN              ; Unrecognized instruction: 0x103
0xA23:  187  UNKNOWN              ; Unrecognized instruction: 0x187
0xA24:  1B9  UNKNOWN              ; Unrecognized instruction: 0x1B9
0xA25:  125  UNKNOWN              ; Unrecognized instruction: 0x125
0xA26:  1A9  UNKNOWN              ; Unrecognized instruction: 0x1A9
0xA27:  1B1  UNKNOWN              ; Unrecognized instruction: 0x1B1
0xA28:  147  UNKNOWN              ; Unrecognized instruction: 0x147
0xA29:  178  UNKNOWN              ; Unrecognized instruction: 0x178
0xA2A:  188  UNKNOWN              ; Unrecognized instruction: 0x188
0xA2B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA2C:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA2D:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA2E:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA2F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA30:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA31:  113  UNKNOWN              ; Unrecognized instruction: 0x113
0xA32:  102  UNKNOWN              ; Unrecognized instruction: 0x102
0xA33:  144  UNKNOWN              ; Unrecognized instruction: 0x144
0xA34:  165  UNKNOWN              ; Unrecognized instruction: 0x165
0xA35:  187  UNKNOWN              ; Unrecognized instruction: 0x187
0xA36:  199  UNKNOWN              ; Unrecognized instruction: 0x199
0xA37:  1A1  UNKNOWN              ; Unrecognized instruction: 0x1A1
0xA38:  1CB  UNKNOWN              ; Unrecognized instruction: 0x1CB
0xA39:  1BB  UNKNOWN              ; Unrecognized instruction: 0x1BB
0xA3A:  1BB  UNKNOWN              ; Unrecognized instruction: 0x1BB
0xA3B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA3C:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA3D:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA3E:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA3F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA40:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA41:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0xA42:  103  UNKNOWN              ; Unrecognized instruction: 0x103
0xA43:  165  UNKNOWN              ; Unrecognized instruction: 0x165
0xA44:  147  UNKNOWN              ; Unrecognized instruction: 0x147
0xA45:  122  UNKNOWN              ; Unrecognized instruction: 0x122
0xA46:  177  UNKNOWN              ; Unrecognized instruction: 0x177
0xA47:  142  UNKNOWN              ; Unrecognized instruction: 0x142
0xA48:  187  UNKNOWN              ; Unrecognized instruction: 0x187
0xA49:  178  UNKNOWN              ; Unrecognized instruction: 0x178
0xA4A:  188  UNKNOWN              ; Unrecognized instruction: 0x188
0xA4B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA4C:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA4D:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA4E:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA4F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA50:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA51:  111  UNKNOWN              ; Unrecognized instruction: 0x111
0xA52:  102  UNKNOWN              ; Unrecognized instruction: 0x102
0xA53:  133  UNKNOWN              ; Unrecognized instruction: 0x133
0xA54:  124  UNKNOWN              ; Unrecognized instruction: 0x124
0xA55:  151  UNKNOWN              ; Unrecognized instruction: 0x151
0xA56:  176  UNKNOWN              ; Unrecognized instruction: 0x176
0xA57:  181  UNKNOWN              ; Unrecognized instruction: 0x181
0xA58:  176  UNKNOWN              ; Unrecognized instruction: 0x176
0xA59:  166  UNKNOWN              ; Unrecognized instruction: 0x166
0xA5A:  166  UNKNOWN              ; Unrecognized instruction: 0x166
0xA5B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA5C:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA5D:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA5E:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA5F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA60:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA61:  121  UNKNOWN              ; Unrecognized instruction: 0x121
0xA62:  103  UNKNOWN              ; Unrecognized instruction: 0x103
0xA63:  144  UNKNOWN              ; Unrecognized instruction: 0x144
0xA64:  135  UNKNOWN              ; Unrecognized instruction: 0x135
0xA65:  111  UNKNOWN              ; Unrecognized instruction: 0x111
0xA66:  185  UNKNOWN              ; Unrecognized instruction: 0x185
0xA67:  160  UNKNOWN              ; Unrecognized instruction: 0x160
0xA68:  175  UNKNOWN              ; Unrecognized instruction: 0x175
0xA69:  175  UNKNOWN              ; Unrecognized instruction: 0x175
0xA6A:  155  UNKNOWN              ; Unrecognized instruction: 0x155
0xA6B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA6C:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA6D:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA6E:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA6F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA70:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA71:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0xA72:  132  UNKNOWN              ; Unrecognized instruction: 0x132
0xA73:  155  UNKNOWN              ; Unrecognized instruction: 0x155
0xA74:  126  UNKNOWN              ; Unrecognized instruction: 0x126
0xA75:  177  UNKNOWN              ; Unrecognized instruction: 0x177
0xA76:  198  UNKNOWN              ; Unrecognized instruction: 0x198
0xA77:  147  UNKNOWN              ; Unrecognized instruction: 0x147
0xA78:  126  UNKNOWN              ; Unrecognized instruction: 0x126
0xA79:  166  UNKNOWN              ; Unrecognized instruction: 0x166
0xA7A:  166  UNKNOWN              ; Unrecognized instruction: 0x166
0xA7B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA7C:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA7D:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA7E:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA7F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA80:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA81:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0xA82:  102  UNKNOWN              ; Unrecognized instruction: 0x102
0xA83:  133  UNKNOWN              ; Unrecognized instruction: 0x133
0xA84:  124  UNKNOWN              ; Unrecognized instruction: 0x124
0xA85:  176  UNKNOWN              ; Unrecognized instruction: 0x176
0xA86:  154  UNKNOWN              ; Unrecognized instruction: 0x154
0xA87:  180  UNKNOWN              ; Unrecognized instruction: 0x180
0xA88:  194  UNKNOWN              ; Unrecognized instruction: 0x194
0xA89:  194  UNKNOWN              ; Unrecognized instruction: 0x194
0xA8A:  144  UNKNOWN              ; Unrecognized instruction: 0x144
0xA8B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA8C:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA8D:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA8E:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA8F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA90:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA91:  121  UNKNOWN              ; Unrecognized instruction: 0x121
0xA92:  143  UNKNOWN              ; Unrecognized instruction: 0x143
0xA93:  155  UNKNOWN              ; Unrecognized instruction: 0x155
0xA94:  136  UNKNOWN              ; Unrecognized instruction: 0x136
0xA95:  187  UNKNOWN              ; Unrecognized instruction: 0x187
0xA96:  196  UNKNOWN              ; Unrecognized instruction: 0x196
0xA97:  13A  UNKNOWN              ; Unrecognized instruction: 0x13A
0xA98:  1BB  UNKNOWN              ; Unrecognized instruction: 0x1BB
0xA99:  15B  UNKNOWN              ; Unrecognized instruction: 0x15B
0xA9A:  1BB  UNKNOWN              ; Unrecognized instruction: 0x1BB
0xA9B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA9C:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA9D:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA9E:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xA9F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xAA0:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xAA1:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0xAA2:  112  UNKNOWN              ; Unrecognized instruction: 0x112
0xAA3:  133  UNKNOWN              ; Unrecognized instruction: 0x133
0xAA4:  124  UNKNOWN              ; Unrecognized instruction: 0x124
0xAA5:  122  UNKNOWN              ; Unrecognized instruction: 0x122
0xAA6:  154  UNKNOWN              ; Unrecognized instruction: 0x154
0xAA7:  122  UNKNOWN              ; Unrecognized instruction: 0x122
0xAA8:  164  UNKNOWN              ; Unrecognized instruction: 0x164
0xAA9:  154  UNKNOWN              ; Unrecognized instruction: 0x154
0xAAA:  144  UNKNOWN              ; Unrecognized instruction: 0x144
0xAAB:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xAAC:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xAAD:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xAAE:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xAAF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xAB0:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xAB1:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0xAB2:  102  UNKNOWN              ; Unrecognized instruction: 0x102
0xAB3:  133  UNKNOWN              ; Unrecognized instruction: 0x133
0xAB4:  121  UNKNOWN              ; Unrecognized instruction: 0x121
0xAB5:  144  UNKNOWN              ; Unrecognized instruction: 0x144
0xAB6:  155  UNKNOWN              ; Unrecognized instruction: 0x155
0xAB7:  144  UNKNOWN              ; Unrecognized instruction: 0x144
0xAB8:  151  UNKNOWN              ; Unrecognized instruction: 0x151
0xAB9:  111  UNKNOWN              ; Unrecognized instruction: 0x111
0xABA:  111  UNKNOWN              ; Unrecognized instruction: 0x111
0xABB:  111  UNKNOWN              ; Unrecognized instruction: 0x111
0xABC:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xABD:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0xABE:  5EF  CALZ     0x5EF       ; Call subroutine at 0x5EF if Zero flag is set
0xABF:  B4B  LD_X     0x4B        ; Set X pointer to RAM address 0x4B
0xAC0:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0xAC1:  C81  UNKNOWN              ; Unrecognized instruction: 0xC81
0xAC2:  D01  UNKNOWN              ; Unrecognized instruction: 0xD01
0xAC3:  B78  LD_X     0x78        ; Set X pointer to RAM address 0x78
0xAC4:  EC8  LD_R_Q   [X], A      ; Copy value from A into [X]
0xAC5:  B90  LD_X     0x90        ; Set X pointer to RAM address 0x90
0xAC6:  E4B  PSET     11          ; Set NP (New Page) to 11 for the next jump/call
0xAC7:  4F0  CALL     0xBF0       ; Call subroutine at 0xBF0
0xAC8:  E1A  LD_R_I   B, #10      ; Load B with immediate value #10
0xAC9:  E4E  PSET     14          ; Set NP (New Page) to 14 for the next jump/call
0xACA:  45A  CALL     0xE5A       ; Call subroutine at 0xE5A
0xACB:  3CF  JP_NC    0xECF       ; Jump to 0xECF if Carry flag is clear (no overflow)
0xACC:  E45  PSET     5           ; Set NP (New Page) to 5 for the next jump/call
0xACD:  717  JP_NZ    0x517       ; Jump to 0x517 if Zero flag is clear (result was non-zero)
0xACE:  0D8  JP       0x5D8       ; Jump to address 0x5D8
0xACF:  5F2  CALZ     0x5F2       ; Call subroutine at 0x5F2 if Zero flag is set
0xAD0:  B4B  LD_X     0x4B        ; Set X pointer to RAM address 0x4B
0xAD1:  DC0  CP_R_I   A, #0       ; Compare register A with immediate value #0
0xAD2:  6D7  JP_Z     0x5D7       ; Jump to 0x5D7 if Zero flag is set (result was zero)
0xAD3:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0xAD4:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0xAD5:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0xAD6:  B05  LD_X     0x05        ; Set X pointer to RAM address 0x05
0xAD7:  E2F  LD_R_I   [X], #15    ; Load [X] with immediate value #15
0xAD8:  E45  PSET     5           ; Set NP (New Page) to 5 for the next jump/call
0xAD9:  01A  JP       0x51A       ; Jump to address 0x51A
0xADA:  5B3  CALZ     0x5B3       ; Call subroutine at 0x5B3 if Zero flag is set
0xADB:  7EE  JP_NZ    0x5EE       ; Jump to 0x5EE if Zero flag is clear (result was non-zero)
0xADC:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0xADD:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0xADE:  B09  LD_X     0x09        ; Set X pointer to RAM address 0x09
0xADF:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0xAE0:  6E9  JP_Z     0x5E9       ; Jump to 0x5E9 if Zero flag is set (result was zero)
0xAE1:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0xAE2:  5EF  CALZ     0x5EF       ; Call subroutine at 0x5EF if Zero flag is set
0xAE3:  B43  LD_X     0x43        ; Set X pointer to RAM address 0x43 (MEM_DISCIPLINE)
0xAE4:  C24  ADD_R_I  [X], #4     ; Add immediate #4 to register [X]
0xAE5:  3E7  JP_NC    0x5E7       ; Jump to 0x5E7 if Carry flag is clear (no overflow)
0xAE6:  E2F  LD_R_I   [X], #15    ; Load [X] with immediate value #15
0xAE7:  8F0  LD_Y     0xF0        ; Set Y pointer to RAM address 0xF0
0xAE8:  5BC  CALZ     0x5BC       ; Call subroutine at 0x5BC if Zero flag is set
0xAE9:  E08  LD_R_I   A, #8       ; Load A with immediate value #8
0xAEA:  E15  LD_R_I   B, #5       ; Load B with immediate value #5
0xAEB:  803  LD_Y     0x03        ; Set Y pointer to RAM address 0x03
0xAEC:  E48  PSET     8           ; Set NP (New Page) to 8 for the next jump/call
0xAED:  4A9  CALL     0x8A9       ; Call subroutine at 0x8A9
0xAEE:  E45  PSET     5           ; Set NP (New Page) to 5 for the next jump/call
0xAEF:  01A  JP       0x51A       ; Jump to address 0x51A
0xAF0:  F80  LD_MN_A  0x00        ; Store A into direct RAM address 0x00
0xAF1:  5EF  CALZ     0x5EF       ; Call subroutine at 0x5EF if Zero flag is set
0xAF2:  B2A  LD_X     0x2A        ; Set X pointer to RAM address 0x2A
0xAF3:  900  LBPX     #0          ; Load constant #0 into [X]
0xAF4:  556  CALZ     0x556       ; Call subroutine at 0x556 if Zero flag is set
0xAF5:  5EF  CALZ     0x5EF       ; Call subroutine at 0x5EF if Zero flag is set
0xAF6:  FA0  LD_A_MN  0x00        ; Load A from direct RAM address 0x00
0xAF7:  B2B  LD_X     0x2B        ; Set X pointer to RAM address 0x2B
0xAF8:  F08  UNKNOWN              ; Unrecognized instruction: 0xF08
0xAF9:  3FF  JP_NC    0x5FF       ; Jump to 0x5FF if Carry flag is clear (no overflow)
0xAFA:  B2A  LD_X     0x2A        ; Set X pointer to RAM address 0x2A
0xAFB:  A89  ADD_R_Q  [X], B      ; Add value of B to register [X]
0xAFC:  EE0  INC_X                ; Increment the X pointer by 1
0xAFD:  C60  UNKNOWN              ; Unrecognized instruction: 0xC60
0xAFE:  0F4  JP       0x5F4       ; Jump to address 0x5F4
0xAFF:  FDF  RET                  ; Return to caller
0xB00:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB01:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB02:  1A1  UNKNOWN              ; Unrecognized instruction: 0x1A1
0xB03:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB04:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB05:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB06:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB07:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB08:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB09:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB0A:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB0B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB0C:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB0D:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB0E:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB0F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB10:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB11:  120  UNKNOWN              ; Unrecognized instruction: 0x120
0xB12:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB13:  130  UNKNOWN              ; Unrecognized instruction: 0x130
0xB14:  111  UNKNOWN              ; Unrecognized instruction: 0x111
0xB15:  102  UNKNOWN              ; Unrecognized instruction: 0x102
0xB16:  105  UNKNOWN              ; Unrecognized instruction: 0x105
0xB17:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB18:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB19:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB1A:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB1B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB1C:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB1D:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB1E:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB1F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB20:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB21:  140  UNKNOWN              ; Unrecognized instruction: 0x140
0xB22:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB23:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB24:  111  UNKNOWN              ; Unrecognized instruction: 0x111
0xB25:  102  UNKNOWN              ; Unrecognized instruction: 0x102
0xB26:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB27:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB28:  103  UNKNOWN              ; Unrecognized instruction: 0x103
0xB29:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB2A:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB2B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB2C:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB2D:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB2E:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB2F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB30:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB31:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB32:  107  UNKNOWN              ; Unrecognized instruction: 0x107
0xB33:  151  UNKNOWN              ; Unrecognized instruction: 0x151
0xB34:  111  UNKNOWN              ; Unrecognized instruction: 0x111
0xB35:  102  UNKNOWN              ; Unrecognized instruction: 0x102
0xB36:  105  UNKNOWN              ; Unrecognized instruction: 0x105
0xB37:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB38:  106  UNKNOWN              ; Unrecognized instruction: 0x106
0xB39:  105  UNKNOWN              ; Unrecognized instruction: 0x105
0xB3A:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB3B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB3C:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB3D:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB3E:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB3F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB40:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB41:  160  UNKNOWN              ; Unrecognized instruction: 0x160
0xB42:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB43:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB44:  111  UNKNOWN              ; Unrecognized instruction: 0x111
0xB45:  104  UNKNOWN              ; Unrecognized instruction: 0x104
0xB46:  105  UNKNOWN              ; Unrecognized instruction: 0x105
0xB47:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB48:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB49:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB4A:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB4B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB4C:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB4D:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB4E:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB4F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB50:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB51:  105  UNKNOWN              ; Unrecognized instruction: 0x105
0xB52:  107  UNKNOWN              ; Unrecognized instruction: 0x107
0xB53:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB54:  111  UNKNOWN              ; Unrecognized instruction: 0x111
0xB55:  102  UNKNOWN              ; Unrecognized instruction: 0x102
0xB56:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB57:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB58:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB59:  105  UNKNOWN              ; Unrecognized instruction: 0x105
0xB5A:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB5B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB5C:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB5D:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB5E:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB5F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB60:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB61:  170  UNKNOWN              ; Unrecognized instruction: 0x170
0xB62:  107  UNKNOWN              ; Unrecognized instruction: 0x107
0xB63:  180  UNKNOWN              ; Unrecognized instruction: 0x180
0xB64:  111  UNKNOWN              ; Unrecognized instruction: 0x111
0xB65:  104  UNKNOWN              ; Unrecognized instruction: 0x104
0xB66:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB67:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB68:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB69:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB6A:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB6B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB6C:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB6D:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB6E:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB6F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB70:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB71:  170  UNKNOWN              ; Unrecognized instruction: 0x170
0xB72:  107  UNKNOWN              ; Unrecognized instruction: 0x107
0xB73:  150  UNKNOWN              ; Unrecognized instruction: 0x150
0xB74:  111  UNKNOWN              ; Unrecognized instruction: 0x111
0xB75:  104  UNKNOWN              ; Unrecognized instruction: 0x104
0xB76:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB77:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB78:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB79:  105  UNKNOWN              ; Unrecognized instruction: 0x105
0xB7A:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB7B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB7C:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB7D:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB7E:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB7F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB80:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB81:  140  UNKNOWN              ; Unrecognized instruction: 0x140
0xB82:  107  UNKNOWN              ; Unrecognized instruction: 0x107
0xB83:  150  UNKNOWN              ; Unrecognized instruction: 0x150
0xB84:  111  UNKNOWN              ; Unrecognized instruction: 0x111
0xB85:  102  UNKNOWN              ; Unrecognized instruction: 0x102
0xB86:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB87:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB88:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB89:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB8A:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB8B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB8C:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB8D:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB8E:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB8F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB90:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB91:  160  UNKNOWN              ; Unrecognized instruction: 0x160
0xB92:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB93:  180  UNKNOWN              ; Unrecognized instruction: 0x180
0xB94:  111  UNKNOWN              ; Unrecognized instruction: 0x111
0xB95:  102  UNKNOWN              ; Unrecognized instruction: 0x102
0xB96:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB97:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB98:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB99:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB9A:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB9B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB9C:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB9D:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB9E:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xB9F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xBA0:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xBA1:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xBA2:  107  UNKNOWN              ; Unrecognized instruction: 0x107
0xBA3:  150  UNKNOWN              ; Unrecognized instruction: 0x150
0xBA4:  111  UNKNOWN              ; Unrecognized instruction: 0x111
0xBA5:  104  UNKNOWN              ; Unrecognized instruction: 0x104
0xBA6:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xBA7:  105  UNKNOWN              ; Unrecognized instruction: 0x105
0xBA8:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xBA9:  105  UNKNOWN              ; Unrecognized instruction: 0x105
0xBAA:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xBAB:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xBAC:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xBAD:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xBAE:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xBAF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xBB0:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xBB1:  190  UNKNOWN              ; Unrecognized instruction: 0x190
0xBB2:  107  UNKNOWN              ; Unrecognized instruction: 0x107
0xBB3:  150  UNKNOWN              ; Unrecognized instruction: 0x150
0xBB4:  111  UNKNOWN              ; Unrecognized instruction: 0x111
0xBB5:  104  UNKNOWN              ; Unrecognized instruction: 0x104
0xBB6:  105  UNKNOWN              ; Unrecognized instruction: 0x105
0xBB7:  105  UNKNOWN              ; Unrecognized instruction: 0x105
0xBB8:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xBB9:  105  UNKNOWN              ; Unrecognized instruction: 0x105
0xBBA:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xBBB:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xBBC:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xBBD:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xBBE:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xBBF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xBC0:  1CA  UNKNOWN              ; Unrecognized instruction: 0x1CA
0xBC1:  1CD  UNKNOWN              ; Unrecognized instruction: 0x1CD
0xBC2:  1D0  UNKNOWN              ; Unrecognized instruction: 0x1D0
0xBC3:  1D3  UNKNOWN              ; Unrecognized instruction: 0x1D3
0xBC4:  1D8  UNKNOWN              ; Unrecognized instruction: 0x1D8
0xBC5:  1DB  UNKNOWN              ; Unrecognized instruction: 0x1DB
0xBC6:  1DE  UNKNOWN              ; Unrecognized instruction: 0x1DE
0xBC7:  1E3  UNKNOWN              ; Unrecognized instruction: 0x1E3
0xBC8:  1E8  UNKNOWN              ; Unrecognized instruction: 0x1E8
0xBC9:  1E8  UNKNOWN              ; Unrecognized instruction: 0x1E8
0xBCA:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0xBCB:  931  LBPX     #31         ; Load constant #49 into [X]
0xBCC:  1CA  UNKNOWN              ; Unrecognized instruction: 0x1CA
0xBCD:  107  UNKNOWN              ; Unrecognized instruction: 0x107
0xBCE:  937  LBPX     #37         ; Load constant #55 into [X]
0xBCF:  1CE  UNKNOWN              ; Unrecognized instruction: 0x1CE
0xBD0:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xBD1:  930  LBPX     #30         ; Load constant #48 into [X]
0xBD2:  1D0  UNKNOWN              ; Unrecognized instruction: 0x1D0
0xBD3:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0xBD4:  131  UNKNOWN              ; Unrecognized instruction: 0x131
0xBD5:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0xBD6:  9F1  LBPX     #F1         ; Load constant #241 into [X]
0xBD7:  1D3  UNKNOWN              ; Unrecognized instruction: 0x1D3
0xBD8:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xBD9:  9F0  LBPX     #F0         ; Load constant #240 into [X]
0xBDA:  1D8  UNKNOWN              ; Unrecognized instruction: 0x1D8
0xBDB:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0xBDC:  9F1  LBPX     #F1         ; Load constant #241 into [X]
0xBDD:  1DB  UNKNOWN              ; Unrecognized instruction: 0x1DB
0xBDE:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0xBDF:  131  UNKNOWN              ; Unrecognized instruction: 0x131
0xBE0:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0xBE1:  9B1  LBPX     #B1         ; Load constant #177 into [X]
0xBE2:  1DE  UNKNOWN              ; Unrecognized instruction: 0x1DE
0xBE3:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0xBE4:  131  UNKNOWN              ; Unrecognized instruction: 0x131
0xBE5:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0xBE6:  931  LBPX     #31         ; Load constant #49 into [X]
0xBE7:  1E6  UNKNOWN              ; Unrecognized instruction: 0x1E6
0xBE8:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0xBE9:  928  LBPX     #28         ; Load constant #40 into [X]
0xBEA:  929  LBPX     #29         ; Load constant #41 into [X]
0xBEB:  92A  LBPX     #2A         ; Load constant #42 into [X]
0xBEC:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0xBED:  92B  LBPX     #2B         ; Load constant #43 into [X]
0xBEE:  92C  LBPX     #2C         ; Load constant #44 into [X]
0xBEF:  12D  UNKNOWN              ; Unrecognized instruction: 0x12D
0xBF0:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0xBF1:  938  LBPX     #38         ; Load constant #56 into [X]
0xBF2:  939  LBPX     #39         ; Load constant #57 into [X]
0xBF3:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0xBF4:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0xBF5:  90E  LBPX     #E          ; Load constant #14 into [X]
0xBF6:  917  LBPX     #17         ; Load constant #23 into [X]
0xBF7:  1FF  UNKNOWN              ; Unrecognized instruction: 0x1FF
0xBF8:  931  LBPX     #31         ; Load constant #49 into [X]
0xBF9:  932  LBPX     #32         ; Load constant #50 into [X]
0xBFA:  933  LBPX     #33         ; Load constant #51 into [X]
0xBFB:  1FF  UNKNOWN              ; Unrecognized instruction: 0x1FF
0xBFC:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0xBFD:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0xBFE:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0xBFF:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0xC00:  10C  UNKNOWN              ; Unrecognized instruction: 0x10C
0xC01:  111  UNKNOWN              ; Unrecognized instruction: 0x111
0xC02:  118  UNKNOWN              ; Unrecognized instruction: 0x118
0xC03:  124  UNKNOWN              ; Unrecognized instruction: 0x124
0xC04:  131  UNKNOWN              ; Unrecognized instruction: 0x131
0xC05:  13A  UNKNOWN              ; Unrecognized instruction: 0x13A
0xC06:  143  UNKNOWN              ; Unrecognized instruction: 0x143
0xC07:  14C  UNKNOWN              ; Unrecognized instruction: 0x14C
0xC08:  156  UNKNOWN              ; Unrecognized instruction: 0x156
0xC09:  160  UNKNOWN              ; Unrecognized instruction: 0x160
0xC0A:  16C  UNKNOWN              ; Unrecognized instruction: 0x16C
0xC0B:  173  UNKNOWN              ; Unrecognized instruction: 0x173
0xC0C:  143  UNKNOWN              ; Unrecognized instruction: 0x143
0xC0D:  145  UNKNOWN              ; Unrecognized instruction: 0x145
0xC0E:  147  UNKNOWN              ; Unrecognized instruction: 0x147
0xC0F:  149  UNKNOWN              ; Unrecognized instruction: 0x149
0xC10:  14B  UNKNOWN              ; Unrecognized instruction: 0x14B
0xC11:  17F  UNKNOWN              ; Unrecognized instruction: 0x17F
0xC12:  17F  UNKNOWN              ; Unrecognized instruction: 0x17F
0xC13:  17F  UNKNOWN              ; Unrecognized instruction: 0x17F
0xC14:  17F  UNKNOWN              ; Unrecognized instruction: 0x17F
0xC15:  17F  UNKNOWN              ; Unrecognized instruction: 0x17F
0xC16:  17F  UNKNOWN              ; Unrecognized instruction: 0x17F
0xC17:  17F  UNKNOWN              ; Unrecognized instruction: 0x17F
0xC18:  10C  UNKNOWN              ; Unrecognized instruction: 0x10C
0xC19:  109  UNKNOWN              ; Unrecognized instruction: 0x109
0xC1A:  109  UNKNOWN              ; Unrecognized instruction: 0x109
0xC1B:  10A  UNKNOWN              ; Unrecognized instruction: 0x10A
0xC1C:  10A  UNKNOWN              ; Unrecognized instruction: 0x10A
0xC1D:  107  UNKNOWN              ; Unrecognized instruction: 0x107
0xC1E:  18C  UNKNOWN              ; Unrecognized instruction: 0x18C
0xC1F:  10D  UNKNOWN              ; Unrecognized instruction: 0x10D
0xC20:  10D  UNKNOWN              ; Unrecognized instruction: 0x10D
0xC21:  10F  UNKNOWN              ; Unrecognized instruction: 0x10F
0xC22:  18F  UNKNOWN              ; Unrecognized instruction: 0x18F
0xC23:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0xC24:  10C  UNKNOWN              ; Unrecognized instruction: 0x10C
0xC25:  109  UNKNOWN              ; Unrecognized instruction: 0x109
0xC26:  10A  UNKNOWN              ; Unrecognized instruction: 0x10A
0xC27:  111  UNKNOWN              ; Unrecognized instruction: 0x111
0xC28:  10D  UNKNOWN              ; Unrecognized instruction: 0x10D
0xC29:  10F  UNKNOWN              ; Unrecognized instruction: 0x10F
0xC2A:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0xC2B:  111  UNKNOWN              ; Unrecognized instruction: 0x111
0xC2C:  109  UNKNOWN              ; Unrecognized instruction: 0x109
0xC2D:  10F  UNKNOWN              ; Unrecognized instruction: 0x10F
0xC2E:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0xC2F:  10D  UNKNOWN              ; Unrecognized instruction: 0x10D
0xC30:  10A  UNKNOWN              ; Unrecognized instruction: 0x10A
0xC31:  117  UNKNOWN              ; Unrecognized instruction: 0x117
0xC32:  118  UNKNOWN              ; Unrecognized instruction: 0x118
0xC33:  118  UNKNOWN              ; Unrecognized instruction: 0x118
0xC34:  119  UNKNOWN              ; Unrecognized instruction: 0x119
0xC35:  119  UNKNOWN              ; Unrecognized instruction: 0x119
0xC36:  11A  UNKNOWN              ; Unrecognized instruction: 0x11A
0xC37:  11A  UNKNOWN              ; Unrecognized instruction: 0x11A
0xC38:  19A  UNKNOWN              ; Unrecognized instruction: 0x19A
0xC39:  19A  UNKNOWN              ; Unrecognized instruction: 0x19A
0xC3A:  120  UNKNOWN              ; Unrecognized instruction: 0x120
0xC3B:  1A2  UNKNOWN              ; Unrecognized instruction: 0x1A2
0xC3C:  124  UNKNOWN              ; Unrecognized instruction: 0x124
0xC3D:  1A6  UNKNOWN              ; Unrecognized instruction: 0x1A6
0xC3E:  1A6  UNKNOWN              ; Unrecognized instruction: 0x1A6
0xC3F:  122  UNKNOWN              ; Unrecognized instruction: 0x122
0xC40:  1A6  UNKNOWN              ; Unrecognized instruction: 0x1A6
0xC41:  126  UNKNOWN              ; Unrecognized instruction: 0x126
0xC42:  124  UNKNOWN              ; Unrecognized instruction: 0x124
0xC43:  127  UNKNOWN              ; Unrecognized instruction: 0x127
0xC44:  128  UNKNOWN              ; Unrecognized instruction: 0x128
0xC45:  129  UNKNOWN              ; Unrecognized instruction: 0x129
0xC46:  12B  UNKNOWN              ; Unrecognized instruction: 0x12B
0xC47:  12C  UNKNOWN              ; Unrecognized instruction: 0x12C
0xC48:  1AC  UNKNOWN              ; Unrecognized instruction: 0x1AC
0xC49:  12B  UNKNOWN              ; Unrecognized instruction: 0x12B
0xC4A:  1AC  UNKNOWN              ; Unrecognized instruction: 0x1AC
0xC4B:  12C  UNKNOWN              ; Unrecognized instruction: 0x12C
0xC4C:  12D  UNKNOWN              ; Unrecognized instruction: 0x12D
0xC4D:  12D  UNKNOWN              ; Unrecognized instruction: 0x12D
0xC4E:  130  UNKNOWN              ; Unrecognized instruction: 0x130
0xC4F:  131  UNKNOWN              ; Unrecognized instruction: 0x131
0xC50:  130  UNKNOWN              ; Unrecognized instruction: 0x130
0xC51:  132  UNKNOWN              ; Unrecognized instruction: 0x132
0xC52:  132  UNKNOWN              ; Unrecognized instruction: 0x132
0xC53:  133  UNKNOWN              ; Unrecognized instruction: 0x133
0xC54:  134  UNKNOWN              ; Unrecognized instruction: 0x134
0xC55:  1B4  UNKNOWN              ; Unrecognized instruction: 0x1B4
0xC56:  117  UNKNOWN              ; Unrecognized instruction: 0x117
0xC57:  118  UNKNOWN              ; Unrecognized instruction: 0x118
0xC58:  119  UNKNOWN              ; Unrecognized instruction: 0x119
0xC59:  11A  UNKNOWN              ; Unrecognized instruction: 0x11A
0xC5A:  19A  UNKNOWN              ; Unrecognized instruction: 0x19A
0xC5B:  11A  UNKNOWN              ; Unrecognized instruction: 0x11A
0xC5C:  1B8  UNKNOWN              ; Unrecognized instruction: 0x1B8
0xC5D:  138  UNKNOWN              ; Unrecognized instruction: 0x138
0xC5E:  119  UNKNOWN              ; Unrecognized instruction: 0x119
0xC5F:  19A  UNKNOWN              ; Unrecognized instruction: 0x19A
0xC60:  117  UNKNOWN              ; Unrecognized instruction: 0x117
0xC61:  117  UNKNOWN              ; Unrecognized instruction: 0x117
0xC62:  118  UNKNOWN              ; Unrecognized instruction: 0x118
0xC63:  119  UNKNOWN              ; Unrecognized instruction: 0x119
0xC64:  117  UNKNOWN              ; Unrecognized instruction: 0x117
0xC65:  11A  UNKNOWN              ; Unrecognized instruction: 0x11A
0xC66:  19A  UNKNOWN              ; Unrecognized instruction: 0x19A
0xC67:  118  UNKNOWN              ; Unrecognized instruction: 0x118
0xC68:  198  UNKNOWN              ; Unrecognized instruction: 0x198
0xC69:  197  UNKNOWN              ; Unrecognized instruction: 0x197
0xC6A:  198  UNKNOWN              ; Unrecognized instruction: 0x198
0xC6B:  19A  UNKNOWN              ; Unrecognized instruction: 0x19A
0xC6C:  135  UNKNOWN              ; Unrecognized instruction: 0x135
0xC6D:  135  UNKNOWN              ; Unrecognized instruction: 0x135
0xC6E:  136  UNKNOWN              ; Unrecognized instruction: 0x136
0xC6F:  137  UNKNOWN              ; Unrecognized instruction: 0x137
0xC70:  137  UNKNOWN              ; Unrecognized instruction: 0x137
0xC71:  1B7  UNKNOWN              ; Unrecognized instruction: 0x1B7
0xC72:  137  UNKNOWN              ; Unrecognized instruction: 0x137
0xC73:  13C  UNKNOWN              ; Unrecognized instruction: 0x13C
0xC74:  13E  UNKNOWN              ; Unrecognized instruction: 0x13E
0xC75:  140  UNKNOWN              ; Unrecognized instruction: 0x140
0xC76:  141  UNKNOWN              ; Unrecognized instruction: 0x141
0xC77:  142  UNKNOWN              ; Unrecognized instruction: 0x142
0xC78:  141  UNKNOWN              ; Unrecognized instruction: 0x141
0xC79:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0xC7A:  F5B  RDF                  ; Reset (clear) Decimal Flag
0xC7B:  B7C  LD_X     0x7C        ; Set X pointer to RAM address 0x7C
0xC7C:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0xC7D:  681  JP_Z     0x581       ; Jump to 0x581 if Zero flag is set (result was zero)
0xC7E:  DEF  CP_R_I   [X], #15    ; Compare register [X] with immediate value #15
0xC7F:  682  JP_Z     0x582       ; Jump to 0x582 if Zero flag is set (result was zero)
0xC80:  C2F  ADD_R_I  [X], #15    ; Add immediate #15 to register [X]
0xC81:  FDF  RET                  ; Return to caller
0xC82:  B4A  LD_X     0x4A        ; Set X pointer to RAM address 0x4A (MEM_SLEEPING)
0xC83:  DA8  UNKNOWN              ; Unrecognized instruction: 0xDA8
0xC84:  696  JP_Z     0x596       ; Jump to 0x596 if Zero flag is set (result was zero)
0xC85:  5F8  CALZ     0x5F8       ; Call subroutine at 0x5F8 if Zero flag is set
0xC86:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0xC87:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0xC88:  78E  JP_NZ    0x58E       ; Jump to 0x58E if Zero flag is clear (result was non-zero)
0xC89:  B15  LD_X     0x15        ; Set X pointer to RAM address 0x15
0xC8A:  C2F  ADD_R_I  [X], #15    ; Add immediate #15 to register [X]
0xC8B:  28D  JP_C     0x58D       ; Jump to 0x58D if Carry flag is set (overflow occurred)
0xC8C:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0xC8D:  FDF  RET                  ; Return to caller
0xC8E:  B04  LD_X     0x04        ; Set X pointer to RAM address 0x04
0xC8F:  C21  ADD_R_I  [X], #1     ; Add immediate #1 to register [X]
0xC90:  EE0  INC_X                ; Increment the X pointer by 1
0xC91:  C60  UNKNOWN              ; Unrecognized instruction: 0xC60
0xC92:  395  JP_NC    0x595       ; Jump to 0x595 if Carry flag is clear (no overflow)
0xC93:  B04  LD_X     0x04        ; Set X pointer to RAM address 0x04
0xC94:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0xC95:  FDF  RET                  ; Return to caller
0xC96:  5F8  CALZ     0x5F8       ; Call subroutine at 0x5F8 if Zero flag is set
0xC97:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0xC98:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0xC99:  7A1  JP_NZ    0x5A1       ; Jump to 0x5A1 if Zero flag is clear (result was non-zero)
0xC9A:  B16  LD_X     0x16        ; Set X pointer to RAM address 0x16
0xC9B:  C2F  ADD_R_I  [X], #15    ; Add immediate #15 to register [X]
0xC9C:  EE0  INC_X                ; Increment the X pointer by 1
0xC9D:  C6F  UNKNOWN              ; Unrecognized instruction: 0xC6F
0xC9E:  2A1  JP_C     0x5A1       ; Jump to 0x5A1 if Carry flag is set (overflow occurred)
0xC9F:  B16  LD_X     0x16        ; Set X pointer to RAM address 0x16
0xCA0:  900  LBPX     #0          ; Load constant #0 into [X]
0xCA1:  B00  LD_X     0x00        ; Set X pointer to RAM address 0x00
0xCA2:  4D2  CALL     0x5D2       ; Call subroutine at 0x5D2
0xCA3:  B02  LD_X     0x02        ; Set X pointer to RAM address 0x02
0xCA4:  4D2  CALL     0x5D2       ; Call subroutine at 0x5D2
0xCA5:  B08  LD_X     0x08        ; Set X pointer to RAM address 0x08
0xCA6:  4D9  CALL     0x5D9       ; Call subroutine at 0x5D9
0xCA7:  B09  LD_X     0x09        ; Set X pointer to RAM address 0x09
0xCA8:  4D9  CALL     0x5D9       ; Call subroutine at 0x5D9
0xCA9:  B06  LD_X     0x06        ; Set X pointer to RAM address 0x06
0xCAA:  4D2  CALL     0x5D2       ; Call subroutine at 0x5D2
0xCAB:  5EF  CALZ     0x5EF       ; Call subroutine at 0x5EF if Zero flag is set
0xCAC:  B40  LD_X     0x40        ; Set X pointer to RAM address 0x40 (MEM_HUNGER)
0xCAD:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0xCAE:  6B8  JP_Z     0x5B8       ; Jump to 0x5B8 if Zero flag is set (result was zero)
0xCAF:  B41  LD_X     0x41        ; Set X pointer to RAM address 0x41 (MEM_HAPPY)
0xCB0:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0xCB1:  6B8  JP_Z     0x5B8       ; Jump to 0x5B8 if Zero flag is set (result was zero)
0xCB2:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0xCB3:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0xCB4:  B0A  LD_X     0x0A        ; Set X pointer to RAM address 0x0A
0xCB5:  900  LBPX     #0          ; Load constant #0 into [X]
0xCB6:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0xCB7:  0BC  JP       0x5BC       ; Jump to address 0x5BC
0xCB8:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0xCB9:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0xCBA:  B0A  LD_X     0x0A        ; Set X pointer to RAM address 0x0A
0xCBB:  4DF  CALL     0x5DF       ; Call subroutine at 0x5DF
0xCBC:  5FB  CALZ     0x5FB       ; Call subroutine at 0x5FB if Zero flag is set
0xCBD:  6C3  JP_Z     0x5C3       ; Jump to 0x5C3 if Zero flag is set (result was zero)
0xCBE:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0xCBF:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0xCC0:  B0D  LD_X     0x0D        ; Set X pointer to RAM address 0x0D
0xCC1:  4DF  CALL     0x5DF       ; Call subroutine at 0x5DF
0xCC2:  0C7  JP       0x5C7       ; Jump to address 0x5C7
0xCC3:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0xCC4:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0xCC5:  B0D  LD_X     0x0D        ; Set X pointer to RAM address 0x0D
0xCC6:  4C8  CALL     0x5C8       ; Call subroutine at 0x5C8
0xCC7:  B10  LD_X     0x10        ; Set X pointer to RAM address 0x10
0xCC8:  C2F  ADD_R_I  [X], #15    ; Add immediate #15 to register [X]
0xCC9:  EE0  INC_X                ; Increment the X pointer by 1
0xCCA:  C6F  UNKNOWN              ; Unrecognized instruction: 0xC6F
0xCCB:  EE0  INC_X                ; Increment the X pointer by 1
0xCCC:  C6F  UNKNOWN              ; Unrecognized instruction: 0xC6F
0xCCD:  2D1  JP_C     0x5D1       ; Jump to 0x5D1 if Carry flag is set (overflow occurred)
0xCCE:  A1E  UNKNOWN              ; Unrecognized instruction: 0xA1E
0xCCF:  900  LBPX     #0          ; Load constant #0 into [X]
0xCD0:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0xCD1:  FDF  RET                  ; Return to caller
0xCD2:  C2F  ADD_R_I  [X], #15    ; Add immediate #15 to register [X]
0xCD3:  EE0  INC_X                ; Increment the X pointer by 1
0xCD4:  C6F  UNKNOWN              ; Unrecognized instruction: 0xC6F
0xCD5:  2D8  JP_C     0x5D8       ; Jump to 0x5D8 if Carry flag is set (overflow occurred)
0xCD6:  A1F  UNKNOWN              ; Unrecognized instruction: 0xA1F
0xCD7:  900  LBPX     #0          ; Load constant #0 into [X]
0xCD8:  FDF  RET                  ; Return to caller
0xCD9:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0xCDA:  6DE  JP_Z     0x5DE       ; Jump to 0x5DE if Zero flag is set (result was zero)
0xCDB:  C21  ADD_R_I  [X], #1     ; Add immediate #1 to register [X]
0xCDC:  3DE  JP_NC    0x5DE       ; Jump to 0x5DE if Carry flag is clear (no overflow)
0xCDD:  E2F  LD_R_I   [X], #15    ; Load [X] with immediate value #15
0xCDE:  FDF  RET                  ; Return to caller
0xCDF:  C21  ADD_R_I  [X], #1     ; Add immediate #1 to register [X]
0xCE0:  EE0  INC_X                ; Increment the X pointer by 1
0xCE1:  C60  UNKNOWN              ; Unrecognized instruction: 0xC60
0xCE2:  EE0  INC_X                ; Increment the X pointer by 1
0xCE3:  C60  UNKNOWN              ; Unrecognized instruction: 0xC60
0xCE4:  FDF  RET                  ; Return to caller
0xCE5:  C24  ADD_R_I  [X], #4     ; Add immediate #4 to register [X]
0xCE6:  3E8  JP_NC    0x5E8       ; Jump to 0x5E8 if Carry flag is clear (no overflow)
0xCE7:  E2F  LD_R_I   [X], #15    ; Load [X] with immediate value #15
0xCE8:  B40  LD_X     0x40        ; Set X pointer to RAM address 0x40 (MEM_HUNGER)
0xCE9:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0xCEA:  6F4  JP_Z     0x5F4       ; Jump to 0x5F4 if Zero flag is set (result was zero)
0xCEB:  B41  LD_X     0x41        ; Set X pointer to RAM address 0x41 (MEM_HAPPY)
0xCEC:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0xCED:  6F4  JP_Z     0x5F4       ; Jump to 0x5F4 if Zero flag is set (result was zero)
0xCEE:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0xCEF:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0xCF0:  B08  LD_X     0x08        ; Set X pointer to RAM address 0x08
0xCF1:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0xCF2:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0xCF3:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0xCF4:  FDF  RET                  ; Return to caller
0xCF5:  918  LBPX     #18         ; Load constant #24 into [X]
0xCF6:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0xCF7:  91D  LBPX     #1D         ; Load constant #29 into [X]
0xCF8:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0xCF9:  900  LBPX     #0          ; Load constant #0 into [X]
0xCFA:  90F  LBPX     #F          ; Load constant #15 into [X]
0xCFB:  900  LBPX     #0          ; Load constant #0 into [X]
0xCFC:  1FF  UNKNOWN              ; Unrecognized instruction: 0x1FF
0xCFD:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0xCFE:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0xCFF:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0xD00:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0xD01:  115  UNKNOWN              ; Unrecognized instruction: 0x115
0xD02:  11C  UNKNOWN              ; Unrecognized instruction: 0x11C
0xD03:  128  UNKNOWN              ; Unrecognized instruction: 0x128
0xD04:  135  UNKNOWN              ; Unrecognized instruction: 0x135
0xD05:  13E  UNKNOWN              ; Unrecognized instruction: 0x13E
0xD06:  147  UNKNOWN              ; Unrecognized instruction: 0x147
0xD07:  150  UNKNOWN              ; Unrecognized instruction: 0x150
0xD08:  15A  UNKNOWN              ; Unrecognized instruction: 0x15A
0xD09:  164  UNKNOWN              ; Unrecognized instruction: 0x164
0xD0A:  170  UNKNOWN              ; Unrecognized instruction: 0x170
0xD0B:  177  UNKNOWN              ; Unrecognized instruction: 0x177
0xD0C:  17D  UNKNOWN              ; Unrecognized instruction: 0x17D
0xD0D:  17D  UNKNOWN              ; Unrecognized instruction: 0x17D
0xD0E:  17D  UNKNOWN              ; Unrecognized instruction: 0x17D
0xD0F:  17D  UNKNOWN              ; Unrecognized instruction: 0x17D
0xD10:  144  UNKNOWN              ; Unrecognized instruction: 0x144
0xD11:  146  UNKNOWN              ; Unrecognized instruction: 0x146
0xD12:  148  UNKNOWN              ; Unrecognized instruction: 0x148
0xD13:  14A  UNKNOWN              ; Unrecognized instruction: 0x14A
0xD14:  14C  UNKNOWN              ; Unrecognized instruction: 0x14C
0xD15:  105  UNKNOWN              ; Unrecognized instruction: 0x105
0xD16:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0xD17:  102  UNKNOWN              ; Unrecognized instruction: 0x102
0xD18:  103  UNKNOWN              ; Unrecognized instruction: 0x103
0xD19:  104  UNKNOWN              ; Unrecognized instruction: 0x104
0xD1A:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xD1B:  106  UNKNOWN              ; Unrecognized instruction: 0x106
0xD1C:  108  UNKNOWN              ; Unrecognized instruction: 0x108
0xD1D:  10B  UNKNOWN              ; Unrecognized instruction: 0x10B
0xD1E:  108  UNKNOWN              ; Unrecognized instruction: 0x108
0xD1F:  108  UNKNOWN              ; Unrecognized instruction: 0x108
0xD20:  10B  UNKNOWN              ; Unrecognized instruction: 0x10B
0xD21:  108  UNKNOWN              ; Unrecognized instruction: 0x108
0xD22:  108  UNKNOWN              ; Unrecognized instruction: 0x108
0xD23:  108  UNKNOWN              ; Unrecognized instruction: 0x108
0xD24:  10B  UNKNOWN              ; Unrecognized instruction: 0x10B
0xD25:  108  UNKNOWN              ; Unrecognized instruction: 0x108
0xD26:  108  UNKNOWN              ; Unrecognized instruction: 0x108
0xD27:  10B  UNKNOWN              ; Unrecognized instruction: 0x10B
0xD28:  114  UNKNOWN              ; Unrecognized instruction: 0x114
0xD29:  192  UNKNOWN              ; Unrecognized instruction: 0x192
0xD2A:  113  UNKNOWN              ; Unrecognized instruction: 0x113
0xD2B:  112  UNKNOWN              ; Unrecognized instruction: 0x112
0xD2C:  115  UNKNOWN              ; Unrecognized instruction: 0x115
0xD2D:  113  UNKNOWN              ; Unrecognized instruction: 0x113
0xD2E:  112  UNKNOWN              ; Unrecognized instruction: 0x112
0xD2F:  113  UNKNOWN              ; Unrecognized instruction: 0x113
0xD30:  193  UNKNOWN              ; Unrecognized instruction: 0x193
0xD31:  112  UNKNOWN              ; Unrecognized instruction: 0x112
0xD32:  116  UNKNOWN              ; Unrecognized instruction: 0x116
0xD33:  112  UNKNOWN              ; Unrecognized instruction: 0x112
0xD34:  192  UNKNOWN              ; Unrecognized instruction: 0x192
0xD35:  108  UNKNOWN              ; Unrecognized instruction: 0x108
0xD36:  10B  UNKNOWN              ; Unrecognized instruction: 0x10B
0xD37:  108  UNKNOWN              ; Unrecognized instruction: 0x108
0xD38:  108  UNKNOWN              ; Unrecognized instruction: 0x108
0xD39:  10B  UNKNOWN              ; Unrecognized instruction: 0x10B
0xD3A:  108  UNKNOWN              ; Unrecognized instruction: 0x108
0xD3B:  10B  UNKNOWN              ; Unrecognized instruction: 0x10B
0xD3C:  108  UNKNOWN              ; Unrecognized instruction: 0x108
0xD3D:  10B  UNKNOWN              ; Unrecognized instruction: 0x10B
0xD3E:  121  UNKNOWN              ; Unrecognized instruction: 0x121
0xD3F:  1A3  UNKNOWN              ; Unrecognized instruction: 0x1A3
0xD40:  125  UNKNOWN              ; Unrecognized instruction: 0x125
0xD41:  115  UNKNOWN              ; Unrecognized instruction: 0x115
0xD42:  121  UNKNOWN              ; Unrecognized instruction: 0x121
0xD43:  1A3  UNKNOWN              ; Unrecognized instruction: 0x1A3
0xD44:  1A3  UNKNOWN              ; Unrecognized instruction: 0x1A3
0xD45:  1A3  UNKNOWN              ; Unrecognized instruction: 0x1A3
0xD46:  116  UNKNOWN              ; Unrecognized instruction: 0x116
0xD47:  121  UNKNOWN              ; Unrecognized instruction: 0x121
0xD48:  1A3  UNKNOWN              ; Unrecognized instruction: 0x1A3
0xD49:  12A  UNKNOWN              ; Unrecognized instruction: 0x12A
0xD4A:  125  UNKNOWN              ; Unrecognized instruction: 0x125
0xD4B:  115  UNKNOWN              ; Unrecognized instruction: 0x115
0xD4C:  121  UNKNOWN              ; Unrecognized instruction: 0x121
0xD4D:  116  UNKNOWN              ; Unrecognized instruction: 0x116
0xD4E:  125  UNKNOWN              ; Unrecognized instruction: 0x125
0xD4F:  121  UNKNOWN              ; Unrecognized instruction: 0x121
0xD50:  12E  UNKNOWN              ; Unrecognized instruction: 0x12E
0xD51:  12F  UNKNOWN              ; Unrecognized instruction: 0x12F
0xD52:  12F  UNKNOWN              ; Unrecognized instruction: 0x12F
0xD53:  12E  UNKNOWN              ; Unrecognized instruction: 0x12E
0xD54:  1AE  UNKNOWN              ; Unrecognized instruction: 0x1AE
0xD55:  115  UNKNOWN              ; Unrecognized instruction: 0x115
0xD56:  12E  UNKNOWN              ; Unrecognized instruction: 0x12E
0xD57:  12E  UNKNOWN              ; Unrecognized instruction: 0x12E
0xD58:  12E  UNKNOWN              ; Unrecognized instruction: 0x12E
0xD59:  12E  UNKNOWN              ; Unrecognized instruction: 0x12E
0xD5A:  121  UNKNOWN              ; Unrecognized instruction: 0x121
0xD5B:  125  UNKNOWN              ; Unrecognized instruction: 0x125
0xD5C:  125  UNKNOWN              ; Unrecognized instruction: 0x125
0xD5D:  115  UNKNOWN              ; Unrecognized instruction: 0x115
0xD5E:  121  UNKNOWN              ; Unrecognized instruction: 0x121
0xD5F:  121  UNKNOWN              ; Unrecognized instruction: 0x121
0xD60:  1A3  UNKNOWN              ; Unrecognized instruction: 0x1A3
0xD61:  123  UNKNOWN              ; Unrecognized instruction: 0x123
0xD62:  116  UNKNOWN              ; Unrecognized instruction: 0x116
0xD63:  125  UNKNOWN              ; Unrecognized instruction: 0x125
0xD64:  139  UNKNOWN              ; Unrecognized instruction: 0x139
0xD65:  13A  UNKNOWN              ; Unrecognized instruction: 0x13A
0xD66:  139  UNKNOWN              ; Unrecognized instruction: 0x139
0xD67:  139  UNKNOWN              ; Unrecognized instruction: 0x139
0xD68:  13B  UNKNOWN              ; Unrecognized instruction: 0x13B
0xD69:  13B  UNKNOWN              ; Unrecognized instruction: 0x13B
0xD6A:  13A  UNKNOWN              ; Unrecognized instruction: 0x13A
0xD6B:  13B  UNKNOWN              ; Unrecognized instruction: 0x13B
0xD6C:  13B  UNKNOWN              ; Unrecognized instruction: 0x13B
0xD6D:  13A  UNKNOWN              ; Unrecognized instruction: 0x13A
0xD6E:  1BA  UNKNOWN              ; Unrecognized instruction: 0x1BA
0xD6F:  13B  UNKNOWN              ; Unrecognized instruction: 0x13B
0xD70:  1AE  UNKNOWN              ; Unrecognized instruction: 0x1AE
0xD71:  12E  UNKNOWN              ; Unrecognized instruction: 0x12E
0xD72:  1AE  UNKNOWN              ; Unrecognized instruction: 0x1AE
0xD73:  115  UNKNOWN              ; Unrecognized instruction: 0x115
0xD74:  12E  UNKNOWN              ; Unrecognized instruction: 0x12E
0xD75:  12E  UNKNOWN              ; Unrecognized instruction: 0x12E
0xD76:  12F  UNKNOWN              ; Unrecognized instruction: 0x12F
0xD77:  13D  UNKNOWN              ; Unrecognized instruction: 0x13D
0xD78:  13F  UNKNOWN              ; Unrecognized instruction: 0x13F
0xD79:  12F  UNKNOWN              ; Unrecognized instruction: 0x12F
0xD7A:  115  UNKNOWN              ; Unrecognized instruction: 0x115
0xD7B:  12E  UNKNOWN              ; Unrecognized instruction: 0x12E
0xD7C:  13D  UNKNOWN              ; Unrecognized instruction: 0x13D
0xD7D:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0xD7E:  5B3  CALZ     0x5B3       ; Call subroutine at 0x5B3 if Zero flag is set
0xD7F:  792  JP_NZ    0x592       ; Jump to 0x592 if Zero flag is clear (result was non-zero)
0xD80:  5F5  CALZ     0x5F5       ; Call subroutine at 0x5F5 if Zero flag is set
0xD81:  B40  LD_X     0x40        ; Set X pointer to RAM address 0x40 (MEM_HUNGER)
0xD82:  494  CALL     0x594       ; Call subroutine at 0x594
0xD83:  BC0  LD_X     0xC0        ; Set X pointer to RAM address 0xC0
0xD84:  494  CALL     0x594       ; Call subroutine at 0x594
0xD85:  E04  LD_R_I   A, #4       ; Load A with immediate value #4
0xD86:  E14  LD_R_I   B, #4       ; Load B with immediate value #4
0xD87:  E4A  PSET     10          ; Set NP (New Page) to 10 for the next jump/call
0xD88:  4F0  CALL     0xAF0       ; Call subroutine at 0xAF0
0xD89:  B4D  LD_X     0x4D        ; Set X pointer to RAM address 0x4D (MEM_POOP)
0xD8A:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0xD8B:  692  JP_Z     0xA92       ; Jump to 0xA92 if Zero flag is set (result was zero)
0xD8C:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0xD8D:  E07  LD_R_I   A, #7       ; Load A with immediate value #7
0xD8E:  E15  LD_R_I   B, #5       ; Load B with immediate value #5
0xD8F:  806  LD_Y     0x06        ; Set Y pointer to RAM address 0x06
0xD90:  E48  PSET     8           ; Set NP (New Page) to 8 for the next jump/call
0xD91:  4A9  CALL     0x8A9       ; Call subroutine at 0x8A9
0xD92:  E45  PSET     5           ; Set NP (New Page) to 5 for the next jump/call
0xD93:  01A  JP       0x51A       ; Jump to address 0x51A
0xD94:  944  LBPX     #44         ; Load constant #68 into [X]
0xD95:  9EE  LBPX     #EE         ; Load constant #238 into [X]
0xD96:  9BB  LBPX     #BB         ; Load constant #187 into [X]
0xD97:  955  LBPX     #55         ; Load constant #85 into [X]
0xD98:  9AA  LBPX     #AA         ; Load constant #170 into [X]
0xD99:  911  LBPX     #11         ; Load constant #17 into [X]
0xD9A:  900  LBPX     #0          ; Load constant #0 into [X]
0xD9B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xD9C:  900  LBPX     #0          ; Load constant #0 into [X]
0xD9D:  121  UNKNOWN              ; Unrecognized instruction: 0x121
0xD9E:  933  LBPX     #33         ; Load constant #51 into [X]
0xD9F:  945  LBPX     #45         ; Load constant #69 into [X]
0xDA0:  903  LBPX     #3          ; Load constant #3 into [X]
0xDA1:  944  LBPX     #44         ; Load constant #68 into [X]
0xDA2:  930  LBPX     #30         ; Load constant #48 into [X]
0xDA3:  933  LBPX     #33         ; Load constant #51 into [X]
0xDA4:  900  LBPX     #0          ; Load constant #0 into [X]
0xDA5:  132  UNKNOWN              ; Unrecognized instruction: 0x132
0xDA6:  943  LBPX     #43         ; Load constant #67 into [X]
0xDA7:  9AF  LBPX     #AF         ; Load constant #175 into [X]
0xDA8:  923  LBPX     #23         ; Load constant #35 into [X]
0xDA9:  99F  LBPX     #9F         ; Load constant #159 into [X]
0xDAA:  903  LBPX     #3          ; Load constant #3 into [X]
0xDAB:  98F  LBPX     #8F         ; Load constant #143 into [X]
0xDAC:  920  LBPX     #20         ; Load constant #32 into [X]
0xDAD:  97F  LBPX     #7F         ; Load constant #127 into [X]
0xDAE:  910  LBPX     #10         ; Load constant #16 into [X]
0xDAF:  96F  LBPX     #6F         ; Load constant #111 into [X]
0xDB0:  900  LBPX     #0          ; Load constant #0 into [X]
0xDB1:  15F  UNKNOWN              ; Unrecognized instruction: 0x15F
0xDB2:  984  LBPX     #84         ; Load constant #132 into [X]
0xDB3:  9AF  LBPX     #AF         ; Load constant #175 into [X]
0xDB4:  904  LBPX     #4          ; Load constant #4 into [X]
0xDB5:  99F  LBPX     #9F         ; Load constant #159 into [X]
0xDB6:  920  LBPX     #20         ; Load constant #32 into [X]
0xDB7:  976  LBPX     #76         ; Load constant #118 into [X]
0xDB8:  900  LBPX     #0          ; Load constant #0 into [X]
0xDB9:  16F  UNKNOWN              ; Unrecognized instruction: 0x16F
0xDBA:  930  LBPX     #30         ; Load constant #48 into [X]
0xDBB:  9AF  LBPX     #AF         ; Load constant #175 into [X]
0xDBC:  920  LBPX     #20         ; Load constant #32 into [X]
0xDBD:  99F  LBPX     #9F         ; Load constant #159 into [X]
0xDBE:  900  LBPX     #0          ; Load constant #0 into [X]
0xDBF:  18F  UNKNOWN              ; Unrecognized instruction: 0x18F
0xDC0:  960  LBPX     #60         ; Load constant #96 into [X]
0xDC1:  9AF  LBPX     #AF         ; Load constant #175 into [X]
0xDC2:  900  LBPX     #0          ; Load constant #0 into [X]
0xDC3:  19F  UNKNOWN              ; Unrecognized instruction: 0x19F
0xDC4:  900  LBPX     #0          ; Load constant #0 into [X]
0xDC5:  1BF  UNKNOWN              ; Unrecognized instruction: 0x1BF
0xDC6:  B90  LD_X     0x90        ; Set X pointer to RAM address 0x90
0xDC7:  E10  LD_R_I   B, #0       ; Load B with immediate value #0
0xDC8:  C0B  ADD_R_I  A, #11      ; Add immediate #11 to register A
0xDC9:  C5C  UNKNOWN              ; Unrecognized instruction: 0xC5C
0xDCA:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0xDCB:  09C  JP       0x59C       ; Jump to address 0x59C
0xDCC:  09E  JP       0x59E       ; Jump to address 0x59E
0xDCD:  0A6  JP       0x5A6       ; Jump to address 0x5A6
0xDCE:  0B2  JP       0x5B2       ; Jump to address 0x5B2
0xDCF:  0BA  JP       0x5BA       ; Jump to address 0x5BA
0xDD0:  0C0  JP       0x5C0       ; Jump to address 0x5C0
0xDD1:  0C4  JP       0x5C4       ; Jump to address 0x5C4
0xDD2:  5F2  CALZ     0x5F2       ; Call subroutine at 0x5F2 if Zero flag is set
0xDD3:  E91  UNKNOWN              ; Unrecognized instruction: 0xE91
0xDD4:  B49  LD_X     0x49        ; Set X pointer to RAM address 0x49 (MEM_SICK)
0xDD5:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0xDD6:  B5D  LD_X     0x5D        ; Set X pointer to RAM address 0x5D (MEM_LIFECYCLE)
0xDD7:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0xDD8:  C08  ADD_R_I  A, #8       ; Add immediate #8 to register A
0xDD9:  C55  UNKNOWN              ; Unrecognized instruction: 0xC55
0xDDA:  F80  LD_MN_A  0x00        ; Store A into direct RAM address 0x00
0xDDB:  F91  LD_MN_B  0x01        ; Store B into direct RAM address 0x01
0xDDC:  E05  LD_R_I   A, #5       ; Load A with immediate value #5
0xDDD:  F82  LD_MN_A  0x02        ; Store A into direct RAM address 0x02
0xDDE:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0xDDF:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0xDE0:  B30  LD_X     0x30        ; Set X pointer to RAM address 0x30
0xDE1:  500  CALZ     0x500       ; Call subroutine at 0x500 if Zero flag is set
0xDE2:  848  LD_Y     0x48        ; Set Y pointer to RAM address 0x48 (MEM_SICK_LEVEL)
0xDE3:  EC3  LD_R_Q   A, [Y]      ; Copy value from [Y] into A
0xDE4:  E12  LD_R_I   B, #2       ; Load B with immediate value #2
0xDE5:  E91  UNKNOWN              ; Unrecognized instruction: 0xE91
0xDE6:  B10  LD_X     0x10        ; Set X pointer to RAM address 0x10
0xDE7:  840  LD_Y     0x40        ; Set Y pointer to RAM address 0x40 (MEM_HUNGER)
0xDE8:  512  CALZ     0x512       ; Call subroutine at 0x512 if Zero flag is set
0xDE9:  599  CALZ     0x599       ; Call subroutine at 0x599 if Zero flag is set
0xDEA:  D88  UNKNOWN              ; Unrecognized instruction: 0xD88
0xDEB:  7EF  JP_NZ    0x5EF       ; Jump to 0x5EF if Zero flag is clear (result was non-zero)
0xDEC:  B0D  LD_X     0x0D        ; Set X pointer to RAM address 0x0D
0xDED:  838  LD_Y     0x38        ; Set Y pointer to RAM address 0x38
0xDEE:  599  CALZ     0x599       ; Call subroutine at 0x599 if Zero flag is set
0xDEF:  509  CALZ     0x509       ; Call subroutine at 0x509 if Zero flag is set
0xDF0:  843  LD_Y     0x43        ; Set Y pointer to RAM address 0x43 (MEM_DISCIPLINE)
0xDF1:  B13  LD_X     0x13        ; Set X pointer to RAM address 0x13
0xDF2:  ECB  LD_R_Q   [X], [Y]    ; Copy value from [Y] into [X]
0xDF3:  5EF  CALZ     0x5EF       ; Call subroutine at 0x5EF if Zero flag is set
0xDF4:  844  LD_Y     0x44        ; Set Y pointer to RAM address 0x44
0xDF5:  B43  LD_X     0x43        ; Set X pointer to RAM address 0x43 (MEM_DISCIPLINE)
0xDF6:  ECB  LD_R_Q   [X], [Y]    ; Copy value from [Y] into [X]
0xDF7:  B50  LD_X     0x50        ; Set X pointer to RAM address 0x50 (MEM_CHARACTER)
0xDF8:  DE2  CP_R_I   [X], #2     ; Compare register [X] with immediate value #2
0xDF9:  6FC  JP_Z     0x5FC       ; Jump to 0x5FC if Zero flag is set (result was zero)
0xDFA:  DE4  CP_R_I   [X], #4     ; Compare register [X] with immediate value #4
0xDFB:  7FE  JP_NZ    0x5FE       ; Jump to 0x5FE if Zero flag is clear (result was non-zero)
0xDFC:  B43  LD_X     0x43        ; Set X pointer to RAM address 0x43 (MEM_DISCIPLINE)
0xDFD:  E28  LD_R_I   [X], #8     ; Load [X] with immediate value #8
0xDFE:  E46  PSET     6           ; Set NP (New Page) to 6 for the next jump/call
0xDFF:  0E5  JP       0x6E5       ; Jump to address 0x6E5
0xE00:  10E  UNKNOWN              ; Unrecognized instruction: 0x10E
0xE01:  111  UNKNOWN              ; Unrecognized instruction: 0x111
0xE02:  116  UNKNOWN              ; Unrecognized instruction: 0x116
0xE03:  11F  UNKNOWN              ; Unrecognized instruction: 0x11F
0xE04:  124  UNKNOWN              ; Unrecognized instruction: 0x124
0xE05:  124  UNKNOWN              ; Unrecognized instruction: 0x124
0xE06:  129  UNKNOWN              ; Unrecognized instruction: 0x129
0xE07:  12E  UNKNOWN              ; Unrecognized instruction: 0x12E
0xE08:  131  UNKNOWN              ; Unrecognized instruction: 0x131
0xE09:  13C  UNKNOWN              ; Unrecognized instruction: 0x13C
0xE0A:  145  UNKNOWN              ; Unrecognized instruction: 0x145
0xE0B:  14E  UNKNOWN              ; Unrecognized instruction: 0x14E
0xE0C:  155  UNKNOWN              ; Unrecognized instruction: 0x155
0xE0D:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0xE0E:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0xE0F:  950  LBPX     #50         ; Load constant #80 into [X]
0xE10:  10E  UNKNOWN              ; Unrecognized instruction: 0x10E
0xE11:  960  LBPX     #60         ; Load constant #96 into [X]
0xE12:  130  UNKNOWN              ; Unrecognized instruction: 0x130
0xE13:  961  LBPX     #61         ; Load constant #97 into [X]
0xE14:  930  LBPX     #30         ; Load constant #48 into [X]
0xE15:  111  UNKNOWN              ; Unrecognized instruction: 0x111
0xE16:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0xE17:  150  UNKNOWN              ; Unrecognized instruction: 0x150
0xE18:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0xE19:  150  UNKNOWN              ; Unrecognized instruction: 0x150
0xE1A:  95E  LBPX     #5E         ; Load constant #94 into [X]
0xE1B:  1A8  UNKNOWN              ; Unrecognized instruction: 0x1A8
0xE1C:  95F  LBPX     #5F         ; Load constant #95 into [X]
0xE1D:  9A8  LBPX     #A8         ; Load constant #168 into [X]
0xE1E:  11A  UNKNOWN              ; Unrecognized instruction: 0x11A
0xE1F:  965  LBPX     #65         ; Load constant #101 into [X]
0xE20:  130  UNKNOWN              ; Unrecognized instruction: 0x130
0xE21:  964  LBPX     #64         ; Load constant #100 into [X]
0xE22:  930  LBPX     #30         ; Load constant #48 into [X]
0xE23:  11F  UNKNOWN              ; Unrecognized instruction: 0x11F
0xE24:  962  LBPX     #62         ; Load constant #98 into [X]
0xE25:  130  UNKNOWN              ; Unrecognized instruction: 0x130
0xE26:  97F  LBPX     #7F         ; Load constant #127 into [X]
0xE27:  950  LBPX     #50         ; Load constant #80 into [X]
0xE28:  124  UNKNOWN              ; Unrecognized instruction: 0x124
0xE29:  97F  LBPX     #7F         ; Load constant #127 into [X]
0xE2A:  150  UNKNOWN              ; Unrecognized instruction: 0x150
0xE2B:  963  LBPX     #63         ; Load constant #99 into [X]
0xE2C:  930  LBPX     #30         ; Load constant #48 into [X]
0xE2D:  129  UNKNOWN              ; Unrecognized instruction: 0x129
0xE2E:  9D7  LBPX     #D7         ; Load constant #215 into [X]
0xE2F:  9B0  LBPX     #B0         ; Load constant #176 into [X]
0xE30:  12E  UNKNOWN              ; Unrecognized instruction: 0x12E
0xE31:  910  LBPX     #10         ; Load constant #16 into [X]
0xE32:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xE33:  910  LBPX     #10         ; Load constant #16 into [X]
0xE34:  180  UNKNOWN              ; Unrecognized instruction: 0x180
0xE35:  9D1  LBPX     #D1         ; Load constant #209 into [X]
0xE36:  180  UNKNOWN              ; Unrecognized instruction: 0x180
0xE37:  9D2  LBPX     #D2         ; Load constant #210 into [X]
0xE38:  180  UNKNOWN              ; Unrecognized instruction: 0x180
0xE39:  9D3  LBPX     #D3         ; Load constant #211 into [X]
0xE3A:  980  LBPX     #80         ; Load constant #128 into [X]
0xE3B:  139  UNKNOWN              ; Unrecognized instruction: 0x139
0xE3C:  910  LBPX     #10         ; Load constant #16 into [X]
0xE3D:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xE3E:  910  LBPX     #10         ; Load constant #16 into [X]
0xE3F:  180  UNKNOWN              ; Unrecognized instruction: 0x180
0xE40:  952  LBPX     #52         ; Load constant #82 into [X]
0xE41:  180  UNKNOWN              ; Unrecognized instruction: 0x180
0xE42:  953  LBPX     #53         ; Load constant #83 into [X]
0xE43:  980  LBPX     #80         ; Load constant #128 into [X]
0xE44:  142  UNKNOWN              ; Unrecognized instruction: 0x142
0xE45:  914  LBPX     #14         ; Load constant #20 into [X]
0xE46:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xE47:  914  LBPX     #14         ; Load constant #20 into [X]
0xE48:  180  UNKNOWN              ; Unrecognized instruction: 0x180
0xE49:  9D5  LBPX     #D5         ; Load constant #213 into [X]
0xE4A:  180  UNKNOWN              ; Unrecognized instruction: 0x180
0xE4B:  9D6  LBPX     #D6         ; Load constant #214 into [X]
0xE4C:  980  LBPX     #80         ; Load constant #128 into [X]
0xE4D:  10E  UNKNOWN              ; Unrecognized instruction: 0x10E
0xE4E:  914  LBPX     #14         ; Load constant #20 into [X]
0xE4F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xE50:  914  LBPX     #14         ; Load constant #20 into [X]
0xE51:  180  UNKNOWN              ; Unrecognized instruction: 0x180
0xE52:  956  LBPX     #56         ; Load constant #86 into [X]
0xE53:  980  LBPX     #80         ; Load constant #128 into [X]
0xE54:  10E  UNKNOWN              ; Unrecognized instruction: 0x10E
0xE55:  910  LBPX     #10         ; Load constant #16 into [X]
0xE56:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0xE57:  9D0  LBPX     #D0         ; Load constant #208 into [X]
0xE58:  980  LBPX     #80         ; Load constant #128 into [X]
0xE59:  157  UNKNOWN              ; Unrecognized instruction: 0x157
0xE5A:  5EF  CALZ     0x6EF       ; Call subroutine at 0x6EF if Zero flag is set
0xE5B:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0xE5C:  E41  PSET     1           ; Set NP (New Page) to 1 for the next jump/call
0xE5D:  4EC  CALL     0x1EC       ; Call subroutine at 0x1EC
0xE5E:  5CE  CALZ     0x1CE       ; Call subroutine at 0x1CE if Zero flag is set
0xE5F:  940  LBPX     #40         ; Load constant #64 into [X]
0xE60:  B78  LD_X     0x78        ; Set X pointer to RAM address 0x78
0xE61:  EE2  UNKNOWN              ; Unrecognized instruction: 0xEE2
0xE62:  B75  LD_X     0x75        ; Set X pointer to RAM address 0x75
0xE63:  EE8  UNKNOWN              ; Unrecognized instruction: 0xEE8
0xE64:  E42  PSET     2           ; Set NP (New Page) to 2 for the next jump/call
0xE65:  4C3  CALL     0x2C3       ; Call subroutine at 0x2C3
0xE66:  279  JP_C     0x279       ; Jump to 0x279 if Carry flag is set (overflow occurred)
0xE67:  679  JP_Z     0x279       ; Jump to 0x279 if Zero flag is set (result was zero)
0xE68:  B90  LD_X     0x90        ; Set X pointer to RAM address 0x90
0xE69:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0xE6A:  B98  LD_X     0x98        ; Set X pointer to RAM address 0x98
0xE6B:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0xE6C:  B90  LD_X     0x90        ; Set X pointer to RAM address 0x90
0xE6D:  DC0  CP_R_I   A, #0       ; Compare register A with immediate value #0
0xE6E:  670  JP_Z     0x270       ; Jump to 0x270 if Zero flag is set (result was zero)
0xE6F:  B98  LD_X     0x98        ; Set X pointer to RAM address 0x98
0xE70:  927  LBPX     #27         ; Load constant #39 into [X]
0xE71:  E47  PSET     7           ; Set NP (New Page) to 7 for the next jump/call
0xE72:  492  CALL     0x792       ; Call subroutine at 0x792
0xE73:  556  CALZ     0x756       ; Call subroutine at 0x756 if Zero flag is set
0xE74:  E4F  PSET     15          ; Set NP (New Page) to 15 for the next jump/call
0xE75:  400  CALL     0xF00       ; Call subroutine at 0xF00
0xE76:  664  JP_Z     0xF64       ; Jump to 0xF64 if Zero flag is set (result was zero)
0xE77:  5EF  CALZ     0xFEF       ; Call subroutine at 0xFEF if Zero flag is set
0xE78:  F41  SCF                  ; Set Carry Flag
0xE79:  B78  LD_X     0x78        ; Set X pointer to RAM address 0x78
0xE7A:  EE8  UNKNOWN              ; Unrecognized instruction: 0xEE8
0xE7B:  FDF  RET                  ; Return to caller
0xE7C:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0xE7D:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0xE7E:  908  LBPX     #8          ; Load constant #8 into [X]
0xE7F:  17D  UNKNOWN              ; Unrecognized instruction: 0x17D
0xE80:  930  LBPX     #30         ; Load constant #48 into [X]
0xE81:  903  LBPX     #3          ; Load constant #3 into [X]
0xE82:  17D  UNKNOWN              ; Unrecognized instruction: 0x17D
0xE83:  900  LBPX     #0          ; Load constant #0 into [X]
0xE84:  107  UNKNOWN              ; Unrecognized instruction: 0x107
0xE85:  900  LBPX     #0          ; Load constant #0 into [X]
0xE86:  106  UNKNOWN              ; Unrecognized instruction: 0x106
0xE87:  900  LBPX     #0          ; Load constant #0 into [X]
0xE88:  105  UNKNOWN              ; Unrecognized instruction: 0x105
0xE89:  900  LBPX     #0          ; Load constant #0 into [X]
0xE8A:  104  UNKNOWN              ; Unrecognized instruction: 0x104
0xE8B:  900  LBPX     #0          ; Load constant #0 into [X]
0xE8C:  103  UNKNOWN              ; Unrecognized instruction: 0x103
0xE8D:  900  LBPX     #0          ; Load constant #0 into [X]
0xE8E:  102  UNKNOWN              ; Unrecognized instruction: 0x102
0xE8F:  900  LBPX     #0          ; Load constant #0 into [X]
0xE90:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0xE91:  900  LBPX     #0          ; Load constant #0 into [X]
0xE92:  900  LBPX     #0          ; Load constant #0 into [X]
0xE93:  17D  UNKNOWN              ; Unrecognized instruction: 0x17D
0xE94:  901  LBPX     #1          ; Load constant #1 into [X]
0xE95:  904  LBPX     #4          ; Load constant #4 into [X]
0xE96:  17D  UNKNOWN              ; Unrecognized instruction: 0x17D
0xE97:  901  LBPX     #1          ; Load constant #1 into [X]
0xE98:  105  UNKNOWN              ; Unrecognized instruction: 0x105
0xE99:  901  LBPX     #1          ; Load constant #1 into [X]
0xE9A:  108  UNKNOWN              ; Unrecognized instruction: 0x108
0xE9B:  901  LBPX     #1          ; Load constant #1 into [X]
0xE9C:  903  LBPX     #3          ; Load constant #3 into [X]
0xE9D:  17D  UNKNOWN              ; Unrecognized instruction: 0x17D
0xE9E:  905  LBPX     #5          ; Load constant #5 into [X]
0xE9F:  107  UNKNOWN              ; Unrecognized instruction: 0x107
0xEA0:  903  LBPX     #3          ; Load constant #3 into [X]
0xEA1:  108  UNKNOWN              ; Unrecognized instruction: 0x108
0xEA2:  90B  LBPX     #B          ; Load constant #11 into [X]
0xEA3:  907  LBPX     #7          ; Load constant #7 into [X]
0xEA4:  17D  UNKNOWN              ; Unrecognized instruction: 0x17D
0xEA5:  901  LBPX     #1          ; Load constant #1 into [X]
0xEA6:  102  UNKNOWN              ; Unrecognized instruction: 0x102
0xEA7:  901  LBPX     #1          ; Load constant #1 into [X]
0xEA8:  108  UNKNOWN              ; Unrecognized instruction: 0x108
0xEA9:  907  LBPX     #7          ; Load constant #7 into [X]
0xEAA:  103  UNKNOWN              ; Unrecognized instruction: 0x103
0xEAB:  907  LBPX     #7          ; Load constant #7 into [X]
0xEAC:  908  LBPX     #8          ; Load constant #8 into [X]
0xEAD:  1A5  UNKNOWN              ; Unrecognized instruction: 0x1A5
0xEAE:  902  LBPX     #2          ; Load constant #2 into [X]
0xEAF:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0xEB0:  902  LBPX     #2          ; Load constant #2 into [X]
0xEB1:  104  UNKNOWN              ; Unrecognized instruction: 0x104
0xEB2:  902  LBPX     #2          ; Load constant #2 into [X]
0xEB3:  102  UNKNOWN              ; Unrecognized instruction: 0x102
0xEB4:  902  LBPX     #2          ; Load constant #2 into [X]
0xEB5:  105  UNKNOWN              ; Unrecognized instruction: 0x105
0xEB6:  902  LBPX     #2          ; Load constant #2 into [X]
0xEB7:  103  UNKNOWN              ; Unrecognized instruction: 0x103
0xEB8:  902  LBPX     #2          ; Load constant #2 into [X]
0xEB9:  106  UNKNOWN              ; Unrecognized instruction: 0x106
0xEBA:  902  LBPX     #2          ; Load constant #2 into [X]
0xEBB:  104  UNKNOWN              ; Unrecognized instruction: 0x104
0xEBC:  902  LBPX     #2          ; Load constant #2 into [X]
0xEBD:  907  LBPX     #7          ; Load constant #7 into [X]
0xEBE:  1AE  UNKNOWN              ; Unrecognized instruction: 0x1AE
0xEBF:  912  LBPX     #12         ; Load constant #18 into [X]
0xEC0:  103  UNKNOWN              ; Unrecognized instruction: 0x103
0xEC1:  919  LBPX     #19         ; Load constant #25 into [X]
0xEC2:  908  LBPX     #8          ; Load constant #8 into [X]
0xEC3:  1BF  UNKNOWN              ; Unrecognized instruction: 0x1BF
0xEC4:  918  LBPX     #18         ; Load constant #24 into [X]
0xEC5:  103  UNKNOWN              ; Unrecognized instruction: 0x103
0xEC6:  928  LBPX     #28         ; Load constant #40 into [X]
0xEC7:  908  LBPX     #8          ; Load constant #8 into [X]
0xEC8:  1C4  UNKNOWN              ; Unrecognized instruction: 0x1C4
0xEC9:  91C  LBPX     #1C         ; Load constant #28 into [X]
0xECA:  103  UNKNOWN              ; Unrecognized instruction: 0x103
0xECB:  944  LBPX     #44         ; Load constant #68 into [X]
0xECC:  908  LBPX     #8          ; Load constant #8 into [X]
0xECD:  1C9  UNKNOWN              ; Unrecognized instruction: 0x1C9
0xECE:  950  LBPX     #50         ; Load constant #80 into [X]
0xECF:  903  LBPX     #3          ; Load constant #3 into [X]
0xED0:  17D  UNKNOWN              ; Unrecognized instruction: 0x17D
0xED1:  903  LBPX     #3          ; Load constant #3 into [X]
0xED2:  104  UNKNOWN              ; Unrecognized instruction: 0x104
0xED3:  902  LBPX     #2          ; Load constant #2 into [X]
0xED4:  902  LBPX     #2          ; Load constant #2 into [X]
0xED5:  1D1  UNKNOWN              ; Unrecognized instruction: 0x1D1
0xED6:  90C  LBPX     #C          ; Load constant #12 into [X]
0xED7:  102  UNKNOWN              ; Unrecognized instruction: 0x102
0xED8:  90C  LBPX     #C          ; Load constant #12 into [X]
0xED9:  104  UNKNOWN              ; Unrecognized instruction: 0x104
0xEDA:  90C  LBPX     #C          ; Load constant #12 into [X]
0xEDB:  106  UNKNOWN              ; Unrecognized instruction: 0x106
0xEDC:  90C  LBPX     #C          ; Load constant #12 into [X]
0xEDD:  104  UNKNOWN              ; Unrecognized instruction: 0x104
0xEDE:  90C  LBPX     #C          ; Load constant #12 into [X]
0xEDF:  102  UNKNOWN              ; Unrecognized instruction: 0x102
0xEE0:  90C  LBPX     #C          ; Load constant #12 into [X]
0xEE1:  108  UNKNOWN              ; Unrecognized instruction: 0x108
0xEE2:  910  LBPX     #10         ; Load constant #16 into [X]
0xEE3:  901  LBPX     #1          ; Load constant #1 into [X]
0xEE4:  17D  UNKNOWN              ; Unrecognized instruction: 0x17D
0xEE5:  90C  LBPX     #C          ; Load constant #12 into [X]
0xEE6:  104  UNKNOWN              ; Unrecognized instruction: 0x104
0xEE7:  906  LBPX     #6          ; Load constant #6 into [X]
0xEE8:  102  UNKNOWN              ; Unrecognized instruction: 0x102
0xEE9:  90C  LBPX     #C          ; Load constant #12 into [X]
0xEEA:  103  UNKNOWN              ; Unrecognized instruction: 0x103
0xEEB:  906  LBPX     #6          ; Load constant #6 into [X]
0xEEC:  104  UNKNOWN              ; Unrecognized instruction: 0x104
0xEED:  910  LBPX     #10         ; Load constant #16 into [X]
0xEEE:  905  LBPX     #5          ; Load constant #5 into [X]
0xEEF:  17D  UNKNOWN              ; Unrecognized instruction: 0x17D
0xEF0:  906  LBPX     #6          ; Load constant #6 into [X]
0xEF1:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0xEF2:  907  LBPX     #7          ; Load constant #7 into [X]
0xEF3:  102  UNKNOWN              ; Unrecognized instruction: 0x102
0xEF4:  908  LBPX     #8          ; Load constant #8 into [X]
0xEF5:  103  UNKNOWN              ; Unrecognized instruction: 0x103
0xEF6:  90A  LBPX     #A          ; Load constant #10 into [X]
0xEF7:  104  UNKNOWN              ; Unrecognized instruction: 0x104
0xEF8:  90C  LBPX     #C          ; Load constant #12 into [X]
0xEF9:  105  UNKNOWN              ; Unrecognized instruction: 0x105
0xEFA:  90E  LBPX     #E          ; Load constant #14 into [X]
0xEFB:  906  LBPX     #6          ; Load constant #6 into [X]
0xEFC:  17D  UNKNOWN              ; Unrecognized instruction: 0x17D
0xEFD:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0xEFE:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0xEFF:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0xF00:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0xF01:  E90  UNKNOWN              ; Unrecognized instruction: 0xE90
0xF02:  5EF  CALZ     0xFEF       ; Call subroutine at 0xFEF if Zero flag is set
0xF03:  B7C  LD_X     0x7C        ; Set X pointer to RAM address 0x7C
0xF04:  DEF  CP_R_I   [X], #15    ; Compare register [X] with immediate value #15
0xF05:  7D6  JP_NZ    0xFD6       ; Jump to 0xFD6 if Zero flag is clear (result was non-zero)
0xF06:  B5C  LD_X     0x5C        ; Set X pointer to RAM address 0x5C
0xF07:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0xF08:  7D6  JP_NZ    0xFD6       ; Jump to 0xFD6 if Zero flag is clear (result was non-zero)
0xF09:  B14  LD_X     0x14        ; Set X pointer to RAM address 0x14
0xF0A:  512  CALZ     0xF12       ; Call subroutine at 0xF12 if Zero flag is set
0xF0B:  EE2  UNKNOWN              ; Unrecognized instruction: 0xEE2
0xF0C:  EC6  LD_R_Q   B, [X]      ; Copy value from [X] into B
0xF0D:  509  CALZ     0xF09       ; Call subroutine at 0xF09 if Zero flag is set
0xF0E:  B4A  LD_X     0x4A        ; Set X pointer to RAM address 0x4A (MEM_SLEEPING)
0xF0F:  DA8  UNKNOWN              ; Unrecognized instruction: 0xDA8
0xF10:  64A  JP_Z     0xF4A       ; Jump to 0xF4A if Zero flag is set (result was zero)
0xF11:  5F8  CALZ     0xFF8       ; Call subroutine at 0xFF8 if Zero flag is set
0xF12:  717  JP_NZ    0xF17       ; Jump to 0xF17 if Zero flag is clear (result was non-zero)
0xF13:  815  LD_Y     0x15        ; Set Y pointer to RAM address 0x15
0xF14:  DF0  CP_R_I   [Y], #0     ; Compare register [Y] with immediate value #0
0xF15:  61D  JP_Z     0xF1D       ; Jump to 0xF1D if Zero flag is set (result was zero)
0xF16:  0D6  JP       0xFD6       ; Jump to address 0xFD6
0xF17:  831  LD_Y     0x31        ; Set Y pointer to RAM address 0x31
0xF18:  4D9  CALL     0xFD9       ; Call subroutine at 0xFD9
0xF19:  235  JP_C     0xF35       ; Jump to 0xF35 if Carry flag is set (overflow occurred)
0xF1A:  833  LD_Y     0x33        ; Set Y pointer to RAM address 0x33
0xF1B:  4D9  CALL     0xFD9       ; Call subroutine at 0xFD9
0xF1C:  335  JP_NC    0xF35       ; Jump to 0xF35 if Carry flag is clear (no overflow)
0xF1D:  B4B  LD_X     0x4B        ; Set X pointer to RAM address 0x4B
0xF1E:  E2F  LD_R_I   [X], #15    ; Load [X] with immediate value #15
0xF1F:  B4A  LD_X     0x4A        ; Set X pointer to RAM address 0x4A (MEM_SLEEPING)
0xF20:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0xF21:  F44  SDF                  ; Set Decimal Flag
0xF22:  B54  LD_X     0x54        ; Set X pointer to RAM address 0x54 (MEM_AGE)
0xF23:  C21  ADD_R_I  [X], #1     ; Add immediate #1 to register [X]
0xF24:  EE0  INC_X                ; Increment the X pointer by 1
0xF25:  C60  UNKNOWN              ; Unrecognized instruction: 0xC60
0xF26:  F5B  RDF                  ; Reset (clear) Decimal Flag
0xF27:  32A  JP_NC    0xF2A       ; Jump to 0xF2A if Carry flag is clear (no overflow)
0xF28:  B54  LD_X     0x54        ; Set X pointer to RAM address 0x54 (MEM_AGE)
0xF29:  999  LBPX     #99         ; Load constant #153 into [X]
0xF2A:  B50  LD_X     0x50        ; Set X pointer to RAM address 0x50 (MEM_CHARACTER)
0xF2B:  DEF  CP_R_I   [X], #15    ; Compare register [X] with immediate value #15
0xF2C:  7D6  JP_NZ    0xFD6       ; Jump to 0xFD6 if Zero flag is clear (result was non-zero)
0xF2D:  810  LD_Y     0x10        ; Set Y pointer to RAM address 0x10
0xF2E:  5D7  CALZ     0xFD7       ; Call subroutine at 0xFD7 if Zero flag is set
0xF2F:  7D6  JP_NZ    0xFD6       ; Jump to 0xFD6 if Zero flag is clear (result was non-zero)
0xF30:  834  LD_Y     0x34        ; Set Y pointer to RAM address 0x34
0xF31:  43D  CALL     0xF3D       ; Call subroutine at 0xF3D
0xF32:  836  LD_Y     0x36        ; Set Y pointer to RAM address 0x36
0xF33:  43D  CALL     0xF3D       ; Call subroutine at 0xF3D
0xF34:  0D6  JP       0xFD6       ; Jump to address 0xFD6
0xF35:  805  LD_Y     0x05        ; Set Y pointer to RAM address 0x05
0xF36:  DFF  CP_R_I   [Y], #15    ; Compare register [Y] with immediate value #15
0xF37:  63C  JP_Z     0xF3C       ; Jump to 0xF3C if Zero flag is set (result was zero)
0xF38:  DF4  CP_R_I   [Y], #4     ; Compare register [Y] with immediate value #4
0xF39:  23C  JP_C     0xF3C       ; Jump to 0xF3C if Carry flag is set (overflow occurred)
0xF3A:  E3F  LD_R_I   [Y], #15    ; Load [Y] with immediate value #15
0xF3B:  4DF  CALL     0xFDF       ; Call subroutine at 0xFDF (INC_NEGLECT)
0xF3C:  0D6  JP       0xFD6       ; Jump to address 0xFD6
0xF3D:  EF3  UNKNOWN              ; Unrecognized instruction: 0xEF3
0xF3E:  EC7  LD_R_Q   B, [Y]      ; Copy value from [Y] into B
0xF3F:  E8D  UNKNOWN              ; Unrecognized instruction: 0xE8D
0xF40:  E8C  UNKNOWN              ; Unrecognized instruction: 0xE8C
0xF41:  E8D  UNKNOWN              ; Unrecognized instruction: 0xE8D
0xF42:  E8C  UNKNOWN              ; Unrecognized instruction: 0xE8C
0xF43:  C93  UNKNOWN              ; Unrecognized instruction: 0xC93
0xF44:  F5E  RCF                  ; Reset (clear) Carry Flag
0xF45:  A3F  UNKNOWN              ; Unrecognized instruction: 0xA3F
0xF46:  AAC  SUB      [Y], A      ; Subtract value of A from register [Y]
0xF47:  EF0  INC_Y                ; Increment the Y pointer by 1
0xF48:  ABD  UNKNOWN              ; Unrecognized instruction: 0xABD
0xF49:  FDF  RET                  ; Return to caller
0xF4A:  5F8  CALZ     0xFF8       ; Call subroutine at 0xFF8 if Zero flag is set
0xF4B:  753  JP_NZ    0xF53       ; Jump to 0xF53 if Zero flag is clear (result was non-zero)
0xF4C:  815  LD_Y     0x15        ; Set Y pointer to RAM address 0x15
0xF4D:  DF0  CP_R_I   [Y], #0     ; Compare register [Y] with immediate value #0
0xF4E:  65B  JP_Z     0xF5B       ; Jump to 0xF5B if Zero flag is set (result was zero)
0xF4F:  816  LD_Y     0x16        ; Set Y pointer to RAM address 0x16
0xF50:  5D4  CALZ     0xFD4       ; Call subroutine at 0xFD4 if Zero flag is set
0xF51:  75B  JP_NZ    0xF5B       ; Jump to 0xF5B if Zero flag is clear (result was non-zero)
0xF52:  059  JP       0xF59       ; Jump to address 0xF59
0xF53:  833  LD_Y     0x33        ; Set Y pointer to RAM address 0x33
0xF54:  4D9  CALL     0xFD9       ; Call subroutine at 0xFD9
0xF55:  359  JP_NC    0xF59       ; Jump to 0xF59 if Carry flag is clear (no overflow)
0xF56:  831  LD_Y     0x31        ; Set Y pointer to RAM address 0x31
0xF57:  4D9  CALL     0xFD9       ; Call subroutine at 0xFD9
0xF58:  35B  JP_NC    0xF5B       ; Jump to 0xF5B if Carry flag is clear (no overflow)
0xF59:  E01  LD_R_I   A, #1       ; Load A with immediate value #1
0xF5A:  0D4  JP       0xFD4       ; Jump to address 0xFD4
0xF5B:  B49  LD_X     0x49        ; Set X pointer to RAM address 0x49 (MEM_SICK)
0xF5C:  DE3  CP_R_I   [X], #3     ; Compare register [X] with immediate value #3
0xF5D:  374  JP_NC    0xF74       ; Jump to 0xF74 if Carry flag is clear (no overflow)
0xF5E:  5F8  CALZ     0xFF8       ; Call subroutine at 0xFF8 if Zero flag is set
0xF5F:  763  JP_NZ    0xF63       ; Jump to 0xF63 if Zero flag is clear (result was non-zero)
0xF60:  5FD  CALZ     0xFFD       ; Call subroutine at 0xFFD if Zero flag is set
0xF61:  671  JP_Z     0xF71       ; Jump to 0xF71 if Zero flag is set (result was zero)
0xF62:  071  JP       0xF71       ; Jump to address 0xF71
0xF63:  80C  LD_Y     0x0C        ; Set Y pointer to RAM address 0x0C
0xF64:  DF2  CP_R_I   [Y], #2     ; Compare register [Y] with immediate value #2
0xF65:  269  JP_C     0xF69       ; Jump to 0xF69 if Carry flag is set (overflow occurred)
0xF66:  80B  LD_Y     0x0B        ; Set Y pointer to RAM address 0x0B
0xF67:  DFD  CP_R_I   [Y], #13    ; Compare register [Y] with immediate value #13
0xF68:  374  JP_NC    0xF74       ; Jump to 0xF74 if Carry flag is clear (no overflow)
0xF69:  5FD  CALZ     0xFFD       ; Call subroutine at 0xFFD if Zero flag is set
0xF6A:  671  JP_Z     0xF71       ; Jump to 0xF71 if Zero flag is set (result was zero)
0xF6B:  80F  LD_Y     0x0F        ; Set Y pointer to RAM address 0x0F
0xF6C:  DF1  CP_R_I   [Y], #1     ; Compare register [Y] with immediate value #1
0xF6D:  271  JP_C     0xF71       ; Jump to 0xF71 if Carry flag is set (overflow occurred)
0xF6E:  80E  LD_Y     0x0E        ; Set Y pointer to RAM address 0x0E
0xF6F:  DF6  CP_R_I   [Y], #6     ; Compare register [Y] with immediate value #6
0xF70:  374  JP_NC    0xF74       ; Jump to 0xF74 if Carry flag is clear (no overflow)
0xF71:  B4F  LD_X     0x4F        ; Set X pointer to RAM address 0x4F
0xF72:  DE5  CP_R_I   [X], #5     ; Compare register [X] with immediate value #5
0xF73:  276  JP_C     0xF76       ; Jump to 0xF76 if Carry flag is set (overflow occurred)
0xF74:  E06  LD_R_I   A, #6       ; Load A with immediate value #6
0xF75:  0D4  JP       0xFD4       ; Jump to address 0xFD4
0xF76:  810  LD_Y     0x10        ; Set Y pointer to RAM address 0x10
0xF77:  5D7  CALZ     0xFD7       ; Call subroutine at 0xFD7 if Zero flag is set
0xF78:  780  JP_NZ    0xF80       ; Jump to 0xF80 if Zero flag is clear (result was non-zero)
0xF79:  B50  LD_X     0x50        ; Set X pointer to RAM address 0x50 (MEM_CHARACTER)
0xF7A:  DEF  CP_R_I   [X], #15    ; Compare register [X] with immediate value #15
0xF7B:  37E  JP_NC    0xF7E       ; Jump to 0xF7E if Carry flag is clear (no overflow)
0xF7C:  E05  LD_R_I   A, #5       ; Load A with immediate value #5
0xF7D:  0D4  JP       0xFD4       ; Jump to address 0xFD4
0xF7E:  B4E  LD_X     0x4E        ; Set X pointer to RAM address 0x4E
0xF7F:  E2F  LD_R_I   [X], #15    ; Load [X] with immediate value #15
0xF80:  806  LD_Y     0x06        ; Set Y pointer to RAM address 0x06
0xF81:  5D4  CALZ     0xFD4       ; Call subroutine at 0xFD4 if Zero flag is set
0xF82:  785  JP_NZ    0xF85       ; Jump to 0xF85 if Zero flag is clear (result was non-zero)
0xF83:  E04  LD_R_I   A, #4       ; Load A with immediate value #4
0xF84:  0D4  JP       0xFD4       ; Jump to address 0xFD4
0xF85:  5FD  CALZ     0xFFD       ; Call subroutine at 0xFFD if Zero flag is set
0xF86:  78D  JP_NZ    0xF8D       ; Jump to 0xF8D if Zero flag is clear (result was non-zero)
0xF87:  80D  LD_Y     0x0D        ; Set Y pointer to RAM address 0x0D
0xF88:  5D7  CALZ     0xFD7       ; Call subroutine at 0xFD7 if Zero flag is set
0xF89:  78D  JP_NZ    0xF8D       ; Jump to 0xF8D if Zero flag is clear (result was non-zero)
0xF8A:  E2F  LD_R_I   [X], #15    ; Load [X] with immediate value #15
0xF8B:  B49  LD_X     0x49        ; Set X pointer to RAM address 0x49 (MEM_SICK)
0xF8C:  C21  ADD_R_I  [X], #1     ; Add immediate #1 to register [X]
0xF8D:  800  LD_Y     0x00        ; Set Y pointer to RAM address 0x00
0xF8E:  5D4  CALZ     0xFD4       ; Call subroutine at 0xFD4 if Zero flag is set
0xF8F:  7A2  JP_NZ    0xFA2       ; Jump to 0xFA2 if Zero flag is clear (result was non-zero)
0xF90:  834  LD_Y     0x34        ; Set Y pointer to RAM address 0x34
0xF91:  EF3  UNKNOWN              ; Unrecognized instruction: 0xEF3
0xF92:  EC7  LD_R_Q   B, [Y]      ; Copy value from [Y] into B
0xF93:  800  LD_Y     0x00        ; Set Y pointer to RAM address 0x00
0xF94:  512  CALZ     0xF12       ; Call subroutine at 0xF12 if Zero flag is set
0xF95:  EFC  UNKNOWN              ; Unrecognized instruction: 0xEFC
0xF96:  ECD  LD_R_Q   [Y], B      ; Copy value from B into [Y]
0xF97:  509  CALZ     0xF09       ; Call subroutine at 0xF09 if Zero flag is set
0xF98:  B40  LD_X     0x40        ; Set X pointer to RAM address 0x40 (MEM_HUNGER)
0xF99:  C2C  ADD_R_I  [X], #12    ; Add immediate #12 to register [X]
0xF9A:  29E  JP_C     0xF9E       ; Jump to 0xF9E if Carry flag is set (overflow occurred)
0xF9B:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0xF9C:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0xF9D:  0D4  JP       0xFD4       ; Jump to address 0xFD4
0xF9E:  813  LD_Y     0x13        ; Set Y pointer to RAM address 0x13
0xF9F:  C3F  ADD_R_I  [Y], #15    ; Add immediate #15 to register [Y]
0xFA0:  2A2  JP_C     0xFA2       ; Jump to 0xFA2 if Carry flag is set (overflow occurred)
0xFA1:  E30  LD_R_I   [Y], #0     ; Load [Y] with immediate value #0
0xFA2:  802  LD_Y     0x02        ; Set Y pointer to RAM address 0x02
0xFA3:  5D4  CALZ     0xFD4       ; Call subroutine at 0xFD4 if Zero flag is set
0xFA4:  7B7  JP_NZ    0xFB7       ; Jump to 0xFB7 if Zero flag is clear (result was non-zero)
0xFA5:  836  LD_Y     0x36        ; Set Y pointer to RAM address 0x36
0xFA6:  EF3  UNKNOWN              ; Unrecognized instruction: 0xEF3
0xFA7:  EC7  LD_R_Q   B, [Y]      ; Copy value from [Y] into B
0xFA8:  802  LD_Y     0x02        ; Set Y pointer to RAM address 0x02
0xFA9:  512  CALZ     0xF12       ; Call subroutine at 0xF12 if Zero flag is set
0xFAA:  EFC  UNKNOWN              ; Unrecognized instruction: 0xEFC
0xFAB:  ECD  LD_R_Q   [Y], B      ; Copy value from B into [Y]
0xFAC:  509  CALZ     0xF09       ; Call subroutine at 0xF09 if Zero flag is set
0xFAD:  B41  LD_X     0x41        ; Set X pointer to RAM address 0x41 (MEM_HAPPY)
0xFAE:  C2C  ADD_R_I  [X], #12    ; Add immediate #12 to register [X]
0xFAF:  2B3  JP_C     0xFB3       ; Jump to 0xFB3 if Carry flag is set (overflow occurred)
0xFB0:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0xFB1:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0xFB2:  0D4  JP       0xFD4       ; Jump to address 0xFD4
0xFB3:  813  LD_Y     0x13        ; Set Y pointer to RAM address 0x13
0xFB4:  C3F  ADD_R_I  [Y], #15    ; Add immediate #15 to register [Y]
0xFB5:  2B7  JP_C     0xFB7       ; Jump to 0xFB7 if Carry flag is set (overflow occurred)
0xFB6:  E30  LD_R_I   [Y], #0     ; Load [Y] with immediate value #0
0xFB7:  843  LD_Y     0x43        ; Set Y pointer to RAM address 0x43 (MEM_DISCIPLINE)
0xFB8:  EC3  LD_R_Q   A, [Y]      ; Copy value from [Y] into A
0xFB9:  813  LD_Y     0x13        ; Set Y pointer to RAM address 0x13
0xFBA:  DF0  CP_R_I   [Y], #0     ; Compare register [Y] with immediate value #0
0xFBB:  7C6  JP_NZ    0xFC6       ; Jump to 0xFC6 if Zero flag is clear (result was non-zero)
0xFBC:  ECC  LD_R_Q   [Y], A      ; Copy value from A into [Y]
0xFBD:  814  LD_Y     0x14        ; Set Y pointer to RAM address 0x14
0xFBE:  B43  LD_X     0x43        ; Set X pointer to RAM address 0x43 (MEM_DISCIPLINE)
0xFBF:  F41  SCF                  ; Set Carry Flag
0xFC0:  A9E  ADC_R_Q  [Y], [X]    ; Add value of [X] plus Carry to register [Y]
0xFC1:  2C6  JP_C     0xFC6       ; Jump to 0xFC6 if Carry flag is set (overflow occurred)
0xFC2:  5F8  CALZ     0xFF8       ; Call subroutine at 0xFF8 if Zero flag is set
0xFC3:  6C6  JP_Z     0xFC6       ; Jump to 0xFC6 if Zero flag is set (result was zero)
0xFC4:  E03  LD_R_I   A, #3       ; Load A with immediate value #3
0xFC5:  0D4  JP       0xFD4       ; Jump to address 0xFD4
0xFC6:  808  LD_Y     0x08        ; Set Y pointer to RAM address 0x08
0xFC7:  DFF  CP_R_I   [Y], #15    ; Compare register [Y] with immediate value #15
0xFC8:  7CD  JP_NZ    0xFCD       ; Jump to 0xFCD if Zero flag is clear (result was non-zero)
0xFC9:  E30  LD_R_I   [Y], #0     ; Load [Y] with immediate value #0
0xFCA:  5F8  CALZ     0xFF8       ; Call subroutine at 0xFF8 if Zero flag is set
0xFCB:  6CD  JP_Z     0xFCD       ; Jump to 0xFCD if Zero flag is set (result was zero)
0xFCC:  4DF  CALL     0xFDF       ; Call subroutine at 0xFDF (INC_NEGLECT)
0xFCD:  809  LD_Y     0x09        ; Set Y pointer to RAM address 0x09
0xFCE:  DFF  CP_R_I   [Y], #15    ; Compare register [Y] with immediate value #15
0xFCF:  7D3  JP_NZ    0xFD3       ; Jump to 0xFD3 if Zero flag is clear (result was non-zero)
0xFD0:  E30  LD_R_I   [Y], #0     ; Load [Y] with immediate value #0

; =========================================================
; ROUTINE: INC_BEHAVIOR_MISTAKE
; Location: 0xFD1 (Page 15, Step D1)
; Trigger:  Discipline call timed out or was ignored
; Logic:    Increments [0x51] using saturated logic (max 15)
; =========================================================

0xFD1:  B51  LD_X     0x51        ; Set X pointer to RAM address 0x51 (MEM_BEHAVIOR_MISTAKE)
0xFD2:  4E8  CALL     0xFE8       ; Call subroutine at 0xFE8 (SATURATED_INC_ROUTINE)
0xFD3:  0D6  JP       0xFD6       ; Jump to address 0xFD6
0xFD4:  B5C  LD_X     0x5C        ; Set X pointer to RAM address 0x5C
0xFD5:  EC8  LD_R_Q   [X], A      ; Copy value from A into [X]
0xFD6:  B5C  LD_X     0x5C        ; Set X pointer to RAM address 0x5C
0xFD7:  DE0  CP_R_I   [X], #0     ; Compare register [X] with immediate value #0
0xFD8:  FDF  RET                  ; Return to caller
0xFD9:  F07  UNKNOWN              ; Unrecognized instruction: 0xF07
0xFDA:  7DE  JP_NZ    0xFDE       ; Jump to 0xFDE if Zero flag is clear (result was non-zero)
0xFDB:  A3F  UNKNOWN              ; Unrecognized instruction: 0xA3F
0xFDC:  A2F  UNKNOWN              ; Unrecognized instruction: 0xA2F
0xFDD:  F03  UNKNOWN              ; Unrecognized instruction: 0xF03
0xFDE:  FDF  RET                  ; Return to caller

; =========================================================
; ROUTINE: INC_NEGLECT
; Location: 0xFDF (Page 15, Step DF)
; Trigger:  Attention call (Hunger/Happy=0) timed out
; Logic:    Increments [0x42] using saturated logic (max 15)
; =========================================================

0xFDF:  B42  LD_X     0x42        ; Set X pointer to RAM address 0x42 (MEM_NEGLECT)
0xFE0:  4E8  CALL     0xFE8       ; Call subroutine at 0xFE8 (SATURATED_INC_ROUTINE)
0xFE1:  B50  LD_X     0x50        ; Set X pointer to RAM address 0x50 (MEM_CHARACTER)
0xFE2:  DEF  CP_R_I   [X], #15    ; Compare register [X] with immediate value #15
0xFE3:  7EB  JP_NZ    0xFEB       ; Jump to 0xFEB if Zero flag is clear (result was non-zero)
0xFE4:  810  LD_Y     0x10        ; Set Y pointer to RAM address 0x10
0xFE5:  5D7  CALZ     0xFD7       ; Call subroutine at 0xFD7 if Zero flag is set
0xFE6:  7EB  JP_NZ    0xFEB       ; Jump to 0xFEB if Zero flag is clear (result was non-zero)
0xFE7:  B4F  LD_X     0x4F        ; Set X pointer to RAM address 0x4F

; =========================================================
; ROUTINE: SATURATED_INC_ROUTINE
; Location: 0xFE8 (Page 15, Step E8)
; Trigger:  Internal sub-call
; Logic:    [X] = Min([X] + 1, 15). Prevents overflow wrap-around.
; =========================================================

0xFE8:  C21  ADD_R_I  [X], #1     ; Add immediate #1 to register [X]
0xFE9:  3EB  JP_NC    0xFEB       ; Jump to 0xFEB if Carry flag is clear (no overflow)
0xFEA:  E2F  LD_R_I   [X], #15    ; Load [X] with immediate value #15
0xFEB:  FDF  RET                  ; Return to caller
0xFEC:  5EF  CALZ     0xFEF       ; Call subroutine at 0xFEF if Zero flag is set
0xFED:  B7C  LD_X     0x7C        ; Set X pointer to RAM address 0x7C
0xFEE:  E2F  LD_R_I   [X], #15    ; Load [X] with immediate value #15
0xFEF:  E06  LD_R_I   A, #6       ; Load A with immediate value #6
0xFF0:  8D1  LD_Y     0xD1        ; Set Y pointer to RAM address 0xD1 (INC_BEHAVIOR_MISTAKE)
0xFF1:  5B7  CALZ     0xFB7       ; Call subroutine at 0xFB7 if Zero flag is set
0xFF2:  E02  LD_R_I   A, #2       ; Load A with immediate value #2
0xFF3:  E14  LD_R_I   B, #4       ; Load B with immediate value #4
0xFF4:  E48  PSET     8           ; Set NP (New Page) to 8 for the next jump/call
0xFF5:  4A8  CALL     0x8A8       ; Call subroutine at 0x8A8
0xFF6:  5EF  CALZ     0x8EF       ; Call subroutine at 0x8EF if Zero flag is set
0xFF7:  B74  LD_X     0x74        ; Set X pointer to RAM address 0x74
0xFF8:  E6F  LDPX_MX  #F          ; Load constant #15 into [X] and increment X
0xFF9:  B5D  LD_X     0x5D        ; Set X pointer to RAM address 0x5D (MEM_LIFECYCLE)
0xFFA:  911  LBPX     #11         ; Load constant #17 into [X]
0xFFB:  E44  PSET     4           ; Set NP (New Page) to 4 for the next jump/call
0xFFC:  465  CALL     0x465       ; Call subroutine at 0x465
0xFFD:  E4D  PSET     13          ; Set NP (New Page) to 13 for the next jump/call
0xFFE:  0D2  JP       0xDD2       ; Jump to address 0xDD2
0xFFF:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x1000:  FA0  LD_A_MN  0x00        ; Load A from direct RAM address 0x00
0x1001:  FB1  LD_B_MN  0x01        ; Load B from direct RAM address 0x01
0x1002:  E50  PSET     16          ; Set NP (New Page) to 16 for the next jump/call
0x1003:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0x1004:  FA0  LD_A_MN  0x00        ; Load A from direct RAM address 0x00
0x1005:  FB1  LD_B_MN  0x01        ; Load B from direct RAM address 0x01
0x1006:  E51  PSET     17          ; Set NP (New Page) to 17 for the next jump/call
0x1007:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0x1008:  FA0  LD_A_MN  0x00        ; Load A from direct RAM address 0x00
0x1009:  FB1  LD_B_MN  0x01        ; Load B from direct RAM address 0x01
0x100A:  E52  PSET     18          ; Set NP (New Page) to 18 for the next jump/call
0x100B:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0x100C:  FA0  LD_A_MN  0x00        ; Load A from direct RAM address 0x00
0x100D:  FB1  LD_B_MN  0x01        ; Load B from direct RAM address 0x01
0x100E:  E53  PSET     19          ; Set NP (New Page) to 19 for the next jump/call
0x100F:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0x1010:  FA0  LD_A_MN  0x00        ; Load A from direct RAM address 0x00
0x1011:  FB1  LD_B_MN  0x01        ; Load B from direct RAM address 0x01
0x1012:  E54  PSET     20          ; Set NP (New Page) to 20 for the next jump/call
0x1013:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0x1014:  FA0  LD_A_MN  0x00        ; Load A from direct RAM address 0x00
0x1015:  FB1  LD_B_MN  0x01        ; Load B from direct RAM address 0x01
0x1016:  E55  PSET     21          ; Set NP (New Page) to 21 for the next jump/call
0x1017:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0x1018:  FA0  LD_A_MN  0x00        ; Load A from direct RAM address 0x00
0x1019:  FB1  LD_B_MN  0x01        ; Load B from direct RAM address 0x01
0x101A:  E56  PSET     22          ; Set NP (New Page) to 22 for the next jump/call
0x101B:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0x101C:  FA0  LD_A_MN  0x00        ; Load A from direct RAM address 0x00
0x101D:  FB1  LD_B_MN  0x01        ; Load B from direct RAM address 0x01
0x101E:  E57  PSET     23          ; Set NP (New Page) to 23 for the next jump/call
0x101F:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0x1020:  423  CALL     0x1723      ; Call subroutine at 0x1723
0x1021:  E40  PSET     0           ; Set NP (New Page) to 0 for the next jump/call
0x1022:  009  JP       0x009       ; Jump to address 0x009
0x1023:  FE8  UNKNOWN              ; Unrecognized instruction: 0xFE8
0x1024:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x1025:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x1026:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x1027:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x1028:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x1029:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x102A:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x102B:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x102C:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x102D:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x102E:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x102F:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x1030:  900  LBPX     #0          ; Load constant #0 into [X]
0x1031:  900  LBPX     #0          ; Load constant #0 into [X]
0x1032:  900  LBPX     #0          ; Load constant #0 into [X]
0x1033:  900  LBPX     #0          ; Load constant #0 into [X]
0x1034:  900  LBPX     #0          ; Load constant #0 into [X]
0x1035:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x1036:  97A  LBPX     #7A         ; Load constant #122 into [X]
0x1037:  96E  LBPX     #6E         ; Load constant #110 into [X]
0x1038:  96E  LBPX     #6E         ; Load constant #110 into [X]
0x1039:  97A  LBPX     #7A         ; Load constant #122 into [X]
0x103A:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x103B:  900  LBPX     #0          ; Load constant #0 into [X]
0x103C:  900  LBPX     #0          ; Load constant #0 into [X]
0x103D:  900  LBPX     #0          ; Load constant #0 into [X]
0x103E:  900  LBPX     #0          ; Load constant #0 into [X]
0x103F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1040:  900  LBPX     #0          ; Load constant #0 into [X]
0x1041:  900  LBPX     #0          ; Load constant #0 into [X]
0x1042:  900  LBPX     #0          ; Load constant #0 into [X]
0x1043:  900  LBPX     #0          ; Load constant #0 into [X]
0x1044:  980  LBPX     #80         ; Load constant #128 into [X]
0x1045:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x1046:  9A0  LBPX     #A0         ; Load constant #160 into [X]
0x1047:  9E0  LBPX     #E0         ; Load constant #224 into [X]
0x1048:  9E0  LBPX     #E0         ; Load constant #224 into [X]
0x1049:  9A0  LBPX     #A0         ; Load constant #160 into [X]
0x104A:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x104B:  980  LBPX     #80         ; Load constant #128 into [X]
0x104C:  900  LBPX     #0          ; Load constant #0 into [X]
0x104D:  900  LBPX     #0          ; Load constant #0 into [X]
0x104E:  900  LBPX     #0          ; Load constant #0 into [X]
0x104F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1050:  900  LBPX     #0          ; Load constant #0 into [X]
0x1051:  900  LBPX     #0          ; Load constant #0 into [X]
0x1052:  900  LBPX     #0          ; Load constant #0 into [X]
0x1053:  900  LBPX     #0          ; Load constant #0 into [X]
0x1054:  900  LBPX     #0          ; Load constant #0 into [X]
0x1055:  940  LBPX     #40         ; Load constant #64 into [X]
0x1056:  943  LBPX     #43         ; Load constant #67 into [X]
0x1057:  967  LBPX     #67         ; Load constant #103 into [X]
0x1058:  97E  LBPX     #7E         ; Load constant #126 into [X]
0x1059:  96E  LBPX     #6E         ; Load constant #110 into [X]
0x105A:  938  LBPX     #38         ; Load constant #56 into [X]
0x105B:  900  LBPX     #0          ; Load constant #0 into [X]
0x105C:  900  LBPX     #0          ; Load constant #0 into [X]
0x105D:  900  LBPX     #0          ; Load constant #0 into [X]
0x105E:  900  LBPX     #0          ; Load constant #0 into [X]
0x105F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1060:  900  LBPX     #0          ; Load constant #0 into [X]
0x1061:  900  LBPX     #0          ; Load constant #0 into [X]
0x1062:  900  LBPX     #0          ; Load constant #0 into [X]
0x1063:  900  LBPX     #0          ; Load constant #0 into [X]
0x1064:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x1065:  9A0  LBPX     #A0         ; Load constant #160 into [X]
0x1066:  9A0  LBPX     #A0         ; Load constant #160 into [X]
0x1067:  9E0  LBPX     #E0         ; Load constant #224 into [X]
0x1068:  9E0  LBPX     #E0         ; Load constant #224 into [X]
0x1069:  9A0  LBPX     #A0         ; Load constant #160 into [X]
0x106A:  9A0  LBPX     #A0         ; Load constant #160 into [X]
0x106B:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x106C:  900  LBPX     #0          ; Load constant #0 into [X]
0x106D:  900  LBPX     #0          ; Load constant #0 into [X]
0x106E:  900  LBPX     #0          ; Load constant #0 into [X]
0x106F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1070:  900  LBPX     #0          ; Load constant #0 into [X]
0x1071:  900  LBPX     #0          ; Load constant #0 into [X]
0x1072:  900  LBPX     #0          ; Load constant #0 into [X]
0x1073:  900  LBPX     #0          ; Load constant #0 into [X]
0x1074:  900  LBPX     #0          ; Load constant #0 into [X]
0x1075:  91E  LBPX     #1E         ; Load constant #30 into [X]
0x1076:  93D  LBPX     #3D         ; Load constant #61 into [X]
0x1077:  927  LBPX     #27         ; Load constant #39 into [X]
0x1078:  927  LBPX     #27         ; Load constant #39 into [X]
0x1079:  93D  LBPX     #3D         ; Load constant #61 into [X]
0x107A:  91E  LBPX     #1E         ; Load constant #30 into [X]
0x107B:  900  LBPX     #0          ; Load constant #0 into [X]
0x107C:  900  LBPX     #0          ; Load constant #0 into [X]
0x107D:  900  LBPX     #0          ; Load constant #0 into [X]
0x107E:  900  LBPX     #0          ; Load constant #0 into [X]
0x107F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1080:  900  LBPX     #0          ; Load constant #0 into [X]
0x1081:  900  LBPX     #0          ; Load constant #0 into [X]
0x1082:  900  LBPX     #0          ; Load constant #0 into [X]
0x1083:  900  LBPX     #0          ; Load constant #0 into [X]
0x1084:  900  LBPX     #0          ; Load constant #0 into [X]
0x1085:  92C  LBPX     #2C         ; Load constant #44 into [X]
0x1086:  96E  LBPX     #6E         ; Load constant #110 into [X]
0x1087:  97A  LBPX     #7A         ; Load constant #122 into [X]
0x1088:  97A  LBPX     #7A         ; Load constant #122 into [X]
0x1089:  97E  LBPX     #7E         ; Load constant #126 into [X]
0x108A:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x108B:  900  LBPX     #0          ; Load constant #0 into [X]
0x108C:  900  LBPX     #0          ; Load constant #0 into [X]
0x108D:  900  LBPX     #0          ; Load constant #0 into [X]
0x108E:  900  LBPX     #0          ; Load constant #0 into [X]
0x108F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1090:  900  LBPX     #0          ; Load constant #0 into [X]
0x1091:  900  LBPX     #0          ; Load constant #0 into [X]
0x1092:  900  LBPX     #0          ; Load constant #0 into [X]
0x1093:  900  LBPX     #0          ; Load constant #0 into [X]
0x1094:  90E  LBPX     #E          ; Load constant #14 into [X]
0x1095:  93D  LBPX     #3D         ; Load constant #61 into [X]
0x1096:  97B  LBPX     #7B         ; Load constant #123 into [X]
0x1097:  94F  LBPX     #4F         ; Load constant #79 into [X]
0x1098:  94F  LBPX     #4F         ; Load constant #79 into [X]
0x1099:  97B  LBPX     #7B         ; Load constant #123 into [X]
0x109A:  93D  LBPX     #3D         ; Load constant #61 into [X]
0x109B:  90E  LBPX     #E          ; Load constant #14 into [X]
0x109C:  900  LBPX     #0          ; Load constant #0 into [X]
0x109D:  900  LBPX     #0          ; Load constant #0 into [X]
0x109E:  900  LBPX     #0          ; Load constant #0 into [X]
0x109F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x10A0:  900  LBPX     #0          ; Load constant #0 into [X]
0x10A1:  900  LBPX     #0          ; Load constant #0 into [X]
0x10A2:  900  LBPX     #0          ; Load constant #0 into [X]
0x10A3:  9E0  LBPX     #E0         ; Load constant #224 into [X]
0x10A4:  910  LBPX     #10         ; Load constant #16 into [X]
0x10A5:  908  LBPX     #8          ; Load constant #8 into [X]
0x10A6:  928  LBPX     #28         ; Load constant #40 into [X]
0x10A7:  988  LBPX     #88         ; Load constant #136 into [X]
0x10A8:  988  LBPX     #88         ; Load constant #136 into [X]
0x10A9:  928  LBPX     #28         ; Load constant #40 into [X]
0x10AA:  908  LBPX     #8          ; Load constant #8 into [X]
0x10AB:  910  LBPX     #10         ; Load constant #16 into [X]
0x10AC:  9E0  LBPX     #E0         ; Load constant #224 into [X]
0x10AD:  900  LBPX     #0          ; Load constant #0 into [X]
0x10AE:  900  LBPX     #0          ; Load constant #0 into [X]
0x10AF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x10B0:  900  LBPX     #0          ; Load constant #0 into [X]
0x10B1:  900  LBPX     #0          ; Load constant #0 into [X]
0x10B2:  900  LBPX     #0          ; Load constant #0 into [X]
0x10B3:  903  LBPX     #3          ; Load constant #3 into [X]
0x10B4:  904  LBPX     #4          ; Load constant #4 into [X]
0x10B5:  908  LBPX     #8          ; Load constant #8 into [X]
0x10B6:  908  LBPX     #8          ; Load constant #8 into [X]
0x10B7:  908  LBPX     #8          ; Load constant #8 into [X]
0x10B8:  908  LBPX     #8          ; Load constant #8 into [X]
0x10B9:  908  LBPX     #8          ; Load constant #8 into [X]
0x10BA:  908  LBPX     #8          ; Load constant #8 into [X]
0x10BB:  904  LBPX     #4          ; Load constant #4 into [X]
0x10BC:  903  LBPX     #3          ; Load constant #3 into [X]
0x10BD:  900  LBPX     #0          ; Load constant #0 into [X]
0x10BE:  900  LBPX     #0          ; Load constant #0 into [X]
0x10BF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x10C0:  900  LBPX     #0          ; Load constant #0 into [X]
0x10C1:  900  LBPX     #0          ; Load constant #0 into [X]
0x10C2:  900  LBPX     #0          ; Load constant #0 into [X]
0x10C3:  9E0  LBPX     #E0         ; Load constant #224 into [X]
0x10C4:  910  LBPX     #10         ; Load constant #16 into [X]
0x10C5:  928  LBPX     #28         ; Load constant #40 into [X]
0x10C6:  908  LBPX     #8          ; Load constant #8 into [X]
0x10C7:  9C8  LBPX     #C8         ; Load constant #200 into [X]
0x10C8:  9C8  LBPX     #C8         ; Load constant #200 into [X]
0x10C9:  908  LBPX     #8          ; Load constant #8 into [X]
0x10CA:  928  LBPX     #28         ; Load constant #40 into [X]
0x10CB:  910  LBPX     #10         ; Load constant #16 into [X]
0x10CC:  9E0  LBPX     #E0         ; Load constant #224 into [X]
0x10CD:  900  LBPX     #0          ; Load constant #0 into [X]
0x10CE:  900  LBPX     #0          ; Load constant #0 into [X]
0x10CF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x10D0:  900  LBPX     #0          ; Load constant #0 into [X]
0x10D1:  900  LBPX     #0          ; Load constant #0 into [X]
0x10D2:  900  LBPX     #0          ; Load constant #0 into [X]
0x10D3:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x10D4:  986  LBPX     #86         ; Load constant #134 into [X]
0x10D5:  9CD  LBPX     #CD         ; Load constant #205 into [X]
0x10D6:  999  LBPX     #99         ; Load constant #153 into [X]
0x10D7:  9F1  LBPX     #F1         ; Load constant #241 into [X]
0x10D8:  901  LBPX     #1          ; Load constant #1 into [X]
0x10D9:  911  LBPX     #11         ; Load constant #17 into [X]
0x10DA:  912  LBPX     #12         ; Load constant #18 into [X]
0x10DB:  904  LBPX     #4          ; Load constant #4 into [X]
0x10DC:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x10DD:  900  LBPX     #0          ; Load constant #0 into [X]
0x10DE:  900  LBPX     #0          ; Load constant #0 into [X]
0x10DF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x10E0:  900  LBPX     #0          ; Load constant #0 into [X]
0x10E1:  900  LBPX     #0          ; Load constant #0 into [X]
0x10E2:  900  LBPX     #0          ; Load constant #0 into [X]
0x10E3:  901  LBPX     #1          ; Load constant #1 into [X]
0x10E4:  902  LBPX     #2          ; Load constant #2 into [X]
0x10E5:  904  LBPX     #4          ; Load constant #4 into [X]
0x10E6:  904  LBPX     #4          ; Load constant #4 into [X]
0x10E7:  904  LBPX     #4          ; Load constant #4 into [X]
0x10E8:  904  LBPX     #4          ; Load constant #4 into [X]
0x10E9:  904  LBPX     #4          ; Load constant #4 into [X]
0x10EA:  904  LBPX     #4          ; Load constant #4 into [X]
0x10EB:  902  LBPX     #2          ; Load constant #2 into [X]
0x10EC:  901  LBPX     #1          ; Load constant #1 into [X]
0x10ED:  900  LBPX     #0          ; Load constant #0 into [X]
0x10EE:  900  LBPX     #0          ; Load constant #0 into [X]
0x10EF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x10F0:  900  LBPX     #0          ; Load constant #0 into [X]
0x10F1:  900  LBPX     #0          ; Load constant #0 into [X]
0x10F2:  900  LBPX     #0          ; Load constant #0 into [X]
0x10F3:  9E0  LBPX     #E0         ; Load constant #224 into [X]
0x10F4:  990  LBPX     #90         ; Load constant #144 into [X]
0x10F5:  988  LBPX     #88         ; Load constant #136 into [X]
0x10F6:  988  LBPX     #88         ; Load constant #136 into [X]
0x10F7:  928  LBPX     #28         ; Load constant #40 into [X]
0x10F8:  908  LBPX     #8          ; Load constant #8 into [X]
0x10F9:  908  LBPX     #8          ; Load constant #8 into [X]
0x10FA:  908  LBPX     #8          ; Load constant #8 into [X]
0x10FB:  910  LBPX     #10         ; Load constant #16 into [X]
0x10FC:  9E0  LBPX     #E0         ; Load constant #224 into [X]
0x10FD:  900  LBPX     #0          ; Load constant #0 into [X]
0x10FE:  900  LBPX     #0          ; Load constant #0 into [X]
0x10FF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1100:  900  LBPX     #0          ; Load constant #0 into [X]
0x1101:  900  LBPX     #0          ; Load constant #0 into [X]
0x1102:  900  LBPX     #0          ; Load constant #0 into [X]
0x1103:  9E0  LBPX     #E0         ; Load constant #224 into [X]
0x1104:  910  LBPX     #10         ; Load constant #16 into [X]
0x1105:  928  LBPX     #28         ; Load constant #40 into [X]
0x1106:  928  LBPX     #28         ; Load constant #40 into [X]
0x1107:  988  LBPX     #88         ; Load constant #136 into [X]
0x1108:  988  LBPX     #88         ; Load constant #136 into [X]
0x1109:  928  LBPX     #28         ; Load constant #40 into [X]
0x110A:  928  LBPX     #28         ; Load constant #40 into [X]
0x110B:  910  LBPX     #10         ; Load constant #16 into [X]
0x110C:  9E0  LBPX     #E0         ; Load constant #224 into [X]
0x110D:  900  LBPX     #0          ; Load constant #0 into [X]
0x110E:  900  LBPX     #0          ; Load constant #0 into [X]
0x110F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1110:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x1111:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x1112:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x1113:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x1114:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x1115:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x1116:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x1117:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x1118:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x1119:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x111A:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x111B:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x111C:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x111D:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x111E:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x111F:  1FF  UNKNOWN              ; Unrecognized instruction: 0x1FF
0x1120:  900  LBPX     #0          ; Load constant #0 into [X]
0x1121:  900  LBPX     #0          ; Load constant #0 into [X]
0x1122:  900  LBPX     #0          ; Load constant #0 into [X]
0x1123:  9E0  LBPX     #E0         ; Load constant #224 into [X]
0x1124:  990  LBPX     #90         ; Load constant #144 into [X]
0x1125:  988  LBPX     #88         ; Load constant #136 into [X]
0x1126:  988  LBPX     #88         ; Load constant #136 into [X]
0x1127:  928  LBPX     #28         ; Load constant #40 into [X]
0x1128:  928  LBPX     #28         ; Load constant #40 into [X]
0x1129:  908  LBPX     #8          ; Load constant #8 into [X]
0x112A:  908  LBPX     #8          ; Load constant #8 into [X]
0x112B:  910  LBPX     #10         ; Load constant #16 into [X]
0x112C:  9E0  LBPX     #E0         ; Load constant #224 into [X]
0x112D:  900  LBPX     #0          ; Load constant #0 into [X]
0x112E:  900  LBPX     #0          ; Load constant #0 into [X]
0x112F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1130:  900  LBPX     #0          ; Load constant #0 into [X]
0x1131:  900  LBPX     #0          ; Load constant #0 into [X]
0x1132:  900  LBPX     #0          ; Load constant #0 into [X]
0x1133:  9FC  LBPX     #FC         ; Load constant #252 into [X]
0x1134:  902  LBPX     #2          ; Load constant #2 into [X]
0x1135:  979  LBPX     #79         ; Load constant #121 into [X]
0x1136:  9F3  LBPX     #F3         ; Load constant #243 into [X]
0x1137:  9F1  LBPX     #F1         ; Load constant #241 into [X]
0x1138:  9F1  LBPX     #F1         ; Load constant #241 into [X]
0x1139:  9F3  LBPX     #F3         ; Load constant #243 into [X]
0x113A:  979  LBPX     #79         ; Load constant #121 into [X]
0x113B:  902  LBPX     #2          ; Load constant #2 into [X]
0x113C:  9FC  LBPX     #FC         ; Load constant #252 into [X]
0x113D:  900  LBPX     #0          ; Load constant #0 into [X]
0x113E:  900  LBPX     #0          ; Load constant #0 into [X]
0x113F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1140:  900  LBPX     #0          ; Load constant #0 into [X]
0x1141:  900  LBPX     #0          ; Load constant #0 into [X]
0x1142:  900  LBPX     #0          ; Load constant #0 into [X]
0x1143:  9E0  LBPX     #E0         ; Load constant #224 into [X]
0x1144:  910  LBPX     #10         ; Load constant #16 into [X]
0x1145:  908  LBPX     #8          ; Load constant #8 into [X]
0x1146:  928  LBPX     #28         ; Load constant #40 into [X]
0x1147:  988  LBPX     #88         ; Load constant #136 into [X]
0x1148:  988  LBPX     #88         ; Load constant #136 into [X]
0x1149:  928  LBPX     #28         ; Load constant #40 into [X]
0x114A:  908  LBPX     #8          ; Load constant #8 into [X]
0x114B:  910  LBPX     #10         ; Load constant #16 into [X]
0x114C:  9E0  LBPX     #E0         ; Load constant #224 into [X]
0x114D:  900  LBPX     #0          ; Load constant #0 into [X]
0x114E:  900  LBPX     #0          ; Load constant #0 into [X]
0x114F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1150:  900  LBPX     #0          ; Load constant #0 into [X]
0x1151:  900  LBPX     #0          ; Load constant #0 into [X]
0x1152:  901  LBPX     #1          ; Load constant #1 into [X]
0x1153:  907  LBPX     #7          ; Load constant #7 into [X]
0x1154:  918  LBPX     #18         ; Load constant #24 into [X]
0x1155:  920  LBPX     #20         ; Load constant #32 into [X]
0x1156:  918  LBPX     #18         ; Load constant #24 into [X]
0x1157:  908  LBPX     #8          ; Load constant #8 into [X]
0x1158:  908  LBPX     #8          ; Load constant #8 into [X]
0x1159:  908  LBPX     #8          ; Load constant #8 into [X]
0x115A:  910  LBPX     #10         ; Load constant #16 into [X]
0x115B:  909  LBPX     #9          ; Load constant #9 into [X]
0x115C:  907  LBPX     #7          ; Load constant #7 into [X]
0x115D:  901  LBPX     #1          ; Load constant #1 into [X]
0x115E:  900  LBPX     #0          ; Load constant #0 into [X]
0x115F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1160:  900  LBPX     #0          ; Load constant #0 into [X]
0x1161:  900  LBPX     #0          ; Load constant #0 into [X]
0x1162:  900  LBPX     #0          ; Load constant #0 into [X]
0x1163:  903  LBPX     #3          ; Load constant #3 into [X]
0x1164:  904  LBPX     #4          ; Load constant #4 into [X]
0x1165:  918  LBPX     #18         ; Load constant #24 into [X]
0x1166:  920  LBPX     #20         ; Load constant #32 into [X]
0x1167:  918  LBPX     #18         ; Load constant #24 into [X]
0x1168:  918  LBPX     #18         ; Load constant #24 into [X]
0x1169:  928  LBPX     #28         ; Load constant #40 into [X]
0x116A:  918  LBPX     #18         ; Load constant #24 into [X]
0x116B:  904  LBPX     #4          ; Load constant #4 into [X]
0x116C:  903  LBPX     #3          ; Load constant #3 into [X]
0x116D:  900  LBPX     #0          ; Load constant #0 into [X]
0x116E:  900  LBPX     #0          ; Load constant #0 into [X]
0x116F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1170:  900  LBPX     #0          ; Load constant #0 into [X]
0x1171:  900  LBPX     #0          ; Load constant #0 into [X]
0x1172:  900  LBPX     #0          ; Load constant #0 into [X]
0x1173:  903  LBPX     #3          ; Load constant #3 into [X]
0x1174:  91C  LBPX     #1C         ; Load constant #28 into [X]
0x1175:  928  LBPX     #28         ; Load constant #40 into [X]
0x1176:  918  LBPX     #18         ; Load constant #24 into [X]
0x1177:  908  LBPX     #8          ; Load constant #8 into [X]
0x1178:  908  LBPX     #8          ; Load constant #8 into [X]
0x1179:  910  LBPX     #10         ; Load constant #16 into [X]
0x117A:  920  LBPX     #20         ; Load constant #32 into [X]
0x117B:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x117C:  903  LBPX     #3          ; Load constant #3 into [X]
0x117D:  900  LBPX     #0          ; Load constant #0 into [X]
0x117E:  900  LBPX     #0          ; Load constant #0 into [X]
0x117F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1180:  900  LBPX     #0          ; Load constant #0 into [X]
0x1181:  97E  LBPX     #7E         ; Load constant #126 into [X]
0x1182:  981  LBPX     #81         ; Load constant #129 into [X]
0x1183:  999  LBPX     #99         ; Load constant #153 into [X]
0x1184:  9AF  LBPX     #AF         ; Load constant #175 into [X]
0x1185:  9B5  LBPX     #B5         ; Load constant #181 into [X]
0x1186:  9AD  LBPX     #AD         ; Load constant #173 into [X]
0x1187:  9B5  LBPX     #B5         ; Load constant #181 into [X]
0x1188:  9AD  LBPX     #AD         ; Load constant #173 into [X]
0x1189:  9B5  LBPX     #B5         ; Load constant #181 into [X]
0x118A:  9AD  LBPX     #AD         ; Load constant #173 into [X]
0x118B:  9B5  LBPX     #B5         ; Load constant #181 into [X]
0x118C:  9AF  LBPX     #AF         ; Load constant #175 into [X]
0x118D:  999  LBPX     #99         ; Load constant #153 into [X]
0x118E:  981  LBPX     #81         ; Load constant #129 into [X]
0x118F:  17E  UNKNOWN              ; Unrecognized instruction: 0x17E
0x1190:  900  LBPX     #0          ; Load constant #0 into [X]
0x1191:  903  LBPX     #3          ; Load constant #3 into [X]
0x1192:  905  LBPX     #5          ; Load constant #5 into [X]
0x1193:  90C  LBPX     #C          ; Load constant #12 into [X]
0x1194:  910  LBPX     #10         ; Load constant #16 into [X]
0x1195:  910  LBPX     #10         ; Load constant #16 into [X]
0x1196:  920  LBPX     #20         ; Load constant #32 into [X]
0x1197:  910  LBPX     #10         ; Load constant #16 into [X]
0x1198:  910  LBPX     #10         ; Load constant #16 into [X]
0x1199:  920  LBPX     #20         ; Load constant #32 into [X]
0x119A:  910  LBPX     #10         ; Load constant #16 into [X]
0x119B:  910  LBPX     #10         ; Load constant #16 into [X]
0x119C:  90C  LBPX     #C          ; Load constant #12 into [X]
0x119D:  905  LBPX     #5          ; Load constant #5 into [X]
0x119E:  903  LBPX     #3          ; Load constant #3 into [X]
0x119F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x11A0:  950  LBPX     #50         ; Load constant #80 into [X]
0x11A1:  9A8  LBPX     #A8         ; Load constant #168 into [X]
0x11A2:  9A8  LBPX     #A8         ; Load constant #168 into [X]
0x11A3:  9A8  LBPX     #A8         ; Load constant #168 into [X]
0x11A4:  904  LBPX     #4          ; Load constant #4 into [X]
0x11A5:  90A  LBPX     #A          ; Load constant #10 into [X]
0x11A6:  902  LBPX     #2          ; Load constant #2 into [X]
0x11A7:  902  LBPX     #2          ; Load constant #2 into [X]
0x11A8:  902  LBPX     #2          ; Load constant #2 into [X]
0x11A9:  90A  LBPX     #A          ; Load constant #10 into [X]
0x11AA:  904  LBPX     #4          ; Load constant #4 into [X]
0x11AB:  908  LBPX     #8          ; Load constant #8 into [X]
0x11AC:  9F0  LBPX     #F0         ; Load constant #240 into [X]
0x11AD:  900  LBPX     #0          ; Load constant #0 into [X]
0x11AE:  900  LBPX     #0          ; Load constant #0 into [X]
0x11AF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x11B0:  96C  LBPX     #6C         ; Load constant #108 into [X]
0x11B1:  992  LBPX     #92         ; Load constant #146 into [X]
0x11B2:  954  LBPX     #54         ; Load constant #84 into [X]
0x11B3:  9D4  LBPX     #D4         ; Load constant #212 into [X]
0x11B4:  902  LBPX     #2          ; Load constant #2 into [X]
0x11B5:  906  LBPX     #6          ; Load constant #6 into [X]
0x11B6:  902  LBPX     #2          ; Load constant #2 into [X]
0x11B7:  902  LBPX     #2          ; Load constant #2 into [X]
0x11B8:  90A  LBPX     #A          ; Load constant #10 into [X]
0x11B9:  902  LBPX     #2          ; Load constant #2 into [X]
0x11BA:  904  LBPX     #4          ; Load constant #4 into [X]
0x11BB:  908  LBPX     #8          ; Load constant #8 into [X]
0x11BC:  9F0  LBPX     #F0         ; Load constant #240 into [X]
0x11BD:  900  LBPX     #0          ; Load constant #0 into [X]
0x11BE:  900  LBPX     #0          ; Load constant #0 into [X]
0x11BF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x11C0:  944  LBPX     #44         ; Load constant #68 into [X]
0x11C1:  9AA  LBPX     #AA         ; Load constant #170 into [X]
0x11C2:  9AA  LBPX     #AA         ; Load constant #170 into [X]
0x11C3:  9BA  LBPX     #BA         ; Load constant #186 into [X]
0x11C4:  902  LBPX     #2          ; Load constant #2 into [X]
0x11C5:  902  LBPX     #2          ; Load constant #2 into [X]
0x11C6:  906  LBPX     #6          ; Load constant #6 into [X]
0x11C7:  902  LBPX     #2          ; Load constant #2 into [X]
0x11C8:  902  LBPX     #2          ; Load constant #2 into [X]
0x11C9:  922  LBPX     #22         ; Load constant #34 into [X]
0x11CA:  904  LBPX     #4          ; Load constant #4 into [X]
0x11CB:  908  LBPX     #8          ; Load constant #8 into [X]
0x11CC:  9F0  LBPX     #F0         ; Load constant #240 into [X]
0x11CD:  900  LBPX     #0          ; Load constant #0 into [X]
0x11CE:  900  LBPX     #0          ; Load constant #0 into [X]
0x11CF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x11D0:  900  LBPX     #0          ; Load constant #0 into [X]
0x11D1:  900  LBPX     #0          ; Load constant #0 into [X]
0x11D2:  900  LBPX     #0          ; Load constant #0 into [X]
0x11D3:  9F0  LBPX     #F0         ; Load constant #240 into [X]
0x11D4:  908  LBPX     #8          ; Load constant #8 into [X]
0x11D5:  904  LBPX     #4          ; Load constant #4 into [X]
0x11D6:  90A  LBPX     #A          ; Load constant #10 into [X]
0x11D7:  90A  LBPX     #A          ; Load constant #10 into [X]
0x11D8:  902  LBPX     #2          ; Load constant #2 into [X]
0x11D9:  90A  LBPX     #A          ; Load constant #10 into [X]
0x11DA:  90A  LBPX     #A          ; Load constant #10 into [X]
0x11DB:  904  LBPX     #4          ; Load constant #4 into [X]
0x11DC:  9A8  LBPX     #A8         ; Load constant #168 into [X]
0x11DD:  9A8  LBPX     #A8         ; Load constant #168 into [X]
0x11DE:  9A8  LBPX     #A8         ; Load constant #168 into [X]
0x11DF:  150  UNKNOWN              ; Unrecognized instruction: 0x150
0x11E0:  E0F  LD_R_I   A, #15      ; Load A with immediate value #15
0x11E1:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x11E2:  B10  LD_X     0x10        ; Set X pointer to RAM address 0x10
0x11E3:  E68  LDPX_MX  #8          ; Load constant #8 into [X] and increment X
0x11E4:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x11E5:  E61  LDPX_MX  #1          ; Load constant #1 into [X] and increment X
0x11E6:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x11E7:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x11E8:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x11E9:  B26  LD_X     0x26        ; Set X pointer to RAM address 0x26
0x11EA:  907  LBPX     #7          ; Load constant #7 into [X]
0x11EB:  B54  LD_X     0x54        ; Set X pointer to RAM address 0x54 (MEM_AGE)
0x11EC:  E6F  LDPX_MX  #F          ; Load constant #15 into [X] and increment X
0x11ED:  B71  LD_X     0x71        ; Set X pointer to RAM address 0x71
0x11EE:  E68  LDPX_MX  #8          ; Load constant #8 into [X] and increment X
0x11EF:  E68  LDPX_MX  #8          ; Load constant #8 into [X] and increment X
0x11F0:  B76  LD_X     0x76        ; Set X pointer to RAM address 0x76
0x11F1:  E63  LDPX_MX  #3          ; Load constant #3 into [X] and increment X
0x11F2:  E62  LDPX_MX  #2          ; Load constant #2 into [X] and increment X
0x11F3:  E62  LDPX_MX  #2          ; Load constant #2 into [X] and increment X
0x11F4:  E62  LDPX_MX  #2          ; Load constant #2 into [X] and increment X
0x11F5:  E42  PSET     2           ; Set NP (New Page) to 2 for the next jump/call
0x11F6:  044  JP       0x244       ; Jump to address 0x244
0x11F7:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x11F8:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x11F9:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x11FA:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x11FB:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x11FC:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x11FD:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x11FE:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x11FF:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x1200:  E00  LD_R_I   A, #0       ; Load A with immediate value #0
0x1201:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x1202:  B24  LD_X     0x24        ; Set X pointer to RAM address 0x24
0x1203:  900  LBPX     #0          ; Load constant #0 into [X]
0x1204:  B14  LD_X     0x14        ; Set X pointer to RAM address 0x14
0x1205:  920  LBPX     #20         ; Load constant #32 into [X]
0x1206:  B32  LD_X     0x32        ; Set X pointer to RAM address 0x32
0x1207:  900  LBPX     #0          ; Load constant #0 into [X]
0x1208:  B36  LD_X     0x36        ; Set X pointer to RAM address 0x36
0x1209:  97D  LBPX     #7D         ; Load constant #125 into [X]
0x120A:  B58  LD_X     0x58        ; Set X pointer to RAM address 0x58
0x120B:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x120C:  B7B  LD_X     0x7B        ; Set X pointer to RAM address 0x7B
0x120D:  E6F  LDPX_MX  #F          ; Load constant #15 into [X] and increment X
0x120E:  B7D  LD_X     0x7D        ; Set X pointer to RAM address 0x7D
0x120F:  E2F  LD_R_I   [X], #15    ; Load [X] with immediate value #15
0x1210:  B3C  LD_X     0x3C        ; Set X pointer to RAM address 0x3C
0x1211:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0x1212:  B74  LD_X     0x74        ; Set X pointer to RAM address 0x74
0x1213:  E60  LDPX_MX  #0          ; Load constant #0 into [X] and increment X
0x1214:  B7C  LD_X     0x7C        ; Set X pointer to RAM address 0x7C
0x1215:  E25  LD_R_I   [X], #5     ; Load [X] with immediate value #5
0x1216:  E0F  LD_R_I   A, #15      ; Load A with immediate value #15
0x1217:  E80  UNKNOWN              ; Unrecognized instruction: 0xE80
0x1218:  B71  LD_X     0x71        ; Set X pointer to RAM address 0x71
0x1219:  E20  LD_R_I   [X], #0     ; Load [X] with immediate value #0
0x121A:  B78  LD_X     0x78        ; Set X pointer to RAM address 0x78
0x121B:  E21  LD_R_I   [X], #1     ; Load [X] with immediate value #1
0x121C:  B00  LD_X     0x00        ; Set X pointer to RAM address 0x00
0x121D:  EE2  UNKNOWN              ; Unrecognized instruction: 0xEE2
0x121E:  EE2  UNKNOWN              ; Unrecognized instruction: 0xEE2
0x121F:  EC2  LD_R_Q   A, [X]      ; Copy value from [X] into A
0x1220:  E42  PSET     2           ; Set NP (New Page) to 2 for the next jump/call
0x1221:  055  JP       0x255       ; Jump to address 0x255
0x1222:  EEE  UNKNOWN              ; Unrecognized instruction: 0xEEE
0x1223:  EF0  INC_Y                ; Increment the Y pointer by 1
0x1224:  EEE  UNKNOWN              ; Unrecognized instruction: 0xEEE
0x1225:  EF0  INC_Y                ; Increment the Y pointer by 1
0x1226:  EEE  UNKNOWN              ; Unrecognized instruction: 0xEEE
0x1227:  EF0  INC_Y                ; Increment the Y pointer by 1
0x1228:  EEE  UNKNOWN              ; Unrecognized instruction: 0xEEE
0x1229:  EF0  INC_Y                ; Increment the Y pointer by 1
0x122A:  EEE  UNKNOWN              ; Unrecognized instruction: 0xEEE
0x122B:  EF0  INC_Y                ; Increment the Y pointer by 1
0x122C:  EEE  UNKNOWN              ; Unrecognized instruction: 0xEEE
0x122D:  E42  PSET     2           ; Set NP (New Page) to 2 for the next jump/call
0x122E:  029  JP       0x229       ; Jump to address 0x229
0x122F:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x1230:  900  LBPX     #0          ; Load constant #0 into [X]
0x1231:  900  LBPX     #0          ; Load constant #0 into [X]
0x1232:  960  LBPX     #60         ; Load constant #96 into [X]
0x1233:  990  LBPX     #90         ; Load constant #144 into [X]
0x1234:  90E  LBPX     #E          ; Load constant #14 into [X]
0x1235:  957  LBPX     #57         ; Load constant #87 into [X]
0x1236:  946  LBPX     #46         ; Load constant #70 into [X]
0x1237:  904  LBPX     #4          ; Load constant #4 into [X]
0x1238:  904  LBPX     #4          ; Load constant #4 into [X]
0x1239:  914  LBPX     #14         ; Load constant #20 into [X]
0x123A:  906  LBPX     #6          ; Load constant #6 into [X]
0x123B:  90F  LBPX     #F          ; Load constant #15 into [X]
0x123C:  91E  LBPX     #1E         ; Load constant #30 into [X]
0x123D:  9F0  LBPX     #F0         ; Load constant #240 into [X]
0x123E:  900  LBPX     #0          ; Load constant #0 into [X]
0x123F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1240:  900  LBPX     #0          ; Load constant #0 into [X]
0x1241:  900  LBPX     #0          ; Load constant #0 into [X]
0x1242:  900  LBPX     #0          ; Load constant #0 into [X]
0x1243:  907  LBPX     #7          ; Load constant #7 into [X]
0x1244:  908  LBPX     #8          ; Load constant #8 into [X]
0x1245:  930  LBPX     #30         ; Load constant #48 into [X]
0x1246:  940  LBPX     #40         ; Load constant #64 into [X]
0x1247:  930  LBPX     #30         ; Load constant #48 into [X]
0x1248:  913  LBPX     #13         ; Load constant #19 into [X]
0x1249:  934  LBPX     #34         ; Load constant #52 into [X]
0x124A:  943  LBPX     #43         ; Load constant #67 into [X]
0x124B:  930  LBPX     #30         ; Load constant #48 into [X]
0x124C:  908  LBPX     #8          ; Load constant #8 into [X]
0x124D:  907  LBPX     #7          ; Load constant #7 into [X]
0x124E:  900  LBPX     #0          ; Load constant #0 into [X]
0x124F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1250:  900  LBPX     #0          ; Load constant #0 into [X]
0x1251:  960  LBPX     #60         ; Load constant #96 into [X]
0x1252:  99E  LBPX     #9E         ; Load constant #158 into [X]
0x1253:  907  LBPX     #7          ; Load constant #7 into [X]
0x1254:  907  LBPX     #7          ; Load constant #7 into [X]
0x1255:  916  LBPX     #16         ; Load constant #22 into [X]
0x1256:  944  LBPX     #44         ; Load constant #68 into [X]
0x1257:  944  LBPX     #44         ; Load constant #68 into [X]
0x1258:  944  LBPX     #44         ; Load constant #68 into [X]
0x1259:  916  LBPX     #16         ; Load constant #22 into [X]
0x125A:  907  LBPX     #7          ; Load constant #7 into [X]
0x125B:  907  LBPX     #7          ; Load constant #7 into [X]
0x125C:  99E  LBPX     #9E         ; Load constant #158 into [X]
0x125D:  960  LBPX     #60         ; Load constant #96 into [X]
0x125E:  900  LBPX     #0          ; Load constant #0 into [X]
0x125F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1260:  900  LBPX     #0          ; Load constant #0 into [X]
0x1261:  900  LBPX     #0          ; Load constant #0 into [X]
0x1262:  907  LBPX     #7          ; Load constant #7 into [X]
0x1263:  90A  LBPX     #A          ; Load constant #10 into [X]
0x1264:  913  LBPX     #13         ; Load constant #19 into [X]
0x1265:  920  LBPX     #20         ; Load constant #32 into [X]
0x1266:  910  LBPX     #10         ; Load constant #16 into [X]
0x1267:  910  LBPX     #10         ; Load constant #16 into [X]
0x1268:  930  LBPX     #30         ; Load constant #48 into [X]
0x1269:  940  LBPX     #40         ; Load constant #64 into [X]
0x126A:  931  LBPX     #31         ; Load constant #49 into [X]
0x126B:  90A  LBPX     #A          ; Load constant #10 into [X]
0x126C:  906  LBPX     #6          ; Load constant #6 into [X]
0x126D:  901  LBPX     #1          ; Load constant #1 into [X]
0x126E:  900  LBPX     #0          ; Load constant #0 into [X]
0x126F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1270:  900  LBPX     #0          ; Load constant #0 into [X]
0x1271:  900  LBPX     #0          ; Load constant #0 into [X]
0x1272:  970  LBPX     #70         ; Load constant #112 into [X]
0x1273:  988  LBPX     #88         ; Load constant #136 into [X]
0x1274:  904  LBPX     #4          ; Load constant #4 into [X]
0x1275:  974  LBPX     #74         ; Load constant #116 into [X]
0x1276:  972  LBPX     #72         ; Load constant #114 into [X]
0x1277:  973  LBPX     #73         ; Load constant #115 into [X]
0x1278:  977  LBPX     #77         ; Load constant #119 into [X]
0x1279:  906  LBPX     #6          ; Load constant #6 into [X]
0x127A:  90C  LBPX     #C          ; Load constant #12 into [X]
0x127B:  92C  LBPX     #2C         ; Load constant #44 into [X]
0x127C:  91C  LBPX     #1C         ; Load constant #28 into [X]
0x127D:  9FC  LBPX     #FC         ; Load constant #252 into [X]
0x127E:  918  LBPX     #18         ; Load constant #24 into [X]
0x127F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1280:  900  LBPX     #0          ; Load constant #0 into [X]
0x1281:  900  LBPX     #0          ; Load constant #0 into [X]
0x1282:  900  LBPX     #0          ; Load constant #0 into [X]
0x1283:  90F  LBPX     #F          ; Load constant #15 into [X]
0x1284:  930  LBPX     #30         ; Load constant #48 into [X]
0x1285:  940  LBPX     #40         ; Load constant #64 into [X]
0x1286:  930  LBPX     #30         ; Load constant #48 into [X]
0x1287:  930  LBPX     #30         ; Load constant #48 into [X]
0x1288:  941  LBPX     #41         ; Load constant #65 into [X]
0x1289:  932  LBPX     #32         ; Load constant #50 into [X]
0x128A:  911  LBPX     #11         ; Load constant #17 into [X]
0x128B:  910  LBPX     #10         ; Load constant #16 into [X]
0x128C:  908  LBPX     #8          ; Load constant #8 into [X]
0x128D:  907  LBPX     #7          ; Load constant #7 into [X]
0x128E:  900  LBPX     #0          ; Load constant #0 into [X]
0x128F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1290:  900  LBPX     #0          ; Load constant #0 into [X]
0x1291:  960  LBPX     #60         ; Load constant #96 into [X]
0x1292:  99E  LBPX     #9E         ; Load constant #158 into [X]
0x1293:  90F  LBPX     #F          ; Load constant #15 into [X]
0x1294:  917  LBPX     #17         ; Load constant #23 into [X]
0x1295:  916  LBPX     #16         ; Load constant #22 into [X]
0x1296:  904  LBPX     #4          ; Load constant #4 into [X]
0x1297:  944  LBPX     #44         ; Load constant #68 into [X]
0x1298:  904  LBPX     #4          ; Load constant #4 into [X]
0x1299:  916  LBPX     #16         ; Load constant #22 into [X]
0x129A:  917  LBPX     #17         ; Load constant #23 into [X]
0x129B:  90F  LBPX     #F          ; Load constant #15 into [X]
0x129C:  99E  LBPX     #9E         ; Load constant #158 into [X]
0x129D:  960  LBPX     #60         ; Load constant #96 into [X]
0x129E:  900  LBPX     #0          ; Load constant #0 into [X]
0x129F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x12A0:  900  LBPX     #0          ; Load constant #0 into [X]
0x12A1:  960  LBPX     #60         ; Load constant #96 into [X]
0x12A2:  9D0  LBPX     #D0         ; Load constant #208 into [X]
0x12A3:  958  LBPX     #58         ; Load constant #88 into [X]
0x12A4:  944  LBPX     #44         ; Load constant #68 into [X]
0x12A5:  94A  LBPX     #4A         ; Load constant #74 into [X]
0x12A6:  942  LBPX     #42         ; Load constant #66 into [X]
0x12A7:  946  LBPX     #46         ; Load constant #70 into [X]
0x12A8:  942  LBPX     #42         ; Load constant #66 into [X]
0x12A9:  92A  LBPX     #2A         ; Load constant #42 into [X]
0x12AA:  906  LBPX     #6          ; Load constant #6 into [X]
0x12AB:  91C  LBPX     #1C         ; Load constant #28 into [X]
0x12AC:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x12AD:  9F0  LBPX     #F0         ; Load constant #240 into [X]
0x12AE:  900  LBPX     #0          ; Load constant #0 into [X]
0x12AF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x12B0:  900  LBPX     #0          ; Load constant #0 into [X]
0x12B1:  900  LBPX     #0          ; Load constant #0 into [X]
0x12B2:  900  LBPX     #0          ; Load constant #0 into [X]
0x12B3:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x12B4:  904  LBPX     #4          ; Load constant #4 into [X]
0x12B5:  92A  LBPX     #2A         ; Load constant #42 into [X]
0x12B6:  942  LBPX     #42         ; Load constant #66 into [X]
0x12B7:  946  LBPX     #46         ; Load constant #70 into [X]
0x12B8:  946  LBPX     #46         ; Load constant #70 into [X]
0x12B9:  946  LBPX     #46         ; Load constant #70 into [X]
0x12BA:  942  LBPX     #42         ; Load constant #66 into [X]
0x12BB:  92A  LBPX     #2A         ; Load constant #42 into [X]
0x12BC:  904  LBPX     #4          ; Load constant #4 into [X]
0x12BD:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x12BE:  900  LBPX     #0          ; Load constant #0 into [X]
0x12BF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x12C0:  900  LBPX     #0          ; Load constant #0 into [X]
0x12C1:  900  LBPX     #0          ; Load constant #0 into [X]
0x12C2:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x12C3:  904  LBPX     #4          ; Load constant #4 into [X]
0x12C4:  90E  LBPX     #E          ; Load constant #14 into [X]
0x12C5:  91E  LBPX     #1E         ; Load constant #30 into [X]
0x12C6:  93E  LBPX     #3E         ; Load constant #62 into [X]
0x12C7:  97E  LBPX     #7E         ; Load constant #126 into [X]
0x12C8:  97E  LBPX     #7E         ; Load constant #126 into [X]
0x12C9:  93E  LBPX     #3E         ; Load constant #62 into [X]
0x12CA:  91E  LBPX     #1E         ; Load constant #30 into [X]
0x12CB:  904  LBPX     #4          ; Load constant #4 into [X]
0x12CC:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x12CD:  900  LBPX     #0          ; Load constant #0 into [X]
0x12CE:  900  LBPX     #0          ; Load constant #0 into [X]
0x12CF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x12D0:  900  LBPX     #0          ; Load constant #0 into [X]
0x12D1:  900  LBPX     #0          ; Load constant #0 into [X]
0x12D2:  907  LBPX     #7          ; Load constant #7 into [X]
0x12D3:  908  LBPX     #8          ; Load constant #8 into [X]
0x12D4:  910  LBPX     #10         ; Load constant #16 into [X]
0x12D5:  920  LBPX     #20         ; Load constant #32 into [X]
0x12D6:  916  LBPX     #16         ; Load constant #22 into [X]
0x12D7:  914  LBPX     #14         ; Load constant #20 into [X]
0x12D8:  934  LBPX     #34         ; Load constant #52 into [X]
0x12D9:  942  LBPX     #42         ; Load constant #66 into [X]
0x12DA:  930  LBPX     #30         ; Load constant #48 into [X]
0x12DB:  908  LBPX     #8          ; Load constant #8 into [X]
0x12DC:  906  LBPX     #6          ; Load constant #6 into [X]
0x12DD:  901  LBPX     #1          ; Load constant #1 into [X]
0x12DE:  900  LBPX     #0          ; Load constant #0 into [X]
0x12DF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x12E0:  930  LBPX     #30         ; Load constant #48 into [X]
0x12E1:  928  LBPX     #28         ; Load constant #40 into [X]
0x12E2:  9A8  LBPX     #A8         ; Load constant #168 into [X]
0x12E3:  9A8  LBPX     #A8         ; Load constant #168 into [X]
0x12E4:  9A4  LBPX     #A4         ; Load constant #164 into [X]
0x12E5:  9A4  LBPX     #A4         ; Load constant #164 into [X]
0x12E6:  96C  LBPX     #6C         ; Load constant #108 into [X]
0x12E7:  904  LBPX     #4          ; Load constant #4 into [X]
0x12E8:  904  LBPX     #4          ; Load constant #4 into [X]
0x12E9:  904  LBPX     #4          ; Load constant #4 into [X]
0x12EA:  92C  LBPX     #2C         ; Load constant #44 into [X]
0x12EB:  91C  LBPX     #1C         ; Load constant #28 into [X]
0x12EC:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x12ED:  9F0  LBPX     #F0         ; Load constant #240 into [X]
0x12EE:  900  LBPX     #0          ; Load constant #0 into [X]
0x12EF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x12F0:  900  LBPX     #0          ; Load constant #0 into [X]
0x12F1:  900  LBPX     #0          ; Load constant #0 into [X]
0x12F2:  9F0  LBPX     #F0         ; Load constant #240 into [X]
0x12F3:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x12F4:  91C  LBPX     #1C         ; Load constant #28 into [X]
0x12F5:  90E  LBPX     #E          ; Load constant #14 into [X]
0x12F6:  90A  LBPX     #A          ; Load constant #10 into [X]
0x12F7:  902  LBPX     #2          ; Load constant #2 into [X]
0x12F8:  946  LBPX     #46         ; Load constant #70 into [X]
0x12F9:  942  LBPX     #42         ; Load constant #66 into [X]
0x12FA:  94A  LBPX     #4A         ; Load constant #74 into [X]
0x12FB:  94C  LBPX     #4C         ; Load constant #76 into [X]
0x12FC:  958  LBPX     #58         ; Load constant #88 into [X]
0x12FD:  9D0  LBPX     #D0         ; Load constant #208 into [X]
0x12FE:  960  LBPX     #60         ; Load constant #96 into [X]
0x12FF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1300:  900  LBPX     #0          ; Load constant #0 into [X]
0x1301:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x1302:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x1303:  9AC  LBPX     #AC         ; Load constant #172 into [X]
0x1304:  98E  LBPX     #8E         ; Load constant #142 into [X]
0x1305:  97E  LBPX     #7E         ; Load constant #126 into [X]
0x1306:  91E  LBPX     #1E         ; Load constant #30 into [X]
0x1307:  91E  LBPX     #1E         ; Load constant #30 into [X]
0x1308:  91F  LBPX     #1F         ; Load constant #31 into [X]
0x1309:  93F  LBPX     #3F         ; Load constant #63 into [X]
0x130A:  93F  LBPX     #3F         ; Load constant #63 into [X]
0x130B:  93F  LBPX     #3F         ; Load constant #63 into [X]
0x130C:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x130D:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x130E:  900  LBPX     #0          ; Load constant #0 into [X]
0x130F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1310:  900  LBPX     #0          ; Load constant #0 into [X]
0x1311:  940  LBPX     #40         ; Load constant #64 into [X]
0x1312:  960  LBPX     #60         ; Load constant #96 into [X]
0x1313:  953  LBPX     #53         ; Load constant #83 into [X]
0x1314:  914  LBPX     #14         ; Load constant #20 into [X]
0x1315:  908  LBPX     #8          ; Load constant #8 into [X]
0x1316:  910  LBPX     #10         ; Load constant #16 into [X]
0x1317:  910  LBPX     #10         ; Load constant #16 into [X]
0x1318:  910  LBPX     #10         ; Load constant #16 into [X]
0x1319:  910  LBPX     #10         ; Load constant #16 into [X]
0x131A:  910  LBPX     #10         ; Load constant #16 into [X]
0x131B:  910  LBPX     #10         ; Load constant #16 into [X]
0x131C:  908  LBPX     #8          ; Load constant #8 into [X]
0x131D:  944  LBPX     #44         ; Load constant #68 into [X]
0x131E:  96B  LBPX     #6B         ; Load constant #107 into [X]
0x131F:  158  UNKNOWN              ; Unrecognized instruction: 0x158
0x1320:  900  LBPX     #0          ; Load constant #0 into [X]
0x1321:  900  LBPX     #0          ; Load constant #0 into [X]
0x1322:  90D  LBPX     #D          ; Load constant #13 into [X]
0x1323:  952  LBPX     #52         ; Load constant #82 into [X]
0x1324:  962  LBPX     #62         ; Load constant #98 into [X]
0x1325:  944  LBPX     #44         ; Load constant #68 into [X]
0x1326:  904  LBPX     #4          ; Load constant #4 into [X]
0x1327:  904  LBPX     #4          ; Load constant #4 into [X]
0x1328:  904  LBPX     #4          ; Load constant #4 into [X]
0x1329:  904  LBPX     #4          ; Load constant #4 into [X]
0x132A:  904  LBPX     #4          ; Load constant #4 into [X]
0x132B:  902  LBPX     #2          ; Load constant #2 into [X]
0x132C:  94E  LBPX     #4E         ; Load constant #78 into [X]
0x132D:  971  LBPX     #71         ; Load constant #113 into [X]
0x132E:  940  LBPX     #40         ; Load constant #64 into [X]
0x132F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1330:  900  LBPX     #0          ; Load constant #0 into [X]
0x1331:  900  LBPX     #0          ; Load constant #0 into [X]
0x1332:  9FC  LBPX     #FC         ; Load constant #252 into [X]
0x1333:  902  LBPX     #2          ; Load constant #2 into [X]
0x1334:  979  LBPX     #79         ; Load constant #121 into [X]
0x1335:  9B5  LBPX     #B5         ; Load constant #181 into [X]
0x1336:  9FD  LBPX     #FD         ; Load constant #253 into [X]
0x1337:  9B5  LBPX     #B5         ; Load constant #181 into [X]
0x1338:  9B5  LBPX     #B5         ; Load constant #181 into [X]
0x1339:  9FD  LBPX     #FD         ; Load constant #253 into [X]
0x133A:  9B5  LBPX     #B5         ; Load constant #181 into [X]
0x133B:  979  LBPX     #79         ; Load constant #121 into [X]
0x133C:  902  LBPX     #2          ; Load constant #2 into [X]
0x133D:  9FC  LBPX     #FC         ; Load constant #252 into [X]
0x133E:  900  LBPX     #0          ; Load constant #0 into [X]
0x133F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1340:  900  LBPX     #0          ; Load constant #0 into [X]
0x1341:  900  LBPX     #0          ; Load constant #0 into [X]
0x1342:  9FC  LBPX     #FC         ; Load constant #252 into [X]
0x1343:  902  LBPX     #2          ; Load constant #2 into [X]
0x1344:  911  LBPX     #11         ; Load constant #17 into [X]
0x1345:  911  LBPX     #11         ; Load constant #17 into [X]
0x1346:  911  LBPX     #11         ; Load constant #17 into [X]
0x1347:  911  LBPX     #11         ; Load constant #17 into [X]
0x1348:  911  LBPX     #11         ; Load constant #17 into [X]
0x1349:  911  LBPX     #11         ; Load constant #17 into [X]
0x134A:  911  LBPX     #11         ; Load constant #17 into [X]
0x134B:  911  LBPX     #11         ; Load constant #17 into [X]
0x134C:  902  LBPX     #2          ; Load constant #2 into [X]
0x134D:  9FC  LBPX     #FC         ; Load constant #252 into [X]
0x134E:  900  LBPX     #0          ; Load constant #0 into [X]
0x134F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1350:  900  LBPX     #0          ; Load constant #0 into [X]
0x1351:  900  LBPX     #0          ; Load constant #0 into [X]
0x1352:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x1353:  91C  LBPX     #1C         ; Load constant #28 into [X]
0x1354:  97F  LBPX     #7F         ; Load constant #127 into [X]
0x1355:  9DF  LBPX     #DF         ; Load constant #223 into [X]
0x1356:  9DE  LBPX     #DE         ; Load constant #222 into [X]
0x1357:  9FE  LBPX     #FE         ; Load constant #254 into [X]
0x1358:  9FE  LBPX     #FE         ; Load constant #254 into [X]
0x1359:  9DE  LBPX     #DE         ; Load constant #222 into [X]
0x135A:  9DF  LBPX     #DF         ; Load constant #223 into [X]
0x135B:  97F  LBPX     #7F         ; Load constant #127 into [X]
0x135C:  91C  LBPX     #1C         ; Load constant #28 into [X]
0x135D:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x135E:  900  LBPX     #0          ; Load constant #0 into [X]
0x135F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1360:  900  LBPX     #0          ; Load constant #0 into [X]
0x1361:  900  LBPX     #0          ; Load constant #0 into [X]
0x1362:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x1363:  91C  LBPX     #1C         ; Load constant #28 into [X]
0x1364:  97F  LBPX     #7F         ; Load constant #127 into [X]
0x1365:  98F  LBPX     #8F         ; Load constant #143 into [X]
0x1366:  9AE  LBPX     #AE         ; Load constant #174 into [X]
0x1367:  9FE  LBPX     #FE         ; Load constant #254 into [X]
0x1368:  9FE  LBPX     #FE         ; Load constant #254 into [X]
0x1369:  98E  LBPX     #8E         ; Load constant #142 into [X]
0x136A:  9AF  LBPX     #AF         ; Load constant #175 into [X]
0x136B:  97F  LBPX     #7F         ; Load constant #127 into [X]
0x136C:  91C  LBPX     #1C         ; Load constant #28 into [X]
0x136D:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x136E:  900  LBPX     #0          ; Load constant #0 into [X]
0x136F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1370:  900  LBPX     #0          ; Load constant #0 into [X]
0x1371:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x1372:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x1373:  9DC  LBPX     #DC         ; Load constant #220 into [X]
0x1374:  9DE  LBPX     #DE         ; Load constant #222 into [X]
0x1375:  97E  LBPX     #7E         ; Load constant #126 into [X]
0x1376:  91E  LBPX     #1E         ; Load constant #30 into [X]
0x1377:  91E  LBPX     #1E         ; Load constant #30 into [X]
0x1378:  91F  LBPX     #1F         ; Load constant #31 into [X]
0x1379:  93F  LBPX     #3F         ; Load constant #63 into [X]
0x137A:  93F  LBPX     #3F         ; Load constant #63 into [X]
0x137B:  93F  LBPX     #3F         ; Load constant #63 into [X]
0x137C:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x137D:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x137E:  900  LBPX     #0          ; Load constant #0 into [X]
0x137F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1380:  900  LBPX     #0          ; Load constant #0 into [X]
0x1381:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x1382:  9A8  LBPX     #A8         ; Load constant #168 into [X]
0x1383:  9AC  LBPX     #AC         ; Load constant #172 into [X]
0x1384:  9AA  LBPX     #AA         ; Load constant #170 into [X]
0x1385:  9A9  LBPX     #A9         ; Load constant #169 into [X]
0x1386:  9ED  LBPX     #ED         ; Load constant #237 into [X]
0x1387:  939  LBPX     #39         ; Load constant #57 into [X]
0x1388:  901  LBPX     #1          ; Load constant #1 into [X]
0x1389:  905  LBPX     #5          ; Load constant #5 into [X]
0x138A:  903  LBPX     #3          ; Load constant #3 into [X]
0x138B:  907  LBPX     #7          ; Load constant #7 into [X]
0x138C:  90E  LBPX     #E          ; Load constant #14 into [X]
0x138D:  9FC  LBPX     #FC         ; Load constant #252 into [X]
0x138E:  900  LBPX     #0          ; Load constant #0 into [X]
0x138F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1390:  9E7  LBPX     #E7         ; Load constant #231 into [X]
0x1391:  9A5  LBPX     #A5         ; Load constant #165 into [X]
0x1392:  9BD  LBPX     #BD         ; Load constant #189 into [X]
0x1393:  9BD  LBPX     #BD         ; Load constant #189 into [X]
0x1394:  9BD  LBPX     #BD         ; Load constant #189 into [X]
0x1395:  9FD  LBPX     #FD         ; Load constant #253 into [X]
0x1396:  907  LBPX     #7          ; Load constant #7 into [X]
0x1397:  901  LBPX     #1          ; Load constant #1 into [X]
0x1398:  911  LBPX     #11         ; Load constant #17 into [X]
0x1399:  909  LBPX     #9          ; Load constant #9 into [X]
0x139A:  911  LBPX     #11         ; Load constant #17 into [X]
0x139B:  902  LBPX     #2          ; Load constant #2 into [X]
0x139C:  9FC  LBPX     #FC         ; Load constant #252 into [X]
0x139D:  900  LBPX     #0          ; Load constant #0 into [X]
0x139E:  900  LBPX     #0          ; Load constant #0 into [X]
0x139F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x13A0:  900  LBPX     #0          ; Load constant #0 into [X]
0x13A1:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x13A2:  9A8  LBPX     #A8         ; Load constant #168 into [X]
0x13A3:  9AC  LBPX     #AC         ; Load constant #172 into [X]
0x13A4:  9AA  LBPX     #AA         ; Load constant #170 into [X]
0x13A5:  9AD  LBPX     #AD         ; Load constant #173 into [X]
0x13A6:  9ED  LBPX     #ED         ; Load constant #237 into [X]
0x13A7:  939  LBPX     #39         ; Load constant #57 into [X]
0x13A8:  901  LBPX     #1          ; Load constant #1 into [X]
0x13A9:  909  LBPX     #9          ; Load constant #9 into [X]
0x13AA:  90B  LBPX     #B          ; Load constant #11 into [X]
0x13AB:  907  LBPX     #7          ; Load constant #7 into [X]
0x13AC:  90E  LBPX     #E          ; Load constant #14 into [X]
0x13AD:  9FC  LBPX     #FC         ; Load constant #252 into [X]
0x13AE:  900  LBPX     #0          ; Load constant #0 into [X]
0x13AF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x13B0:  900  LBPX     #0          ; Load constant #0 into [X]
0x13B1:  900  LBPX     #0          ; Load constant #0 into [X]
0x13B2:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x13B3:  904  LBPX     #4          ; Load constant #4 into [X]
0x13B4:  90A  LBPX     #A          ; Load constant #10 into [X]
0x13B5:  902  LBPX     #2          ; Load constant #2 into [X]
0x13B6:  9A2  LBPX     #A2         ; Load constant #162 into [X]
0x13B7:  9A2  LBPX     #A2         ; Load constant #162 into [X]
0x13B8:  9A2  LBPX     #A2         ; Load constant #162 into [X]
0x13B9:  902  LBPX     #2          ; Load constant #2 into [X]
0x13BA:  90A  LBPX     #A          ; Load constant #10 into [X]
0x13BB:  904  LBPX     #4          ; Load constant #4 into [X]
0x13BC:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x13BD:  900  LBPX     #0          ; Load constant #0 into [X]
0x13BE:  900  LBPX     #0          ; Load constant #0 into [X]
0x13BF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x13C0:  900  LBPX     #0          ; Load constant #0 into [X]
0x13C1:  900  LBPX     #0          ; Load constant #0 into [X]
0x13C2:  900  LBPX     #0          ; Load constant #0 into [X]
0x13C3:  901  LBPX     #1          ; Load constant #1 into [X]
0x13C4:  902  LBPX     #2          ; Load constant #2 into [X]
0x13C5:  904  LBPX     #4          ; Load constant #4 into [X]
0x13C6:  904  LBPX     #4          ; Load constant #4 into [X]
0x13C7:  91C  LBPX     #1C         ; Load constant #28 into [X]
0x13C8:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x13C9:  964  LBPX     #64         ; Load constant #100 into [X]
0x13CA:  944  LBPX     #44         ; Load constant #68 into [X]
0x13CB:  962  LBPX     #62         ; Load constant #98 into [X]
0x13CC:  911  LBPX     #11         ; Load constant #17 into [X]
0x13CD:  920  LBPX     #20         ; Load constant #32 into [X]
0x13CE:  940  LBPX     #40         ; Load constant #64 into [X]
0x13CF:  120  UNKNOWN              ; Unrecognized instruction: 0x120
0x13D0:  900  LBPX     #0          ; Load constant #0 into [X]
0x13D1:  900  LBPX     #0          ; Load constant #0 into [X]
0x13D2:  900  LBPX     #0          ; Load constant #0 into [X]
0x13D3:  901  LBPX     #1          ; Load constant #1 into [X]
0x13D4:  902  LBPX     #2          ; Load constant #2 into [X]
0x13D5:  924  LBPX     #24         ; Load constant #36 into [X]
0x13D6:  974  LBPX     #74         ; Load constant #116 into [X]
0x13D7:  95C  LBPX     #5C         ; Load constant #92 into [X]
0x13D8:  94C  LBPX     #4C         ; Load constant #76 into [X]
0x13D9:  924  LBPX     #24         ; Load constant #36 into [X]
0x13DA:  924  LBPX     #24         ; Load constant #36 into [X]
0x13DB:  942  LBPX     #42         ; Load constant #66 into [X]
0x13DC:  941  LBPX     #41         ; Load constant #65 into [X]
0x13DD:  930  LBPX     #30         ; Load constant #48 into [X]
0x13DE:  900  LBPX     #0          ; Load constant #0 into [X]
0x13DF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x13E0:  900  LBPX     #0          ; Load constant #0 into [X]
0x13E1:  900  LBPX     #0          ; Load constant #0 into [X]
0x13E2:  900  LBPX     #0          ; Load constant #0 into [X]
0x13E3:  901  LBPX     #1          ; Load constant #1 into [X]
0x13E4:  942  LBPX     #42         ; Load constant #66 into [X]
0x13E5:  964  LBPX     #64         ; Load constant #100 into [X]
0x13E6:  954  LBPX     #54         ; Load constant #84 into [X]
0x13E7:  96C  LBPX     #6C         ; Load constant #108 into [X]
0x13E8:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x13E9:  974  LBPX     #74         ; Load constant #116 into [X]
0x13EA:  964  LBPX     #64         ; Load constant #100 into [X]
0x13EB:  942  LBPX     #42         ; Load constant #66 into [X]
0x13EC:  949  LBPX     #49         ; Load constant #73 into [X]
0x13ED:  930  LBPX     #30         ; Load constant #48 into [X]
0x13EE:  900  LBPX     #0          ; Load constant #0 into [X]
0x13EF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x13F0:  900  LBPX     #0          ; Load constant #0 into [X]
0x13F1:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x13F2:  9A6  LBPX     #A6         ; Load constant #166 into [X]
0x13F3:  9B9  LBPX     #B9         ; Load constant #185 into [X]
0x13F4:  9A5  LBPX     #A5         ; Load constant #165 into [X]
0x13F5:  935  LBPX     #35         ; Load constant #53 into [X]
0x13F6:  925  LBPX     #25         ; Load constant #37 into [X]
0x13F7:  905  LBPX     #5          ; Load constant #5 into [X]
0x13F8:  905  LBPX     #5          ; Load constant #5 into [X]
0x13F9:  925  LBPX     #25         ; Load constant #37 into [X]
0x13FA:  905  LBPX     #5          ; Load constant #5 into [X]
0x13FB:  919  LBPX     #19         ; Load constant #25 into [X]
0x13FC:  912  LBPX     #12         ; Load constant #18 into [X]
0x13FD:  992  LBPX     #92         ; Load constant #146 into [X]
0x13FE:  96C  LBPX     #6C         ; Load constant #108 into [X]
0x13FF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1400:  900  LBPX     #0          ; Load constant #0 into [X]
0x1401:  950  LBPX     #50         ; Load constant #80 into [X]
0x1402:  96B  LBPX     #6B         ; Load constant #107 into [X]
0x1403:  944  LBPX     #44         ; Load constant #68 into [X]
0x1404:  90E  LBPX     #E          ; Load constant #14 into [X]
0x1405:  912  LBPX     #12         ; Load constant #18 into [X]
0x1406:  91A  LBPX     #1A         ; Load constant #26 into [X]
0x1407:  912  LBPX     #12         ; Load constant #18 into [X]
0x1408:  912  LBPX     #12         ; Load constant #18 into [X]
0x1409:  912  LBPX     #12         ; Load constant #18 into [X]
0x140A:  918  LBPX     #18         ; Load constant #24 into [X]
0x140B:  908  LBPX     #8          ; Load constant #8 into [X]
0x140C:  944  LBPX     #44         ; Load constant #68 into [X]
0x140D:  96B  LBPX     #6B         ; Load constant #107 into [X]
0x140E:  950  LBPX     #50         ; Load constant #80 into [X]
0x140F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1410:  900  LBPX     #0          ; Load constant #0 into [X]
0x1411:  900  LBPX     #0          ; Load constant #0 into [X]
0x1412:  99C  LBPX     #9C         ; Load constant #156 into [X]
0x1413:  9E2  LBPX     #E2         ; Load constant #226 into [X]
0x1414:  992  LBPX     #92         ; Load constant #146 into [X]
0x1415:  98A  LBPX     #8A         ; Load constant #138 into [X]
0x1416:  98A  LBPX     #8A         ; Load constant #138 into [X]
0x1417:  91A  LBPX     #1A         ; Load constant #26 into [X]
0x1418:  92A  LBPX     #2A         ; Load constant #42 into [X]
0x1419:  9AA  LBPX     #AA         ; Load constant #170 into [X]
0x141A:  9AA  LBPX     #AA         ; Load constant #170 into [X]
0x141B:  912  LBPX     #12         ; Load constant #18 into [X]
0x141C:  924  LBPX     #24         ; Load constant #36 into [X]
0x141D:  924  LBPX     #24         ; Load constant #36 into [X]
0x141E:  9D8  LBPX     #D8         ; Load constant #216 into [X]
0x141F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1420:  900  LBPX     #0          ; Load constant #0 into [X]
0x1421:  953  LBPX     #53         ; Load constant #83 into [X]
0x1422:  96E  LBPX     #6E         ; Load constant #110 into [X]
0x1423:  952  LBPX     #52         ; Load constant #82 into [X]
0x1424:  97A  LBPX     #7A         ; Load constant #122 into [X]
0x1425:  948  LBPX     #48         ; Load constant #72 into [X]
0x1426:  968  LBPX     #68         ; Load constant #104 into [X]
0x1427:  948  LBPX     #48         ; Load constant #72 into [X]
0x1428:  948  LBPX     #48         ; Load constant #72 into [X]
0x1429:  950  LBPX     #50         ; Load constant #80 into [X]
0x142A:  960  LBPX     #60         ; Load constant #96 into [X]
0x142B:  960  LBPX     #60         ; Load constant #96 into [X]
0x142C:  950  LBPX     #50         ; Load constant #80 into [X]
0x142D:  96F  LBPX     #6F         ; Load constant #111 into [X]
0x142E:  950  LBPX     #50         ; Load constant #80 into [X]
0x142F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1430:  940  LBPX     #40         ; Load constant #64 into [X]
0x1431:  9A0  LBPX     #A0         ; Load constant #160 into [X]
0x1432:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x1433:  904  LBPX     #4          ; Load constant #4 into [X]
0x1434:  97A  LBPX     #7A         ; Load constant #122 into [X]
0x1435:  9EA  LBPX     #EA         ; Load constant #234 into [X]
0x1436:  9BF  LBPX     #BF         ; Load constant #191 into [X]
0x1437:  9E9  LBPX     #E9         ; Load constant #233 into [X]
0x1438:  9BD  LBPX     #BD         ; Load constant #189 into [X]
0x1439:  9EA  LBPX     #EA         ; Load constant #234 into [X]
0x143A:  97A  LBPX     #7A         ; Load constant #122 into [X]
0x143B:  902  LBPX     #2          ; Load constant #2 into [X]
0x143C:  904  LBPX     #4          ; Load constant #4 into [X]
0x143D:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x143E:  9A0  LBPX     #A0         ; Load constant #160 into [X]
0x143F:  140  UNKNOWN              ; Unrecognized instruction: 0x140
0x1440:  900  LBPX     #0          ; Load constant #0 into [X]
0x1441:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x1442:  9A6  LBPX     #A6         ; Load constant #166 into [X]
0x1443:  9B9  LBPX     #B9         ; Load constant #185 into [X]
0x1444:  9A5  LBPX     #A5         ; Load constant #165 into [X]
0x1445:  925  LBPX     #25         ; Load constant #37 into [X]
0x1446:  925  LBPX     #25         ; Load constant #37 into [X]
0x1447:  905  LBPX     #5          ; Load constant #5 into [X]
0x1448:  915  LBPX     #15         ; Load constant #21 into [X]
0x1449:  925  LBPX     #25         ; Load constant #37 into [X]
0x144A:  925  LBPX     #25         ; Load constant #37 into [X]
0x144B:  909  LBPX     #9          ; Load constant #9 into [X]
0x144C:  912  LBPX     #12         ; Load constant #18 into [X]
0x144D:  992  LBPX     #92         ; Load constant #146 into [X]
0x144E:  96C  LBPX     #6C         ; Load constant #108 into [X]
0x144F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1450:  900  LBPX     #0          ; Load constant #0 into [X]
0x1451:  900  LBPX     #0          ; Load constant #0 into [X]
0x1452:  900  LBPX     #0          ; Load constant #0 into [X]
0x1453:  9FC  LBPX     #FC         ; Load constant #252 into [X]
0x1454:  942  LBPX     #42         ; Load constant #66 into [X]
0x1455:  981  LBPX     #81         ; Load constant #129 into [X]
0x1456:  981  LBPX     #81         ; Load constant #129 into [X]
0x1457:  981  LBPX     #81         ; Load constant #129 into [X]
0x1458:  982  LBPX     #82         ; Load constant #130 into [X]
0x1459:  981  LBPX     #81         ; Load constant #129 into [X]
0x145A:  981  LBPX     #81         ; Load constant #129 into [X]
0x145B:  981  LBPX     #81         ; Load constant #129 into [X]
0x145C:  981  LBPX     #81         ; Load constant #129 into [X]
0x145D:  942  LBPX     #42         ; Load constant #66 into [X]
0x145E:  9FC  LBPX     #FC         ; Load constant #252 into [X]
0x145F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1460:  900  LBPX     #0          ; Load constant #0 into [X]
0x1461:  900  LBPX     #0          ; Load constant #0 into [X]
0x1462:  900  LBPX     #0          ; Load constant #0 into [X]
0x1463:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x1464:  9F0  LBPX     #F0         ; Load constant #240 into [X]
0x1465:  9C8  LBPX     #C8         ; Load constant #200 into [X]
0x1466:  9E4  LBPX     #E4         ; Load constant #228 into [X]
0x1467:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x1468:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x1469:  9CC  LBPX     #CC         ; Load constant #204 into [X]
0x146A:  9D8  LBPX     #D8         ; Load constant #216 into [X]
0x146B:  9F0  LBPX     #F0         ; Load constant #240 into [X]
0x146C:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x146D:  900  LBPX     #0          ; Load constant #0 into [X]
0x146E:  900  LBPX     #0          ; Load constant #0 into [X]
0x146F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1470:  900  LBPX     #0          ; Load constant #0 into [X]
0x1471:  900  LBPX     #0          ; Load constant #0 into [X]
0x1472:  900  LBPX     #0          ; Load constant #0 into [X]
0x1473:  903  LBPX     #3          ; Load constant #3 into [X]
0x1474:  915  LBPX     #15         ; Load constant #21 into [X]
0x1475:  919  LBPX     #19         ; Load constant #25 into [X]
0x1476:  91B  LBPX     #1B         ; Load constant #27 into [X]
0x1477:  91E  LBPX     #1E         ; Load constant #30 into [X]
0x1478:  916  LBPX     #16         ; Load constant #22 into [X]
0x1479:  917  LBPX     #17         ; Load constant #23 into [X]
0x147A:  91C  LBPX     #1C         ; Load constant #28 into [X]
0x147B:  916  LBPX     #16         ; Load constant #22 into [X]
0x147C:  903  LBPX     #3          ; Load constant #3 into [X]
0x147D:  900  LBPX     #0          ; Load constant #0 into [X]
0x147E:  900  LBPX     #0          ; Load constant #0 into [X]
0x147F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1480:  900  LBPX     #0          ; Load constant #0 into [X]
0x1481:  900  LBPX     #0          ; Load constant #0 into [X]
0x1482:  980  LBPX     #80         ; Load constant #128 into [X]
0x1483:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x1484:  920  LBPX     #20         ; Load constant #32 into [X]
0x1485:  990  LBPX     #90         ; Load constant #144 into [X]
0x1486:  9F0  LBPX     #F0         ; Load constant #240 into [X]
0x1487:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x1488:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x1489:  9F0  LBPX     #F0         ; Load constant #240 into [X]
0x148A:  990  LBPX     #90         ; Load constant #144 into [X]
0x148B:  9A0  LBPX     #A0         ; Load constant #160 into [X]
0x148C:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x148D:  980  LBPX     #80         ; Load constant #128 into [X]
0x148E:  900  LBPX     #0          ; Load constant #0 into [X]
0x148F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1490:  900  LBPX     #0          ; Load constant #0 into [X]
0x1491:  900  LBPX     #0          ; Load constant #0 into [X]
0x1492:  903  LBPX     #3          ; Load constant #3 into [X]
0x1493:  915  LBPX     #15         ; Load constant #21 into [X]
0x1494:  919  LBPX     #19         ; Load constant #25 into [X]
0x1495:  91B  LBPX     #1B         ; Load constant #27 into [X]
0x1496:  91F  LBPX     #1F         ; Load constant #31 into [X]
0x1497:  91C  LBPX     #1C         ; Load constant #28 into [X]
0x1498:  91C  LBPX     #1C         ; Load constant #28 into [X]
0x1499:  91F  LBPX     #1F         ; Load constant #31 into [X]
0x149A:  913  LBPX     #13         ; Load constant #19 into [X]
0x149B:  91B  LBPX     #1B         ; Load constant #27 into [X]
0x149C:  917  LBPX     #17         ; Load constant #23 into [X]
0x149D:  903  LBPX     #3          ; Load constant #3 into [X]
0x149E:  900  LBPX     #0          ; Load constant #0 into [X]
0x149F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x14A0:  938  LBPX     #38         ; Load constant #56 into [X]
0x14A1:  9A6  LBPX     #A6         ; Load constant #166 into [X]
0x14A2:  913  LBPX     #13         ; Load constant #19 into [X]
0x14A3:  90F  LBPX     #F          ; Load constant #15 into [X]
0x14A4:  903  LBPX     #3          ; Load constant #3 into [X]
0x14A5:  9E0  LBPX     #E0         ; Load constant #224 into [X]
0x14A6:  9D0  LBPX     #D0         ; Load constant #208 into [X]
0x14A7:  931  LBPX     #31         ; Load constant #49 into [X]
0x14A8:  930  LBPX     #30         ; Load constant #48 into [X]
0x14A9:  9D0  LBPX     #D0         ; Load constant #208 into [X]
0x14AA:  9E2  LBPX     #E2         ; Load constant #226 into [X]
0x14AB:  90F  LBPX     #F          ; Load constant #15 into [X]
0x14AC:  913  LBPX     #13         ; Load constant #19 into [X]
0x14AD:  916  LBPX     #16         ; Load constant #22 into [X]
0x14AE:  948  LBPX     #48         ; Load constant #72 into [X]
0x14AF:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0x14B0:  900  LBPX     #0          ; Load constant #0 into [X]
0x14B1:  910  LBPX     #10         ; Load constant #16 into [X]
0x14B2:  900  LBPX     #0          ; Load constant #0 into [X]
0x14B3:  903  LBPX     #3          ; Load constant #3 into [X]
0x14B4:  915  LBPX     #15         ; Load constant #21 into [X]
0x14B5:  919  LBPX     #19         ; Load constant #25 into [X]
0x14B6:  91B  LBPX     #1B         ; Load constant #27 into [X]
0x14B7:  91F  LBPX     #1F         ; Load constant #31 into [X]
0x14B8:  917  LBPX     #17         ; Load constant #23 into [X]
0x14B9:  917  LBPX     #17         ; Load constant #23 into [X]
0x14BA:  91D  LBPX     #1D         ; Load constant #29 into [X]
0x14BB:  916  LBPX     #16         ; Load constant #22 into [X]
0x14BC:  903  LBPX     #3          ; Load constant #3 into [X]
0x14BD:  900  LBPX     #0          ; Load constant #0 into [X]
0x14BE:  908  LBPX     #8          ; Load constant #8 into [X]
0x14BF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x14C0:  941  LBPX     #41         ; Load constant #65 into [X]
0x14C1:  92A  LBPX     #2A         ; Load constant #42 into [X]
0x14C2:  908  LBPX     #8          ; Load constant #8 into [X]
0x14C3:  936  LBPX     #36         ; Load constant #54 into [X]
0x14C4:  908  LBPX     #8          ; Load constant #8 into [X]
0x14C5:  92A  LBPX     #2A         ; Load constant #42 into [X]
0x14C6:  941  LBPX     #41         ; Load constant #65 into [X]
0x14C7:  900  LBPX     #0          ; Load constant #0 into [X]
0x14C8:  900  LBPX     #0          ; Load constant #0 into [X]
0x14C9:  900  LBPX     #0          ; Load constant #0 into [X]
0x14CA:  908  LBPX     #8          ; Load constant #8 into [X]
0x14CB:  914  LBPX     #14         ; Load constant #20 into [X]
0x14CC:  908  LBPX     #8          ; Load constant #8 into [X]
0x14CD:  900  LBPX     #0          ; Load constant #0 into [X]
0x14CE:  900  LBPX     #0          ; Load constant #0 into [X]
0x14CF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x14D0:  900  LBPX     #0          ; Load constant #0 into [X]
0x14D1:  900  LBPX     #0          ; Load constant #0 into [X]
0x14D2:  920  LBPX     #20         ; Load constant #32 into [X]
0x14D3:  950  LBPX     #50         ; Load constant #80 into [X]
0x14D4:  920  LBPX     #20         ; Load constant #32 into [X]
0x14D5:  900  LBPX     #0          ; Load constant #0 into [X]
0x14D6:  900  LBPX     #0          ; Load constant #0 into [X]
0x14D7:  900  LBPX     #0          ; Load constant #0 into [X]
0x14D8:  900  LBPX     #0          ; Load constant #0 into [X]
0x14D9:  922  LBPX     #22         ; Load constant #34 into [X]
0x14DA:  908  LBPX     #8          ; Load constant #8 into [X]
0x14DB:  914  LBPX     #14         ; Load constant #20 into [X]
0x14DC:  908  LBPX     #8          ; Load constant #8 into [X]
0x14DD:  922  LBPX     #22         ; Load constant #34 into [X]
0x14DE:  900  LBPX     #0          ; Load constant #0 into [X]
0x14DF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x14E0:  980  LBPX     #80         ; Load constant #128 into [X]
0x14E1:  940  LBPX     #40         ; Load constant #64 into [X]
0x14E2:  9F0  LBPX     #F0         ; Load constant #240 into [X]
0x14E3:  908  LBPX     #8          ; Load constant #8 into [X]
0x14E4:  924  LBPX     #24         ; Load constant #36 into [X]
0x14E5:  98E  LBPX     #8E         ; Load constant #142 into [X]
0x14E6:  996  LBPX     #96         ; Load constant #150 into [X]
0x14E7:  906  LBPX     #6          ; Load constant #6 into [X]
0x14E8:  924  LBPX     #24         ; Load constant #36 into [X]
0x14E9:  908  LBPX     #8          ; Load constant #8 into [X]
0x14EA:  9F0  LBPX     #F0         ; Load constant #240 into [X]
0x14EB:  940  LBPX     #40         ; Load constant #64 into [X]
0x14EC:  940  LBPX     #40         ; Load constant #64 into [X]
0x14ED:  980  LBPX     #80         ; Load constant #128 into [X]
0x14EE:  900  LBPX     #0          ; Load constant #0 into [X]
0x14EF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x14F0:  907  LBPX     #7          ; Load constant #7 into [X]
0x14F1:  908  LBPX     #8          ; Load constant #8 into [X]
0x14F2:  904  LBPX     #4          ; Load constant #4 into [X]
0x14F3:  905  LBPX     #5          ; Load constant #5 into [X]
0x14F4:  90E  LBPX     #E          ; Load constant #14 into [X]
0x14F5:  912  LBPX     #12         ; Load constant #18 into [X]
0x14F6:  922  LBPX     #22         ; Load constant #34 into [X]
0x14F7:  922  LBPX     #22         ; Load constant #34 into [X]
0x14F8:  962  LBPX     #62         ; Load constant #98 into [X]
0x14F9:  915  LBPX     #15         ; Load constant #21 into [X]
0x14FA:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x14FB:  904  LBPX     #4          ; Load constant #4 into [X]
0x14FC:  908  LBPX     #8          ; Load constant #8 into [X]
0x14FD:  907  LBPX     #7          ; Load constant #7 into [X]
0x14FE:  900  LBPX     #0          ; Load constant #0 into [X]
0x14FF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1500:  93E  LBPX     #3E         ; Load constant #62 into [X]
0x1501:  941  LBPX     #41         ; Load constant #65 into [X]
0x1502:  941  LBPX     #41         ; Load constant #65 into [X]
0x1503:  13E  UNKNOWN              ; Unrecognized instruction: 0x13E
0x1504:  900  LBPX     #0          ; Load constant #0 into [X]
0x1505:  900  LBPX     #0          ; Load constant #0 into [X]
0x1506:  902  LBPX     #2          ; Load constant #2 into [X]
0x1507:  17F  UNKNOWN              ; Unrecognized instruction: 0x17F
0x1508:  962  LBPX     #62         ; Load constant #98 into [X]
0x1509:  951  LBPX     #51         ; Load constant #81 into [X]
0x150A:  949  LBPX     #49         ; Load constant #73 into [X]
0x150B:  146  UNKNOWN              ; Unrecognized instruction: 0x146
0x150C:  941  LBPX     #41         ; Load constant #65 into [X]
0x150D:  949  LBPX     #49         ; Load constant #73 into [X]
0x150E:  949  LBPX     #49         ; Load constant #73 into [X]
0x150F:  136  UNKNOWN              ; Unrecognized instruction: 0x136
0x1510:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x1511:  922  LBPX     #22         ; Load constant #34 into [X]
0x1512:  97F  LBPX     #7F         ; Load constant #127 into [X]
0x1513:  120  UNKNOWN              ; Unrecognized instruction: 0x120
0x1514:  94F  LBPX     #4F         ; Load constant #79 into [X]
0x1515:  949  LBPX     #49         ; Load constant #73 into [X]
0x1516:  949  LBPX     #49         ; Load constant #73 into [X]
0x1517:  131  UNKNOWN              ; Unrecognized instruction: 0x131
0x1518:  93E  LBPX     #3E         ; Load constant #62 into [X]
0x1519:  949  LBPX     #49         ; Load constant #73 into [X]
0x151A:  949  LBPX     #49         ; Load constant #73 into [X]
0x151B:  132  UNKNOWN              ; Unrecognized instruction: 0x132
0x151C:  907  LBPX     #7          ; Load constant #7 into [X]
0x151D:  901  LBPX     #1          ; Load constant #1 into [X]
0x151E:  971  LBPX     #71         ; Load constant #113 into [X]
0x151F:  10F  UNKNOWN              ; Unrecognized instruction: 0x10F
0x1520:  936  LBPX     #36         ; Load constant #54 into [X]
0x1521:  949  LBPX     #49         ; Load constant #73 into [X]
0x1522:  949  LBPX     #49         ; Load constant #73 into [X]
0x1523:  136  UNKNOWN              ; Unrecognized instruction: 0x136
0x1524:  906  LBPX     #6          ; Load constant #6 into [X]
0x1525:  949  LBPX     #49         ; Load constant #73 into [X]
0x1526:  949  LBPX     #49         ; Load constant #73 into [X]
0x1527:  13E  UNKNOWN              ; Unrecognized instruction: 0x13E
0x1528:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x1529:  944  LBPX     #44         ; Load constant #68 into [X]
0x152A:  17C  UNKNOWN              ; Unrecognized instruction: 0x17C
0x152B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x152C:  900  LBPX     #0          ; Load constant #0 into [X]
0x152D:  900  LBPX     #0          ; Load constant #0 into [X]
0x152E:  17C  UNKNOWN              ; Unrecognized instruction: 0x17C
0x152F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1530:  974  LBPX     #74         ; Load constant #116 into [X]
0x1531:  954  LBPX     #54         ; Load constant #84 into [X]
0x1532:  15C  UNKNOWN              ; Unrecognized instruction: 0x15C
0x1533:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1534:  954  LBPX     #54         ; Load constant #84 into [X]
0x1535:  954  LBPX     #54         ; Load constant #84 into [X]
0x1536:  17C  UNKNOWN              ; Unrecognized instruction: 0x17C
0x1537:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1538:  91C  LBPX     #1C         ; Load constant #28 into [X]
0x1539:  910  LBPX     #10         ; Load constant #16 into [X]
0x153A:  17C  UNKNOWN              ; Unrecognized instruction: 0x17C
0x153B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x153C:  95C  LBPX     #5C         ; Load constant #92 into [X]
0x153D:  954  LBPX     #54         ; Load constant #84 into [X]
0x153E:  174  UNKNOWN              ; Unrecognized instruction: 0x174
0x153F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1540:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x1541:  954  LBPX     #54         ; Load constant #84 into [X]
0x1542:  174  UNKNOWN              ; Unrecognized instruction: 0x174
0x1543:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1544:  90C  LBPX     #C          ; Load constant #12 into [X]
0x1545:  904  LBPX     #4          ; Load constant #4 into [X]
0x1546:  17C  UNKNOWN              ; Unrecognized instruction: 0x17C
0x1547:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1548:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x1549:  954  LBPX     #54         ; Load constant #84 into [X]
0x154A:  17C  UNKNOWN              ; Unrecognized instruction: 0x17C
0x154B:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x154C:  95C  LBPX     #5C         ; Load constant #92 into [X]
0x154D:  954  LBPX     #54         ; Load constant #84 into [X]
0x154E:  17C  UNKNOWN              ; Unrecognized instruction: 0x17C
0x154F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1550:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x1551:  938  LBPX     #38         ; Load constant #56 into [X]
0x1552:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0x1553:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1554:  944  LBPX     #44         ; Load constant #68 into [X]
0x1555:  928  LBPX     #28         ; Load constant #40 into [X]
0x1556:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0x1557:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1558:  064  JP       0x264       ; Jump to address 0x264
0x1559:  064  JP       0x264       ; Jump to address 0x264
0x155A:  071  JP       0x271       ; Jump to address 0x271
0x155B:  07E  JP       0x27E       ; Jump to address 0x27E
0x155C:  08B  JP       0x28B       ; Jump to address 0x28B
0x155D:  098  JP       0x298       ; Jump to address 0x298
0x155E:  0A5  JP       0x2A5       ; Jump to address 0x2A5
0x155F:  0B2  JP       0x2B2       ; Jump to address 0x2B2
0x1560:  0BF  JP       0x2BF       ; Jump to address 0x2BF
0x1561:  0CC  JP       0x2CC       ; Jump to address 0x2CC
0x1562:  0D9  JP       0x2D9       ; Jump to address 0x2D9
0x1563:  098  JP       0x298       ; Jump to address 0x298
0x1564:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x1565:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x1566:  903  LBPX     #3          ; Load constant #3 into [X]
0x1567:  904  LBPX     #4          ; Load constant #4 into [X]
0x1568:  92D  LBPX     #2D         ; Load constant #45 into [X]
0x1569:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x156A:  905  LBPX     #5          ; Load constant #5 into [X]
0x156B:  905  LBPX     #5          ; Load constant #5 into [X]
0x156C:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x156D:  9F0  LBPX     #F0         ; Load constant #240 into [X]
0x156E:  980  LBPX     #80         ; Load constant #128 into [X]
0x156F:  911  LBPX     #11         ; Load constant #17 into [X]
0x1570:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1571:  909  LBPX     #9          ; Load constant #9 into [X]
0x1572:  914  LBPX     #14         ; Load constant #20 into [X]
0x1573:  932  LBPX     #32         ; Load constant #50 into [X]
0x1574:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x1575:  9DE  LBPX     #DE         ; Load constant #222 into [X]
0x1576:  9C3  LBPX     #C3         ; Load constant #195 into [X]
0x1577:  910  LBPX     #10         ; Load constant #16 into [X]
0x1578:  999  LBPX     #99         ; Load constant #153 into [X]
0x1579:  964  LBPX     #64         ; Load constant #100 into [X]
0x157A:  965  LBPX     #65         ; Load constant #101 into [X]
0x157B:  980  LBPX     #80         ; Load constant #128 into [X]
0x157C:  911  LBPX     #11         ; Load constant #17 into [X]
0x157D:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x157E:  909  LBPX     #9          ; Load constant #9 into [X]
0x157F:  915  LBPX     #15         ; Load constant #21 into [X]
0x1580:  94B  LBPX     #4B         ; Load constant #75 into [X]
0x1581:  955  LBPX     #55         ; Load constant #85 into [X]
0x1582:  978  LBPX     #78         ; Load constant #120 into [X]
0x1583:  9C6  LBPX     #C6         ; Load constant #198 into [X]
0x1584:  920  LBPX     #20         ; Load constant #32 into [X]
0x1585:  999  LBPX     #99         ; Load constant #153 into [X]
0x1586:  9AC  LBPX     #AC         ; Load constant #172 into [X]
0x1587:  968  LBPX     #68         ; Load constant #104 into [X]
0x1588:  980  LBPX     #80         ; Load constant #128 into [X]
0x1589:  911  LBPX     #11         ; Load constant #17 into [X]
0x158A:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0x158B:  909  LBPX     #9          ; Load constant #9 into [X]
0x158C:  915  LBPX     #15         ; Load constant #21 into [X]
0x158D:  94B  LBPX     #4B         ; Load constant #75 into [X]
0x158E:  955  LBPX     #55         ; Load constant #85 into [X]
0x158F:  994  LBPX     #94         ; Load constant #148 into [X]
0x1590:  9C2  LBPX     #C2         ; Load constant #194 into [X]
0x1591:  920  LBPX     #20         ; Load constant #32 into [X]
0x1592:  999  LBPX     #99         ; Load constant #153 into [X]
0x1593:  964  LBPX     #64         ; Load constant #100 into [X]
0x1594:  965  LBPX     #65         ; Load constant #101 into [X]
0x1595:  980  LBPX     #80         ; Load constant #128 into [X]
0x1596:  911  LBPX     #11         ; Load constant #17 into [X]
0x1597:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1598:  909  LBPX     #9          ; Load constant #9 into [X]
0x1599:  916  LBPX     #16         ; Load constant #22 into [X]
0x159A:  951  LBPX     #51         ; Load constant #81 into [X]
0x159B:  95B  LBPX     #5B         ; Load constant #91 into [X]
0x159C:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x159D:  98F  LBPX     #8F         ; Load constant #143 into [X]
0x159E:  930  LBPX     #30         ; Load constant #48 into [X]
0x159F:  999  LBPX     #99         ; Load constant #153 into [X]
0x15A0:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x15A1:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x15A2:  98F  LBPX     #8F         ; Load constant #143 into [X]
0x15A3:  911  LBPX     #11         ; Load constant #17 into [X]
0x15A4:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0x15A5:  909  LBPX     #9          ; Load constant #9 into [X]
0x15A6:  916  LBPX     #16         ; Load constant #22 into [X]
0x15A7:  951  LBPX     #51         ; Load constant #81 into [X]
0x15A8:  95B  LBPX     #5B         ; Load constant #91 into [X]
0x15A9:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x15AA:  98A  LBPX     #8A         ; Load constant #138 into [X]
0x15AB:  930  LBPX     #30         ; Load constant #48 into [X]
0x15AC:  999  LBPX     #99         ; Load constant #153 into [X]
0x15AD:  930  LBPX     #30         ; Load constant #48 into [X]
0x15AE:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x15AF:  988  LBPX     #88         ; Load constant #136 into [X]
0x15B0:  911  LBPX     #11         ; Load constant #17 into [X]
0x15B1:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0x15B2:  90B  LBPX     #B          ; Load constant #11 into [X]
0x15B3:  917  LBPX     #17         ; Load constant #23 into [X]
0x15B4:  937  LBPX     #37         ; Load constant #55 into [X]
0x15B5:  941  LBPX     #41         ; Load constant #65 into [X]
0x15B6:  920  LBPX     #20         ; Load constant #32 into [X]
0x15B7:  98A  LBPX     #8A         ; Load constant #138 into [X]
0x15B8:  930  LBPX     #30         ; Load constant #48 into [X]
0x15B9:  999  LBPX     #99         ; Load constant #153 into [X]
0x15BA:  940  LBPX     #40         ; Load constant #64 into [X]
0x15BB:  97B  LBPX     #7B         ; Load constant #123 into [X]
0x15BC:  9B0  LBPX     #B0         ; Load constant #176 into [X]
0x15BD:  923  LBPX     #23         ; Load constant #35 into [X]
0x15BE:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0x15BF:  909  LBPX     #9          ; Load constant #9 into [X]
0x15C0:  916  LBPX     #16         ; Load constant #22 into [X]
0x15C1:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x15C2:  946  LBPX     #46         ; Load constant #70 into [X]
0x15C3:  992  LBPX     #92         ; Load constant #146 into [X]
0x15C4:  9C4  LBPX     #C4         ; Load constant #196 into [X]
0x15C5:  920  LBPX     #20         ; Load constant #32 into [X]
0x15C6:  999  LBPX     #99         ; Load constant #153 into [X]
0x15C7:  918  LBPX     #18         ; Load constant #24 into [X]
0x15C8:  9F6  LBPX     #F6         ; Load constant #246 into [X]
0x15C9:  95F  LBPX     #5F         ; Load constant #95 into [X]
0x15CA:  943  LBPX     #43         ; Load constant #67 into [X]
0x15CB:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0x15CC:  909  LBPX     #9          ; Load constant #9 into [X]
0x15CD:  916  LBPX     #16         ; Load constant #22 into [X]
0x15CE:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x15CF:  946  LBPX     #46         ; Load constant #70 into [X]
0x15D0:  968  LBPX     #68         ; Load constant #104 into [X]
0x15D1:  9D1  LBPX     #D1         ; Load constant #209 into [X]
0x15D2:  910  LBPX     #10         ; Load constant #16 into [X]
0x15D3:  999  LBPX     #99         ; Load constant #153 into [X]
0x15D4:  90C  LBPX     #C          ; Load constant #12 into [X]
0x15D5:  973  LBPX     #73         ; Load constant #115 into [X]
0x15D6:  988  LBPX     #88         ; Load constant #136 into [X]
0x15D7:  911  LBPX     #11         ; Load constant #17 into [X]
0x15D8:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x15D9:  90A  LBPX     #A          ; Load constant #10 into [X]
0x15DA:  916  LBPX     #16         ; Load constant #22 into [X]
0x15DB:  92D  LBPX     #2D         ; Load constant #45 into [X]
0x15DC:  932  LBPX     #32         ; Load constant #50 into [X]
0x15DD:  994  LBPX     #94         ; Load constant #148 into [X]
0x15DE:  9C2  LBPX     #C2         ; Load constant #194 into [X]
0x15DF:  920  LBPX     #20         ; Load constant #32 into [X]
0x15E0:  999  LBPX     #99         ; Load constant #153 into [X]
0x15E1:  9A0  LBPX     #A0         ; Load constant #160 into [X]
0x15E2:  975  LBPX     #75         ; Load constant #117 into [X]
0x15E3:  980  LBPX     #80         ; Load constant #128 into [X]
0x15E4:  911  LBPX     #11         ; Load constant #17 into [X]
0x15E5:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0x15E6:  112  UNKNOWN              ; Unrecognized instruction: 0x112
0x15E7:  101  UNKNOWN              ; Unrecognized instruction: 0x101
0x15E8:  102  UNKNOWN              ; Unrecognized instruction: 0x102
0x15E9:  103  UNKNOWN              ; Unrecognized instruction: 0x103
0x15EA:  104  UNKNOWN              ; Unrecognized instruction: 0x104
0x15EB:  105  UNKNOWN              ; Unrecognized instruction: 0x105
0x15EC:  106  UNKNOWN              ; Unrecognized instruction: 0x106
0x15ED:  107  UNKNOWN              ; Unrecognized instruction: 0x107
0x15EE:  108  UNKNOWN              ; Unrecognized instruction: 0x108
0x15EF:  109  UNKNOWN              ; Unrecognized instruction: 0x109
0x15F0:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0x15F1:  111  UNKNOWN              ; Unrecognized instruction: 0x111
0x15F2:  192  UNKNOWN              ; Unrecognized instruction: 0x192
0x15F3:  181  UNKNOWN              ; Unrecognized instruction: 0x181
0x15F4:  182  UNKNOWN              ; Unrecognized instruction: 0x182
0x15F5:  183  UNKNOWN              ; Unrecognized instruction: 0x183
0x15F6:  184  UNKNOWN              ; Unrecognized instruction: 0x184
0x15F7:  185  UNKNOWN              ; Unrecognized instruction: 0x185
0x15F8:  186  UNKNOWN              ; Unrecognized instruction: 0x186
0x15F9:  187  UNKNOWN              ; Unrecognized instruction: 0x187
0x15FA:  188  UNKNOWN              ; Unrecognized instruction: 0x188
0x15FB:  189  UNKNOWN              ; Unrecognized instruction: 0x189
0x15FC:  190  UNKNOWN              ; Unrecognized instruction: 0x190
0x15FD:  191  UNKNOWN              ; Unrecognized instruction: 0x191
0x15FE:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x15FF:  FFF  UNKNOWN              ; Unrecognized instruction: 0xFFF
0x1600:  900  LBPX     #0          ; Load constant #0 into [X]
0x1601:  900  LBPX     #0          ; Load constant #0 into [X]
0x1602:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x1603:  982  LBPX     #82         ; Load constant #130 into [X]
0x1604:  982  LBPX     #82         ; Load constant #130 into [X]
0x1605:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x1606:  900  LBPX     #0          ; Load constant #0 into [X]
0x1607:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1608:  900  LBPX     #0          ; Load constant #0 into [X]
0x1609:  900  LBPX     #0          ; Load constant #0 into [X]
0x160A:  900  LBPX     #0          ; Load constant #0 into [X]
0x160B:  904  LBPX     #4          ; Load constant #4 into [X]
0x160C:  9FE  LBPX     #FE         ; Load constant #254 into [X]
0x160D:  900  LBPX     #0          ; Load constant #0 into [X]
0x160E:  900  LBPX     #0          ; Load constant #0 into [X]
0x160F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1610:  900  LBPX     #0          ; Load constant #0 into [X]
0x1611:  900  LBPX     #0          ; Load constant #0 into [X]
0x1612:  9CC  LBPX     #CC         ; Load constant #204 into [X]
0x1613:  9A2  LBPX     #A2         ; Load constant #162 into [X]
0x1614:  992  LBPX     #92         ; Load constant #146 into [X]
0x1615:  98C  LBPX     #8C         ; Load constant #140 into [X]
0x1616:  900  LBPX     #0          ; Load constant #0 into [X]
0x1617:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1618:  900  LBPX     #0          ; Load constant #0 into [X]
0x1619:  900  LBPX     #0          ; Load constant #0 into [X]
0x161A:  944  LBPX     #44         ; Load constant #68 into [X]
0x161B:  982  LBPX     #82         ; Load constant #130 into [X]
0x161C:  992  LBPX     #92         ; Load constant #146 into [X]
0x161D:  96C  LBPX     #6C         ; Load constant #108 into [X]
0x161E:  900  LBPX     #0          ; Load constant #0 into [X]
0x161F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1620:  900  LBPX     #0          ; Load constant #0 into [X]
0x1621:  900  LBPX     #0          ; Load constant #0 into [X]
0x1622:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x1623:  922  LBPX     #22         ; Load constant #34 into [X]
0x1624:  9FE  LBPX     #FE         ; Load constant #254 into [X]
0x1625:  920  LBPX     #20         ; Load constant #32 into [X]
0x1626:  900  LBPX     #0          ; Load constant #0 into [X]
0x1627:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1628:  900  LBPX     #0          ; Load constant #0 into [X]
0x1629:  900  LBPX     #0          ; Load constant #0 into [X]
0x162A:  99E  LBPX     #9E         ; Load constant #158 into [X]
0x162B:  992  LBPX     #92         ; Load constant #146 into [X]
0x162C:  992  LBPX     #92         ; Load constant #146 into [X]
0x162D:  962  LBPX     #62         ; Load constant #98 into [X]
0x162E:  900  LBPX     #0          ; Load constant #0 into [X]
0x162F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1630:  900  LBPX     #0          ; Load constant #0 into [X]
0x1631:  900  LBPX     #0          ; Load constant #0 into [X]
0x1632:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x1633:  992  LBPX     #92         ; Load constant #146 into [X]
0x1634:  992  LBPX     #92         ; Load constant #146 into [X]
0x1635:  964  LBPX     #64         ; Load constant #100 into [X]
0x1636:  900  LBPX     #0          ; Load constant #0 into [X]
0x1637:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1638:  900  LBPX     #0          ; Load constant #0 into [X]
0x1639:  900  LBPX     #0          ; Load constant #0 into [X]
0x163A:  906  LBPX     #6          ; Load constant #6 into [X]
0x163B:  9E2  LBPX     #E2         ; Load constant #226 into [X]
0x163C:  912  LBPX     #12         ; Load constant #18 into [X]
0x163D:  90E  LBPX     #E          ; Load constant #14 into [X]
0x163E:  900  LBPX     #0          ; Load constant #0 into [X]
0x163F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1640:  900  LBPX     #0          ; Load constant #0 into [X]
0x1641:  900  LBPX     #0          ; Load constant #0 into [X]
0x1642:  96C  LBPX     #6C         ; Load constant #108 into [X]
0x1643:  992  LBPX     #92         ; Load constant #146 into [X]
0x1644:  992  LBPX     #92         ; Load constant #146 into [X]
0x1645:  96C  LBPX     #6C         ; Load constant #108 into [X]
0x1646:  900  LBPX     #0          ; Load constant #0 into [X]
0x1647:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1648:  900  LBPX     #0          ; Load constant #0 into [X]
0x1649:  900  LBPX     #0          ; Load constant #0 into [X]
0x164A:  94C  LBPX     #4C         ; Load constant #76 into [X]
0x164B:  992  LBPX     #92         ; Load constant #146 into [X]
0x164C:  992  LBPX     #92         ; Load constant #146 into [X]
0x164D:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x164E:  900  LBPX     #0          ; Load constant #0 into [X]
0x164F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1650:  900  LBPX     #0          ; Load constant #0 into [X]
0x1651:  9EE  LBPX     #EE         ; Load constant #238 into [X]
0x1652:  925  LBPX     #25         ; Load constant #37 into [X]
0x1653:  9C5  LBPX     #C5         ; Load constant #197 into [X]
0x1654:  925  LBPX     #25         ; Load constant #37 into [X]
0x1655:  9EF  LBPX     #EF         ; Load constant #239 into [X]
0x1656:  9EE  LBPX     #EE         ; Load constant #238 into [X]
0x1657:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1658:  900  LBPX     #0          ; Load constant #0 into [X]
0x1659:  9EF  LBPX     #EF         ; Load constant #239 into [X]
0x165A:  92F  LBPX     #2F         ; Load constant #47 into [X]
0x165B:  9C5  LBPX     #C5         ; Load constant #197 into [X]
0x165C:  925  LBPX     #25         ; Load constant #37 into [X]
0x165D:  9E5  LBPX     #E5         ; Load constant #229 into [X]
0x165E:  9E2  LBPX     #E2         ; Load constant #226 into [X]
0x165F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1660:  900  LBPX     #0          ; Load constant #0 into [X]
0x1661:  900  LBPX     #0          ; Load constant #0 into [X]
0x1662:  94C  LBPX     #4C         ; Load constant #76 into [X]
0x1663:  992  LBPX     #92         ; Load constant #146 into [X]
0x1664:  992  LBPX     #92         ; Load constant #146 into [X]
0x1665:  964  LBPX     #64         ; Load constant #100 into [X]
0x1666:  900  LBPX     #0          ; Load constant #0 into [X]
0x1667:  1FE  UNKNOWN              ; Unrecognized instruction: 0x1FE
0x1668:  992  LBPX     #92         ; Load constant #146 into [X]
0x1669:  992  LBPX     #92         ; Load constant #146 into [X]
0x166A:  900  LBPX     #0          ; Load constant #0 into [X]
0x166B:  902  LBPX     #2          ; Load constant #2 into [X]
0x166C:  9FE  LBPX     #FE         ; Load constant #254 into [X]
0x166D:  902  LBPX     #2          ; Load constant #2 into [X]
0x166E:  900  LBPX     #0          ; Load constant #0 into [X]
0x166F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1670:  900  LBPX     #0          ; Load constant #0 into [X]
0x1671:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x1672:  942  LBPX     #42         ; Load constant #66 into [X]
0x1673:  942  LBPX     #42         ; Load constant #66 into [X]
0x1674:  942  LBPX     #42         ; Load constant #66 into [X]
0x1675:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x1676:  900  LBPX     #0          ; Load constant #0 into [X]
0x1677:  17E  UNKNOWN              ; Unrecognized instruction: 0x17E
0x1678:  900  LBPX     #0          ; Load constant #0 into [X]
0x1679:  93E  LBPX     #3E         ; Load constant #62 into [X]
0x167A:  9C0  LBPX     #C0         ; Load constant #192 into [X]
0x167B:  93E  LBPX     #3E         ; Load constant #62 into [X]
0x167C:  900  LBPX     #0          ; Load constant #0 into [X]
0x167D:  9CE  LBPX     #CE         ; Load constant #206 into [X]
0x167E:  992  LBPX     #92         ; Load constant #146 into [X]
0x167F:  1E6  UNKNOWN              ; Unrecognized instruction: 0x1E6
0x1680:  90C  LBPX     #C          ; Load constant #12 into [X]
0x1681:  9F2  LBPX     #F2         ; Load constant #242 into [X]
0x1682:  982  LBPX     #82         ; Load constant #130 into [X]
0x1683:  982  LBPX     #82         ; Load constant #130 into [X]
0x1684:  9F2  LBPX     #F2         ; Load constant #242 into [X]
0x1685:  98E  LBPX     #8E         ; Load constant #142 into [X]
0x1686:  9F2  LBPX     #F2         ; Load constant #242 into [X]
0x1687:  10C  UNKNOWN              ; Unrecognized instruction: 0x10C
0x1688:  90C  LBPX     #C          ; Load constant #12 into [X]
0x1689:  9F2  LBPX     #F2         ; Load constant #242 into [X]
0x168A:  984  LBPX     #84         ; Load constant #132 into [X]
0x168B:  988  LBPX     #88         ; Load constant #136 into [X]
0x168C:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x168D:  988  LBPX     #88         ; Load constant #136 into [X]
0x168E:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x168F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1690:  900  LBPX     #0          ; Load constant #0 into [X]
0x1691:  9F0  LBPX     #F0         ; Load constant #240 into [X]
0x1692:  990  LBPX     #90         ; Load constant #144 into [X]
0x1693:  9A0  LBPX     #A0         ; Load constant #160 into [X]
0x1694:  9E0  LBPX     #E0         ; Load constant #224 into [X]
0x1695:  9A0  LBPX     #A0         ; Load constant #160 into [X]
0x1696:  9E0  LBPX     #E0         ; Load constant #224 into [X]
0x1697:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1698:  900  LBPX     #0          ; Load constant #0 into [X]
0x1699:  900  LBPX     #0          ; Load constant #0 into [X]
0x169A:  900  LBPX     #0          ; Load constant #0 into [X]
0x169B:  900  LBPX     #0          ; Load constant #0 into [X]
0x169C:  900  LBPX     #0          ; Load constant #0 into [X]
0x169D:  900  LBPX     #0          ; Load constant #0 into [X]
0x169E:  900  LBPX     #0          ; Load constant #0 into [X]
0x169F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x16A0:  904  LBPX     #4          ; Load constant #4 into [X]
0x16A1:  906  LBPX     #6          ; Load constant #6 into [X]
0x16A2:  93F  LBPX     #3F         ; Load constant #63 into [X]
0x16A3:  934  LBPX     #34         ; Load constant #52 into [X]
0x16A4:  92C  LBPX     #2C         ; Load constant #44 into [X]
0x16A5:  9FC  LBPX     #FC         ; Load constant #252 into [X]
0x16A6:  960  LBPX     #60         ; Load constant #96 into [X]
0x16A7:  120  UNKNOWN              ; Unrecognized instruction: 0x120
0x16A8:  900  LBPX     #0          ; Load constant #0 into [X]
0x16A9:  900  LBPX     #0          ; Load constant #0 into [X]
0x16AA:  938  LBPX     #38         ; Load constant #56 into [X]
0x16AB:  930  LBPX     #30         ; Load constant #48 into [X]
0x16AC:  928  LBPX     #28         ; Load constant #40 into [X]
0x16AD:  9FC  LBPX     #FC         ; Load constant #252 into [X]
0x16AE:  960  LBPX     #60         ; Load constant #96 into [X]
0x16AF:  120  UNKNOWN              ; Unrecognized instruction: 0x120
0x16B0:  900  LBPX     #0          ; Load constant #0 into [X]
0x16B1:  900  LBPX     #0          ; Load constant #0 into [X]
0x16B2:  920  LBPX     #20         ; Load constant #32 into [X]
0x16B3:  930  LBPX     #30         ; Load constant #48 into [X]
0x16B4:  920  LBPX     #20         ; Load constant #32 into [X]
0x16B5:  9F0  LBPX     #F0         ; Load constant #240 into [X]
0x16B6:  960  LBPX     #60         ; Load constant #96 into [X]
0x16B7:  120  UNKNOWN              ; Unrecognized instruction: 0x120
0x16B8:  90A  LBPX     #A          ; Load constant #10 into [X]
0x16B9:  90A  LBPX     #A          ; Load constant #10 into [X]
0x16BA:  902  LBPX     #2          ; Load constant #2 into [X]
0x16BB:  900  LBPX     #0          ; Load constant #0 into [X]
0x16BC:  97E  LBPX     #7E         ; Load constant #126 into [X]
0x16BD:  90A  LBPX     #A          ; Load constant #10 into [X]
0x16BE:  90A  LBPX     #A          ; Load constant #10 into [X]
0x16BF:  102  UNKNOWN              ; Unrecognized instruction: 0x102
0x16C0:  900  LBPX     #0          ; Load constant #0 into [X]
0x16C1:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x16C2:  97A  LBPX     #7A         ; Load constant #122 into [X]
0x16C3:  96E  LBPX     #6E         ; Load constant #110 into [X]
0x16C4:  96E  LBPX     #6E         ; Load constant #110 into [X]
0x16C5:  97A  LBPX     #7A         ; Load constant #122 into [X]
0x16C6:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x16C7:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x16C8:  900  LBPX     #0          ; Load constant #0 into [X]
0x16C9:  99C  LBPX     #9C         ; Load constant #156 into [X]
0x16CA:  9A0  LBPX     #A0         ; Load constant #160 into [X]
0x16CB:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x16CC:  900  LBPX     #0          ; Load constant #0 into [X]
0x16CD:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x16CE:  908  LBPX     #8          ; Load constant #8 into [X]
0x16CF:  104  UNKNOWN              ; Unrecognized instruction: 0x104
0x16D0:  900  LBPX     #0          ; Load constant #0 into [X]
0x16D1:  986  LBPX     #86         ; Load constant #134 into [X]
0x16D2:  9F4  LBPX     #F4         ; Load constant #244 into [X]
0x16D3:  994  LBPX     #94         ; Load constant #148 into [X]
0x16D4:  9DC  LBPX     #DC         ; Load constant #220 into [X]
0x16D5:  994  LBPX     #94         ; Load constant #148 into [X]
0x16D6:  9F4  LBPX     #F4         ; Load constant #244 into [X]
0x16D7:  186  UNKNOWN              ; Unrecognized instruction: 0x186
0x16D8:  900  LBPX     #0          ; Load constant #0 into [X]
0x16D9:  9FC  LBPX     #FC         ; Load constant #252 into [X]
0x16DA:  984  LBPX     #84         ; Load constant #132 into [X]
0x16DB:  9FC  LBPX     #FC         ; Load constant #252 into [X]
0x16DC:  900  LBPX     #0          ; Load constant #0 into [X]
0x16DD:  9C4  LBPX     #C4         ; Load constant #196 into [X]
0x16DE:  9B4  LBPX     #B4         ; Load constant #180 into [X]
0x16DF:  18C  UNKNOWN              ; Unrecognized instruction: 0x18C
0x16E0:  91C  LBPX     #1C         ; Load constant #28 into [X]
0x16E1:  932  LBPX     #32         ; Load constant #50 into [X]
0x16E2:  97E  LBPX     #7E         ; Load constant #126 into [X]
0x16E3:  9FC  LBPX     #FC         ; Load constant #252 into [X]
0x16E4:  97E  LBPX     #7E         ; Load constant #126 into [X]
0x16E5:  93E  LBPX     #3E         ; Load constant #62 into [X]
0x16E6:  91C  LBPX     #1C         ; Load constant #28 into [X]
0x16E7:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x16E8:  91C  LBPX     #1C         ; Load constant #28 into [X]
0x16E9:  922  LBPX     #22         ; Load constant #34 into [X]
0x16EA:  942  LBPX     #42         ; Load constant #66 into [X]
0x16EB:  984  LBPX     #84         ; Load constant #132 into [X]
0x16EC:  942  LBPX     #42         ; Load constant #66 into [X]
0x16ED:  922  LBPX     #22         ; Load constant #34 into [X]
0x16EE:  91C  LBPX     #1C         ; Load constant #28 into [X]
0x16EF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x16F0:  905  LBPX     #5          ; Load constant #5 into [X]
0x16F1:  9C2  LBPX     #C2         ; Load constant #194 into [X]
0x16F2:  9A0  LBPX     #A0         ; Load constant #160 into [X]
0x16F3:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x16F4:  9D0  LBPX     #D0         ; Load constant #208 into [X]
0x16F5:  9E0  LBPX     #E0         ; Load constant #224 into [X]
0x16F6:  9CA  LBPX     #CA         ; Load constant #202 into [X]
0x16F7:  104  UNKNOWN              ; Unrecognized instruction: 0x104
0x16F8:  904  LBPX     #4          ; Load constant #4 into [X]
0x16F9:  9CA  LBPX     #CA         ; Load constant #202 into [X]
0x16FA:  9E0  LBPX     #E0         ; Load constant #224 into [X]
0x16FB:  9F8  LBPX     #F8         ; Load constant #248 into [X]
0x16FC:  9D0  LBPX     #D0         ; Load constant #208 into [X]
0x16FD:  9A0  LBPX     #A0         ; Load constant #160 into [X]
0x16FE:  9C2  LBPX     #C2         ; Load constant #194 into [X]
0x16FF:  105  UNKNOWN              ; Unrecognized instruction: 0x105
0x1700:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x1701:  93B  LBPX     #3B         ; Load constant #59 into [X]
0x1702:  95B  LBPX     #5B         ; Load constant #91 into [X]
0x1703:  96B  LBPX     #6B         ; Load constant #107 into [X]
0x1704:  973  LBPX     #73         ; Load constant #115 into [X]
0x1705:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x1706:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x1707:  1FF  UNKNOWN              ; Unrecognized instruction: 0x1FF
0x1708:  9DF  LBPX     #DF         ; Load constant #223 into [X]
0x1709:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x170A:  9EF  LBPX     #EF         ; Load constant #239 into [X]
0x170B:  9FF  LBPX     #FF         ; Load constant #255 into [X]
0x170C:  9E6  LBPX     #E6         ; Load constant #230 into [X]
0x170D:  9EA  LBPX     #EA         ; Load constant #234 into [X]
0x170E:  9EC  LBPX     #EC         ; Load constant #236 into [X]
0x170F:  1FF  UNKNOWN              ; Unrecognized instruction: 0x1FF
0x1710:  900  LBPX     #0          ; Load constant #0 into [X]
0x1711:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x1712:  9F6  LBPX     #F6         ; Load constant #246 into [X]
0x1713:  976  LBPX     #76         ; Load constant #118 into [X]
0x1714:  9DE  LBPX     #DE         ; Load constant #222 into [X]
0x1715:  976  LBPX     #76         ; Load constant #118 into [X]
0x1716:  9F6  LBPX     #F6         ; Load constant #246 into [X]
0x1717:  13C  UNKNOWN              ; Unrecognized instruction: 0x13C
0x1718:  908  LBPX     #8          ; Load constant #8 into [X]
0x1719:  942  LBPX     #42         ; Load constant #66 into [X]
0x171A:  918  LBPX     #18         ; Load constant #24 into [X]
0x171B:  925  LBPX     #25         ; Load constant #37 into [X]
0x171C:  9A4  LBPX     #A4         ; Load constant #164 into [X]
0x171D:  918  LBPX     #18         ; Load constant #24 into [X]
0x171E:  942  LBPX     #42         ; Load constant #66 into [X]
0x171F:  110  UNKNOWN              ; Unrecognized instruction: 0x110
0x1720:  900  LBPX     #0          ; Load constant #0 into [X]
0x1721:  940  LBPX     #40         ; Load constant #64 into [X]
0x1722:  900  LBPX     #0          ; Load constant #0 into [X]
0x1723:  90C  LBPX     #C          ; Load constant #12 into [X]
0x1724:  90F  LBPX     #F          ; Load constant #15 into [X]
0x1725:  91F  LBPX     #1F         ; Load constant #31 into [X]
0x1726:  91E  LBPX     #1E         ; Load constant #30 into [X]
0x1727:  106  UNKNOWN              ; Unrecognized instruction: 0x106
0x1728:  900  LBPX     #0          ; Load constant #0 into [X]
0x1729:  900  LBPX     #0          ; Load constant #0 into [X]
0x172A:  920  LBPX     #20         ; Load constant #32 into [X]
0x172B:  918  LBPX     #18         ; Load constant #24 into [X]
0x172C:  918  LBPX     #18         ; Load constant #24 into [X]
0x172D:  900  LBPX     #0          ; Load constant #0 into [X]
0x172E:  900  LBPX     #0          ; Load constant #0 into [X]
0x172F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1730:  900  LBPX     #0          ; Load constant #0 into [X]
0x1731:  910  LBPX     #10         ; Load constant #16 into [X]
0x1732:  938  LBPX     #38         ; Load constant #56 into [X]
0x1733:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x1734:  9FE  LBPX     #FE         ; Load constant #254 into [X]
0x1735:  938  LBPX     #38         ; Load constant #56 into [X]
0x1736:  938  LBPX     #38         ; Load constant #56 into [X]
0x1737:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1738:  900  LBPX     #0          ; Load constant #0 into [X]
0x1739:  938  LBPX     #38         ; Load constant #56 into [X]
0x173A:  938  LBPX     #38         ; Load constant #56 into [X]
0x173B:  9FE  LBPX     #FE         ; Load constant #254 into [X]
0x173C:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x173D:  938  LBPX     #38         ; Load constant #56 into [X]
0x173E:  910  LBPX     #10         ; Load constant #16 into [X]
0x173F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1740:  97E  LBPX     #7E         ; Load constant #126 into [X]
0x1741:  902  LBPX     #2          ; Load constant #2 into [X]
0x1742:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x1743:  902  LBPX     #2          ; Load constant #2 into [X]
0x1744:  97E  LBPX     #7E         ; Load constant #126 into [X]
0x1745:  900  LBPX     #0          ; Load constant #0 into [X]
0x1746:  938  LBPX     #38         ; Load constant #56 into [X]
0x1747:  154  UNKNOWN              ; Unrecognized instruction: 0x154
0x1748:  954  LBPX     #54         ; Load constant #84 into [X]
0x1749:  958  LBPX     #58         ; Load constant #88 into [X]
0x174A:  900  LBPX     #0          ; Load constant #0 into [X]
0x174B:  930  LBPX     #30         ; Load constant #48 into [X]
0x174C:  954  LBPX     #54         ; Load constant #84 into [X]
0x174D:  954  LBPX     #54         ; Load constant #84 into [X]
0x174E:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x174F:  140  UNKNOWN              ; Unrecognized instruction: 0x140
0x1750:  900  LBPX     #0          ; Load constant #0 into [X]
0x1751:  97E  LBPX     #7E         ; Load constant #126 into [X]
0x1752:  900  LBPX     #0          ; Load constant #0 into [X]
0x1753:  900  LBPX     #0          ; Load constant #0 into [X]
0x1754:  900  LBPX     #0          ; Load constant #0 into [X]
0x1755:  900  LBPX     #0          ; Load constant #0 into [X]
0x1756:  900  LBPX     #0          ; Load constant #0 into [X]
0x1757:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1758:  926  LBPX     #26         ; Load constant #38 into [X]
0x1759:  949  LBPX     #49         ; Load constant #73 into [X]
0x175A:  949  LBPX     #49         ; Load constant #73 into [X]
0x175B:  932  LBPX     #32         ; Load constant #50 into [X]
0x175C:  900  LBPX     #0          ; Load constant #0 into [X]
0x175D:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x175E:  904  LBPX     #4          ; Load constant #4 into [X]
0x175F:  104  UNKNOWN              ; Unrecognized instruction: 0x104
0x1760:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x1761:  900  LBPX     #0          ; Load constant #0 into [X]
0x1762:  930  LBPX     #30         ; Load constant #48 into [X]
0x1763:  954  LBPX     #54         ; Load constant #84 into [X]
0x1764:  954  LBPX     #54         ; Load constant #84 into [X]
0x1765:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x1766:  940  LBPX     #40         ; Load constant #64 into [X]
0x1767:  138  UNKNOWN              ; Unrecognized instruction: 0x138
0x1768:  944  LBPX     #44         ; Load constant #68 into [X]
0x1769:  944  LBPX     #44         ; Load constant #68 into [X]
0x176A:  928  LBPX     #28         ; Load constant #40 into [X]
0x176B:  900  LBPX     #0          ; Load constant #0 into [X]
0x176C:  97F  LBPX     #7F         ; Load constant #127 into [X]
0x176D:  910  LBPX     #10         ; Load constant #16 into [X]
0x176E:  968  LBPX     #68         ; Load constant #104 into [X]
0x176F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1770:  97F  LBPX     #7F         ; Load constant #127 into [X]
0x1771:  908  LBPX     #8          ; Load constant #8 into [X]
0x1772:  908  LBPX     #8          ; Load constant #8 into [X]
0x1773:  97F  LBPX     #7F         ; Load constant #127 into [X]
0x1774:  900  LBPX     #0          ; Load constant #0 into [X]
0x1775:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x1776:  940  LBPX     #40         ; Load constant #64 into [X]
0x1777:  17C  UNKNOWN              ; Unrecognized instruction: 0x17C
0x1778:  900  LBPX     #0          ; Load constant #0 into [X]
0x1779:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x177A:  904  LBPX     #4          ; Load constant #4 into [X]
0x177B:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x177C:  900  LBPX     #0          ; Load constant #0 into [X]
0x177D:  9BC  LBPX     #BC         ; Load constant #188 into [X]
0x177E:  9A4  LBPX     #A4         ; Load constant #164 into [X]
0x177F:  1FC  UNKNOWN              ; Unrecognized instruction: 0x1FC
0x1780:  900  LBPX     #0          ; Load constant #0 into [X]
0x1781:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x1782:  908  LBPX     #8          ; Load constant #8 into [X]
0x1783:  904  LBPX     #4          ; Load constant #4 into [X]
0x1784:  900  LBPX     #0          ; Load constant #0 into [X]
0x1785:  99C  LBPX     #9C         ; Load constant #156 into [X]
0x1786:  9A0  LBPX     #A0         ; Load constant #160 into [X]
0x1787:  17C  UNKNOWN              ; Unrecognized instruction: 0x17C
0x1788:  900  LBPX     #0          ; Load constant #0 into [X]
0x1789:  97F  LBPX     #7F         ; Load constant #127 into [X]
0x178A:  908  LBPX     #8          ; Load constant #8 into [X]
0x178B:  908  LBPX     #8          ; Load constant #8 into [X]
0x178C:  97F  LBPX     #7F         ; Load constant #127 into [X]
0x178D:  900  LBPX     #0          ; Load constant #0 into [X]
0x178E:  930  LBPX     #30         ; Load constant #48 into [X]
0x178F:  154  UNKNOWN              ; Unrecognized instruction: 0x154
0x1790:  954  LBPX     #54         ; Load constant #84 into [X]
0x1791:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x1792:  940  LBPX     #40         ; Load constant #64 into [X]
0x1793:  900  LBPX     #0          ; Load constant #0 into [X]
0x1794:  9FC  LBPX     #FC         ; Load constant #252 into [X]
0x1795:  924  LBPX     #24         ; Load constant #36 into [X]
0x1796:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x1797:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x1798:  9FC  LBPX     #FC         ; Load constant #252 into [X]
0x1799:  924  LBPX     #24         ; Load constant #36 into [X]
0x179A:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x179B:  900  LBPX     #0          ; Load constant #0 into [X]
0x179C:  99C  LBPX     #9C         ; Load constant #156 into [X]
0x179D:  9A0  LBPX     #A0         ; Load constant #160 into [X]
0x179E:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x179F:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x17A0:  900  LBPX     #0          ; Load constant #0 into [X]
0x17A1:  97F  LBPX     #7F         ; Load constant #127 into [X]
0x17A2:  941  LBPX     #41         ; Load constant #65 into [X]
0x17A3:  941  LBPX     #41         ; Load constant #65 into [X]
0x17A4:  93E  LBPX     #3E         ; Load constant #62 into [X]
0x17A5:  900  LBPX     #0          ; Load constant #0 into [X]
0x17A6:  974  LBPX     #74         ; Load constant #116 into [X]
0x17A7:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x17A8:  95C  LBPX     #5C         ; Load constant #92 into [X]
0x17A9:  974  LBPX     #74         ; Load constant #116 into [X]
0x17AA:  900  LBPX     #0          ; Load constant #0 into [X]
0x17AB:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x17AC:  944  LBPX     #44         ; Load constant #68 into [X]
0x17AD:  900  LBPX     #0          ; Load constant #0 into [X]
0x17AE:  974  LBPX     #74         ; Load constant #116 into [X]
0x17AF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x17B0:  9FC  LBPX     #FC         ; Load constant #252 into [X]
0x17B1:  924  LBPX     #24         ; Load constant #36 into [X]
0x17B2:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x17B3:  900  LBPX     #0          ; Load constant #0 into [X]
0x17B4:  97F  LBPX     #7F         ; Load constant #127 into [X]
0x17B5:  900  LBPX     #0          ; Load constant #0 into [X]
0x17B6:  974  LBPX     #74         ; Load constant #116 into [X]
0x17B7:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x17B8:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x17B9:  904  LBPX     #4          ; Load constant #4 into [X]
0x17BA:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x17BB:  900  LBPX     #0          ; Load constant #0 into [X]
0x17BC:  97C  LBPX     #7C         ; Load constant #124 into [X]
0x17BD:  954  LBPX     #54         ; Load constant #84 into [X]
0x17BE:  95C  LBPX     #5C         ; Load constant #92 into [X]
0x17BF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x17C0:  900  LBPX     #0          ; Load constant #0 into [X]
0x17C1:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x17C2:  942  LBPX     #42         ; Load constant #66 into [X]
0x17C3:  942  LBPX     #42         ; Load constant #66 into [X]
0x17C4:  942  LBPX     #42         ; Load constant #66 into [X]
0x17C5:  93C  LBPX     #3C         ; Load constant #60 into [X]
0x17C6:  900  LBPX     #0          ; Load constant #0 into [X]
0x17C7:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x17C8:  900  LBPX     #0          ; Load constant #0 into [X]
0x17C9:  97E  LBPX     #7E         ; Load constant #126 into [X]
0x17CA:  902  LBPX     #2          ; Load constant #2 into [X]
0x17CB:  90C  LBPX     #C          ; Load constant #12 into [X]
0x17CC:  930  LBPX     #30         ; Load constant #48 into [X]
0x17CD:  940  LBPX     #40         ; Load constant #64 into [X]
0x17CE:  97E  LBPX     #7E         ; Load constant #126 into [X]
0x17CF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x17D0:  900  LBPX     #0          ; Load constant #0 into [X]
0x17D1:  9C4  LBPX     #C4         ; Load constant #196 into [X]
0x17D2:  9A4  LBPX     #A4         ; Load constant #164 into [X]
0x17D3:  994  LBPX     #94         ; Load constant #148 into [X]
0x17D4:  98C  LBPX     #8C         ; Load constant #140 into [X]
0x17D5:  900  LBPX     #0          ; Load constant #0 into [X]
0x17D6:  900  LBPX     #0          ; Load constant #0 into [X]
0x17D7:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x17D8:  920  LBPX     #20         ; Load constant #32 into [X]
0x17D9:  900  LBPX     #0          ; Load constant #0 into [X]
0x17DA:  910  LBPX     #10         ; Load constant #16 into [X]
0x17DB:  900  LBPX     #0          ; Load constant #0 into [X]
0x17DC:  919  LBPX     #19         ; Load constant #25 into [X]
0x17DD:  915  LBPX     #15         ; Load constant #21 into [X]
0x17DE:  913  LBPX     #13         ; Load constant #19 into [X]
0x17DF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x17E0:  900  LBPX     #0          ; Load constant #0 into [X]
0x17E1:  900  LBPX     #0          ; Load constant #0 into [X]
0x17E2:  900  LBPX     #0          ; Load constant #0 into [X]
0x17E3:  900  LBPX     #0          ; Load constant #0 into [X]
0x17E4:  900  LBPX     #0          ; Load constant #0 into [X]
0x17E5:  900  LBPX     #0          ; Load constant #0 into [X]
0x17E6:  900  LBPX     #0          ; Load constant #0 into [X]
0x17E7:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x17E8:  900  LBPX     #0          ; Load constant #0 into [X]
0x17E9:  900  LBPX     #0          ; Load constant #0 into [X]
0x17EA:  900  LBPX     #0          ; Load constant #0 into [X]
0x17EB:  900  LBPX     #0          ; Load constant #0 into [X]
0x17EC:  900  LBPX     #0          ; Load constant #0 into [X]
0x17ED:  900  LBPX     #0          ; Load constant #0 into [X]
0x17EE:  900  LBPX     #0          ; Load constant #0 into [X]
0x17EF:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x17F0:  900  LBPX     #0          ; Load constant #0 into [X]
0x17F1:  900  LBPX     #0          ; Load constant #0 into [X]
0x17F2:  900  LBPX     #0          ; Load constant #0 into [X]
0x17F3:  900  LBPX     #0          ; Load constant #0 into [X]
0x17F4:  900  LBPX     #0          ; Load constant #0 into [X]
0x17F5:  900  LBPX     #0          ; Load constant #0 into [X]
0x17F6:  900  LBPX     #0          ; Load constant #0 into [X]
0x17F7:  100  UNKNOWN              ; Unrecognized instruction: 0x100
0x17F8:  900  LBPX     #0          ; Load constant #0 into [X]
0x17F9:  900  LBPX     #0          ; Load constant #0 into [X]
0x17FA:  900  LBPX     #0          ; Load constant #0 into [X]
0x17FB:  900  LBPX     #0          ; Load constant #0 into [X]
0x17FC:  900  LBPX     #0          ; Load constant #0 into [X]
0x17FD:  900  LBPX     #0          ; Load constant #0 into [X]
0x17FE:  900  LBPX     #0          ; Load constant #0 into [X]
0x17FF:  100  UNKNOWN              ; Unrecognized instruction: 0x100