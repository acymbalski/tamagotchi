; ======================================================================
; TAMAGOTCHI P1 MASTER DISASSEMBLY
; ======================================================================

0x000:  FA2  LD_A_MN  0x02        ; Direct RAM access at 0x02
0x001:  C87  AND_R_I  A, #7       ; Register A op with immediate #7
0x002:  E10  LD_R_I   B, #0       ; Register B op with immediate #0
0x003:  A80  ADD_R_Q  A, A        ; Register A op with A
0x004:  A80  ADD_R_Q  A, A        ; Register A op with A
0x005:  A95  ADC_R_Q  B, B        ; Register B op with B
0x006:  512  CALZ     0x112       ; Flow to 0x112
0x007:  E50  PSET     #10         ; Set next Page to 16
0x008:  020  JP       0x1020      ; Flow to 0x1020
0x009:  FC4  PUSH_XP              ; 
0x00A:  FC5  PUSH_XH              ; 
0x00B:  FC6  PUSH_XL              ; 
0x00C:  FC0  PUSH_R               ; 
0x00D:  5EF  CALZ     0x10EF      ; Flow to 0x10EF
0x00E:  B7D  LD_X     0x7D        ; Set pointer to RAM 0x7D
0x00F:  E2F  LD_R_I   [X], #15    ; Register [X] op with immediate #15
0x010:  F48  SET                  ; 
0x011:  01A  JP       0x101A      ; Flow to 0x101A
0x012:  FC4  PUSH_XP              ; 
0x013:  FC5  PUSH_XH              ; 
0x014:  FC6  PUSH_XL              ; 
0x015:  FC0  PUSH_R               ; 
0x016:  5EF  CALZ     0x10EF      ; Flow to 0x10EF
0x017:  B7D  LD_X     0x7D        ; Set pointer to RAM 0x7D
0x018:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0x019:  F57  RST                  ; 
0x01A:  FD0  POP_R                ; 
0x01B:  FD6  POP_XL               ; 
0x01C:  FD5  POP_XH               ; 
0x01D:  FD4  POP_XP               ; 
0x01E:  FDF  RET                  ; 
0x01F:  B02  LD_X     0x02        ; Set pointer to RAM 0x02
0x020:  53C  CALZ     0x103C      ; Flow to 0x103C
0x021:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x022:  E80  LD_XP_R              ; 
0x023:  B26  LD_X     0x26        ; Set pointer to RAM 0x26
0x024:  512  CALZ     0x1012      ; Flow to 0x1012
0x025:  EE2  LDPX_R               ; 
0x026:  EC6  LD_R_Q   B, [X]      ; Register B op with [X]
0x027:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x028:  509  CALZ     0x1009      ; Flow to 0x1009
0x029:  EE8  LDPX_R               ; 
0x02A:  EC9  LD_R_Q   [X], B      ; Register [X] op with B
0x02B:  FDF  RET                  ; 
0x02C:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x02D:  E90  LD_YP_R              ; 
0x02E:  822  LD_Y     0x22        ; Set pointer to RAM 0x22
0x02F:  512  CALZ     0x1012      ; Flow to 0x1012
0x030:  EAB  LD_R_XL              ; 
0x031:  EF0  INC_Y                ; 
0x032:  EA7  LD_R_XH              ; 
0x033:  509  CALZ     0x1009      ; Flow to 0x1009
0x034:  FDF  RET                  ; 
0x035:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x036:  E90  LD_YP_R              ; 
0x037:  823  LD_Y     0x23        ; Set pointer to RAM 0x23
0x038:  EC3  LD_R_Q   A, [Y]      ; Register A op with [Y]
0x039:  822  LD_Y     0x22        ; Set pointer to RAM 0x22
0x03A:  AD3  OR_R_Q   A, [Y]      ; Register A op with [Y]
0x03B:  FDF  RET                  ; 
0x03C:  42C  CALL     0x102C      ; Flow to 0x102C
0x03D:  435  CALL     0x1035      ; Flow to 0x1035
0x03E:  73D  JP_NZ    0x103D      ; Flow to 0x103D
0x03F:  FDF  RET                  ; 
0x040:  5EF  CALZ     0x10EF      ; Flow to 0x10EF
0x041:  B2A  LD_X     0x2A        ; Set pointer to RAM 0x2A
0x042:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x043:  E01  LD_R_I   A, #1       ; Register A op with immediate #1
0x044:  E10  LD_R_I   B, #0       ; Register B op with immediate #0
0x045:  E80  LD_XP_R              ; 
0x046:  B00  LD_X     0x00        ; Set pointer to RAM 0x00
0x047:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x048:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x049:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x04A:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x04B:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x04C:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x04D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x04E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x04F:  C1F  ADD_R_I  B, #15      ; Register B op with immediate #15
0x050:  747  JP_NZ    0x1047      ; Flow to 0x1047
0x051:  FDF  RET                  ; 
0x052:  E44  PSET     #4          ; Set next Page to 4
0x053:  486  CALL     0x486       ; Flow to 0x486 (MEM_SICK_LEVEL)
0x054:  E44  PSET     #4          ; Set next Page to 4
0x055:  400  CALL     0x400       ; Flow to 0x400 (MEM_HUNGER)
0x056:  5EF  CALZ     0x4EF       ; Flow to 0x4EF
0x057:  B2A  LD_X     0x2A        ; Set pointer to RAM 0x2A
0x058:  E9A  LD_YL_R              ; 
0x059:  EE0  INC_X                ; 
0x05A:  E96  LD_YH_R              ; 
0x05B:  E01  LD_R_I   A, #1       ; Register A op with immediate #1
0x05C:  E90  LD_YP_R              ; 
0x05D:  E0E  LD_R_I   A, #14      ; Register A op with immediate #14
0x05E:  E80  LD_XP_R              ; 
0x05F:  B00  LD_X     0x00        ; Set pointer to RAM 0x00
0x060:  48D  CALL     0x48D       ; Flow to 0x48D (MEM_SICK_LEVEL)
0x061:  F5E  RST                  ; 
0x062:  A27  ADC_YH               ; 
0x063:  B80  LD_X     0x80        ; Set pointer to RAM 0x80
0x064:  48D  CALL     0x48D       ; Flow to 0x48D (MEM_SICK_LEVEL)
0x065:  F5E  RST                  ; 
0x066:  A28  ADC_YH               ; 
0x067:  B12  LD_X     0x12        ; Set pointer to RAM 0x12
0x068:  48D  CALL     0x48D       ; Flow to 0x48D (MEM_SICK_LEVEL)
0x069:  F5E  RST                  ; 
0x06A:  A27  ADC_YH               ; 
0x06B:  B92  LD_X     0x92        ; Set pointer to RAM 0x92
0x06C:  48D  CALL     0x48D       ; Flow to 0x48D (MEM_SICK_LEVEL)
0x06D:  F5E  RST                  ; 
0x06E:  A28  ADC_YH               ; 
0x06F:  B48  LD_X     0x48        ; Set pointer to RAM 0x48 (MEM_SICK_LEVEL)
0x070:  F41  SET                  ; 
0x071:  49F  CALL     0x49F       ; Flow to 0x49F (MEM_SICK)
0x072:  B3E  LD_X     0x3E        ; Set pointer to RAM 0x3E
0x073:  F41  SET                  ; 
0x074:  4A7  CALL     0x4A7       ; Flow to 0x4A7 (MEM_SLEEPING)
0x075:  F5E  RST                  ; 
0x076:  A27  ADC_YH               ; 
0x077:  BC8  LD_X     0xC8        ; Set pointer to RAM 0xC8
0x078:  F41  SET                  ; 
0x079:  49F  CALL     0x49F       ; Flow to 0x49F (MEM_SICK)
0x07A:  BBE  LD_X     0xBE        ; Set pointer to RAM 0xBE
0x07B:  F41  SET                  ; 
0x07C:  4A7  CALL     0x4A7       ; Flow to 0x4A7 (MEM_SLEEPING)
0x07D:  F5E  RST                  ; 
0x07E:  A28  ADC_YH               ; 
0x07F:  B36  LD_X     0x36        ; Set pointer to RAM 0x36
0x080:  F41  SET                  ; 
0x081:  4A3  CALL     0x4A3       ; Flow to 0x4A3 (MEM_SLEEPING)
0x082:  B2E  LD_X     0x2E        ; Set pointer to RAM 0x2E
0x083:  F41  SET                  ; 
0x084:  4A3  CALL     0x4A3       ; Flow to 0x4A3 (MEM_SLEEPING)
0x085:  F5E  RST                  ; 
0x086:  A27  ADC_YH               ; 
0x087:  BB6  LD_X     0xB6        ; Set pointer to RAM 0xB6
0x088:  F41  SET                  ; 
0x089:  4A3  CALL     0x4A3       ; Flow to 0x4A3 (MEM_SLEEPING)
0x08A:  BAE  LD_X     0xAE        ; Set pointer to RAM 0xAE
0x08B:  F41  SET                  ; 
0x08C:  0A3  JP       0x4A3       ; Flow to 0x4A3 (MEM_SLEEPING)
0x08D:  48F  CALL     0x48F       ; Flow to 0x48F (MEM_SICK_LEVEL)
0x08E:  EE0  INC_X                ; 
0x08F:  EFB  LDPY_R               ; 
0x090:  EE0  INC_X                ; 
0x091:  EFB  LDPY_R               ; 
0x092:  EE0  INC_X                ; 
0x093:  EFB  LDPY_R               ; 
0x094:  EE0  INC_X                ; 
0x095:  EFB  LDPY_R               ; 
0x096:  EE0  INC_X                ; 
0x097:  EFB  LDPY_R               ; 
0x098:  EE0  INC_X                ; 
0x099:  EFB  LDPY_R               ; 
0x09A:  EE0  INC_X                ; 
0x09B:  EFB  LDPY_R               ; 
0x09C:  EE0  INC_X                ; 
0x09D:  EFB  LDPY_R               ; 
0x09E:  FDF  RET                  ; 
0x09F:  EFB  LDPY_R               ; 
0x0A0:  EE0  INC_X                ; 
0x0A1:  EFB  LDPY_R               ; 
0x0A2:  A1C  ADC_XL               ; 
0x0A3:  EFB  LDPY_R               ; 
0x0A4:  EE0  INC_X                ; 
0x0A5:  EFB  LDPY_R               ; 
0x0A6:  A1C  ADC_XL               ; 
0x0A7:  EFB  LDPY_R               ; 
0x0A8:  EE0  INC_X                ; 
0x0A9:  EFB  LDPY_R               ; 
0x0AA:  A1C  ADC_XL               ; 
0x0AB:  EFB  LDPY_R               ; 
0x0AC:  EE0  INC_X                ; 
0x0AD:  EFB  LDPY_R               ; 
0x0AE:  A1C  ADC_XL               ; 
0x0AF:  EFB  LDPY_R               ; 
0x0B0:  EE0  INC_X                ; 
0x0B1:  EFB  LDPY_R               ; 
0x0B2:  FDF  RET                  ; 
0x0B3:  5EF  CALZ     0x4EF       ; Flow to 0x4EF
0x0B4:  B4A  LD_X     0x4A        ; Set pointer to RAM 0x4A (MEM_SLEEPING)
0x0B5:  DA8  FAN_R_I              ; 
0x0B6:  FDF  RET                  ; 
0x0B7:  5F2  CALZ     0x4F2       ; Flow to 0x4F2
0x0B8:  0BF  JP       0x4BF       ; Flow to 0x4BF
0x0B9:  5EF  CALZ     0x4EF       ; Flow to 0x4EF
0x0BA:  0BF  JP       0x4BF       ; Flow to 0x4BF
0x0BB:  894  LD_Y     0x94        ; Set pointer to RAM 0x94
0x0BC:  E1F  LD_R_I   B, #15      ; Register B op with immediate #15
0x0BD:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x0BE:  E80  LD_XP_R              ; 
0x0BF:  B7B  LD_X     0x7B        ; Set pointer to RAM 0x7B
0x0C0:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x0C1:  6CD  JP_Z     0x4CD       ; Flow to 0x4CD
0x0C2:  B32  LD_X     0x32        ; Set pointer to RAM 0x32
0x0C3:  512  CALZ     0x412       ; Flow to 0x412 (MEM_HAPPY)
0x0C4:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x0C5:  B36  LD_X     0x36        ; Set pointer to RAM 0x36
0x0C6:  EBA  LD_R_YL              ; 
0x0C7:  EE0  INC_X                ; 
0x0C8:  EB6  LD_R_YH              ; 
0x0C9:  B58  LD_X     0x58        ; Set pointer to RAM 0x58
0x0CA:  EE8  LDPX_R               ; 
0x0CB:  EC9  LD_R_Q   [X], B      ; Register [X] op with B
0x0CC:  509  CALZ     0x409       ; Flow to 0x409 (MEM_HUNGER)
0x0CD:  FDF  RET                  ; 
0x0CE:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x0CF:  E80  LD_XP_R              ; 
0x0D0:  B2A  LD_X     0x2A        ; Set pointer to RAM 0x2A
0x0D1:  940  LBPX     #40         ; Store constant #40 into memory pointer
0x0D2:  B3A  LD_X     0x3A        ; Set pointer to RAM 0x3A
0x0D3:  FDF  RET                  ; 
0x0D4:  512  CALZ     0x412       ; Flow to 0x412 (MEM_HAPPY)
0x0D5:  EF3  LDPY_R               ; 
0x0D6:  0DB  JP       0x4DB       ; Flow to 0x4DB (MEM_POOP)
0x0D7:  512  CALZ     0x412       ; Flow to 0x412 (MEM_HAPPY)
0x0D8:  EF3  LDPY_R               ; 
0x0D9:  AD3  OR_R_Q   A, [Y]      ; Register A op with [Y]
0x0DA:  EF0  INC_Y                ; 
0x0DB:  AD3  OR_R_Q   A, [Y]      ; Register A op with [Y]
0x0DC:  509  CALZ     0x409       ; Flow to 0x409 (MEM_HUNGER)
0x0DD:  FDF  RET                  ; 
0x0DE:  5CE  CALZ     0x4CE       ; Flow to 0x4CE
0x0DF:  940  LBPX     #40         ; Store constant #40 into memory pointer
0x0E0:  E47  PSET     #7          ; Set next Page to 7
0x0E1:  092  JP       0x792       ; Flow to 0x792
0x0E2:  B12  LD_X     0x12        ; Set pointer to RAM 0x12
0x0E3:  F44  SET                  ; 
0x0E4:  C21  ADD_R_I  [X], #1     ; Register [X] op with immediate #1
0x0E5:  EE0  INC_X                ; 
0x0E6:  C60  ADC_R_I              ; 
0x0E7:  DE6  CP_R_I   [X], #6     ; Register [X] op with immediate #6
0x0E8:  2EA  JP_C     0x7EA       ; Flow to 0x7EA
0x0E9:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0x0EA:  F5B  RST                  ; 
0x0EB:  FDF  RET                  ; 
0x0EC:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x0ED:  E47  PSET     #7          ; Set next Page to 7
0x0EE:  0C0  JP       0x7C0       ; Flow to 0x7C0
0x0EF:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x0F0:  E80  LD_XP_R              ; 
0x0F1:  FDF  RET                  ; 
0x0F2:  E10  LD_R_I   B, #0       ; Register B op with immediate #0
0x0F3:  E81  LD_XP_R              ; 
0x0F4:  FDF  RET                  ; 
0x0F5:  E01  LD_R_I   A, #1       ; Register A op with immediate #1
0x0F6:  E80  LD_XP_R              ; 
0x0F7:  FDF  RET                  ; 
0x0F8:  B5D  LD_X     0x5D        ; Set pointer to RAM 0x5D (MEM_LIFECYCLE)
0x0F9:  DE1  CP_R_I   [X], #1     ; Register [X] op with immediate #1
0x0FA:  FDF  RET                  ; 
0x0FB:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x0FC:  E80  LD_XP_R              ; 
0x0FD:  B48  LD_X     0x48        ; Set pointer to RAM 0x48 (MEM_SICK_LEVEL)
0x0FE:  DA8  FAN_R_I              ; 
0x0FF:  FDF  RET                  ; 

; =========================================================
; ROUTINE: RESET_VECTOR
; Location: 0x100 (Page 1, Step 00)
; Trigger:  Power on / Reset
; Logic:    Initialize registers and jump to main loop
; =========================================================

0x100:  010  JP       0x710       ; Flow to 0x710
0x101:  016  JP       0x716       ; Flow to 0x716
0x102:  01D  JP       0x71D       ; Flow to 0x71D
0x103:  016  JP       0x716       ; Flow to 0x716
0x104:  016  JP       0x716       ; Flow to 0x716
0x105:  016  JP       0x716       ; Flow to 0x716
0x106:  016  JP       0x716       ; Flow to 0x716
0x107:  016  JP       0x716       ; Flow to 0x716
0x108:  016  JP       0x716       ; Flow to 0x716
0x109:  016  JP       0x716       ; Flow to 0x716
0x10A:  016  JP       0x716       ; Flow to 0x716
0x10B:  016  JP       0x716       ; Flow to 0x716
0x10C:  06F  JP       0x76F       ; Flow to 0x76F
0x10D:  016  JP       0x716       ; Flow to 0x716
0x10E:  016  JP       0x716       ; Flow to 0x716
0x10F:  016  JP       0x716       ; Flow to 0x716
0x110:  F50  RST                  ; 
0x111:  E0F  LD_R_I   A, #15      ; Register A op with immediate #15
0x112:  FE0  LD_SPH_R             ; 
0x113:  FF0  LD_SPL_R             ; 
0x114:  E42  PSET     #2          ; Set next Page to 2
0x115:  02A  JP       0x22A       ; Flow to 0x22A
0x116:  FCA  PUSH_F               ; 
0x117:  FC0  PUSH_R               ; 
0x118:  FC1  PUSH_R               ; 
0x119:  FC4  PUSH_XP              ; 
0x11A:  FC5  PUSH_XH              ; 
0x11B:  FC6  PUSH_XL              ; 
0x11C:  05B  JP       0x25B       ; Flow to 0x25B
0x11D:  FCA  PUSH_F               ; 
0x11E:  FC0  PUSH_R               ; 
0x11F:  FC1  PUSH_R               ; 
0x120:  FC4  PUSH_XP              ; 
0x121:  FC5  PUSH_XH              ; 
0x122:  FC6  PUSH_XL              ; 
0x123:  F5B  RST                  ; 
0x124:  E0F  LD_R_I   A, #15      ; Register A op with immediate #15
0x125:  E80  LD_XP_R              ; 
0x126:  B00  LD_X     0x00        ; Set pointer to RAM 0x00
0x127:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x128:  B76  LD_X     0x76        ; Set pointer to RAM 0x76
0x129:  901  LBPX     #1          ; Store constant #1 into memory pointer
0x12A:  921  LBPX     #21         ; Store constant #21 into memory pointer
0x12B:  B12  LD_X     0x12        ; Set pointer to RAM 0x12
0x12C:  E21  LD_R_I   [X], #1     ; Register [X] op with immediate #1
0x12D:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x12E:  E80  LD_XP_R              ; 
0x12F:  B57  LD_X     0x57        ; Set pointer to RAM 0x57
0x130:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x131:  633  JP_Z     0x233       ; Flow to 0x233
0x132:  C2F  ADD_R_I  [X], #15    ; Register [X] op with immediate #15
0x133:  B3C  LD_X     0x3C        ; Set pointer to RAM 0x3C
0x134:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x135:  64A  JP_Z     0x24A       ; Flow to 0x24A
0x136:  F44  SET                  ; 
0x137:  B2E  LD_X     0x2E        ; Set pointer to RAM 0x2E
0x138:  E21  LD_R_I   [X], #1     ; Register [X] op with immediate #1
0x139:  B10  LD_X     0x10        ; Set pointer to RAM 0x10
0x13A:  C21  ADD_R_I  [X], #1     ; Register [X] op with immediate #1
0x13B:  EE0  INC_X                ; 
0x13C:  C60  ADC_R_I              ; 
0x13D:  DE6  CP_R_I   [X], #6     ; Register [X] op with immediate #6
0x13E:  249  JP_C     0x249       ; Flow to 0x249
0x13F:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x140:  5E4  CALZ     0x2E4       ; Flow to 0x2E4
0x141:  247  JP_C     0x247       ; Flow to 0x247
0x142:  B14  LD_X     0x14        ; Set pointer to RAM 0x14
0x143:  EE2  LDPX_R               ; 
0x144:  EE6  LDPX_R               ; 
0x145:  B14  LD_X     0x14        ; Set pointer to RAM 0x14
0x146:  4F4  CALL     0x2F4       ; Flow to 0x2F4
0x147:  E4C  PSET     #C          ; Set next Page to 12
0x148:  47A  CALL     0xC7A       ; Flow to 0xC7A
0x149:  F5B  RST                  ; 
0x14A:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x14B:  E80  LD_XP_R              ; 
0x14C:  B2F  LD_X     0x2F        ; Set pointer to RAM 0x2F
0x14D:  C21  ADD_R_I  [X], #1     ; Register [X] op with immediate #1
0x14E:  EE0  INC_X                ; 
0x14F:  F28  ACPX                 ; 
0x150:  C60  ADC_R_I              ; 
0x151:  35B  JP_NC    0xC5B       ; Flow to 0xC5B
0x152:  E0F  LD_R_I   A, #15      ; Register A op with immediate #15
0x153:  E80  LD_XP_R              ; 
0x154:  B70  LD_X     0x70        ; Set pointer to RAM 0x70
0x155:  DA3  FAN_R_I              ; 
0x156:  65B  JP_Z     0xC5B       ; Flow to 0xC5B
0x157:  4E5  CALL     0xCE5       ; Flow to 0xCE5
0x158:  65B  JP_Z     0xC5B       ; Flow to 0xC5B
0x159:  B70  LD_X     0x70        ; Set pointer to RAM 0x70
0x15A:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0x15B:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x15C:  E80  LD_XP_R              ; 
0x15D:  B7D  LD_X     0x7D        ; Set pointer to RAM 0x7D
0x15E:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x15F:  668  JP_Z     0xC68       ; Flow to 0xC68
0x160:  FD6  POP_XL               ; 
0x161:  FD5  POP_XH               ; 
0x162:  FD4  POP_XP               ; 
0x163:  FD1  POP_R                ; 
0x164:  FD0  POP_R                ; 
0x165:  FDA  POP_F                ; 
0x166:  F48  SET                  ; 
0x167:  FDF  RET                  ; 
0x168:  FD6  POP_XL               ; 
0x169:  FD5  POP_XH               ; 
0x16A:  FD4  POP_XP               ; 
0x16B:  FD1  POP_R                ; 
0x16C:  FD0  POP_R                ; 
0x16D:  FDA  POP_F                ; 
0x16E:  FDF  RET                  ; 
0x16F:  FCA  PUSH_F               ; 
0x170:  FC0  PUSH_R               ; 
0x171:  FC1  PUSH_R               ; 
0x172:  FC4  PUSH_XP              ; 
0x173:  FC5  PUSH_XH              ; 
0x174:  FC6  PUSH_XL              ; 
0x175:  F5B  RST                  ; 
0x176:  4A0  CALL     0xCA0       ; Flow to 0xCA0
0x177:  E0F  LD_R_I   A, #15      ; Register A op with immediate #15
0x178:  E80  LD_XP_R              ; 
0x179:  B02  LD_X     0x02        ; Set pointer to RAM 0x02
0x17A:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]

; =========================================================
; ROUTINE: PROCESS_HUNGER_CHANGE
; Location: 0x17B (Page 1, Step 7B)
; Trigger:  Feeding or Tick
; Logic:    Modifies Hunger level [0x40] and updates internal counters
; =========================================================

0x17B:  B40  LD_X     0x40        ; Set pointer to RAM 0x40 (MEM_HUNGER)
0x17C:  EC6  LD_R_Q   B, [X]      ; Register B op with [X]
0x17D:  D1F  XOR_R_I              ; 
0x17E:  C97  AND_R_I  B, #7       ; Register B op with immediate #7
0x17F:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x180:  E80  LD_XP_R              ; 
0x181:  B5A  LD_X     0x5A        ; Set pointer to RAM 0x5A
0x182:  C21  ADD_R_I  [X], #1     ; Register [X] op with immediate #1
0x183:  B22  LD_X     0x22        ; Set pointer to RAM 0x22
0x184:  C2F  ADD_R_I  [X], #15    ; Register [X] op with immediate #15
0x185:  EE0  INC_X                ; 
0x186:  C6F  ADC_R_I              ; 
0x187:  28A  JP_C     0xC8A       ; Flow to 0xC8A
0x188:  B22  LD_X     0x22        ; Set pointer to RAM 0x22
0x189:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x18A:  B26  LD_X     0x26        ; Set pointer to RAM 0x26
0x18B:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x18C:  EE9  LDPX_R               ; 
0x18D:  AE1  XOR_R_Q  A, B        ; Register A op with B
0x18E:  AC1  AND_R_Q  A, B        ; Register A op with B
0x18F:  AD8  OR_R_Q   [X], A      ; Register [X] op with A
0x190:  B3D  LD_X     0x3D        ; Set pointer to RAM 0x3D
0x191:  F09  CP_R_Q   [X], B      ; Register [X] op with B
0x192:  697  JP_Z     0xC97       ; Flow to 0xC97
0x193:  EC9  LD_R_Q   [X], B      ; Register [X] op with B
0x194:  B3E  LD_X     0x3E        ; Set pointer to RAM 0x3E
0x195:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0x196:  09F  JP       0xC9F       ; Flow to 0xC9F
0x197:  B3E  LD_X     0x3E        ; Set pointer to RAM 0x3E
0x198:  C21  ADD_R_I  [X], #1     ; Register [X] op with immediate #1
0x199:  79F  JP_NZ    0xC9F       ; Flow to 0xC9F
0x19A:  E28  LD_R_I   [X], #8     ; Register [X] op with immediate #8
0x19B:  B3F  LD_X     0x3F        ; Set pointer to RAM 0x3F
0x19C:  AC6  AND_R_Q  B, [X]      ; Register B op with [X]
0x19D:  B27  LD_X     0x27        ; Set pointer to RAM 0x27
0x19E:  AD9  OR_R_Q   [X], B      ; Register [X] op with B
0x19F:  05B  JP       0xC5B       ; Flow to 0xC5B
0x1A0:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x1A1:  E80  LD_XP_R              ; 
0x1A2:  B32  LD_X     0x32        ; Set pointer to RAM 0x32
0x1A3:  C2F  ADD_R_I  [X], #15    ; Register [X] op with immediate #15
0x1A4:  EE0  INC_X                ; 
0x1A5:  C6F  ADC_R_I              ; 
0x1A6:  3AB  JP_NC    0xCAB       ; Flow to 0xCAB
0x1A7:  B34  LD_X     0x34        ; Set pointer to RAM 0x34
0x1A8:  DA8  FAN_R_I              ; 
0x1A9:  7D7  JP_NZ    0xCD7       ; Flow to 0xCD7
0x1AA:  FDF  RET                  ; 
0x1AB:  B36  LD_X     0x36        ; Set pointer to RAM 0x36
0x1AC:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x1AD:  C22  ADD_R_I  [X], #2     ; Register [X] op with immediate #2
0x1AE:  EE0  INC_X                ; 
0x1AF:  EC6  LD_R_Q   B, [X]      ; Register B op with [X]
0x1B0:  C60  ADC_R_I              ; 
0x1B1:  B32  LD_X     0x32        ; Set pointer to RAM 0x32
0x1B2:  E4E  PSET     #E          ; Set next Page to 14
0x1B3:  47C  CALL     0xE7C       ; Flow to 0xE7C
0x1B4:  A56  CP_XL                ; 
0x1B5:  6C1  JP_Z     0xEC1       ; Flow to 0xEC1
0x1B6:  B59  LD_X     0x59        ; Set pointer to RAM 0x59
0x1B7:  DEF  CP_R_I   [X], #15    ; Register [X] op with immediate #15
0x1B8:  6C1  JP_Z     0xEC1       ; Flow to 0xEC1
0x1B9:  B58  LD_X     0x58        ; Set pointer to RAM 0x58
0x1BA:  C2F  ADD_R_I  [X], #15    ; Register [X] op with immediate #15
0x1BB:  EE0  INC_X                ; 
0x1BC:  C6F  ADC_R_I              ; 
0x1BD:  2C1  JP_C     0xEC1       ; Flow to 0xEC1
0x1BE:  B36  LD_X     0x36        ; Set pointer to RAM 0x36
0x1BF:  97D  LBPX     #7D         ; Store constant #7D into memory pointer
0x1C0:  0AB  JP       0xEAB       ; Flow to 0xEAB
0x1C1:  B34  LD_X     0x34        ; Set pointer to RAM 0x34
0x1C2:  DA8  FAN_R_I              ; 
0x1C3:  7D7  JP_NZ    0xED7       ; Flow to 0xED7
0x1C4:  B38  LD_X     0x38        ; Set pointer to RAM 0x38
0x1C5:  958  LBPX     #58         ; Store constant #58 into memory pointer
0x1C6:  E0F  LD_R_I   A, #15      ; Register A op with immediate #15
0x1C7:  E80  LD_XP_R              ; 
0x1C8:  B71  LD_X     0x71        ; Set pointer to RAM 0x71
0x1C9:  CE1  OR_R_I   [X], #1     ; Register [X] op with immediate #1
0x1CA:  FC4  PUSH_XP              ; 
0x1CB:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x1CC:  E80  LD_XP_R              ; 
0x1CD:  B34  LD_X     0x34        ; Set pointer to RAM 0x34
0x1CE:  EE2  LDPX_R               ; 
0x1CF:  EC6  LD_R_Q   B, [X]      ; Register B op with [X]
0x1D0:  FD4  POP_XP               ; 
0x1D1:  B74  LD_X     0x74        ; Set pointer to RAM 0x74
0x1D2:  EE8  LDPX_R               ; 
0x1D3:  EC9  LD_R_Q   [X], B      ; Register [X] op with B
0x1D4:  B54  LD_X     0x54        ; Set pointer to RAM 0x54 (MEM_AGE)
0x1D5:  CA7  AND_R_I  [X], #7     ; Register [X] op with immediate #7
0x1D6:  FDF  RET                  ; 
0x1D7:  B38  LD_X     0x38        ; Set pointer to RAM 0x38
0x1D8:  C2F  ADD_R_I  [X], #15    ; Register [X] op with immediate #15
0x1D9:  EE0  INC_X                ; 
0x1DA:  C6F  ADC_R_I              ; 
0x1DB:  E0F  LD_R_I   A, #15      ; Register A op with immediate #15
0x1DC:  E80  LD_XP_R              ; 
0x1DD:  2E0  JP_C     0xEE0       ; Flow to 0xEE0
0x1DE:  B71  LD_X     0x71        ; Set pointer to RAM 0x71
0x1DF:  CAE  AND_R_I  [X], #14    ; Register [X] op with immediate #14
0x1E0:  B54  LD_X     0x54        ; Set pointer to RAM 0x54 (MEM_AGE)
0x1E1:  CE8  OR_R_I   [X], #8     ; Register [X] op with immediate #8
0x1E2:  FDF  RET                  ; 
0x1E3:  E0F  LD_R_I   A, #15      ; Register A op with immediate #15
0x1E4:  E80  LD_XP_R              ; 
0x1E5:  B73  LD_X     0x73        ; Set pointer to RAM 0x73
0x1E6:  E26  LD_R_I   [X], #6     ; Register [X] op with immediate #6
0x1E7:  FFB  NOP5                 ; 
0x1E8:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x1E9:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0x1EA:  C88  AND_R_I  A, #8       ; Register A op with immediate #8
0x1EB:  FDF  RET                  ; 
0x1EC:  B75  LD_X     0x75        ; Set pointer to RAM 0x75
0x1ED:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x1EE:  EE8  LDPX_R               ; 
0x1EF:  EE9  LDPX_R               ; 
0x1F0:  B57  LD_X     0x57        ; Set pointer to RAM 0x57
0x1F1:  EE9  LDPX_R               ; 
0x1F2:  521  CALZ     0xE21       ; Flow to 0xE21
0x1F3:  FDF  RET                  ; 
0x1F4:  C01  ADD_R_I  A, #1       ; Register A op with immediate #1
0x1F5:  C50  ADC_R_I              ; 
0x1F6:  DD1  CP_R_I   B, #1       ; Register B op with immediate #1
0x1F7:  2FD  JP_C     0xEFD       ; Flow to 0xEFD
0x1F8:  7FB  JP_NZ    0xEFB       ; Flow to 0xEFB
0x1F9:  DC8  CP_R_I   A, #8       ; Register A op with immediate #8
0x1FA:  2FD  JP_C     0xEFD       ; Flow to 0xEFD
0x1FB:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x1FC:  E10  LD_R_I   B, #0       ; Register B op with immediate #0
0x1FD:  EE8  LDPX_R               ; 
0x1FE:  EE9  LDPX_R               ; 
0x1FF:  FDF  RET                  ; 
0x200:  556  CALZ     0xE56       ; Flow to 0xE56
0x201:  521  CALZ     0xE21       ; Flow to 0xE21
0x202:  DC5  CP_R_I   A, #5       ; Register A op with immediate #5
0x203:  606  JP_Z     0xE06       ; Flow to 0xE06
0x204:  D91  FAN_R_I              ; 
0x205:  FDF  RET                  ; 
0x206:  512  CALZ     0xE12       ; Flow to 0xE12
0x207:  5EF  CALZ     0xEEF       ; Flow to 0xEEF
0x208:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x209:  E90  LD_YP_R              ; 
0x20A:  B10  LD_X     0x10        ; Set pointer to RAM 0x10
0x20B:  872  LD_Y     0x72        ; Set pointer to RAM 0x72
0x20C:  427  CALL     0xE27       ; Flow to 0xE27
0x20D:  F50  RST                  ; 
0x20E:  E0F  LD_R_I   A, #15      ; Register A op with immediate #15
0x20F:  FE0  LD_SPH_R             ; 
0x210:  FF0  LD_SPL_R             ; 
0x211:  442  CALL     0xE42       ; Flow to 0xE42
0x212:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x213:  E90  LD_YP_R              ; 
0x214:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x215:  E80  LD_XP_R              ; 
0x216:  810  LD_Y     0x10        ; Set pointer to RAM 0x10
0x217:  B72  LD_X     0x72        ; Set pointer to RAM 0x72
0x218:  427  CALL     0xE27       ; Flow to 0xE27
0x219:  509  CALZ     0xE09       ; Flow to 0xE09
0x21A:  880  LD_Y     0x80        ; Set pointer to RAM 0x80
0x21B:  5BC  CALZ     0xEBC       ; Flow to 0xEBC
0x21C:  E47  PSET     #7          ; Set next Page to 7
0x21D:  461  CALL     0x761       ; Flow to 0x761
0x21E:  E44  PSET     #4          ; Set next Page to 4
0x21F:  465  CALL     0x465       ; Flow to 0x465 (MEM_WEIGHT)
0x220:  B3C  LD_X     0x3C        ; Set pointer to RAM 0x3C
0x221:  E2F  LD_R_I   [X], #15    ; Register [X] op with immediate #15
0x222:  521  CALZ     0x421       ; Flow to 0x421 (MEM_NEGLECT)
0x223:  D87  FAN_R_I              ; 
0x224:  722  JP_NZ    0x422       ; Flow to 0x422 (MEM_NEGLECT)
0x225:  E45  PSET     #5          ; Set next Page to 5
0x226:  017  JP       0x517       ; Flow to 0x517 (MEM_BEHAVIOR_MISTAKE)
0x227:  E52  PSET     #12         ; Set next Page to 18
0x228:  022  JP       0x1222      ; Flow to 0x1222
0x229:  FDF  RET                  ; 
0x22A:  E41  PSET     #1          ; Set next Page to 1
0x22B:  4E3  CALL     0x1E3       ; Flow to 0x1E3
0x22C:  72F  JP_NZ    0x12F       ; Flow to 0x12F
0x22D:  B70  LD_X     0x70        ; Set pointer to RAM 0x70
0x22E:  E21  LD_R_I   [X], #1     ; Register [X] op with immediate #1
0x22F:  E0F  LD_R_I   A, #15      ; Register A op with immediate #15
0x230:  E80  LD_XP_R              ; 
0x231:  B40  LD_X     0x40        ; Set pointer to RAM 0x40 (MEM_HUNGER)
0x232:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x233:  E90  LD_YP_R              ; 
0x234:  870  LD_Y     0x70        ; Set pointer to RAM 0x70
0x235:  ECE  LD_R_Q   [Y], [X]    ; Register [Y] op with [X]
0x236:  CB7  AND_R_I  [Y], #7     ; Register [Y] op with immediate #7
0x237:  442  CALL     0x142       ; Flow to 0x142
0x238:  509  CALZ     0x109       ; Flow to 0x109
0x239:  880  LD_Y     0x80        ; Set pointer to RAM 0x80
0x23A:  5BC  CALZ     0x1BC       ; Flow to 0x1BC
0x23B:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x23C:  E80  LD_XP_R              ; 
0x23D:  B70  LD_X     0x70        ; Set pointer to RAM 0x70
0x23E:  DE3  CP_R_I   [X], #3     ; Register [X] op with immediate #3
0x23F:  656  JP_Z     0x156       ; Flow to 0x156
0x240:  E49  PSET     #9          ; Set next Page to 9
0x241:  07F  JP       0x97F       ; Flow to 0x97F
0x242:  E51  PSET     #11         ; Set next Page to 17
0x243:  0E0  JP       0x11E0      ; Flow to 0x11E0
0x244:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x245:  E1E  LD_R_I   B, #14      ; Register B op with immediate #14
0x246:  545  CALZ     0x1145      ; Flow to 0x1145
0x247:  E01  LD_R_I   A, #1       ; Register A op with immediate #1
0x248:  E10  LD_R_I   B, #0       ; Register B op with immediate #0
0x249:  545  CALZ     0x1145      ; Flow to 0x1145
0x24A:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x24B:  E17  LD_R_I   B, #7       ; Register B op with immediate #7
0x24C:  545  CALZ     0x1145      ; Flow to 0x1145
0x24D:  E0E  LD_R_I   A, #14      ; Register A op with immediate #14
0x24E:  E15  LD_R_I   B, #5       ; Register B op with immediate #5
0x24F:  545  CALZ     0x1145      ; Flow to 0x1145
0x250:  E15  LD_R_I   B, #5       ; Register B op with immediate #5
0x251:  B80  LD_X     0x80        ; Set pointer to RAM 0x80
0x252:  547  CALZ     0x1147      ; Flow to 0x1147
0x253:  E52  PSET     #12         ; Set next Page to 18
0x254:  000  JP       0x1200      ; Flow to 0x1200
0x255:  FDF  RET                  ; 
0x256:  B2C  LD_X     0x2C        ; Set pointer to RAM 0x2C
0x257:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x258:  8FF  LD_Y     0xFF        ; Set pointer to RAM 0xFF
0x259:  E12  LD_R_I   B, #2       ; Register B op with immediate #2
0x25A:  46B  CALL     0x126B      ; Flow to 0x126B
0x25B:  B2C  LD_X     0x2C        ; Set pointer to RAM 0x2C
0x25C:  95A  LBPX     #5A         ; Store constant #5A into memory pointer
0x25D:  8A5  LD_Y     0xA5        ; Set pointer to RAM 0xA5
0x25E:  E11  LD_R_I   B, #1       ; Register B op with immediate #1
0x25F:  46B  CALL     0x126B      ; Flow to 0x126B
0x260:  B2C  LD_X     0x2C        ; Set pointer to RAM 0x2C
0x261:  9A5  LBPX     #A5         ; Store constant #A5 into memory pointer
0x262:  85A  LD_Y     0x5A        ; Set pointer to RAM 0x5A
0x263:  E14  LD_R_I   B, #4       ; Register B op with immediate #4
0x264:  46B  CALL     0x126B      ; Flow to 0x126B
0x265:  B2C  LD_X     0x2C        ; Set pointer to RAM 0x2C
0x266:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x267:  E12  LD_R_I   B, #2       ; Register B op with immediate #2
0x268:  481  CALL     0x1281      ; Flow to 0x1281
0x269:  E49  PSET     #9          ; Set next Page to 9
0x26A:  07F  JP       0x97F       ; Flow to 0x97F
0x26B:  F90  LD_MN_B  0x00        ; Direct RAM access at 0x00
0x26C:  5F5  CALZ     0x9F5       ; Flow to 0x9F5
0x26D:  B00  LD_X     0x00        ; Set pointer to RAM 0x00
0x26E:  EB4  LD_R_YH              ; 
0x26F:  EB9  LD_R_YL              ; 
0x270:  EE8  LDPX_R               ; 
0x271:  EE8  LDPX_R               ; 
0x272:  EE9  LDPX_R               ; 
0x273:  EE9  LDPX_R               ; 
0x274:  A40  CP_XH                ; 
0x275:  770  JP_NZ    0x970       ; Flow to 0x970
0x276:  A50  CP_XL                ; 
0x277:  770  JP_NZ    0x970       ; Flow to 0x970
0x278:  E47  PSET     #7          ; Set next Page to 7
0x279:  4E1  CALL     0x7E1       ; Flow to 0x7E1
0x27A:  556  CALZ     0x756       ; Flow to 0x756
0x27B:  521  CALZ     0x721       ; Flow to 0x721
0x27C:  FB0  LD_B_MN  0x00        ; Direct RAM access at 0x00
0x27D:  F01  CP_R_Q   A, B        ; Register A op with B
0x27E:  77B  JP_NZ    0x77B       ; Flow to 0x77B
0x27F:  5BB  CALZ     0x7BB       ; Flow to 0x7BB
0x280:  FDF  RET                  ; 
0x281:  F90  LD_MN_B  0x00        ; Direct RAM access at 0x00
0x282:  5F5  CALZ     0x7F5       ; Flow to 0x7F5
0x283:  B00  LD_X     0x00        ; Set pointer to RAM 0x00
0x284:  901  LBPX     #1          ; Store constant #1 into memory pointer
0x285:  A48  CP_XH                ; 
0x286:  784  JP_NZ    0x784       ; Flow to 0x784
0x287:  980  LBPX     #80         ; Store constant #80 into memory pointer
0x288:  A40  CP_XH                ; 
0x289:  787  JP_NZ    0x787       ; Flow to 0x787
0x28A:  B00  LD_X     0x00        ; Set pointer to RAM 0x00
0x28B:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x28C:  B3E  LD_X     0x3E        ; Set pointer to RAM 0x3E
0x28D:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x28E:  B80  LD_X     0x80        ; Set pointer to RAM 0x80
0x28F:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x290:  BBE  LD_X     0xBE        ; Set pointer to RAM 0xBE
0x291:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x292:  078  JP       0x778       ; Flow to 0x778
0x293:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x294:  5ED  CALZ     0x7ED       ; Flow to 0x7ED
0x295:  540  CALZ     0x740       ; Flow to 0x740
0x296:  521  CALZ     0x721       ; Flow to 0x721
0x297:  5CE  CALZ     0x7CE       ; Flow to 0x7CE
0x298:  9C4  LBPX     #C4         ; Store constant #C4 into memory pointer
0x299:  E45  PSET     #5          ; Set next Page to 5
0x29A:  4A6  CALL     0x5A6       ; Flow to 0x5A6
0x29B:  E15  LD_R_I   B, #5       ; Register B op with immediate #5
0x29C:  F95  LD_MN_B  0x05        ; Direct RAM access at 0x05
0x29D:  FA4  LD_A_MN  0x04        ; Direct RAM access at 0x04
0x29E:  DC6  CP_R_I   A, #6       ; Register A op with immediate #6
0x29F:  2A1  JP_C     0x5A1       ; Flow to 0x5A1
0x2A0:  C03  ADD_R_I  A, #3       ; Register A op with immediate #3
0x2A1:  F84  LD_MN_A  0x04        ; Direct RAM access at 0x04
0x2A2:  5F5  CALZ     0x5F5       ; Flow to 0x5F5
0x2A3:  BE2  LD_X     0xE2        ; Set pointer to RAM 0xE2
0x2A4:  F74  DEC_MN               ; 
0x2A5:  FA4  LD_A_MN  0x04        ; Direct RAM access at 0x04
0x2A6:  AF0  RLC                  ; 
0x2A7:  E05  LD_R_I   A, #5       ; Register A op with immediate #5
0x2A8:  AF0  RLC                  ; 
0x2A9:  E45  PSET     #5          ; Set next Page to 5
0x2AA:  4EF  CALL     0x5EF       ; Flow to 0x5EF
0x2AB:  F75  DEC_MN               ; 
0x2AC:  7A4  JP_NZ    0x5A4       ; Flow to 0x5A4
0x2AD:  556  CALZ     0x556       ; Flow to 0x556
0x2AE:  E4F  PSET     #F          ; Set next Page to 15
0x2AF:  400  CALL     0xF00       ; Flow to 0xF00
0x2B0:  7C0  JP_NZ    0xFC0       ; Flow to 0xFC0
0x2B1:  51F  CALZ     0xF1F       ; Flow to 0xF1F
0x2B2:  D92  FAN_R_I              ; 
0x2B3:  E45  PSET     #5          ; Set next Page to 5
0x2B4:  708  JP_NZ    0x508       ; Flow to 0x508 (MEM_CHARACTER)
0x2B5:  DC5  CP_R_I   A, #5       ; Register A op with immediate #5
0x2B6:  E45  PSET     #5          ; Set next Page to 5
0x2B7:  653  JP_Z     0x553       ; Flow to 0x553
0x2B8:  B7C  LD_X     0x7C        ; Set pointer to RAM 0x7C
0x2B9:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x2BA:  E45  PSET     #5          ; Set next Page to 5
0x2BB:  608  JP_Z     0x508       ; Flow to 0x508 (MEM_CHARACTER)
0x2BC:  B2E  LD_X     0x2E        ; Set pointer to RAM 0x2E
0x2BD:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x2BE:  6B1  JP_Z     0x5B1       ; Flow to 0x5B1
0x2BF:  097  JP       0x597       ; Flow to 0x597
0x2C0:  E43  PSET     #3          ; Set next Page to 3
0x2C1:  407  CALL     0x307       ; Flow to 0x307
0x2C2:  093  JP       0x393       ; Flow to 0x393
0x2C3:  521  CALZ     0x321       ; Flow to 0x321
0x2C4:  AD1  OR_R_Q   A, B        ; Register A op with B
0x2C5:  D87  FAN_R_I              ; 
0x2C6:  6CD  JP_Z     0x3CD       ; Flow to 0x3CD
0x2C7:  B77  LD_X     0x77        ; Set pointer to RAM 0x77
0x2C8:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x2C9:  DC0  CP_R_I   A, #0       ; Register A op with immediate #0
0x2CA:  6CD  JP_Z     0x3CD       ; Flow to 0x3CD
0x2CB:  B57  LD_X     0x57        ; Set pointer to RAM 0x57
0x2CC:  EC8  LD_R_Q   [X], A      ; Register [X] op with A
0x2CD:  B29  LD_X     0x29        ; Set pointer to RAM 0x29
0x2CE:  DA4  FAN_R_I              ; 
0x2CF:  6D9  JP_Z     0x3D9       ; Flow to 0x3D9
0x2D0:  5BB  CALZ     0x3BB       ; Flow to 0x3BB
0x2D1:  B76  LD_X     0x76        ; Set pointer to RAM 0x76
0x2D2:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x2D3:  B75  LD_X     0x75        ; Set pointer to RAM 0x75
0x2D4:  C21  ADD_R_I  [X], #1     ; Register [X] op with immediate #1
0x2D5:  F08  CP_R_Q   [X], A      ; Register [X] op with A
0x2D6:  2EE  JP_C     0x3EE       ; Flow to 0x3EE
0x2D7:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0x2D8:  0EE  JP       0x3EE       ; Flow to 0x3EE
0x2D9:  DA2  FAN_R_I              ; 
0x2DA:  6DF  JP_Z     0x3DF       ; Flow to 0x3DF
0x2DB:  5BB  CALZ     0x3BB       ; Flow to 0x3BB
0x2DC:  F5E  RST                  ; 
0x2DD:  F42  SET                  ; 
0x2DE:  0F0  JP       0x3F0       ; Flow to 0x3F0
0x2DF:  DA1  FAN_R_I              ; 
0x2E0:  6E5  JP_Z     0x3E5       ; Flow to 0x3E5
0x2E1:  5BB  CALZ     0x3BB       ; Flow to 0x3BB
0x2E2:  F41  SET                  ; 
0x2E3:  F42  SET                  ; 
0x2E4:  0F0  JP       0x3F0       ; Flow to 0x3F0
0x2E5:  B57  LD_X     0x57        ; Set pointer to RAM 0x57
0x2E6:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x2E7:  7EE  JP_NZ    0x3EE       ; Flow to 0x3EE
0x2E8:  B77  LD_X     0x77        ; Set pointer to RAM 0x77
0x2E9:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x2EA:  6EE  JP_Z     0x3EE       ; Flow to 0x3EE
0x2EB:  F41  SET                  ; 
0x2EC:  F5D  RST                  ; 
0x2ED:  0F0  JP       0x3F0       ; Flow to 0x3F0
0x2EE:  F5E  RST                  ; 
0x2EF:  F5D  RST                  ; 
0x2F0:  B75  LD_X     0x75        ; Set pointer to RAM 0x75
0x2F1:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x2F2:  FDF  RET                  ; 
0x2F3:  FFF  NOP7                 ; 
0x2F4:  FFF  NOP7                 ; 
0x2F5:  FFF  NOP7                 ; 
0x2F6:  FFF  NOP7                 ; 
0x2F7:  FFF  NOP7                 ; 
0x2F8:  FFF  NOP7                 ; 
0x2F9:  FFF  NOP7                 ; 
0x2FA:  FFF  NOP7                 ; 
0x2FB:  FFF  NOP7                 ; 
0x2FC:  FFF  NOP7                 ; 
0x2FD:  FFF  NOP7                 ; 
0x2FE:  FFF  NOP7                 ; 
0x2FF:  FFF  NOP7                 ; 
0x300:  FDF  RET                  ; 
0x301:  00C  JP       0x30C       ; Flow to 0x30C
0x302:  01C  JP       0x31C       ; Flow to 0x31C
0x303:  024  JP       0x324       ; Flow to 0x324
0x304:  029  JP       0x329       ; Flow to 0x329
0x305:  04B  JP       0x34B       ; Flow to 0x34B
0x306:  074  JP       0x374       ; Flow to 0x374
0x307:  5F2  CALZ     0x3F2       ; Flow to 0x3F2
0x308:  B5C  LD_X     0x5C        ; Set pointer to RAM 0x5C
0x309:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x30A:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0x30B:  FE8  JPBA                 ; 
0x30C:  B4A  LD_X     0x4A        ; Set pointer to RAM 0x4A (MEM_SLEEPING)
0x30D:  E2F  LD_R_I   [X], #15    ; Register [X] op with immediate #15
0x30E:  B5D  LD_X     0x5D        ; Set pointer to RAM 0x5D (MEM_LIFECYCLE)
0x30F:  EC6  LD_R_Q   B, [X]      ; Register B op with [X]
0x310:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x311:  E80  LD_XP_R              ; 
0x312:  B04  LD_X     0x04        ; Set pointer to RAM 0x04
0x313:  DD1  CP_R_I   B, #1       ; Register B op with immediate #1
0x314:  617  JP_Z     0x317       ; Flow to 0x317
0x315:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x316:  018  JP       0x318       ; Flow to 0x318
0x317:  93D  LBPX     #3D         ; Store constant #3D into memory pointer
0x318:  E08  LD_R_I   A, #8       ; Register A op with immediate #8
0x319:  8A5  LD_Y     0xA5        ; Set pointer to RAM 0xA5
0x31A:  5B7  CALZ     0x3B7       ; Flow to 0x3B7
0x31B:  FDF  RET                  ; 
0x31C:  B5D  LD_X     0x5D        ; Set pointer to RAM 0x5D (MEM_LIFECYCLE)
0x31D:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x31E:  E90  LD_YP_R              ; 
0x31F:  808  LD_Y     0x08        ; Set pointer to RAM 0x08
0x320:  DE1  CP_R_I   [X], #1     ; Register [X] op with immediate #1
0x321:  727  JP_NZ    0x327       ; Flow to 0x327
0x322:  E3D  LD_R_I   [Y], #13    ; Register [Y] op with immediate #13
0x323:  018  JP       0x318       ; Flow to 0x318
0x324:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x325:  E90  LD_YP_R              ; 
0x326:  809  LD_Y     0x09        ; Set pointer to RAM 0x09
0x327:  E31  LD_R_I   [Y], #1     ; Register [Y] op with immediate #1
0x328:  016  JP       0x316       ; Flow to 0x316
0x329:  B4B  LD_X     0x4B        ; Set pointer to RAM 0x4B
0x32A:  FC2  PUSH_R               ; 
0x32B:  E2F  LD_R_I   [X], #15    ; Register [X] op with immediate #15
0x32C:  E04  LD_R_I   A, #4       ; Register A op with immediate #4
0x32D:  E18  LD_R_I   B, #8       ; Register B op with immediate #8
0x32E:  802  LD_Y     0x02        ; Set pointer to RAM 0x02
0x32F:  4D5  CALL     0x3D5       ; Flow to 0x3D5
0x330:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x331:  E90  LD_YP_R              ; 
0x332:  84B  LD_Y     0x4B        ; Set pointer to RAM 0x4B
0x333:  FD3  POP_R                ; 
0x334:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x335:  E80  LD_XP_R              ; 
0x336:  B06  LD_X     0x06        ; Set pointer to RAM 0x06
0x337:  9B4  LBPX     #B4         ; Store constant #B4 into memory pointer
0x338:  85D  LD_Y     0x5D        ; Set pointer to RAM 0x5D (MEM_LIFECYCLE)
0x339:  DF1  CP_R_I   [Y], #1     ; Register [Y] op with immediate #1
0x33A:  73D  JP_NZ    0x33D       ; Flow to 0x33D
0x33B:  B06  LD_X     0x06        ; Set pointer to RAM 0x06
0x33C:  919  LBPX     #19         ; Store constant #19 into memory pointer
0x33D:  84D  LD_Y     0x4D        ; Set pointer to RAM 0x4D (MEM_POOP)
0x33E:  C31  ADD_R_I  [Y], #1     ; Register [Y] op with immediate #1
0x33F:  DF8  CP_R_I   [Y], #8     ; Register [Y] op with immediate #8
0x340:  24A  JP_C     0x34A       ; Flow to 0x34A
0x341:  E38  LD_R_I   [Y], #8     ; Register [Y] op with immediate #8
0x342:  848  LD_Y     0x48        ; Set pointer to RAM 0x48 (MEM_SICK_LEVEL)
0x343:  DB8  FAN_R_I              ; 
0x344:  74A  JP_NZ    0x34A       ; Flow to 0x34A
0x345:  B0D  LD_X     0x0D        ; Set pointer to RAM 0x0D
0x346:  512  CALZ     0x312       ; Flow to 0x312
0x347:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x348:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0x349:  509  CALZ     0x309       ; Flow to 0x309
0x34A:  FDF  RET                  ; 
0x34B:  E03  LD_R_I   A, #3       ; Register A op with immediate #3
0x34C:  8AE  LD_Y     0xAE        ; Set pointer to RAM 0xAE
0x34D:  5B7  CALZ     0x3B7       ; Flow to 0x3B7
0x34E:  4FC  CALL     0x3FC       ; Flow to 0x3FC
0x34F:  E13  LD_R_I   B, #3       ; Register B op with immediate #3
0x350:  E48  PSET     #8          ; Set next Page to 8
0x351:  49E  CALL     0x89E       ; Flow to 0x89E
0x352:  4FC  CALL     0x8FC       ; Flow to 0x8FC
0x353:  5EF  CALZ     0x8EF       ; Flow to 0x8EF
0x354:  B50  LD_X     0x50        ; Set pointer to RAM 0x50 (MEM_CHARACTER)
0x355:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x356:  E4D  PSET     #D          ; Set next Page to 13
0x357:  4C6  CALL     0xDC6       ; Flow to 0xDC6
0x358:  B51  LD_X     0x51        ; Set pointer to RAM 0x51 (MEM_BEHAVIOR_MISTAKE)
0x359:  EC6  LD_R_Q   B, [X]      ; Register B op with [X]
0x35A:  B42  LD_X     0x42        ; Set pointer to RAM 0x42 (MEM_NEGLECT)
0x35B:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x35C:  B90  LD_X     0x90        ; Set pointer to RAM 0x90
0x35D:  F02  CP_R_Q   A, [X]      ; Register A op with [X]
0x35E:  EE0  INC_X                ; 
0x35F:  262  JP_C     0xD62       ; Flow to 0xD62
0x360:  F06  CP_R_Q   B, [X]      ; Register B op with [X]
0x361:  366  JP_NC    0xD66       ; Flow to 0xD66
0x362:  EE0  INC_X                ; 
0x363:  EE0  INC_X                ; 
0x364:  EE0  INC_X                ; 
0x365:  05D  JP       0xD5D       ; Flow to 0xD5D
0x366:  EE0  INC_X                ; 
0x367:  EE2  LDPX_R               ; 
0x368:  EC6  LD_R_Q   B, [X]      ; Register B op with [X]
0x369:  B50  LD_X     0x50        ; Set pointer to RAM 0x50 (MEM_CHARACTER)
0x36A:  EC8  LD_R_Q   [X], A      ; Register [X] op with A
0x36B:  B5D  LD_X     0x5D        ; Set pointer to RAM 0x5D (MEM_LIFECYCLE)
0x36C:  EC9  LD_R_Q   [X], B      ; Register [X] op with B
0x36D:  E44  PSET     #4          ; Set next Page to 4
0x36E:  465  CALL     0x465       ; Flow to 0x465 (MEM_WEIGHT)
0x36F:  E14  LD_R_I   B, #4       ; Register B op with immediate #4
0x370:  E48  PSET     #8          ; Set next Page to 8
0x371:  49E  CALL     0x89E       ; Flow to 0x89E
0x372:  E4D  PSET     #D          ; Set next Page to 13
0x373:  0D2  JP       0xDD2       ; Flow to 0xDD2
0x374:  5EC  CALZ     0xDEC       ; Flow to 0xDEC
0x375:  4FC  CALL     0xDFC       ; Flow to 0xDFC
0x376:  5EF  CALZ     0xDEF       ; Flow to 0xDEF
0x377:  B74  LD_X     0x74        ; Set pointer to RAM 0x74
0x378:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x379:  B48  LD_X     0x48        ; Set pointer to RAM 0x48 (MEM_SICK_LEVEL)
0x37A:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x37B:  9F0  LBPX     #F0         ; Store constant #F0 into memory pointer
0x37C:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x37D:  B5D  LD_X     0x5D        ; Set pointer to RAM 0x5D (MEM_LIFECYCLE)
0x37E:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x37F:  F86  LD_MN_A  0x06        ; Direct RAM access at 0x06
0x380:  8BF  LD_Y     0xBF        ; Set pointer to RAM 0xBF
0x381:  5BC  CALZ     0xDBC       ; Flow to 0xDBC
0x382:  4D2  CALL     0xDD2       ; Flow to 0xDD2
0x383:  4D2  CALL     0xDD2       ; Flow to 0xDD2
0x384:  4D2  CALL     0xDD2       ; Flow to 0xDD2
0x385:  4D2  CALL     0xDD2       ; Flow to 0xDD2
0x386:  8C4  LD_Y     0xC4        ; Set pointer to RAM 0xC4
0x387:  5BC  CALZ     0xDBC       ; Flow to 0xDBC
0x388:  4D2  CALL     0xDD2       ; Flow to 0xDD2
0x389:  8C9  LD_Y     0xC9        ; Set pointer to RAM 0xC9
0x38A:  5BC  CALZ     0xDBC       ; Flow to 0xDBC
0x38B:  4D2  CALL     0xDD2       ; Flow to 0xDD2
0x38C:  5EF  CALZ     0xDEF       ; Flow to 0xDEF
0x38D:  B5D  LD_X     0x5D        ; Set pointer to RAM 0x5D (MEM_LIFECYCLE)
0x38E:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0x38F:  B4E  LD_X     0x4E        ; Set pointer to RAM 0x4E
0x390:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x391:  69E  JP_Z     0xD9E       ; Flow to 0xD9E
0x392:  4D7  CALL     0xDD7       ; Flow to 0xDD7
0x393:  B1B  LD_X     0x1B        ; Set pointer to RAM 0x1B
0x394:  53C  CALZ     0xD3C       ; Flow to 0xD3C
0x395:  B48  LD_X     0x48        ; Set pointer to RAM 0x48 (MEM_SICK_LEVEL)
0x396:  52C  CALZ     0xD2C       ; Flow to 0xD2C
0x397:  4D7  CALL     0xDD7       ; Flow to 0xDD7
0x398:  540  CALZ     0xD40       ; Flow to 0xD40
0x399:  4E4  CALL     0xDE4       ; Flow to 0xDE4
0x39A:  535  CALZ     0xD35       ; Flow to 0xD35
0x39B:  797  JP_NZ    0xD97       ; Flow to 0xD97
0x39C:  B1B  LD_X     0x1B        ; Set pointer to RAM 0x1B
0x39D:  53C  CALZ     0xD3C       ; Flow to 0xD3C
0x39E:  8CE  LD_Y     0xCE        ; Set pointer to RAM 0xCE
0x39F:  5BC  CALZ     0xDBC       ; Flow to 0xDBC
0x3A0:  521  CALZ     0xD21       ; Flow to 0xD21
0x3A1:  540  CALZ     0xD40       ; Flow to 0xD40
0x3A2:  5F2  CALZ     0xDF2       ; Flow to 0xDF2
0x3A3:  B80  LD_X     0x80        ; Set pointer to RAM 0x80
0x3A4:  C28  ADD_R_I  [X], #8     ; Register [X] op with immediate #8
0x3A5:  EC6  LD_R_Q   B, [X]      ; Register B op with [X]
0x3A6:  B3A  LD_X     0x3A        ; Set pointer to RAM 0x3A
0x3A7:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x3A8:  E03  LD_R_I   A, #3       ; Register A op with immediate #3
0x3A9:  4EE  CALL     0xDEE       ; Flow to 0xDEE
0x3AA:  5F2  CALZ     0xDF2       ; Flow to 0xDF2
0x3AB:  B3A  LD_X     0x3A        ; Set pointer to RAM 0x3A
0x3AC:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x3AD:  E04  LD_R_I   A, #4       ; Register A op with immediate #4
0x3AE:  4ED  CALL     0xDED       ; Flow to 0xDED
0x3AF:  E42  PSET     #2          ; Set next Page to 2
0x3B0:  400  CALL     0x200       ; Flow to 0x200
0x3B1:  6A1  JP_Z     0x2A1       ; Flow to 0x2A1
0x3B2:  5BB  CALZ     0x2BB       ; Flow to 0x2BB
0x3B3:  5F5  CALZ     0x2F5       ; Flow to 0x2F5
0x3B4:  BD0  LD_X     0xD0        ; Set pointer to RAM 0xD0
0x3B5:  E11  LD_R_I   B, #1       ; Register B op with immediate #1
0x3B6:  E09  LD_R_I   A, #9       ; Register A op with immediate #9
0x3B7:  4D0  CALL     0x2D0       ; Flow to 0x2D0 (MEM_ATTENTION)
0x3B8:  E10  LD_R_I   B, #0       ; Register B op with immediate #0
0x3B9:  E91  LD_YP_R              ; 
0x3BA:  854  LD_Y     0x54        ; Set pointer to RAM 0x54 (MEM_AGE)
0x3BB:  EF3  LDPY_R               ; 
0x3BC:  B50  LD_X     0x50        ; Set pointer to RAM 0x50 (MEM_CHARACTER)
0x3BD:  4D0  CALL     0x2D0       ; Flow to 0x2D0 (MEM_ATTENTION)
0x3BE:  E10  LD_R_I   B, #0       ; Register B op with immediate #0
0x3BF:  EC3  LD_R_Q   A, [Y]      ; Register A op with [Y]
0x3C0:  DC0  CP_R_I   A, #0       ; Register A op with immediate #0
0x3C1:  6C4  JP_Z     0x2C4       ; Flow to 0x2C4
0x3C2:  B40  LD_X     0x40        ; Set pointer to RAM 0x40 (MEM_HUNGER)

; =========================================================
; ROUTINE: CHECK_HUNGER_NEGLECT
; Location: 0x3C3 (Page 3, Step C3)
; Trigger:  Main timer tick
; Logic:    If Hunger hearts == 0, proceed to neglect timer check
; =========================================================

0x3C3:  4D0  CALL     0x2D0       ; Flow to 0x2D0 (MEM_ATTENTION)
0x3C4:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x3C5:  E12  LD_R_I   B, #2       ; Register B op with immediate #2
0x3C6:  E4A  PSET     #A          ; Set next Page to 10
0x3C7:  4F0  CALL     0xAF0       ; Flow to 0xAF0
0x3C8:  E42  PSET     #2          ; Set next Page to 2
0x3C9:  400  CALL     0x200       ; Flow to 0x200
0x3CA:  6C8  JP_Z     0x2C8       ; Flow to 0x2C8
0x3CB:  5BB  CALZ     0x2BB       ; Flow to 0x2BB
0x3CC:  E1E  LD_R_I   B, #14      ; Register B op with immediate #14
0x3CD:  E45  PSET     #5          ; Set next Page to 5
0x3CE:  400  CALL     0x500       ; Flow to 0x500 (MEM_CHARACTER)
0x3CF:  0A1  JP       0x5A1       ; Flow to 0x5A1
0x3D0:  E47  PSET     #7          ; Set next Page to 7
0x3D1:  0A5  JP       0x7A5       ; Flow to 0x7A5 (EXTRACT_HEART_COUNT)
0x3D2:  E0A  LD_R_I   A, #10      ; Register A op with immediate #10
0x3D3:  E1A  LD_R_I   B, #10      ; Register B op with immediate #10
0x3D4:  805  LD_Y     0x05        ; Set pointer to RAM 0x05
0x3D5:  E48  PSET     #8          ; Set next Page to 8
0x3D6:  0A9  JP       0x8A9       ; Flow to 0x8A9
0x3D7:  540  CALZ     0x840       ; Flow to 0x840
0x3D8:  5EF  CALZ     0x8EF       ; Flow to 0x8EF
0x3D9:  FB6  LD_B_MN  0x06        ; Direct RAM access at 0x06
0x3DA:  B5D  LD_X     0x5D        ; Set pointer to RAM 0x5D (MEM_LIFECYCLE)
0x3DB:  EC9  LD_R_Q   [X], B      ; Register [X] op with B
0x3DC:  E04  LD_R_I   A, #4       ; Register A op with immediate #4
0x3DD:  B00  LD_X     0x00        ; Set pointer to RAM 0x00
0x3DE:  E4A  PSET     #A          ; Set next Page to 10
0x3DF:  4BD  CALL     0xABD       ; Flow to 0xABD
0x3E0:  FA1  LD_A_MN  0x01        ; Direct RAM access at 0x01
0x3E1:  B3A  LD_X     0x3A        ; Set pointer to RAM 0x3A
0x3E2:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x3E3:  4ED  CALL     0xAED       ; Flow to 0xAED
0x3E4:  5F2  CALZ     0xAF2       ; Flow to 0xAF2
0x3E5:  B5D  LD_X     0x5D        ; Set pointer to RAM 0x5D (MEM_LIFECYCLE)
0x3E6:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0x3E7:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x3E8:  B3A  LD_X     0x3A        ; Set pointer to RAM 0x3A
0x3E9:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x3EA:  4ED  CALL     0xAED       ; Flow to 0xAED
0x3EB:  556  CALZ     0xA56       ; Flow to 0xA56
0x3EC:  FDF  RET                  ; 
0x3ED:  E10  LD_R_I   B, #0       ; Register B op with immediate #0
0x3EE:  FC1  PUSH_R               ; 
0x3EF:  5F2  CALZ     0xAF2       ; Flow to 0xAF2
0x3F0:  FD1  POP_R                ; 
0x3F1:  FC1  PUSH_R               ; 
0x3F2:  FC0  PUSH_R               ; 
0x3F3:  E49  PSET     #9          ; Set next Page to 9
0x3F4:  428  CALL     0x928       ; Flow to 0x928
0x3F5:  FD0  POP_R                ; 
0x3F6:  5F2  CALZ     0x9F2       ; Flow to 0x9F2
0x3F7:  FD1  POP_R                ; 
0x3F8:  B3B  LD_X     0x3B        ; Set pointer to RAM 0x3B
0x3F9:  C28  ADD_R_I  [X], #8     ; Register [X] op with immediate #8
0x3FA:  E49  PSET     #9          ; Set next Page to 9
0x3FB:  039  JP       0x939       ; Flow to 0x939
0x3FC:  E49  PSET     #9          ; Set next Page to 9
0x3FD:  006  JP       0x906       ; Flow to 0x906
0x3FE:  FFF  NOP7                 ; 
0x3FF:  FFF  NOP7                 ; 
0x400:  5EF  CALZ     0x9EF       ; Flow to 0x9EF
0x401:  B4B  LD_X     0x4B        ; Set pointer to RAM 0x4B
0x402:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x403:  71B  JP_NZ    0x91B       ; Flow to 0x91B
0x404:  5F5  CALZ     0x9F5       ; Flow to 0x9F5
0x405:  E90  LD_YP_R              ; 
0x406:  B00  LD_X     0x00        ; Set pointer to RAM 0x00
0x407:  880  LD_Y     0x80        ; Set pointer to RAM 0x80
0x408:  E6F  LDPX_MX  #F          ; Store constant #F into memory pointer
0x409:  E7F  LDPY_MY  #F          ; Store constant #F into memory pointer
0x40A:  A44  CP_XH                ; 
0x40B:  208  JP_C     0x908       ; Flow to 0x908
0x40C:  5B3  CALZ     0x9B3       ; Flow to 0x9B3
0x40D:  61A  JP_Z     0x91A       ; Flow to 0x91A
0x40E:  C21  ADD_R_I  [X], #1     ; Register [X] op with immediate #1
0x40F:  CE8  OR_R_I   [X], #8     ; Register [X] op with immediate #8
0x410:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x411:  E8C  RRC                  ; 
0x412:  C81  AND_R_I  A, #1       ; Register A op with immediate #1
0x413:  C00  ADD_R_I  A, #0       ; Register A op with immediate #0
0x414:  E11  LD_R_I   B, #1       ; Register B op with immediate #1
0x415:  E81  LD_XP_R              ; 
0x416:  E12  LD_R_I   B, #2       ; Register B op with immediate #2
0x417:  B20  LD_X     0x20        ; Set pointer to RAM 0x20
0x418:  E47  PSET     #7          ; Set next Page to 7
0x419:  4A5  CALL     0x7A5       ; Flow to 0x7A5 (EXTRACT_HEART_COUNT)
0x41A:  FDF  RET                  ; 
0x41B:  5B3  CALZ     0x7B3       ; Flow to 0x7B3
0x41C:  62A  JP_Z     0x72A       ; Flow to 0x72A
0x41D:  C21  ADD_R_I  [X], #1     ; Register [X] op with immediate #1
0x41E:  CE8  OR_R_I   [X], #8     ; Register [X] op with immediate #8
0x41F:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x420:  E8C  RRC                  ; 
0x421:  C81  AND_R_I  A, #1       ; Register A op with immediate #1
0x422:  C0A  ADD_R_I  A, #10      ; Register A op with immediate #10
0x423:  E11  LD_R_I   B, #1       ; Register B op with immediate #1
0x424:  E81  LD_XP_R              ; 
0x425:  E13  LD_R_I   B, #3       ; Register B op with immediate #3
0x426:  B30  LD_X     0x30        ; Set pointer to RAM 0x30
0x427:  E47  PSET     #7          ; Set next Page to 7
0x428:  4A5  CALL     0x7A5       ; Flow to 0x7A5 (EXTRACT_HEART_COUNT)
0x429:  032  JP       0x732       ; Flow to 0x732
0x42A:  5FB  CALZ     0x7FB       ; Flow to 0x7FB
0x42B:  632  JP_Z     0x732       ; Flow to 0x732
0x42C:  5F5  CALZ     0x7F5       ; Flow to 0x7F5
0x42D:  B30  LD_X     0x30        ; Set pointer to RAM 0x30
0x42E:  E12  LD_R_I   B, #2       ; Register B op with immediate #2
0x42F:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x430:  E47  PSET     #7          ; Set next Page to 7
0x431:  4A5  CALL     0x7A5       ; Flow to 0x7A5 (EXTRACT_HEART_COUNT)
0x432:  5EF  CALZ     0x7EF       ; Flow to 0x7EF
0x433:  B7E  LD_X     0x7E        ; Set pointer to RAM 0x7E
0x434:  C21  ADD_R_I  [X], #1     ; Register [X] op with immediate #1
0x435:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x436:  E8C  RRC                  ; 
0x437:  C81  AND_R_I  A, #1       ; Register A op with immediate #1
0x438:  C0E  ADD_R_I  A, #14      ; Register A op with immediate #14
0x439:  F84  LD_MN_A  0x04        ; Direct RAM access at 0x04
0x43A:  B4D  LD_X     0x4D        ; Set pointer to RAM 0x4D (MEM_POOP)
0x43B:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x43C:  DC8  CP_R_I   A, #8       ; Register A op with immediate #8
0x43D:  23F  JP_C     0x73F       ; Flow to 0x73F
0x43E:  E08  LD_R_I   A, #8       ; Register A op with immediate #8
0x43F:  F83  LD_MN_A  0x03        ; Direct RAM access at 0x03
0x440:  C0D  ADD_R_I  A, #13      ; Register A op with immediate #13
0x441:  356  JP_NC    0x756       ; Flow to 0x756
0x442:  E8C  RRC                  ; 
0x443:  C83  AND_R_I  A, #3       ; Register A op with immediate #3
0x444:  C01  ADD_R_I  A, #1       ; Register A op with immediate #1
0x445:  800  LD_Y     0x00        ; Set pointer to RAM 0x00
0x446:  E94  LD_YH_R              ; 
0x447:  5F5  CALZ     0x7F5       ; Flow to 0x7F5
0x448:  E90  LD_YP_R              ; 
0x449:  B00  LD_X     0x00        ; Set pointer to RAM 0x00
0x44A:  EEB  LDPX_R               ; 
0x44B:  EF0  INC_Y                ; 
0x44C:  A44  CP_XH                ; 
0x44D:  24A  JP_C     0x74A       ; Flow to 0x74A
0x44E:  F5E  RST                  ; 
0x44F:  A04  ADC_XH               ; 
0x450:  F5E  RST                  ; 
0x451:  A24  ADC_YH               ; 
0x452:  EEB  LDPX_R               ; 
0x453:  EF0  INC_Y                ; 
0x454:  A4C  CP_XH                ; 
0x455:  252  JP_C     0x752       ; Flow to 0x752
0x456:  5F5  CALZ     0x7F5       ; Flow to 0x7F5
0x457:  BB0  LD_X     0xB0        ; Set pointer to RAM 0xB0
0x458:  F63  INC_MN               ; 
0x459:  F73  DEC_MN               ; 
0x45A:  664  JP_Z     0x764       ; Flow to 0x764
0x45B:  E11  LD_R_I   B, #1       ; Register B op with immediate #1
0x45C:  FA4  LD_A_MN  0x04        ; Direct RAM access at 0x04
0x45D:  E47  PSET     #7          ; Set next Page to 7
0x45E:  4A5  CALL     0x7A5       ; Flow to 0x7A5 (EXTRACT_HEART_COUNT)
0x45F:  F5E  RST                  ; 
0x460:  A07  ADC_XH               ; 
0x461:  259  JP_C     0x759       ; Flow to 0x759
0x462:  A0F  ADC_XH               ; 
0x463:  059  JP       0x759       ; Flow to 0x759
0x464:  FDF  RET                  ; 
0x465:  5EF  CALZ     0x7EF       ; Flow to 0x7EF
0x466:  B5F  LD_X     0x5F        ; Set pointer to RAM 0x5F
0x467:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x468:  B66  LD_X     0x66        ; Set pointer to RAM 0x66
0x469:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x46A:  B5D  LD_X     0x5D        ; Set pointer to RAM 0x5D (MEM_LIFECYCLE)
0x46B:  EE6  LDPX_R               ; 
0x46C:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x46D:  B6E  LD_X     0x6E        ; Set pointer to RAM 0x6E
0x46E:  E4A  PSET     #A          ; Set next Page to 10
0x46F:  4BD  CALL     0xABD       ; Flow to 0xABD
0x470:  B5D  LD_X     0x5D        ; Set pointer to RAM 0x5D (MEM_LIFECYCLE)
0x471:  EE6  LDPX_R               ; 
0x472:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x473:  B00  LD_X     0x00        ; Set pointer to RAM 0x00
0x474:  484  CALL     0xA84       ; Flow to 0xA84
0x475:  E10  LD_R_I   B, #0       ; Register B op with immediate #0
0x476:  FA1  LD_A_MN  0x01        ; Direct RAM access at 0x01
0x477:  C0B  ADD_R_I  A, #11      ; Register A op with immediate #11
0x478:  C58  ADC_R_I              ; 
0x479:  B6A  LD_X     0x6A        ; Set pointer to RAM 0x6A
0x47A:  482  CALL     0xA82       ; Flow to 0xA82
0x47B:  E10  LD_R_I   B, #0       ; Register B op with immediate #0
0x47C:  FA0  LD_A_MN  0x00        ; Direct RAM access at 0x00
0x47D:  C00  ADD_R_I  A, #0       ; Register A op with immediate #0
0x47E:  C5C  ADC_R_I              ; 
0x47F:  B64  LD_X     0x64        ; Set pointer to RAM 0x64
0x480:  E4B  PSET     #B          ; Set next Page to 11
0x481:  FE8  JPBA                 ; 
0x482:  E49  PSET     #9          ; Set next Page to 9
0x483:  FE8  JPBA                 ; 
0x484:  E4B  PSET     #B          ; Set next Page to 11
0x485:  FE8  JPBA                 ; 
0x486:  5EF  CALZ     0xBEF       ; Flow to 0xBEF
0x487:  B5F  LD_X     0x5F        ; Set pointer to RAM 0x5F
0x488:  C2F  ADD_R_I  [X], #15    ; Register [X] op with immediate #15
0x489:  296  JP_C     0xB96       ; Flow to 0xB96
0x48A:  B64  LD_X     0x64        ; Set pointer to RAM 0x64
0x48B:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x48C:  C21  ADD_R_I  [X], #1     ; Register [X] op with immediate #1
0x48D:  EE0  INC_X                ; 
0x48E:  EC6  LD_R_Q   B, [X]      ; Register B op with [X]
0x48F:  C60  ADC_R_I              ; 
0x490:  B62  LD_X     0x62        ; Set pointer to RAM 0x62
0x491:  4E3  CALL     0xBE3       ; Flow to 0xBE3
0x492:  B62  LD_X     0x62        ; Set pointer to RAM 0x62
0x493:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x494:  B5F  LD_X     0x5F        ; Set pointer to RAM 0x5F
0x495:  EC8  LD_R_Q   [X], A      ; Register [X] op with A
0x496:  B66  LD_X     0x66        ; Set pointer to RAM 0x66
0x497:  C2F  ADD_R_I  [X], #15    ; Register [X] op with immediate #15
0x498:  EE0  INC_X                ; 
0x499:  C6F  ADC_R_I              ; 
0x49A:  2A8  JP_C     0xBA8       ; Flow to 0xBA8
0x49B:  B6A  LD_X     0x6A        ; Set pointer to RAM 0x6A
0x49C:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x49D:  C22  ADD_R_I  [X], #2     ; Register [X] op with immediate #2
0x49E:  EE0  INC_X                ; 
0x49F:  EC6  LD_R_Q   B, [X]      ; Register B op with [X]
0x4A0:  C60  ADC_R_I              ; 
0x4A1:  B66  LD_X     0x66        ; Set pointer to RAM 0x66
0x4A2:  4E5  CALL     0xBE5       ; Flow to 0xBE5
0x4A3:  B67  LD_X     0x67        ; Set pointer to RAM 0x67
0x4A4:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x4A5:  CA0  AND_R_I  [X], #0     ; Register [X] op with immediate #0
0x4A6:  B70  LD_X     0x70        ; Set pointer to RAM 0x70
0x4A7:  EC8  LD_R_Q   [X], A      ; Register [X] op with A
0x4A8:  B68  LD_X     0x68        ; Set pointer to RAM 0x68
0x4A9:  EE2  LDPX_R               ; 
0x4AA:  EE6  LDPX_R               ; 
0x4AB:  D81  FAN_R_I              ; 
0x4AC:  6B2  JP_Z     0xBB2       ; Flow to 0xBB2
0x4AD:  C8E  AND_R_I  A, #14      ; Register A op with immediate #14
0x4AE:  B6C  LD_X     0x6C        ; Set pointer to RAM 0x6C
0x4AF:  A82  ADD_R_Q  A, [X]      ; Register A op with [X]
0x4B0:  EE0  INC_X                ; 
0x4B1:  A96  ADC_R_Q  B, [X]      ; Register B op with [X]
0x4B2:  B6C  LD_X     0x6C        ; Set pointer to RAM 0x6C
0x4B3:  EE8  LDPX_R               ; 
0x4B4:  EE9  LDPX_R               ; 
0x4B5:  B3A  LD_X     0x3A        ; Set pointer to RAM 0x3A
0x4B6:  EE8  LDPX_R               ; 
0x4B7:  EE9  LDPX_R               ; 
0x4B8:  B70  LD_X     0x70        ; Set pointer to RAM 0x70
0x4B9:  DA8  FAN_R_I              ; 
0x4BA:  6CB  JP_Z     0xBCB       ; Flow to 0xBCB
0x4BB:  B63  LD_X     0x63        ; Set pointer to RAM 0x63
0x4BC:  EC6  LD_R_Q   B, [X]      ; Register B op with [X]
0x4BD:  B6E  LD_X     0x6E        ; Set pointer to RAM 0x6E
0x4BE:  D92  FAN_R_I              ; 
0x4BF:  6C1  JP_Z     0xBC1       ; Flow to 0xBC1
0x4C0:  B6F  LD_X     0x6F        ; Set pointer to RAM 0x6F
0x4C1:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x4C2:  B70  LD_X     0x70        ; Set pointer to RAM 0x70
0x4C3:  EC6  LD_R_Q   B, [X]      ; Register B op with [X]
0x4C4:  A85  ADD_R_Q  B, B        ; Register B op with B
0x4C5:  A85  ADD_R_Q  B, B        ; Register B op with B
0x4C6:  B63  LD_X     0x63        ; Set pointer to RAM 0x63
0x4C7:  AE6  XOR_R_Q  B, [X]      ; Register B op with [X]
0x4C8:  C98  AND_R_I  B, #8       ; Register B op with immediate #8
0x4C9:  E49  PSET     #9          ; Set next Page to 9
0x4CA:  428  CALL     0x928       ; Flow to 0x928
0x4CB:  5EF  CALZ     0x9EF       ; Flow to 0x9EF
0x4CC:  B3B  LD_X     0x3B        ; Set pointer to RAM 0x3B
0x4CD:  C28  ADD_R_I  [X], #8     ; Register [X] op with immediate #8
0x4CE:  B70  LD_X     0x70        ; Set pointer to RAM 0x70
0x4CF:  DA4  FAN_R_I              ; 
0x4D0:  6E2  JP_Z     0x9E2       ; Flow to 0x9E2
0x4D1:  B63  LD_X     0x63        ; Set pointer to RAM 0x63
0x4D2:  EC6  LD_R_Q   B, [X]      ; Register B op with [X]
0x4D3:  B6E  LD_X     0x6E        ; Set pointer to RAM 0x6E
0x4D4:  D91  FAN_R_I              ; 
0x4D5:  6D7  JP_Z     0x9D7       ; Flow to 0x9D7
0x4D6:  B6F  LD_X     0x6F        ; Set pointer to RAM 0x6F
0x4D7:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x4D8:  B70  LD_X     0x70        ; Set pointer to RAM 0x70
0x4D9:  EC6  LD_R_Q   B, [X]      ; Register B op with [X]
0x4DA:  A85  ADD_R_Q  B, B        ; Register B op with B
0x4DB:  A85  ADD_R_Q  B, B        ; Register B op with B
0x4DC:  B63  LD_X     0x63        ; Set pointer to RAM 0x63
0x4DD:  AE6  XOR_R_Q  B, [X]      ; Register B op with [X]
0x4DE:  A85  ADD_R_Q  B, B        ; Register B op with B
0x4DF:  C98  AND_R_I  B, #8       ; Register B op with immediate #8
0x4E0:  E49  PSET     #9          ; Set next Page to 9
0x4E1:  439  CALL     0x939       ; Flow to 0x939
0x4E2:  FDF  RET                  ; 
0x4E3:  E4B  PSET     #B          ; Set next Page to 11
0x4E4:  FE8  JPBA                 ; 
0x4E5:  E49  PSET     #9          ; Set next Page to 9
0x4E6:  FE8  JPBA                 ; 
0x4E7:  B40  LD_X     0x40        ; Set pointer to RAM 0x40 (MEM_HUNGER)
0x4E8:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x4E9:  E48  PSET     #8          ; Set next Page to 8
0x4EA:  40D  CALL     0x80D       ; Flow to 0x80D
0x4EB:  BC0  LD_X     0xC0        ; Set pointer to RAM 0xC0
0x4EC:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x4ED:  E48  PSET     #8          ; Set next Page to 8
0x4EE:  40D  CALL     0x80D       ; Flow to 0x80D
0x4EF:  5EF  CALZ     0x8EF       ; Flow to 0x8EF
0x4F0:  B3A  LD_X     0x3A        ; Set pointer to RAM 0x3A
0x4F1:  9C4  LBPX     #C4         ; Store constant #C4 into memory pointer
0x4F2:  E45  PSET     #5          ; Set next Page to 5
0x4F3:  4A6  CALL     0x5A6       ; Flow to 0x5A6
0x4F4:  B70  LD_X     0x70        ; Set pointer to RAM 0x70
0x4F5:  E04  LD_R_I   A, #4       ; Register A op with immediate #4
0x4F6:  E48  PSET     #8          ; Set next Page to 8
0x4F7:  40D  CALL     0x80D       ; Flow to 0x80D
0x4F8:  E04  LD_R_I   A, #4       ; Register A op with immediate #4
0x4F9:  E14  LD_R_I   B, #4       ; Register B op with immediate #4
0x4FA:  E4A  PSET     #A          ; Set next Page to 10
0x4FB:  4F0  CALL     0xAF0       ; Flow to 0xAF0
0x4FC:  E42  PSET     #2          ; Set next Page to 2
0x4FD:  093  JP       0x293       ; Flow to 0x293
0x4FE:  FFF  NOP7                 ; 
0x4FF:  FFF  NOP7                 ; 
0x500:  556  CALZ     0x256       ; Flow to 0x256
0x501:  5EF  CALZ     0x2EF       ; Flow to 0x2EF
0x502:  B2A  LD_X     0x2A        ; Set pointer to RAM 0x2A
0x503:  A89  ADD_R_Q  [X], B      ; Register [X] op with B
0x504:  EE0  INC_X                ; 
0x505:  C6F  ADC_R_I              ; 
0x506:  200  JP_C     0x200       ; Flow to 0x200
0x507:  FDF  RET                  ; 
0x508:  5BB  CALZ     0x2BB       ; Flow to 0x2BB
0x509:  5EC  CALZ     0x2EC       ; Flow to 0x2EC
0x50A:  5CE  CALZ     0x2CE       ; Flow to 0x2CE
0x50B:  496  CALL     0x296       ; Flow to 0x296
0x50C:  E44  PSET     #4          ; Set next Page to 4
0x50D:  486  CALL     0x486       ; Flow to 0x486 (MEM_SICK_LEVEL)
0x50E:  E44  PSET     #4          ; Set next Page to 4
0x50F:  400  CALL     0x400       ; Flow to 0x400 (MEM_HUNGER)
0x510:  E1C  LD_R_I   B, #12      ; Register B op with immediate #12
0x511:  400  CALL     0x400       ; Flow to 0x400 (MEM_HUNGER)
0x512:  B7C  LD_X     0x7C        ; Set pointer to RAM 0x7C
0x513:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x514:  717  JP_NZ    0x417       ; Flow to 0x417 (MEM_HAPPY)
0x515:  E4F  PSET     #F          ; Set next Page to 15
0x516:  4EC  CALL     0xFEC       ; Flow to 0xFEC
0x517:  5EF  CALZ     0xFEF       ; Flow to 0xFEF
0x518:  BA0  LD_X     0xA0        ; Set pointer to RAM 0xA0
0x519:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x51A:  E1A  LD_R_I   B, #10      ; Register B op with immediate #10
0x51B:  5EF  CALZ     0xFEF       ; Flow to 0xFEF
0x51C:  E01  LD_R_I   A, #1       ; Register A op with immediate #1
0x51D:  B7C  LD_X     0x7C        ; Set pointer to RAM 0x7C
0x51E:  DEF  CP_R_I   [X], #15    ; Register [X] op with immediate #15
0x51F:  721  JP_NZ    0xF21       ; Flow to 0xF21
0x520:  E08  LD_R_I   A, #8       ; Register A op with immediate #8
0x521:  E41  PSET     #1          ; Set next Page to 1
0x522:  4EC  CALL     0x1EC       ; Flow to 0x1EC
0x523:  BA0  LD_X     0xA0        ; Set pointer to RAM 0xA0
0x524:  EE2  LDPX_R               ; 
0x525:  B75  LD_X     0x75        ; Set pointer to RAM 0x75
0x526:  EE8  LDPX_R               ; 
0x527:  5ED  CALZ     0x1ED       ; Flow to 0x1ED
0x528:  5EF  CALZ     0x1EF       ; Flow to 0x1EF
0x529:  B7C  LD_X     0x7C        ; Set pointer to RAM 0x7C
0x52A:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x52B:  612  JP_Z     0x112       ; Flow to 0x112
0x52C:  E4F  PSET     #F          ; Set next Page to 15
0x52D:  400  CALL     0xF00       ; Flow to 0xF00
0x52E:  74A  JP_NZ    0xF4A       ; Flow to 0xF4A
0x52F:  E42  PSET     #2          ; Set next Page to 2
0x530:  4C3  CALL     0x2C3       ; Flow to 0x2C3
0x531:  FCA  PUSH_F               ; 
0x532:  FD1  POP_R                ; 
0x533:  B28  LD_X     0x28        ; Set pointer to RAM 0x28
0x534:  DE3  CP_R_I   [X], #3     ; Register [X] op with immediate #3
0x535:  DE5  CP_R_I   [X], #5     ; Register [X] op with immediate #5
0x536:  73A  JP_NZ    0x23A       ; Flow to 0x23A
0x537:  B29  LD_X     0x29        ; Set pointer to RAM 0x29
0x538:  DA5  FAN_R_I              ; 
0x539:  74D  JP_NZ    0x24D       ; Flow to 0x24D
0x53A:  D91  FAN_R_I              ; 
0x53B:  717  JP_NZ    0x217       ; Flow to 0x217
0x53C:  D92  FAN_R_I              ; 
0x53D:  743  JP_NZ    0x243       ; Flow to 0x243
0x53E:  5ED  CALZ     0x2ED       ; Flow to 0x2ED
0x53F:  540  CALZ     0x240       ; Flow to 0x240
0x540:  496  CALL     0x296       ; Flow to 0x296
0x541:  552  CALZ     0x252       ; Flow to 0x252
0x542:  028  JP       0x228       ; Flow to 0x228
0x543:  5F2  CALZ     0x2F2       ; Flow to 0x2F2
0x544:  BA0  LD_X     0xA0        ; Set pointer to RAM 0xA0
0x545:  EC8  LD_R_Q   [X], A      ; Register [X] op with A
0x546:  A80  ADD_R_Q  A, A        ; Register A op with A
0x547:  A95  ADC_R_Q  B, B        ; Register B op with B
0x548:  E47  PSET     #7          ; Set next Page to 7
0x549:  FE8  JPBA                 ; 
0x54A:  E43  PSET     #3          ; Set next Page to 3
0x54B:  407  CALL     0x307       ; Flow to 0x307
0x54C:  017  JP       0x317       ; Flow to 0x317
0x54D:  B7B  LD_X     0x7B        ; Set pointer to RAM 0x7B
0x54E:  D2F  XOR_R_I              ; 
0x54F:  E1F  LD_R_I   B, #15      ; Register B op with immediate #15
0x550:  897  LD_Y     0x97        ; Set pointer to RAM 0x97
0x551:  5C2  CALZ     0x3C2       ; Flow to 0x3C2
0x552:  017  JP       0x317       ; Flow to 0x317
0x553:  5BB  CALZ     0x3BB       ; Flow to 0x3BB
0x554:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x555:  5ED  CALZ     0x3ED       ; Flow to 0x3ED
0x556:  540  CALZ     0x340       ; Flow to 0x340
0x557:  5F5  CALZ     0x3F5       ; Flow to 0x3F5
0x558:  BE0  LD_X     0xE0        ; Set pointer to RAM 0xE0
0x559:  E0C  LD_R_I   A, #12      ; Register A op with immediate #12
0x55A:  E10  LD_R_I   B, #0       ; Register B op with immediate #0
0x55B:  E47  PSET     #7          ; Set next Page to 7
0x55C:  4A5  CALL     0x7A5       ; Flow to 0x7A5 (EXTRACT_HEART_COUNT)
0x55D:  E0D  LD_R_I   A, #13      ; Register A op with immediate #13
0x55E:  E10  LD_R_I   B, #0       ; Register B op with immediate #0
0x55F:  E47  PSET     #7          ; Set next Page to 7
0x560:  4A5  CALL     0x7A5       ; Flow to 0x7A5 (EXTRACT_HEART_COUNT)
0x561:  5EF  CALZ     0x7EF       ; Flow to 0x7EF
0x562:  B3C  LD_X     0x3C        ; Set pointer to RAM 0x3C
0x563:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0x564:  B10  LD_X     0x10        ; Set pointer to RAM 0x10
0x565:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x566:  B3F  LD_X     0x3F        ; Set pointer to RAM 0x3F
0x567:  E26  LD_R_I   [X], #6     ; Register [X] op with immediate #6
0x568:  491  CALL     0x791       ; Flow to 0x791
0x569:  521  CALZ     0x721       ; Flow to 0x721
0x56A:  DC0  CP_R_I   A, #0       ; Register A op with immediate #0
0x56B:  769  JP_NZ    0x769       ; Flow to 0x769
0x56C:  491  CALL     0x791       ; Flow to 0x791
0x56D:  521  CALZ     0x721       ; Flow to 0x721
0x56E:  DA1  FAN_R_I              ; 
0x56F:  786  JP_NZ    0x786       ; Flow to 0x786
0x570:  DA2  FAN_R_I              ; 
0x571:  676  JP_Z     0x776       ; Flow to 0x776
0x572:  5BB  CALZ     0x7BB       ; Flow to 0x7BB
0x573:  5E2  CALZ     0x7E2       ; Flow to 0x7E2
0x574:  B2E  LD_X     0x2E        ; Set pointer to RAM 0x2E
0x575:  E2F  LD_R_I   [X], #15    ; Register [X] op with immediate #15
0x576:  B29  LD_X     0x29        ; Set pointer to RAM 0x29
0x577:  DA4  FAN_R_I              ; 
0x578:  682  JP_Z     0x782       ; Flow to 0x782
0x579:  5BB  CALZ     0x7BB       ; Flow to 0x7BB
0x57A:  B14  LD_X     0x14        ; Set pointer to RAM 0x14
0x57B:  EE2  LDPX_R               ; 
0x57C:  EE6  LDPX_R               ; 
0x57D:  C91  AND_R_I  B, #1       ; Register B op with immediate #1
0x57E:  B14  LD_X     0x14        ; Set pointer to RAM 0x14
0x57F:  E41  PSET     #1          ; Set next Page to 1
0x580:  4F4  CALL     0x1F4       ; Flow to 0x1F4
0x581:  085  JP       0x185       ; Flow to 0x185
0x582:  B2E  LD_X     0x2E        ; Set pointer to RAM 0x2E
0x583:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x584:  66D  JP_Z     0x16D       ; Flow to 0x16D
0x585:  06C  JP       0x16C       ; Flow to 0x16C
0x586:  5BB  CALZ     0x1BB       ; Flow to 0x1BB
0x587:  B3F  LD_X     0x3F        ; Set pointer to RAM 0x3F
0x588:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0x589:  B15  LD_X     0x15        ; Set pointer to RAM 0x15
0x58A:  DE2  CP_R_I   [X], #2     ; Register [X] op with immediate #2
0x58B:  E49  PSET     #9          ; Set next Page to 9
0x58C:  37F  JP_NC    0x97F       ; Flow to 0x97F
0x58D:  B3C  LD_X     0x3C        ; Set pointer to RAM 0x3C
0x58E:  E2F  LD_R_I   [X], #15    ; Register [X] op with immediate #15
0x58F:  E42  PSET     #2          ; Set next Page to 2
0x590:  093  JP       0x293       ; Flow to 0x293
0x591:  5CE  CALZ     0x2CE       ; Flow to 0x2CE
0x592:  9C4  LBPX     #C4         ; Store constant #C4 into memory pointer
0x593:  4A6  CALL     0x2A6       ; Flow to 0x2A6
0x594:  556  CALZ     0x256       ; Flow to 0x256
0x595:  FDF  RET                  ; 
0x596:  5B3  CALZ     0x2B3       ; Flow to 0x2B3
0x597:  79E  JP_NZ    0x29E       ; Flow to 0x29E
0x598:  5FD  CALZ     0x2FD       ; Flow to 0x2FD
0x599:  79C  JP_NZ    0x29C       ; Flow to 0x29C
0x59A:  E01  LD_R_I   A, #1       ; Register A op with immediate #1
0x59B:  09F  JP       0x29F       ; Flow to 0x29F
0x59C:  E09  LD_R_I   A, #9       ; Register A op with immediate #9
0x59D:  09F  JP       0x29F       ; Flow to 0x29F
0x59E:  E03  LD_R_I   A, #3       ; Register A op with immediate #3
0x59F:  B5E  LD_X     0x5E        ; Set pointer to RAM 0x5E
0x5A0:  F08  CP_R_Q   [X], A      ; Register [X] op with A
0x5A1:  6A5  JP_Z     0x2A5       ; Flow to 0x2A5
0x5A2:  EC8  LD_R_Q   [X], A      ; Register [X] op with A
0x5A3:  E44  PSET     #4          ; Set next Page to 4
0x5A4:  465  CALL     0x465       ; Flow to 0x465 (MEM_WEIGHT)
0x5A5:  FDF  RET                  ; 
0x5A6:  5EF  CALZ     0x4EF       ; Flow to 0x4EF
0x5A7:  B2E  LD_X     0x2E        ; Set pointer to RAM 0x2E
0x5A8:  512  CALZ     0x412       ; Flow to 0x412 (MEM_HAPPY)
0x5A9:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0x5AA:  B10  LD_X     0x10        ; Set pointer to RAM 0x10
0x5AB:  EE2  LDPX_R               ; 
0x5AC:  F84  LD_MN_A  0x04        ; Direct RAM access at 0x04
0x5AD:  EE2  LDPX_R               ; 
0x5AE:  F85  LD_MN_A  0x05        ; Direct RAM access at 0x05
0x5AF:  EE2  LDPX_R               ; 
0x5B0:  F86  LD_MN_A  0x06        ; Direct RAM access at 0x06
0x5B1:  EE2  LDPX_R               ; 
0x5B2:  F87  LD_MN_A  0x07        ; Direct RAM access at 0x07
0x5B3:  EE2  LDPX_R               ; 
0x5B4:  EE6  LDPX_R               ; 
0x5B5:  509  CALZ     0x409       ; Flow to 0x409 (MEM_HUNGER)
0x5B6:  B08  LD_X     0x08        ; Set pointer to RAM 0x08
0x5B7:  4E3  CALL     0x4E3       ; Flow to 0x4E3
0x5B8:  B3A  LD_X     0x3A        ; Set pointer to RAM 0x3A
0x5B9:  EE2  LDPX_R               ; 
0x5BA:  E86  LD_XH_R              ; 
0x5BB:  E88  LD_XL_R              ; 
0x5BC:  5F5  CALZ     0x4F5       ; Flow to 0x4F5
0x5BD:  FA9  LD_A_MN  0x09        ; Direct RAM access at 0x09
0x5BE:  E8C  RRC                  ; 
0x5BF:  E8C  RRC                  ; 
0x5C0:  E8C  RRC                  ; 
0x5C1:  C81  AND_R_I  A, #1       ; Register A op with immediate #1
0x5C2:  CCA  OR_R_I   A, #10      ; Register A op with immediate #10
0x5C3:  E10  LD_R_I   B, #0       ; Register B op with immediate #0
0x5C4:  E47  PSET     #7          ; Set next Page to 7
0x5C5:  4A5  CALL     0x7A5       ; Flow to 0x7A5 (EXTRACT_HEART_COUNT)
0x5C6:  E47  PSET     #7          ; Set next Page to 7
0x5C7:  4B8  CALL     0x7B8       ; Flow to 0x7B8
0x5C8:  F5E  RST                  ; 
0x5C9:  A06  ADC_XH               ; 
0x5CA:  FA9  LD_A_MN  0x09        ; Direct RAM access at 0x09
0x5CB:  C83  AND_R_I  A, #3       ; Register A op with immediate #3
0x5CC:  7D0  JP_NZ    0x7D0       ; Flow to 0x7D0
0x5CD:  E47  PSET     #7          ; Set next Page to 7
0x5CE:  4BC  CALL     0x7BC       ; Flow to 0x7BC
0x5CF:  0D1  JP       0x7D1       ; Flow to 0x7D1
0x5D0:  4F3  CALL     0x7F3       ; Flow to 0x7F3
0x5D1:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x5D2:  FA8  LD_A_MN  0x08        ; Direct RAM access at 0x08
0x5D3:  4F3  CALL     0x7F3       ; Flow to 0x7F3
0x5D4:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x5D5:  922  LBPX     #22         ; Store constant #22 into memory pointer
0x5D6:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x5D7:  FA7  LD_A_MN  0x07        ; Direct RAM access at 0x07
0x5D8:  4F3  CALL     0x7F3       ; Flow to 0x7F3
0x5D9:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x5DA:  FA6  LD_A_MN  0x06        ; Direct RAM access at 0x06
0x5DB:  4F3  CALL     0x7F3       ; Flow to 0x7F3
0x5DC:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x5DD:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x5DE:  FA5  LD_A_MN  0x05        ; Direct RAM access at 0x05
0x5DF:  4EF  CALL     0x7EF       ; Flow to 0x7EF
0x5E0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x5E1:  FA4  LD_A_MN  0x04        ; Direct RAM access at 0x04
0x5E2:  0EF  JP       0x7EF       ; Flow to 0x7EF
0x5E3:  DD1  CP_R_I   B, #1       ; Register B op with immediate #1
0x5E4:  2E9  JP_C     0x7E9       ; Flow to 0x7E9
0x5E5:  7E8  JP_NZ    0x7E8       ; Flow to 0x7E8
0x5E6:  DC8  CP_R_I   A, #8       ; Register A op with immediate #8
0x5E7:  2E9  JP_C     0x7E9       ; Flow to 0x7E9
0x5E8:  100  RETD     0x00        ; Table lookup return from 0x00
0x5E9:  C06  ADD_R_I  A, #6       ; Register A op with immediate #6
0x5EA:  F80  LD_MN_A  0x00        ; Direct RAM access at 0x00
0x5EB:  C5E  ADC_R_I              ; 
0x5EC:  F91  LD_MN_B  0x01        ; Direct RAM access at 0x01
0x5ED:  E05  LD_R_I   A, #5       ; Register A op with immediate #5
0x5EE:  0FB  JP       0x7FB       ; Flow to 0x7FB
0x5EF:  E10  LD_R_I   B, #0       ; Register B op with immediate #0
0x5F0:  C0A  ADD_R_I  A, #10      ; Register A op with immediate #10
0x5F1:  C50  ADC_R_I              ; 
0x5F2:  0F4  JP       0x7F4       ; Flow to 0x7F4
0x5F3:  E10  LD_R_I   B, #0       ; Register B op with immediate #0
0x5F4:  A80  ADD_R_Q  A, A        ; Register A op with A
0x5F5:  A95  ADC_R_Q  B, B        ; Register B op with B
0x5F6:  A80  ADD_R_Q  A, A        ; Register A op with A
0x5F7:  A95  ADC_R_Q  B, B        ; Register B op with B
0x5F8:  F80  LD_MN_A  0x00        ; Direct RAM access at 0x00
0x5F9:  F91  LD_MN_B  0x01        ; Direct RAM access at 0x01
0x5FA:  E05  LD_R_I   A, #5       ; Register A op with immediate #5
0x5FB:  F82  LD_MN_A  0x02        ; Direct RAM access at 0x02
0x5FC:  E40  PSET     #0          ; Set next Page to 0
0x5FD:  000  JP       0x000       ; Flow to 0x000
0x5FE:  FFF  NOP7                 ; 
0x5FF:  FFF  NOP7                 ; 
0x600:  5B3  CALZ     0x0B3       ; Flow to 0x0B3
0x601:  71C  JP_NZ    0x01C       ; Flow to 0x01C
0x602:  5FB  CALZ     0x0FB       ; Flow to 0x0FB
0x603:  706  JP_NZ    0x006       ; Flow to 0x006
0x604:  E46  PSET     #6          ; Set next Page to 6
0x605:  01E  JP       0x61E       ; Flow to 0x61E
0x606:  CA7  AND_R_I  [X], #7     ; Register [X] op with immediate #7
0x607:  E08  LD_R_I   A, #8       ; Register A op with immediate #8
0x608:  E15  LD_R_I   B, #5       ; Register B op with immediate #5
0x609:  803  LD_Y     0x03        ; Set pointer to RAM 0x03
0x60A:  E48  PSET     #8          ; Set next Page to 8
0x60B:  4A9  CALL     0x8A9       ; Flow to 0x8A9
0x60C:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x60D:  E90  LD_YP_R              ; 
0x60E:  83B  LD_Y     0x3B        ; Set pointer to RAM 0x3B
0x60F:  5EF  CALZ     0x8EF       ; Flow to 0x8EF
0x610:  B48  LD_X     0x48        ; Set pointer to RAM 0x48 (MEM_SICK_LEVEL)
0x611:  CE8  OR_R_I   [X], #8     ; Register [X] op with immediate #8
0x612:  A8B  ADD_R_Q  [X], [Y]    ; Register [X] op with [Y]
0x613:  DA8  FAN_R_I              ; 
0x614:  71C  JP_NZ    0x81C       ; Flow to 0x81C
0x615:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x616:  E80  LD_XP_R              ; 
0x617:  B0D  LD_X     0x0D        ; Set pointer to RAM 0x0D
0x618:  838  LD_Y     0x38        ; Set pointer to RAM 0x38
0x619:  512  CALZ     0x812       ; Flow to 0x812
0x61A:  599  CALZ     0x899       ; Flow to 0x899
0x61B:  509  CALZ     0x809       ; Flow to 0x809
0x61C:  E45  PSET     #5          ; Set next Page to 5
0x61D:  01A  JP       0x51A       ; Flow to 0x51A (MEM_BEHAVIOR_MISTAKE)
0x61E:  E06  LD_R_I   A, #6       ; Register A op with immediate #6
0x61F:  E15  LD_R_I   B, #5       ; Register B op with immediate #5
0x620:  E48  PSET     #8          ; Set next Page to 8
0x621:  4A8  CALL     0x8A8       ; Flow to 0x8A8
0x622:  E45  PSET     #5          ; Set next Page to 5
0x623:  01A  JP       0x51A       ; Flow to 0x51A (MEM_BEHAVIOR_MISTAKE)
0x624:  5B3  CALZ     0x5B3       ; Flow to 0x5B3
0x625:  722  JP_NZ    0x522       ; Flow to 0x522
0x626:  5FB  CALZ     0x5FB       ; Flow to 0x5FB
0x627:  71E  JP_NZ    0x51E       ; Flow to 0x51E (MEM_BEHAVIOR_MISTAKE)
0x628:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x629:  E90  LD_YP_R              ; 
0x62A:  809  LD_Y     0x09        ; Set pointer to RAM 0x09
0x62B:  DF0  CP_R_I   [Y], #0     ; Register [Y] op with immediate #0
0x62C:  71E  JP_NZ    0x51E       ; Flow to 0x51E (MEM_BEHAVIOR_MISTAKE)
0x62D:  B5E  LD_X     0x5E        ; Set pointer to RAM 0x5E
0x62E:  E25  LD_R_I   [X], #5     ; Register [X] op with immediate #5
0x62F:  E44  PSET     #4          ; Set next Page to 4
0x630:  465  CALL     0x465       ; Flow to 0x465 (MEM_WEIGHT)
0x631:  540  CALZ     0x440       ; Flow to 0x440
0x632:  E44  PSET     #4          ; Set next Page to 4
0x633:  486  CALL     0x486       ; Flow to 0x486 (MEM_SICK_LEVEL)
0x634:  E44  PSET     #4          ; Set next Page to 4
0x635:  400  CALL     0x400       ; Flow to 0x400 (MEM_HUNGER)
0x636:  5EF  CALZ     0x4EF       ; Flow to 0x4EF
0x637:  B90  LD_X     0x90        ; Set pointer to RAM 0x90
0x638:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x639:  91C  LBPX     #1C         ; Store constant #1C into memory pointer
0x63A:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x63B:  91C  LBPX     #1C         ; Store constant #1C into memory pointer
0x63C:  91D  LBPX     #1D         ; Store constant #1D into memory pointer
0x63D:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x63E:  91D  LBPX     #1D         ; Store constant #1D into memory pointer
0x63F:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x640:  8D6  LD_Y     0xD6        ; Set pointer to RAM 0xD6
0x641:  5BC  CALZ     0x4BC       ; Flow to 0x4BC
0x642:  5DE  CALZ     0x4DE       ; Flow to 0x4DE (MEM_POOP)
0x643:  556  CALZ     0x456       ; Flow to 0x456
0x644:  B0D  LD_X     0x0D        ; Set pointer to RAM 0x0D
0x645:  53C  CALZ     0x43C       ; Flow to 0x43C (MEM_DISCIPLINE)
0x646:  E1C  LD_R_I   B, #12      ; Register B op with immediate #12
0x647:  E45  PSET     #5          ; Set next Page to 5
0x648:  400  CALL     0x500       ; Flow to 0x500 (MEM_CHARACTER)
0x649:  B82  LD_X     0x82        ; Set pointer to RAM 0x82
0x64A:  E65  LDPX_MX  #5          ; Store constant #5 into memory pointer
0x64B:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x64C:  5EF  CALZ     0x5EF       ; Flow to 0x5EF
0x64D:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x64E:  E90  LD_YP_R              ; 
0x64F:  B81  LD_X     0x81        ; Set pointer to RAM 0x81
0x650:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x651:  846  LD_Y     0x46        ; Set pointer to RAM 0x46 (MEM_WEIGHT)
0x652:  B80  LD_X     0x80        ; Set pointer to RAM 0x80
0x653:  EEB  LDPX_R               ; 
0x654:  B84  LD_X     0x84        ; Set pointer to RAM 0x84
0x655:  E28  LD_R_I   [X], #8     ; Register [X] op with immediate #8
0x656:  845  LD_Y     0x45        ; Set pointer to RAM 0x45
0x657:  EC3  LD_R_Q   A, [Y]      ; Register A op with [Y]
0x658:  E49  PSET     #9          ; Set next Page to 9
0x659:  400  CALL     0x900       ; Flow to 0x900
0x65A:  260  JP_C     0x960       ; Flow to 0x960
0x65B:  847  LD_Y     0x47        ; Set pointer to RAM 0x47
0x65C:  B80  LD_X     0x80        ; Set pointer to RAM 0x80
0x65D:  EEB  LDPX_R               ; 
0x65E:  B84  LD_X     0x84        ; Set pointer to RAM 0x84
0x65F:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0x660:  B5E  LD_X     0x5E        ; Set pointer to RAM 0x5E
0x661:  E25  LD_R_I   [X], #5     ; Register [X] op with immediate #5
0x662:  E44  PSET     #4          ; Set next Page to 4
0x663:  465  CALL     0x465       ; Flow to 0x465 (MEM_WEIGHT)
0x664:  521  CALZ     0x421       ; Flow to 0x421 (MEM_NEGLECT)
0x665:  B57  LD_X     0x57        ; Set pointer to RAM 0x57
0x666:  E2F  LD_R_I   [X], #15    ; Register [X] op with immediate #15
0x667:  897  LD_Y     0x97        ; Set pointer to RAM 0x97
0x668:  5BC  CALZ     0x4BC       ; Flow to 0x4BC
0x669:  540  CALZ     0x440       ; Flow to 0x440
0x66A:  E44  PSET     #4          ; Set next Page to 4
0x66B:  486  CALL     0x486       ; Flow to 0x486 (MEM_SICK_LEVEL)
0x66C:  4D4  CALL     0x4D4       ; Flow to 0x4D4 (MEM_POOP)
0x66D:  554  CALZ     0x454       ; Flow to 0x454
0x66E:  521  CALZ     0x421       ; Flow to 0x421 (MEM_NEGLECT)
0x66F:  DA1  FAN_R_I              ; 
0x670:  7C5  JP_NZ    0x4C5       ; Flow to 0x4C5
0x671:  B57  LD_X     0x57        ; Set pointer to RAM 0x57
0x672:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x673:  6C5  JP_Z     0x4C5       ; Flow to 0x4C5
0x674:  B81  LD_X     0x81        ; Set pointer to RAM 0x81
0x675:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x676:  77A  JP_NZ    0x47A       ; Flow to 0x47A
0x677:  D96  FAN_R_I              ; 
0x678:  667  JP_Z     0x467       ; Flow to 0x467 (MEM_WEIGHT)
0x679:  EC9  LD_R_Q   [X], B      ; Register [X] op with B
0x67A:  B80  LD_X     0x80        ; Set pointer to RAM 0x80
0x67B:  C2F  ADD_R_I  [X], #15    ; Register [X] op with immediate #15
0x67C:  767  JP_NZ    0x467       ; Flow to 0x467 (MEM_WEIGHT)
0x67D:  5BB  CALZ     0x4BB       ; Flow to 0x4BB
0x67E:  540  CALZ     0x440       ; Flow to 0x440
0x67F:  5EF  CALZ     0x4EF       ; Flow to 0x4EF
0x680:  B84  LD_X     0x84        ; Set pointer to RAM 0x84
0x681:  EC6  LD_R_Q   B, [X]      ; Register B op with [X]
0x682:  B81  LD_X     0x81        ; Set pointer to RAM 0x81
0x683:  DA4  FAN_R_I              ; 
0x684:  686  JP_Z     0x486       ; Flow to 0x486 (MEM_SICK_LEVEL)
0x685:  D18  XOR_R_I              ; 
0x686:  B3A  LD_X     0x3A        ; Set pointer to RAM 0x3A
0x687:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x688:  E43  PSET     #3          ; Set next Page to 3
0x689:  4EE  CALL     0x3EE       ; Flow to 0x3EE
0x68A:  4D4  CALL     0x3D4       ; Flow to 0x3D4
0x68B:  554  CALZ     0x354       ; Flow to 0x354
0x68C:  B29  LD_X     0x29        ; Set pointer to RAM 0x29
0x68D:  53C  CALZ     0x33C       ; Flow to 0x33C
0x68E:  5EF  CALZ     0x3EF       ; Flow to 0x3EF
0x68F:  B84  LD_X     0x84        ; Set pointer to RAM 0x84
0x690:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x691:  696  JP_Z     0x396       ; Flow to 0x396
0x692:  B83  LD_X     0x83        ; Set pointer to RAM 0x83
0x693:  C21  ADD_R_I  [X], #1     ; Register [X] op with immediate #1
0x694:  4C8  CALL     0x3C8       ; Flow to 0x3C8
0x695:  097  JP       0x397       ; Flow to 0x397
0x696:  4CD  CALL     0x3CD       ; Flow to 0x3CD
0x697:  5EF  CALZ     0x3EF       ; Flow to 0x3EF
0x698:  B82  LD_X     0x82        ; Set pointer to RAM 0x82
0x699:  C2F  ADD_R_I  [X], #15    ; Register [X] op with immediate #15
0x69A:  74C  JP_NZ    0x34C       ; Flow to 0x34C
0x69B:  B90  LD_X     0x90        ; Set pointer to RAM 0x90
0x69C:  E4C  PSET     #C          ; Set next Page to 12
0x69D:  4F5  CALL     0xCF5       ; Flow to 0xCF5
0x69E:  B83  LD_X     0x83        ; Set pointer to RAM 0x83
0x69F:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x6A0:  B98  LD_X     0x98        ; Set pointer to RAM 0x98
0x6A1:  EC8  LD_R_Q   [X], A      ; Register [X] op with A
0x6A2:  E15  LD_R_I   B, #5       ; Register B op with immediate #5
0x6A3:  AA4  SUB      B, A        ; Register B op with A
0x6A4:  B9C  LD_X     0x9C        ; Set pointer to RAM 0x9C
0x6A5:  EC9  LD_R_Q   [X], B      ; Register [X] op with B
0x6A6:  8E5  LD_Y     0xE5        ; Set pointer to RAM 0xE5
0x6A7:  5BC  CALZ     0xCBC       ; Flow to 0xCBC
0x6A8:  5DE  CALZ     0xCDE       ; Flow to 0xCDE
0x6A9:  556  CALZ     0xC56       ; Flow to 0xC56
0x6AA:  B52  LD_X     0x52        ; Set pointer to RAM 0x52
0x6AB:  53C  CALZ     0xC3C       ; Flow to 0xC3C
0x6AC:  5EF  CALZ     0xCEF       ; Flow to 0xCEF
0x6AD:  B83  LD_X     0x83        ; Set pointer to RAM 0x83
0x6AE:  DE3  CP_R_I   [X], #3     ; Register [X] op with immediate #3
0x6AF:  2B5  JP_C     0xCB5       ; Flow to 0xCB5
0x6B0:  B41  LD_X     0x41        ; Set pointer to RAM 0x41 (MEM_HAPPY)
0x6B1:  E4C  PSET     #C          ; Set next Page to 12
0x6B2:  4E5  CALL     0xCE5       ; Flow to 0xCE5
0x6B3:  4C8  CALL     0xCC8       ; Flow to 0xCC8
0x6B4:  0B6  JP       0xCB6       ; Flow to 0xCB6
0x6B5:  4CD  CALL     0xCCD       ; Flow to 0xCCD
0x6B6:  5EF  CALZ     0xCEF       ; Flow to 0xCEF
0x6B7:  B46  LD_X     0x46        ; Set pointer to RAM 0x46 (MEM_WEIGHT)
0x6B8:  F44  SET                  ; 
0x6B9:  C29  ADD_R_I  [X], #9     ; Register [X] op with immediate #9
0x6BA:  EE0  INC_X                ; 
0x6BB:  C69  ADC_R_I              ; 
0x6BC:  F5B  RST                  ; 
0x6BD:  E46  PSET     #6          ; Set next Page to 6
0x6BE:  4E5  CALL     0x6E5       ; Flow to 0x6E5
0x6BF:  B29  LD_X     0x29        ; Set pointer to RAM 0x29
0x6C0:  DA1  FAN_R_I              ; 
0x6C1:  7C5  JP_NZ    0x6C5       ; Flow to 0x6C5
0x6C2:  E4F  PSET     #F          ; Set next Page to 15
0x6C3:  400  CALL     0xF00       ; Flow to 0xF00
0x6C4:  626  JP_Z     0xF26       ; Flow to 0xF26
0x6C5:  5BB  CALZ     0xFBB       ; Flow to 0xFBB
0x6C6:  E45  PSET     #5          ; Set next Page to 5
0x6C7:  017  JP       0x517       ; Flow to 0x517 (MEM_BEHAVIOR_MISTAKE)
0x6C8:  883  LD_Y     0x83        ; Set pointer to RAM 0x83
0x6C9:  5BC  CALZ     0x5BC       ; Flow to 0x5BC
0x6CA:  E07  LD_R_I   A, #7       ; Register A op with immediate #7
0x6CB:  806  LD_Y     0x06        ; Set pointer to RAM 0x06
0x6CC:  0D1  JP       0x5D1       ; Flow to 0x5D1 (MEM_LIFECYCLE)
0x6CD:  89E  LD_Y     0x9E        ; Set pointer to RAM 0x9E
0x6CE:  5BC  CALZ     0x5BC       ; Flow to 0x5BC
0x6CF:  E08  LD_R_I   A, #8       ; Register A op with immediate #8
0x6D0:  803  LD_Y     0x03        ; Set pointer to RAM 0x03
0x6D1:  E15  LD_R_I   B, #5       ; Register B op with immediate #5
0x6D2:  E48  PSET     #8          ; Set next Page to 8
0x6D3:  0A9  JP       0x8A9       ; Flow to 0x8A9
0x6D4:  5EF  CALZ     0x8EF       ; Flow to 0x8EF
0x6D5:  B81  LD_X     0x81        ; Set pointer to RAM 0x81
0x6D6:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x6D7:  6E4  JP_Z     0x8E4       ; Flow to 0x8E4
0x6D8:  EC6  LD_R_Q   B, [X]      ; Register B op with [X]
0x6D9:  BB0  LD_X     0xB0        ; Set pointer to RAM 0xB0
0x6DA:  E07  LD_R_I   A, #7       ; Register A op with immediate #7
0x6DB:  D94  FAN_R_I              ; 
0x6DC:  6DF  JP_Z     0x8DF       ; Flow to 0x8DF
0x6DD:  B80  LD_X     0x80        ; Set pointer to RAM 0x80
0x6DE:  E06  LD_R_I   A, #6       ; Register A op with immediate #6
0x6DF:  E11  LD_R_I   B, #1       ; Register B op with immediate #1
0x6E0:  E81  LD_XP_R              ; 
0x6E1:  E12  LD_R_I   B, #2       ; Register B op with immediate #2
0x6E2:  E47  PSET     #7          ; Set next Page to 7
0x6E3:  4A5  CALL     0x7A5       ; Flow to 0x7A5 (EXTRACT_HEART_COUNT)
0x6E4:  FDF  RET                  ; 
0x6E5:  5EF  CALZ     0x7EF       ; Flow to 0x7EF
0x6E6:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x6E7:  E90  LD_YP_R              ; 
0x6E8:  83D  LD_Y     0x3D        ; Set pointer to RAM 0x3D
0x6E9:  4F6  CALL     0x7F6       ; Flow to 0x7F6
0x6EA:  2F0  JP_C     0x7F0       ; Flow to 0x7F0
0x6EB:  83F  LD_Y     0x3F        ; Set pointer to RAM 0x3F
0x6EC:  4F6  CALL     0x7F6       ; Flow to 0x7F6
0x6ED:  2F5  JP_C     0x7F5       ; Flow to 0x7F5
0x6EE:  83E  LD_Y     0x3E        ; Set pointer to RAM 0x3E
0x6EF:  0F1  JP       0x7F1       ; Flow to 0x7F1
0x6F0:  83C  LD_Y     0x3C        ; Set pointer to RAM 0x3C
0x6F1:  B46  LD_X     0x46        ; Set pointer to RAM 0x46 (MEM_WEIGHT)
0x6F2:  512  CALZ     0x712       ; Flow to 0x712
0x6F3:  59B  CALZ     0x79B       ; Flow to 0x79B
0x6F4:  509  CALZ     0x709       ; Flow to 0x709
0x6F5:  FDF  RET                  ; 
0x6F6:  B47  LD_X     0x47        ; Set pointer to RAM 0x47
0x6F7:  F0B  CP_R_Q   [X], [Y]    ; Register [X] op with [Y]
0x6F8:  2FD  JP_C     0x7FD       ; Flow to 0x7FD
0x6F9:  7FD  JP_NZ    0x7FD       ; Flow to 0x7FD
0x6FA:  B46  LD_X     0x46        ; Set pointer to RAM 0x46 (MEM_WEIGHT)
0x6FB:  A3F  ADC_YL               ; 
0x6FC:  F0B  CP_R_Q   [X], [Y]    ; Register [X] op with [Y]
0x6FD:  FDF  RET                  ; 
0x6FE:  FFF  NOP7                 ; 
0x6FF:  FFF  NOP7                 ; 
0x700:  E44  PSET     #4          ; Set next Page to 4
0x701:  0E7  JP       0x4E7       ; Flow to 0x4E7
0x702:  E47  PSET     #7          ; Set next Page to 7
0x703:  010  JP       0x710       ; Flow to 0x710
0x704:  E4A  PSET     #A          ; Set next Page to 10
0x705:  0BE  JP       0xABE       ; Flow to 0xABE
0x706:  E46  PSET     #6          ; Set next Page to 6
0x707:  024  JP       0x624       ; Flow to 0x624
0x708:  E46  PSET     #6          ; Set next Page to 6
0x709:  000  JP       0x600       ; Flow to 0x600
0x70A:  E4D  PSET     #D          ; Set next Page to 13
0x70B:  07E  JP       0xD7E       ; Flow to 0xD7E
0x70C:  E48  PSET     #8          ; Set next Page to 8
0x70D:  014  JP       0x814       ; Flow to 0x814
0x70E:  E4A  PSET     #A          ; Set next Page to 10
0x70F:  0DA  JP       0xADA       ; Flow to 0xADA
0x710:  5B3  CALZ     0xAB3       ; Flow to 0xAB3
0x711:  720  JP_NZ    0xA20       ; Flow to 0xA20
0x712:  5EF  CALZ     0xAEF       ; Flow to 0xAEF
0x713:  B73  LD_X     0x73        ; Set pointer to RAM 0x73
0x714:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x715:  B78  LD_X     0x78        ; Set pointer to RAM 0x78
0x716:  EC8  LD_R_Q   [X], A      ; Register [X] op with A
0x717:  B90  LD_X     0x90        ; Set pointer to RAM 0x90
0x718:  E4B  PSET     #B          ; Set next Page to 11
0x719:  4E8  CALL     0xBE8       ; Flow to 0xBE8
0x71A:  E1A  LD_R_I   B, #10      ; Register B op with immediate #10
0x71B:  E4E  PSET     #E          ; Set next Page to 14
0x71C:  45A  CALL     0xE5A       ; Flow to 0xE5A
0x71D:  322  JP_NC    0xE22       ; Flow to 0xE22
0x71E:  E45  PSET     #5          ; Set next Page to 5
0x71F:  717  JP_NZ    0x517       ; Flow to 0x517 (MEM_BEHAVIOR_MISTAKE)
0x720:  E45  PSET     #5          ; Set next Page to 5
0x721:  01A  JP       0x51A       ; Flow to 0x51A (MEM_BEHAVIOR_MISTAKE)
0x722:  5F2  CALZ     0x5F2       ; Flow to 0x5F2
0x723:  B73  LD_X     0x73        ; Set pointer to RAM 0x73
0x724:  EE8  LDPX_R               ; 
0x725:  DC0  CP_R_I   A, #0       ; Register A op with immediate #0
0x726:  739  JP_NZ    0x539       ; Flow to 0x539
0x727:  80C  LD_Y     0x0C        ; Set pointer to RAM 0x0C
0x728:  5FD  CALZ     0x5FD       ; Flow to 0x5FD
0x729:  751  JP_NZ    0x551       ; Flow to 0x551
0x72A:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x72B:  E80  LD_XP_R              ; 
0x72C:  B09  LD_X     0x09        ; Set pointer to RAM 0x09
0x72D:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x72E:  751  JP_NZ    0x551       ; Flow to 0x551
0x72F:  5EF  CALZ     0x5EF       ; Flow to 0x5EF
0x730:  B40  LD_X     0x40        ; Set pointer to RAM 0x40 (MEM_HUNGER)
0x731:  DEF  CP_R_I   [X], #15    ; Register [X] op with immediate #15
0x732:  651  JP_Z     0x551       ; Flow to 0x551
0x733:  E4C  PSET     #C          ; Set next Page to 12
0x734:  4E5  CALL     0xCE5       ; Flow to 0xCE5
0x735:  E01  LD_R_I   A, #1       ; Register A op with immediate #1
0x736:  456  CALL     0xC56       ; Flow to 0xC56
0x737:  808  LD_Y     0x08        ; Set pointer to RAM 0x08
0x738:  049  JP       0xC49       ; Flow to 0xC49
0x739:  B41  LD_X     0x41        ; Set pointer to RAM 0x41 (MEM_HAPPY)
0x73A:  E4C  PSET     #C          ; Set next Page to 12
0x73B:  4E5  CALL     0xCE5       ; Flow to 0xCE5
0x73C:  5FD  CALZ     0xCFD       ; Flow to 0xCFD
0x73D:  746  JP_NZ    0xC46       ; Flow to 0xC46
0x73E:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x73F:  E80  LD_XP_R              ; 
0x740:  B0D  LD_X     0x0D        ; Set pointer to RAM 0x0D
0x741:  512  CALZ     0xC12       ; Flow to 0xC12
0x742:  E4C  PSET     #C          ; Set next Page to 12
0x743:  4C8  CALL     0xCC8       ; Flow to 0xCC8
0x744:  509  CALZ     0xC09       ; Flow to 0xC09
0x745:  5EF  CALZ     0xCEF       ; Flow to 0xCEF
0x746:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x747:  456  CALL     0xC56       ; Flow to 0xC56
0x748:  80A  LD_Y     0x0A        ; Set pointer to RAM 0x0A
0x749:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x74A:  E80  LD_XP_R              ; 
0x74B:  B48  LD_X     0x48        ; Set pointer to RAM 0x48 (MEM_SICK_LEVEL)
0x74C:  DA1  FAN_R_I              ; 
0x74D:  64F  JP_Z     0xC4F       ; Flow to 0xC4F
0x74E:  EF0  INC_Y                ; 
0x74F:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x750:  052  JP       0xC52       ; Flow to 0xC52
0x751:  E06  LD_R_I   A, #6       ; Register A op with immediate #6
0x752:  E15  LD_R_I   B, #5       ; Register B op with immediate #5
0x753:  E48  PSET     #8          ; Set next Page to 8
0x754:  4A9  CALL     0x8A9       ; Flow to 0x8A9
0x755:  012  JP       0x812       ; Flow to 0x812
0x756:  F44  SET                  ; 
0x757:  B46  LD_X     0x46        ; Set pointer to RAM 0x46 (MEM_WEIGHT)
0x758:  A88  ADD_R_Q  [X], A      ; Register [X] op with A
0x759:  EE0  INC_X                ; 
0x75A:  C60  ADC_R_I              ; 
0x75B:  35E  JP_NC    0x85E       ; Flow to 0x85E
0x75C:  B46  LD_X     0x46        ; Set pointer to RAM 0x46 (MEM_WEIGHT)
0x75D:  999  LBPX     #99         ; Store constant #99 into memory pointer
0x75E:  F5B  RST                  ; 
0x75F:  E46  PSET     #6          ; Set next Page to 6
0x760:  0E5  JP       0x6E5       ; Flow to 0x6E5
0x761:  5EF  CALZ     0x6EF       ; Flow to 0x6EF
0x762:  B5D  LD_X     0x5D        ; Set pointer to RAM 0x5D (MEM_LIFECYCLE)
0x763:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x764:  B73  LD_X     0x73        ; Set pointer to RAM 0x73
0x765:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x766:  B40  LD_X     0x40        ; Set pointer to RAM 0x40 (MEM_HUNGER)
0x767:  E61  LDPX_MX  #1          ; Store constant #1 into memory pointer
0x768:  E61  LDPX_MX  #1          ; Store constant #1 into memory pointer
0x769:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x76A:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x76B:  B46  LD_X     0x46        ; Set pointer to RAM 0x46 (MEM_WEIGHT)
0x76C:  905  LBPX     #5          ; Store constant #5 into memory pointer
0x76D:  B54  LD_X     0x54        ; Set pointer to RAM 0x54 (MEM_AGE)
0x76E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x76F:  B48  LD_X     0x48        ; Set pointer to RAM 0x48 (MEM_SICK_LEVEL)
0x770:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x771:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x772:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x773:  E6F  LDPX_MX  #F          ; Store constant #F into memory pointer
0x774:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x775:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x776:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x777:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x778:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x779:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x77A:  B5C  LD_X     0x5C        ; Set pointer to RAM 0x5C
0x77B:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x77C:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x77D:  E80  LD_XP_R              ; 
0x77E:  B00  LD_X     0x00        ; Set pointer to RAM 0x00
0x77F:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x780:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x781:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x782:  90F  LBPX     #F          ; Store constant #F into memory pointer
0x783:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x784:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x785:  512  CALZ     0x612       ; Flow to 0x612
0x786:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x787:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x788:  509  CALZ     0x609       ; Flow to 0x609
0x789:  B0F  LD_X     0x0F        ; Set pointer to RAM 0x0F
0x78A:  E6F  LDPX_MX  #F          ; Store constant #F into memory pointer
0x78B:  B12  LD_X     0x12        ; Set pointer to RAM 0x12
0x78C:  E6F  LDPX_MX  #F          ; Store constant #F into memory pointer
0x78D:  B15  LD_X     0x15        ; Set pointer to RAM 0x15
0x78E:  E65  LDPX_MX  #5          ; Store constant #5 into memory pointer
0x78F:  B16  LD_X     0x16        ; Set pointer to RAM 0x16
0x790:  928  LBPX     #28         ; Store constant #28 into memory pointer
0x791:  FDF  RET                  ; 
0x792:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x793:  E90  LD_YP_R              ; 
0x794:  5F5  CALZ     0x6F5       ; Flow to 0x6F5
0x795:  83A  LD_Y     0x3A        ; Set pointer to RAM 0x3A
0x796:  E8B  LD_XL_R              ; 
0x797:  EF0  INC_Y                ; 
0x798:  E87  LD_XH_R              ; 
0x799:  890  LD_Y     0x90        ; Set pointer to RAM 0x90
0x79A:  4A3  CALL     0x6A3       ; Flow to 0x6A3
0x79B:  4A3  CALL     0x6A3       ; Flow to 0x6A3
0x79C:  4A3  CALL     0x6A3       ; Flow to 0x6A3
0x79D:  4A3  CALL     0x6A3       ; Flow to 0x6A3
0x79E:  F5E  RST                  ; 
0x79F:  A04  ADC_XH               ; 
0x7A0:  4A3  CALL     0x6A3       ; Flow to 0x6A3
0x7A1:  4A3  CALL     0x6A3       ; Flow to 0x6A3
0x7A2:  4A3  CALL     0x6A3       ; Flow to 0x6A3
0x7A3:  EF3  LDPY_R               ; 
0x7A4:  EF7  LDPY_R               ; 

; =========================================================
; ROUTINE: EXTRACT_HEART_COUNT
; Location: 0x7A5 (Page 7, Step A5)
; Trigger:  Drawing status screen or checking neglect
; Logic:    Converts raw level nibble (0-F) to heart count (0-4)
; =========================================================

0x7A5:  FC1  PUSH_R               ; 
0x7A6:  E10  LD_R_I   B, #0       ; Register B op with immediate #0
0x7A7:  E8C  RRC                  ; 
0x7A8:  E8D  RRC                  ; 
0x7A9:  F90  LD_MN_B  0x00        ; Direct RAM access at 0x00
0x7AA:  FD1  POP_R                ; 
0x7AB:  DD4  CP_R_I   B, #4       ; Register B op with immediate #4
0x7AC:  E47  PSET     #7          ; Set next Page to 7
0x7AD:  3B8  JP_NC    0x7B8       ; Flow to 0x7B8
0x7AE:  A80  ADD_R_Q  A, A        ; Register A op with A
0x7AF:  F5E  RST                  ; 
0x7B0:  E8D  RRC                  ; 
0x7B1:  E8C  RRC                  ; 
0x7B2:  C00  ADD_R_I  A, #0       ; Register A op with immediate #0
0x7B3:  C56  ADC_R_I              ; 
0x7B4:  F81  LD_MN_A  0x01        ; Direct RAM access at 0x01
0x7B5:  F92  LD_MN_B  0x02        ; Direct RAM access at 0x02
0x7B6:  E40  PSET     #0          ; Set next Page to 0
0x7B7:  000  JP       0x000       ; Flow to 0x000
0x7B8:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x7B9:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x7BA:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x7BB:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x7BC:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x7BD:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x7BE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x7BF:  100  RETD     0x00        ; Table lookup return from 0x00
0x7C0:  5F2  CALZ     0x0F2       ; Flow to 0x0F2
0x7C1:  B2C  LD_X     0x2C        ; Set pointer to RAM 0x2C
0x7C2:  4D5  CALL     0x0D5       ; Flow to 0x0D5
0x7C3:  5B3  CALZ     0x0B3       ; Flow to 0x0B3
0x7C4:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0x7C5:  E80  LD_XP_R              ; 
0x7C6:  6CB  JP_Z     0x0CB       ; Flow to 0x0CB
0x7C7:  B05  LD_X     0x05        ; Set pointer to RAM 0x05
0x7C8:  DE4  CP_R_I   [X], #4     ; Register [X] op with immediate #4
0x7C9:  2D1  JP_C     0x0D1       ; Flow to 0x0D1
0x7CA:  0E1  JP       0x0E1       ; Flow to 0x0E1
0x7CB:  B08  LD_X     0x08        ; Set pointer to RAM 0x08
0x7CC:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x7CD:  7D1  JP_NZ    0x0D1       ; Flow to 0x0D1
0x7CE:  B09  LD_X     0x09        ; Set pointer to RAM 0x09
0x7CF:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x7D0:  6E1  JP_Z     0x0E1       ; Flow to 0x0E1
0x7D1:  5EF  CALZ     0x0EF       ; Flow to 0x0EF
0x7D2:  B2D  LD_X     0x2D        ; Set pointer to RAM 0x2D (MEM_ATTENTION)
0x7D3:  CE8  OR_R_I   [X], #8     ; Register [X] op with immediate #8
0x7D4:  0E1  JP       0x0E1       ; Flow to 0x0E1
0x7D5:  C08  ADD_R_I  A, #8       ; Register A op with immediate #8
0x7D6:  C5D  ADC_R_I              ; 
0x7D7:  FE8  JPBA                 ; 
0x7D8:  100  RETD     0x00        ; Table lookup return from 0x00
0x7D9:  101  RETD     0x01        ; Table lookup return from 0x01
0x7DA:  102  RETD     0x02        ; Table lookup return from 0x02
0x7DB:  104  RETD     0x04        ; Table lookup return from 0x04
0x7DC:  108  RETD     0x08        ; Table lookup return from 0x08
0x7DD:  110  RETD     0x10        ; Table lookup return from 0x10
0x7DE:  120  RETD     0x20        ; Table lookup return from 0x20
0x7DF:  140  RETD     0x40        ; Table lookup return from 0x40 (MEM_HUNGER)
0x7E0:  180  RETD     0x80        ; Table lookup return from 0x80
0x7E1:  E0E  LD_R_I   A, #14      ; Register A op with immediate #14
0x7E2:  E80  LD_XP_R              ; 
0x7E3:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x7E4:  E90  LD_YP_R              ; 
0x7E5:  82C  LD_Y     0x2C        ; Set pointer to RAM 0x2C
0x7E6:  EF3  LDPY_R               ; 
0x7E7:  EC7  LD_R_Q   B, [Y]      ; Register B op with [Y]
0x7E8:  B10  LD_X     0x10        ; Set pointer to RAM 0x10
0x7E9:  EC8  LD_R_Q   [X], A      ; Register [X] op with A
0x7EA:  E8C  RRC                  ; 
0x7EB:  B22  LD_X     0x22        ; Set pointer to RAM 0x22
0x7EC:  EC8  LD_R_Q   [X], A      ; Register [X] op with A
0x7ED:  E8C  RRC                  ; 
0x7EE:  B24  LD_X     0x24        ; Set pointer to RAM 0x24
0x7EF:  EC8  LD_R_Q   [X], A      ; Register [X] op with A
0x7F0:  E8C  RRC                  ; 
0x7F1:  B26  LD_X     0x26        ; Set pointer to RAM 0x26
0x7F2:  EC8  LD_R_Q   [X], A      ; Register [X] op with A
0x7F3:  BB9  LD_X     0xB9        ; Set pointer to RAM 0xB9
0x7F4:  EC9  LD_R_Q   [X], B      ; Register [X] op with B
0x7F5:  AF5  RLC                  ; 
0x7F6:  BCB  LD_X     0xCB        ; Set pointer to RAM 0xCB
0x7F7:  EC9  LD_R_Q   [X], B      ; Register [X] op with B
0x7F8:  AF5  RLC                  ; 
0x7F9:  BCD  LD_X     0xCD        ; Set pointer to RAM 0xCD
0x7FA:  EC9  LD_R_Q   [X], B      ; Register [X] op with B
0x7FB:  AF5  RLC                  ; 
0x7FC:  BCF  LD_X     0xCF        ; Set pointer to RAM 0xCF
0x7FD:  EC9  LD_R_Q   [X], B      ; Register [X] op with B
0x7FE:  FDF  RET                  ; 
0x7FF:  FFF  NOP7                 ; 
0x800:  120  RETD     0x20        ; Table lookup return from 0x20
0x801:  108  RETD     0x08        ; Table lookup return from 0x08
0x802:  101  RETD     0x01        ; Table lookup return from 0x01
0x803:  140  RETD     0x40        ; Table lookup return from 0x40 (MEM_HUNGER)
0x804:  102  RETD     0x02        ; Table lookup return from 0x02
0x805:  180  RETD     0x80        ; Table lookup return from 0x80
0x806:  110  RETD     0x10        ; Table lookup return from 0x10
0x807:  104  RETD     0x04        ; Table lookup return from 0x04
0x808:  D88  FAN_R_I              ; 
0x809:  60B  JP_Z     0x00B       ; Flow to 0x00B
0x80A:  100  RETD     0x00        ; Table lookup return from 0x00
0x80B:  E10  LD_R_I   B, #0       ; Register B op with immediate #0
0x80C:  FE8  JPBA                 ; 
0x80D:  E11  LD_R_I   B, #1       ; Register B op with immediate #1
0x80E:  E81  LD_XP_R              ; 
0x80F:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x810:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x811:  C0F  ADD_R_I  A, #15      ; Register A op with immediate #15
0x812:  70F  JP_NZ    0x00F       ; Flow to 0x00F
0x813:  FDF  RET                  ; 
0x814:  5EF  CALZ     0x0EF       ; Flow to 0x0EF
0x815:  B80  LD_X     0x80        ; Set pointer to RAM 0x80
0x816:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0x817:  436  CALL     0x036       ; Flow to 0x036
0x818:  5DE  CALZ     0x0DE       ; Flow to 0x0DE
0x819:  5EF  CALZ     0x0EF       ; Flow to 0x0EF
0x81A:  B81  LD_X     0x81        ; Set pointer to RAM 0x81
0x81B:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x81C:  61E  JP_Z     0x01E       ; Flow to 0x01E
0x81D:  467  CALL     0x067       ; Flow to 0x067
0x81E:  556  CALZ     0x056       ; Flow to 0x056
0x81F:  521  CALZ     0x021       ; Flow to 0x021
0x820:  B57  LD_X     0x57        ; Set pointer to RAM 0x57
0x821:  E2F  LD_R_I   [X], #15    ; Register [X] op with immediate #15
0x822:  521  CALZ     0x021       ; Flow to 0x021
0x823:  B57  LD_X     0x57        ; Set pointer to RAM 0x57
0x824:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x825:  633  JP_Z     0x033       ; Flow to 0x033
0x826:  D91  FAN_R_I              ; 
0x827:  733  JP_NZ    0x033       ; Flow to 0x033
0x828:  D96  FAN_R_I              ; 
0x829:  622  JP_Z     0x022       ; Flow to 0x022
0x82A:  5BB  CALZ     0x0BB       ; Flow to 0x0BB
0x82B:  B80  LD_X     0x80        ; Set pointer to RAM 0x80
0x82C:  C21  ADD_R_I  [X], #1     ; Register [X] op with immediate #1
0x82D:  DE4  CP_R_I   [X], #4     ; Register [X] op with immediate #4
0x82E:  230  JP_C     0x030       ; Flow to 0x030
0x82F:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0x830:  E4F  PSET     #F          ; Set next Page to 15
0x831:  400  CALL     0xF00       ; Flow to 0xF00
0x832:  617  JP_Z     0xF17       ; Flow to 0xF17
0x833:  5BB  CALZ     0xFBB       ; Flow to 0xFBB
0x834:  E45  PSET     #5          ; Set next Page to 5
0x835:  01A  JP       0x51A       ; Flow to 0x51A (MEM_BEHAVIOR_MISTAKE)
0x836:  5F2  CALZ     0x5F2       ; Flow to 0x5F2
0x837:  E91  LD_YP_R              ; 
0x838:  B80  LD_X     0x80        ; Set pointer to RAM 0x80
0x839:  EE2  LDPX_R               ; 
0x83A:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x83B:  C0F  ADD_R_I  A, #15      ; Register A op with immediate #15
0x83C:  C53  ADC_R_I              ; 
0x83D:  B90  LD_X     0x90        ; Set pointer to RAM 0x90
0x83E:  FE8  JPBA                 ; 
0x83F:  043  JP       0x543       ; Flow to 0x543 (MEM_AGE)
0x840:  05C  JP       0x55C       ; Flow to 0x55C
0x841:  083  JP       0x583       ; Flow to 0x583
0x842:  089  JP       0x589       ; Flow to 0x589
0x843:  918  LBPX     #18         ; Store constant #18 into memory pointer
0x844:  855  LD_Y     0x55        ; Set pointer to RAM 0x55
0x845:  EEB  LDPX_R               ; 
0x846:  E10  LD_R_I   B, #0       ; Register B op with immediate #0
0x847:  DF0  CP_R_I   [Y], #0     ; Register [Y] op with immediate #0
0x848:  74A  JP_NZ    0x54A       ; Flow to 0x54A (MEM_AGE)
0x849:  E1F  LD_R_I   B, #15      ; Register B op with immediate #15
0x84A:  EE9  LDPX_R               ; 
0x84B:  854  LD_Y     0x54        ; Set pointer to RAM 0x54 (MEM_AGE)
0x84C:  EEB  LDPX_R               ; 
0x84D:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x84E:  919  LBPX     #19         ; Store constant #19 into memory pointer
0x84F:  91A  LBPX     #1A         ; Store constant #1A into memory pointer
0x850:  847  LD_Y     0x47        ; Set pointer to RAM 0x47
0x851:  EEB  LDPX_R               ; 
0x852:  E10  LD_R_I   B, #0       ; Register B op with immediate #0
0x853:  DF0  CP_R_I   [Y], #0     ; Register [Y] op with immediate #0
0x854:  756  JP_NZ    0x556       ; Flow to 0x556
0x855:  E1F  LD_R_I   B, #15      ; Register B op with immediate #15
0x856:  EE9  LDPX_R               ; 
0x857:  846  LD_Y     0x46        ; Set pointer to RAM 0x46 (MEM_WEIGHT)
0x858:  EEB  LDPX_R               ; 
0x859:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x85A:  91B  LBPX     #1B         ; Store constant #1B into memory pointer
0x85B:  FDF  RET                  ; 
0x85C:  934  LBPX     #34         ; Store constant #34 into memory pointer
0x85D:  935  LBPX     #35         ; Store constant #35 into memory pointer
0x85E:  936  LBPX     #36         ; Store constant #36 into memory pointer
0x85F:  937  LBPX     #37         ; Store constant #37 into memory pointer
0x860:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x861:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x862:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x863:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x864:  881  LD_Y     0x81        ; Set pointer to RAM 0x81
0x865:  E31  LD_R_I   [Y], #1     ; Register [Y] op with immediate #1
0x866:  FDF  RET                  ; 
0x867:  5F5  CALZ     0x5F5       ; Flow to 0x5F5
0x868:  BC2  LD_X     0xC2        ; Set pointer to RAM 0xC2
0x869:  93D  LBPX     #3D         ; Store constant #3D into memory pointer
0x86A:  47D  CALL     0x57D       ; Flow to 0x57D
0x86B:  943  LBPX     #43         ; Store constant #43 into memory pointer
0x86C:  47D  CALL     0x57D       ; Flow to 0x57D
0x86D:  93D  LBPX     #3D         ; Store constant #3D into memory pointer
0x86E:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x86F:  E90  LD_YP_R              ; 
0x870:  843  LD_Y     0x43        ; Set pointer to RAM 0x43 (MEM_DISCIPLINE)
0x871:  EC3  LD_R_Q   A, [Y]      ; Register A op with [Y]
0x872:  DC0  CP_R_I   A, #0       ; Register A op with immediate #0
0x873:  775  JP_NZ    0x575       ; Flow to 0x575
0x874:  E01  LD_R_I   A, #1       ; Register A op with immediate #1
0x875:  F80  LD_MN_A  0x00        ; Direct RAM access at 0x00
0x876:  BC6  LD_X     0xC6        ; Set pointer to RAM 0xC6
0x877:  F70  DEC_MN               ; 
0x878:  682  JP_Z     0x582       ; Flow to 0x582
0x879:  95A  LBPX     #5A         ; Store constant #5A into memory pointer
0x87A:  EE0  INC_X                ; 
0x87B:  EE0  INC_X                ; 
0x87C:  077  JP       0x577       ; Flow to 0x577
0x87D:  E0E  LD_R_I   A, #14      ; Register A op with immediate #14
0x87E:  F80  LD_MN_A  0x00        ; Direct RAM access at 0x00
0x87F:  942  LBPX     #42         ; Store constant #42 into memory pointer
0x880:  F70  DEC_MN               ; 
0x881:  77F  JP_NZ    0x57F       ; Flow to 0x57F
0x882:  FDF  RET                  ; 
0x883:  92E  LBPX     #2E         ; Store constant #2E into memory pointer
0x884:  92F  LBPX     #2F         ; Store constant #2F into memory pointer
0x885:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x886:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x887:  840  LD_Y     0x40        ; Set pointer to RAM 0x40 (MEM_HUNGER)
0x888:  08C  JP       0x58C       ; Flow to 0x58C
0x889:  E4B  PSET     #B          ; Set next Page to 11
0x88A:  4F8  CALL     0xBF8       ; Flow to 0xBF8
0x88B:  841  LD_Y     0x41        ; Set pointer to RAM 0x41 (MEM_HAPPY)
0x88C:  E04  LD_R_I   A, #4       ; Register A op with immediate #4
0x88D:  DFF  CP_R_I   [Y], #15    ; Register [Y] op with immediate #15
0x88E:  394  JP_NC    0xB94       ; Flow to 0xB94
0x88F:  EC3  LD_R_Q   A, [Y]      ; Register A op with [Y]
0x890:  C01  ADD_R_I  A, #1       ; Register A op with immediate #1
0x891:  E8C  RRC                  ; 
0x892:  E8C  RRC                  ; 
0x893:  C83  AND_R_I  A, #3       ; Register A op with immediate #3
0x894:  E14  LD_R_I   B, #4       ; Register B op with immediate #4
0x895:  DC0  CP_R_I   A, #0       ; Register A op with immediate #0
0x896:  799  JP_NZ    0xB99       ; Flow to 0xB99
0x897:  91D  LBPX     #1D         ; Store constant #1D into memory pointer
0x898:  09B  JP       0xB9B       ; Flow to 0xB9B
0x899:  C0F  ADD_R_I  A, #15      ; Register A op with immediate #15
0x89A:  91C  LBPX     #1C         ; Store constant #1C into memory pointer
0x89B:  C1F  ADD_R_I  B, #15      ; Register B op with immediate #15
0x89C:  795  JP_NZ    0xB95       ; Flow to 0xB95
0x89D:  FDF  RET                  ; 
0x89E:  800  LD_Y     0x00        ; Set pointer to RAM 0x00
0x89F:  FC1  PUSH_R               ; 
0x8A0:  FC8  PUSH_YH              ; 
0x8A1:  FC9  PUSH_YL              ; 
0x8A2:  E45  PSET     #5          ; Set next Page to 5
0x8A3:  496  CALL     0x596       ; Flow to 0x596
0x8A4:  FD9  POP_YL               ; 
0x8A5:  FD8  POP_YH               ; 
0x8A6:  5EF  CALZ     0x5EF       ; Flow to 0x5EF
0x8A7:  0AD  JP       0x5AD       ; Flow to 0x5AD
0x8A8:  800  LD_Y     0x00        ; Set pointer to RAM 0x00
0x8A9:  FC1  PUSH_R               ; 
0x8AA:  5F2  CALZ     0x5F2       ; Flow to 0x5F2
0x8AB:  B5E  LD_X     0x5E        ; Set pointer to RAM 0x5E
0x8AC:  EE8  LDPX_R               ; 
0x8AD:  B57  LD_X     0x57        ; Set pointer to RAM 0x57
0x8AE:  FD2  POP_R                ; 
0x8AF:  EB8  LD_R_YL              ; 
0x8B0:  EB5  LD_R_YH              ; 
0x8B1:  BA6  LD_X     0xA6        ; Set pointer to RAM 0xA6
0x8B2:  E4E  PSET     #E          ; Set next Page to 14
0x8B3:  40D  CALL     0xE0D       ; Flow to 0xE0D
0x8B4:  BAA  LD_X     0xAA        ; Set pointer to RAM 0xAA
0x8B5:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x8B6:  E44  PSET     #4          ; Set next Page to 4
0x8B7:  465  CALL     0x465       ; Flow to 0x465 (MEM_WEIGHT)
0x8B8:  521  CALZ     0x421       ; Flow to 0x421 (MEM_NEGLECT)
0x8B9:  540  CALZ     0x440       ; Flow to 0x440
0x8BA:  E44  PSET     #4          ; Set next Page to 4
0x8BB:  486  CALL     0x486       ; Flow to 0x486 (MEM_SICK_LEVEL)
0x8BC:  5EF  CALZ     0x4EF       ; Flow to 0x4EF
0x8BD:  E90  LD_YP_R              ; 
0x8BE:  BAA  LD_X     0xAA        ; Set pointer to RAM 0xAA
0x8BF:  C2F  ADD_R_I  [X], #15    ; Register [X] op with immediate #15
0x8C0:  2D5  JP_C     0x4D5       ; Flow to 0x4D5 (MEM_POOP)
0x8C1:  BA6  LD_X     0xA6        ; Set pointer to RAM 0xA6
0x8C2:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x8C3:  C22  ADD_R_I  [X], #2     ; Register [X] op with immediate #2
0x8C4:  EE0  INC_X                ; 
0x8C5:  EC6  LD_R_Q   B, [X]      ; Register B op with [X]
0x8C6:  C60  ADC_R_I              ; 
0x8C7:  BA2  LD_X     0xA2        ; Set pointer to RAM 0xA2
0x8C8:  E4E  PSET     #E          ; Set next Page to 14
0x8C9:  40D  CALL     0xE0D       ; Flow to 0xE0D
0x8CA:  BA2  LD_X     0xA2        ; Set pointer to RAM 0xA2
0x8CB:  8A8  LD_Y     0xA8        ; Set pointer to RAM 0xA8
0x8CC:  EEE  LDPX_R               ; 
0x8CD:  EF0  INC_Y                ; 
0x8CE:  ECE  LD_R_Q   [Y], [X]    ; Register [Y] op with [X]
0x8CF:  CB3  AND_R_I  [Y], #3     ; Register [Y] op with immediate #3
0x8D0:  8AA  LD_Y     0xAA        ; Set pointer to RAM 0xAA
0x8D1:  ECE  LD_R_Q   [Y], [X]    ; Register [Y] op with [X]
0x8D2:  E8F  RRC                  ; 
0x8D3:  E8F  RRC                  ; 
0x8D4:  CB3  AND_R_I  [Y], #3     ; Register [Y] op with immediate #3
0x8D5:  BA8  LD_X     0xA8        ; Set pointer to RAM 0xA8
0x8D6:  DEF  CP_R_I   [X], #15    ; Register [X] op with immediate #15
0x8D7:  7DB  JP_NZ    0xEDB       ; Flow to 0xEDB
0x8D8:  EE0  INC_X                ; 
0x8D9:  DE3  CP_R_I   [X], #3     ; Register [X] op with immediate #3
0x8DA:  6F4  JP_Z     0xEF4       ; Flow to 0xEF4
0x8DB:  8A4  LD_Y     0xA4        ; Set pointer to RAM 0xA4
0x8DC:  E8B  LD_XL_R              ; 
0x8DD:  EF0  INC_Y                ; 
0x8DE:  E87  LD_XH_R              ; 
0x8DF:  85D  LD_Y     0x5D        ; Set pointer to RAM 0x5D (MEM_LIFECYCLE)
0x8E0:  DF1  CP_R_I   [Y], #1     ; Register [Y] op with immediate #1
0x8E1:  7F0  JP_NZ    0xEF0       ; Flow to 0xEF0
0x8E2:  EA4  LD_R_XH              ; 
0x8E3:  DC0  CP_R_I   A, #0       ; Register A op with immediate #0
0x8E4:  6E6  JP_Z     0xEE6       ; Flow to 0xEE6
0x8E5:  CC8  OR_R_I   A, #8       ; Register A op with immediate #8
0x8E6:  E84  LD_XH_R              ; 
0x8E7:  F5E  RST                  ; 
0x8E8:  A18  ADC_XL               ; 
0x8E9:  A0F  ADC_XH               ; 
0x8EA:  EA4  LD_R_XH              ; 
0x8EB:  CC8  OR_R_I   A, #8       ; Register A op with immediate #8
0x8EC:  DCF  CP_R_I   A, #15      ; Register A op with immediate #15
0x8ED:  7F0  JP_NZ    0xEF0       ; Flow to 0xEF0
0x8EE:  F5E  RST                  ; 
0x8EF:  A01  ADC_XH               ; 
0x8F0:  5F5  CALZ     0xEF5       ; Flow to 0xEF5
0x8F1:  8A8  LD_Y     0xA8        ; Set pointer to RAM 0xA8
0x8F2:  E47  PSET     #7          ; Set next Page to 7
0x8F3:  4A3  CALL     0x7A3       ; Flow to 0x7A3
0x8F4:  554  CALZ     0x754       ; Flow to 0x754
0x8F5:  521  CALZ     0x721       ; Flow to 0x721
0x8F6:  B57  LD_X     0x57        ; Set pointer to RAM 0x57
0x8F7:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x8F8:  6FF  JP_Z     0x7FF       ; Flow to 0x7FF
0x8F9:  B74  LD_X     0x74        ; Set pointer to RAM 0x74
0x8FA:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0x8FB:  6B9  JP_Z     0x7B9       ; Flow to 0x7B9
0x8FC:  D97  FAN_R_I              ; 
0x8FD:  6B9  JP_Z     0x7B9       ; Flow to 0x7B9
0x8FE:  5BB  CALZ     0x7BB       ; Flow to 0x7BB
0x8FF:  FDF  RET                  ; 
0x900:  DC0  CP_R_I   A, #0       ; Register A op with immediate #0
0x901:  605  JP_Z     0x705       ; Flow to 0x705
0x902:  B5A  LD_X     0x5A        ; Set pointer to RAM 0x5A
0x903:  F41  SET                  ; 
0x904:  A98  ADC_R_Q  [X], A      ; Register [X] op with A
0x905:  FDF  RET                  ; 
0x906:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x907:  F82  LD_MN_A  0x02        ; Direct RAM access at 0x02
0x908:  E08  LD_R_I   A, #8       ; Register A op with immediate #8
0x909:  F83  LD_MN_A  0x03        ; Direct RAM access at 0x03
0x90A:  413  CALL     0x713       ; Flow to 0x713
0x90B:  556  CALZ     0x756       ; Flow to 0x756
0x90C:  B01  LD_X     0x01        ; Set pointer to RAM 0x01
0x90D:  53C  CALZ     0x73C       ; Flow to 0x73C
0x90E:  F62  INC_MN               ; 
0x90F:  F73  DEC_MN               ; 
0x910:  70A  JP_NZ    0x70A       ; Flow to 0x70A
0x911:  540  CALZ     0x740       ; Flow to 0x740
0x912:  FDF  RET                  ; 
0x913:  5EF  CALZ     0x7EF       ; Flow to 0x7EF
0x914:  B00  LD_X     0x00        ; Set pointer to RAM 0x00
0x915:  FA2  LD_A_MN  0x02        ; Direct RAM access at 0x02
0x916:  E48  PSET     #8          ; Set next Page to 8
0x917:  408  CALL     0x808       ; Flow to 0x808
0x918:  5F5  CALZ     0x8F5       ; Flow to 0x8F5
0x919:  B00  LD_X     0x00        ; Set pointer to RAM 0x00
0x91A:  FA0  LD_A_MN  0x00        ; Direct RAM access at 0x00
0x91B:  FB1  LD_B_MN  0x01        ; Direct RAM access at 0x01
0x91C:  F5E  RST                  ; 
0x91D:  AD8  OR_R_Q   [X], A      ; Register [X] op with A
0x91E:  EE0  INC_X                ; 
0x91F:  AD8  OR_R_Q   [X], A      ; Register [X] op with A
0x920:  EE0  INC_X                ; 
0x921:  AD9  OR_R_Q   [X], B      ; Register [X] op with B
0x922:  EE0  INC_X                ; 
0x923:  AD9  OR_R_Q   [X], B      ; Register [X] op with B
0x924:  A11  ADC_XL               ; 
0x925:  A00  ADC_XH               ; 
0x926:  31D  JP_NC    0x81D       ; Flow to 0x81D
0x927:  FDF  RET                  ; 
0x928:  F80  LD_MN_A  0x00        ; Direct RAM access at 0x00
0x929:  F93  LD_MN_B  0x03        ; Direct RAM access at 0x03
0x92A:  B5D  LD_X     0x5D        ; Set pointer to RAM 0x5D (MEM_LIFECYCLE)
0x92B:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x92C:  E10  LD_R_I   B, #0       ; Register B op with immediate #0
0x92D:  B01  LD_X     0x01        ; Set pointer to RAM 0x01
0x92E:  E4C  PSET     #C          ; Set next Page to 12
0x92F:  479  CALL     0xC79       ; Flow to 0xC79
0x930:  FA1  LD_A_MN  0x01        ; Direct RAM access at 0x01
0x931:  FB0  LD_B_MN  0x00        ; Direct RAM access at 0x00
0x932:  A81  ADD_R_Q  A, B        ; Register A op with B
0x933:  FB2  LD_B_MN  0x02        ; Direct RAM access at 0x02
0x934:  C50  ADC_R_I              ; 
0x935:  B24  LD_X     0x24        ; Set pointer to RAM 0x24
0x936:  E4C  PSET     #C          ; Set next Page to 12
0x937:  479  CALL     0xC79       ; Flow to 0xC79
0x938:  049  JP       0xC49       ; Flow to 0xC49
0x939:  F80  LD_MN_A  0x00        ; Direct RAM access at 0x00
0x93A:  F93  LD_MN_B  0x03        ; Direct RAM access at 0x03
0x93B:  B5D  LD_X     0x5D        ; Set pointer to RAM 0x5D (MEM_LIFECYCLE)
0x93C:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x93D:  E10  LD_R_I   B, #0       ; Register B op with immediate #0
0x93E:  B01  LD_X     0x01        ; Set pointer to RAM 0x01
0x93F:  E4D  PSET     #D          ; Set next Page to 13
0x940:  47D  CALL     0xD7D       ; Flow to 0xD7D
0x941:  FA1  LD_A_MN  0x01        ; Direct RAM access at 0x01
0x942:  FB0  LD_B_MN  0x00        ; Direct RAM access at 0x00
0x943:  A81  ADD_R_Q  A, B        ; Register A op with B
0x944:  FB2  LD_B_MN  0x02        ; Direct RAM access at 0x02
0x945:  C50  ADC_R_I              ; 
0x946:  B24  LD_X     0x24        ; Set pointer to RAM 0x24
0x947:  E4D  PSET     #D          ; Set next Page to 13
0x948:  47D  CALL     0xD7D       ; Flow to 0xD7D
0x949:  FA3  LD_A_MN  0x03        ; Direct RAM access at 0x03
0x94A:  C88  AND_R_I  A, #8       ; Register A op with immediate #8
0x94B:  B25  LD_X     0x25        ; Set pointer to RAM 0x25
0x94C:  AE8  XOR_R_Q  [X], A      ; Register [X] op with A
0x94D:  E49  PSET     #9          ; Set next Page to 9
0x94E:  04F  JP       0x94F       ; Flow to 0x94F
0x94F:  5EF  CALZ     0x9EF       ; Flow to 0x9EF
0x950:  F80  LD_MN_A  0x00        ; Direct RAM access at 0x00
0x951:  B24  LD_X     0x24        ; Set pointer to RAM 0x24
0x952:  EE2  LDPX_R               ; 
0x953:  EE6  LDPX_R               ; 
0x954:  C97  AND_R_I  B, #7       ; Register B op with immediate #7
0x955:  C03  ADD_R_I  A, #3       ; Register A op with immediate #3
0x956:  C50  ADC_R_I              ; 
0x957:  DD8  CP_R_I   B, #8       ; Register B op with immediate #8
0x958:  37E  JP_NC    0x97E       ; Flow to 0x97E
0x959:  F92  LD_MN_B  0x02        ; Direct RAM access at 0x02
0x95A:  F81  LD_MN_A  0x01        ; Direct RAM access at 0x01
0x95B:  B3A  LD_X     0x3A        ; Set pointer to RAM 0x3A
0x95C:  EE2  LDPX_R               ; 
0x95D:  EE6  LDPX_R               ; 
0x95E:  E88  LD_XL_R              ; 
0x95F:  E85  LD_XH_R              ; 
0x960:  5F5  CALZ     0x9F5       ; Flow to 0x9F5
0x961:  500  CALZ     0x900       ; Flow to 0x900
0x962:  5EF  CALZ     0x9EF       ; Flow to 0x9EF
0x963:  B25  LD_X     0x25        ; Set pointer to RAM 0x25
0x964:  DA8  FAN_R_I              ; 
0x965:  67E  JP_Z     0x97E       ; Flow to 0x97E
0x966:  B3A  LD_X     0x3A        ; Set pointer to RAM 0x3A
0x967:  EE2  LDPX_R               ; 
0x968:  EE6  LDPX_R               ; 
0x969:  E88  LD_XL_R              ; 
0x96A:  E85  LD_XH_R              ; 
0x96B:  C0E  ADD_R_I  A, #14      ; Register A op with immediate #14
0x96C:  E98  LD_YL_R              ; 
0x96D:  C51  ADC_R_I              ; 
0x96E:  E95  LD_YH_R              ; 
0x96F:  5F5  CALZ     0x9F5       ; Flow to 0x9F5
0x970:  E90  LD_YP_R              ; 
0x971:  E08  LD_R_I   A, #8       ; Register A op with immediate #8
0x972:  F80  LD_MN_A  0x00        ; Direct RAM access at 0x00
0x973:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x974:  EEB  LDPX_R               ; 
0x975:  EFC  LDPY_R               ; 
0x976:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x977:  EEB  LDPX_R               ; 
0x978:  ECC  LD_R_Q   [Y], A      ; Register [Y] op with A
0x979:  F5E  RST                  ; 
0x97A:  A3D  ADC_YL               ; 
0x97B:  A2F  ADC_YH               ; 
0x97C:  F70  DEC_MN               ; 
0x97D:  773  JP_NZ    0x973       ; Flow to 0x973
0x97E:  FDF  RET                  ; 
0x97F:  E47  PSET     #7          ; Set next Page to 7
0x980:  461  CALL     0x761       ; Flow to 0x761
0x981:  E44  PSET     #4          ; Set next Page to 4
0x982:  465  CALL     0x465       ; Flow to 0x465 (MEM_WEIGHT)
0x983:  5EC  CALZ     0x4EC       ; Flow to 0x4EC
0x984:  540  CALZ     0x440       ; Flow to 0x440
0x985:  552  CALZ     0x452       ; Flow to 0x452
0x986:  521  CALZ     0x421       ; Flow to 0x421 (MEM_NEGLECT)
0x987:  DA2  FAN_R_I              ; 
0x988:  684  JP_Z     0x484       ; Flow to 0x484 (MEM_SICK_LEVEL)
0x989:  E45  PSET     #5          ; Set next Page to 5
0x98A:  053  JP       0x553       ; Flow to 0x553
0x98B:  19B  RETD     0x9B        ; Table lookup return from 0x9B
0x98C:  19E  RETD     0x9E        ; Table lookup return from 0x9E
0x98D:  1B1  RETD     0xB1        ; Table lookup return from 0xB1
0x98E:  1BE  RETD     0xBE        ; Table lookup return from 0xBE
0x98F:  1C3  RETD     0xC3        ; Table lookup return from 0xC3
0x990:  1CE  RETD     0xCE        ; Table lookup return from 0xCE
0x991:  1D3  RETD     0xD3        ; Table lookup return from 0xD3
0x992:  1DC  RETD     0xDC        ; Table lookup return from 0xDC
0x993:  1E5  RETD     0xE5        ; Table lookup return from 0xE5
0x994:  1EC  RETD     0xEC        ; Table lookup return from 0xEC
0x995:  1F1  RETD     0xF1        ; Table lookup return from 0xF1
0x996:  100  RETD     0x00        ; Table lookup return from 0x00
0x997:  100  RETD     0x00        ; Table lookup return from 0x00
0x998:  100  RETD     0x00        ; Table lookup return from 0x00
0x999:  100  RETD     0x00        ; Table lookup return from 0x00
0x99A:  100  RETD     0x00        ; Table lookup return from 0x00
0x99B:  9CF  LBPX     #CF         ; Store constant #CF into memory pointer
0x99C:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x99D:  19B  RETD     0x9B        ; Table lookup return from 0x9B
0x99E:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x99F:  112  RETD     0x12        ; Table lookup return from 0x12
0x9A0:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x9A1:  112  RETD     0x12        ; Table lookup return from 0x12
0x9A2:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x9A3:  114  RETD     0x14        ; Table lookup return from 0x14
0x9A4:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x9A5:  112  RETD     0x12        ; Table lookup return from 0x12
0x9A6:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x9A7:  112  RETD     0x12        ; Table lookup return from 0x12
0x9A8:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x9A9:  112  RETD     0x12        ; Table lookup return from 0x12
0x9AA:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x9AB:  114  RETD     0x14        ; Table lookup return from 0x14
0x9AC:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x9AD:  112  RETD     0x12        ; Table lookup return from 0x12
0x9AE:  9C7  LBPX     #C7         ; Store constant #C7 into memory pointer
0x9AF:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x9B0:  1AE  RETD     0xAE        ; Table lookup return from 0xAE
0x9B1:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x9B2:  110  RETD     0x10        ; Table lookup return from 0x10
0x9B3:  9C1  LBPX     #C1         ; Store constant #C1 into memory pointer
0x9B4:  1FB  RETD     0xFB        ; Table lookup return from 0xFB
0x9B5:  9F0  LBPX     #F0         ; Store constant #F0 into memory pointer
0x9B6:  10C  RETD     0x0C        ; Table lookup return from 0x0C
0x9B7:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x9B8:  108  RETD     0x08        ; Table lookup return from 0x08
0x9B9:  9F2  LBPX     #F2         ; Store constant #F2 into memory pointer
0x9BA:  107  RETD     0x07        ; Table lookup return from 0x07
0x9BB:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x9BC:  914  LBPX     #14         ; Store constant #14 into memory pointer
0x9BD:  1B1  RETD     0xB1        ; Table lookup return from 0xB1
0x9BE:  9C5  LBPX     #C5         ; Store constant #C5 into memory pointer
0x9BF:  110  RETD     0x10        ; Table lookup return from 0x10
0x9C0:  9C1  LBPX     #C1         ; Store constant #C1 into memory pointer
0x9C1:  90E  LBPX     #E          ; Store constant #E into memory pointer
0x9C2:  1BE  RETD     0xBE        ; Table lookup return from 0xBE
0x9C3:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x9C4:  110  RETD     0x10        ; Table lookup return from 0x10
0x9C5:  9C2  LBPX     #C2         ; Store constant #C2 into memory pointer
0x9C6:  1FD  RETD     0xFD        ; Table lookup return from 0xFD
0x9C7:  9F3  LBPX     #F3         ; Store constant #F3 into memory pointer
0x9C8:  105  RETD     0x05        ; Table lookup return from 0x05
0x9C9:  9C1  LBPX     #C1         ; Store constant #C1 into memory pointer
0x9CA:  1FD  RETD     0xFD        ; Table lookup return from 0xFD
0x9CB:  9F3  LBPX     #F3         ; Store constant #F3 into memory pointer
0x9CC:  903  LBPX     #3          ; Store constant #3 into memory pointer
0x9CD:  1C3  RETD     0xC3        ; Table lookup return from 0xC3
0x9CE:  9C5  LBPX     #C5         ; Store constant #C5 into memory pointer
0x9CF:  110  RETD     0x10        ; Table lookup return from 0x10
0x9D0:  9D0  LBPX     #D0         ; Store constant #D0 into memory pointer
0x9D1:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x9D2:  1CE  RETD     0xCE        ; Table lookup return from 0xCE
0x9D3:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x9D4:  110  RETD     0x10        ; Table lookup return from 0x10
0x9D5:  9C3  LBPX     #C3         ; Store constant #C3 into memory pointer
0x9D6:  1FF  RETD     0xFF        ; Table lookup return from 0xFF
0x9D7:  9F7  LBPX     #F7         ; Store constant #F7 into memory pointer
0x9D8:  103  RETD     0x03        ; Table lookup return from 0x03
0x9D9:  9C2  LBPX     #C2         ; Store constant #C2 into memory pointer
0x9DA:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x9DB:  1D3  RETD     0xD3        ; Table lookup return from 0xD3
0x9DC:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x9DD:  110  RETD     0x10        ; Table lookup return from 0x10
0x9DE:  9C2  LBPX     #C2         ; Store constant #C2 into memory pointer
0x9DF:  1FD  RETD     0xFD        ; Table lookup return from 0xFD
0x9E0:  9F5  LBPX     #F5         ; Store constant #F5 into memory pointer
0x9E1:  105  RETD     0x05        ; Table lookup return from 0x05
0x9E2:  9C1  LBPX     #C1         ; Store constant #C1 into memory pointer
0x9E3:  9FD  LBPX     #FD         ; Store constant #FD into memory pointer
0x9E4:  1DC  RETD     0xDC        ; Table lookup return from 0xDC
0x9E5:  9C7  LBPX     #C7         ; Store constant #C7 into memory pointer
0x9E6:  110  RETD     0x10        ; Table lookup return from 0x10
0x9E7:  9D3  LBPX     #D3         ; Store constant #D3 into memory pointer
0x9E8:  110  RETD     0x10        ; Table lookup return from 0x10
0x9E9:  9CB  LBPX     #CB         ; Store constant #CB into memory pointer
0x9EA:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x9EB:  1E5  RETD     0xE5        ; Table lookup return from 0xE5
0x9EC:  9C7  LBPX     #C7         ; Store constant #C7 into memory pointer
0x9ED:  110  RETD     0x10        ; Table lookup return from 0x10
0x9EE:  9F7  LBPX     #F7         ; Store constant #F7 into memory pointer
0x9EF:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x9F0:  1EC  RETD     0xEC        ; Table lookup return from 0xEC
0x9F1:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x9F2:  110  RETD     0x10        ; Table lookup return from 0x10
0x9F3:  9C1  LBPX     #C1         ; Store constant #C1 into memory pointer
0x9F4:  112  RETD     0x12        ; Table lookup return from 0x12
0x9F5:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x9F6:  110  RETD     0x10        ; Table lookup return from 0x10
0x9F7:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x9F8:  112  RETD     0x12        ; Table lookup return from 0x12
0x9F9:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x9FA:  110  RETD     0x10        ; Table lookup return from 0x10
0x9FB:  9C1  LBPX     #C1         ; Store constant #C1 into memory pointer
0x9FC:  112  RETD     0x12        ; Table lookup return from 0x12
0x9FD:  9C7  LBPX     #C7         ; Store constant #C7 into memory pointer
0x9FE:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x9FF:  1FD  RETD     0xFD        ; Table lookup return from 0xFD
0xA00:  100  RETD     0x00        ; Table lookup return from 0x00
0xA01:  110  RETD     0x10        ; Table lookup return from 0x10
0xA02:  121  RETD     0x21        ; Table lookup return from 0x21
0xA03:  133  RETD     0x33        ; Table lookup return from 0x33
0xA04:  144  RETD     0x44        ; Table lookup return from 0x44
0xA05:  100  RETD     0x00        ; Table lookup return from 0x00
0xA06:  100  RETD     0x00        ; Table lookup return from 0x00
0xA07:  100  RETD     0x00        ; Table lookup return from 0x00
0xA08:  100  RETD     0x00        ; Table lookup return from 0x00
0xA09:  100  RETD     0x00        ; Table lookup return from 0x00
0xA0A:  100  RETD     0x00        ; Table lookup return from 0x00
0xA0B:  100  RETD     0x00        ; Table lookup return from 0x00
0xA0C:  100  RETD     0x00        ; Table lookup return from 0x00
0xA0D:  100  RETD     0x00        ; Table lookup return from 0x00
0xA0E:  100  RETD     0x00        ; Table lookup return from 0x00
0xA0F:  100  RETD     0x00        ; Table lookup return from 0x00
0xA10:  100  RETD     0x00        ; Table lookup return from 0x00
0xA11:  115  RETD     0x15        ; Table lookup return from 0x15
0xA12:  112  RETD     0x12        ; Table lookup return from 0x12
0xA13:  133  RETD     0x33        ; Table lookup return from 0x33
0xA14:  143  RETD     0x43        ; Table lookup return from 0x43 (MEM_DISCIPLINE)
0xA15:  145  RETD     0x45        ; Table lookup return from 0x45
0xA16:  100  RETD     0x00        ; Table lookup return from 0x00
0xA17:  141  RETD     0x41        ; Table lookup return from 0x41 (MEM_HAPPY)
0xA18:  161  RETD     0x61        ; Table lookup return from 0x61
0xA19:  113  RETD     0x13        ; Table lookup return from 0x13
0xA1A:  133  RETD     0x33        ; Table lookup return from 0x33
0xA1B:  100  RETD     0x00        ; Table lookup return from 0x00
0xA1C:  100  RETD     0x00        ; Table lookup return from 0x00
0xA1D:  100  RETD     0x00        ; Table lookup return from 0x00
0xA1E:  100  RETD     0x00        ; Table lookup return from 0x00
0xA1F:  100  RETD     0x00        ; Table lookup return from 0x00
0xA20:  100  RETD     0x00        ; Table lookup return from 0x00
0xA21:  115  RETD     0x15        ; Table lookup return from 0x15
0xA22:  103  RETD     0x03        ; Table lookup return from 0x03
0xA23:  187  RETD     0x87        ; Table lookup return from 0x87
0xA24:  1B9  RETD     0xB9        ; Table lookup return from 0xB9
0xA25:  125  RETD     0x25        ; Table lookup return from 0x25
0xA26:  1A9  RETD     0xA9        ; Table lookup return from 0xA9
0xA27:  1B1  RETD     0xB1        ; Table lookup return from 0xB1
0xA28:  147  RETD     0x47        ; Table lookup return from 0x47
0xA29:  178  RETD     0x78        ; Table lookup return from 0x78
0xA2A:  188  RETD     0x88        ; Table lookup return from 0x88
0xA2B:  100  RETD     0x00        ; Table lookup return from 0x00
0xA2C:  100  RETD     0x00        ; Table lookup return from 0x00
0xA2D:  100  RETD     0x00        ; Table lookup return from 0x00
0xA2E:  100  RETD     0x00        ; Table lookup return from 0x00
0xA2F:  100  RETD     0x00        ; Table lookup return from 0x00
0xA30:  100  RETD     0x00        ; Table lookup return from 0x00
0xA31:  113  RETD     0x13        ; Table lookup return from 0x13
0xA32:  102  RETD     0x02        ; Table lookup return from 0x02
0xA33:  144  RETD     0x44        ; Table lookup return from 0x44
0xA34:  165  RETD     0x65        ; Table lookup return from 0x65
0xA35:  187  RETD     0x87        ; Table lookup return from 0x87
0xA36:  199  RETD     0x99        ; Table lookup return from 0x99
0xA37:  1A1  RETD     0xA1        ; Table lookup return from 0xA1
0xA38:  1CB  RETD     0xCB        ; Table lookup return from 0xCB
0xA39:  1BB  RETD     0xBB        ; Table lookup return from 0xBB
0xA3A:  1BB  RETD     0xBB        ; Table lookup return from 0xBB
0xA3B:  100  RETD     0x00        ; Table lookup return from 0x00
0xA3C:  100  RETD     0x00        ; Table lookup return from 0x00
0xA3D:  100  RETD     0x00        ; Table lookup return from 0x00
0xA3E:  100  RETD     0x00        ; Table lookup return from 0x00
0xA3F:  100  RETD     0x00        ; Table lookup return from 0x00
0xA40:  100  RETD     0x00        ; Table lookup return from 0x00
0xA41:  110  RETD     0x10        ; Table lookup return from 0x10
0xA42:  103  RETD     0x03        ; Table lookup return from 0x03
0xA43:  165  RETD     0x65        ; Table lookup return from 0x65
0xA44:  147  RETD     0x47        ; Table lookup return from 0x47
0xA45:  122  RETD     0x22        ; Table lookup return from 0x22
0xA46:  177  RETD     0x77        ; Table lookup return from 0x77
0xA47:  142  RETD     0x42        ; Table lookup return from 0x42 (MEM_NEGLECT)
0xA48:  187  RETD     0x87        ; Table lookup return from 0x87
0xA49:  178  RETD     0x78        ; Table lookup return from 0x78
0xA4A:  188  RETD     0x88        ; Table lookup return from 0x88
0xA4B:  100  RETD     0x00        ; Table lookup return from 0x00
0xA4C:  100  RETD     0x00        ; Table lookup return from 0x00
0xA4D:  100  RETD     0x00        ; Table lookup return from 0x00
0xA4E:  100  RETD     0x00        ; Table lookup return from 0x00
0xA4F:  100  RETD     0x00        ; Table lookup return from 0x00
0xA50:  100  RETD     0x00        ; Table lookup return from 0x00
0xA51:  111  RETD     0x11        ; Table lookup return from 0x11
0xA52:  102  RETD     0x02        ; Table lookup return from 0x02
0xA53:  133  RETD     0x33        ; Table lookup return from 0x33
0xA54:  124  RETD     0x24        ; Table lookup return from 0x24
0xA55:  151  RETD     0x51        ; Table lookup return from 0x51 (MEM_BEHAVIOR_MISTAKE)
0xA56:  176  RETD     0x76        ; Table lookup return from 0x76
0xA57:  181  RETD     0x81        ; Table lookup return from 0x81
0xA58:  176  RETD     0x76        ; Table lookup return from 0x76
0xA59:  166  RETD     0x66        ; Table lookup return from 0x66
0xA5A:  166  RETD     0x66        ; Table lookup return from 0x66
0xA5B:  100  RETD     0x00        ; Table lookup return from 0x00
0xA5C:  100  RETD     0x00        ; Table lookup return from 0x00
0xA5D:  100  RETD     0x00        ; Table lookup return from 0x00
0xA5E:  100  RETD     0x00        ; Table lookup return from 0x00
0xA5F:  100  RETD     0x00        ; Table lookup return from 0x00
0xA60:  100  RETD     0x00        ; Table lookup return from 0x00
0xA61:  121  RETD     0x21        ; Table lookup return from 0x21
0xA62:  103  RETD     0x03        ; Table lookup return from 0x03
0xA63:  144  RETD     0x44        ; Table lookup return from 0x44
0xA64:  135  RETD     0x35        ; Table lookup return from 0x35
0xA65:  111  RETD     0x11        ; Table lookup return from 0x11
0xA66:  185  RETD     0x85        ; Table lookup return from 0x85
0xA67:  160  RETD     0x60        ; Table lookup return from 0x60
0xA68:  175  RETD     0x75        ; Table lookup return from 0x75
0xA69:  175  RETD     0x75        ; Table lookup return from 0x75
0xA6A:  155  RETD     0x55        ; Table lookup return from 0x55
0xA6B:  100  RETD     0x00        ; Table lookup return from 0x00
0xA6C:  100  RETD     0x00        ; Table lookup return from 0x00
0xA6D:  100  RETD     0x00        ; Table lookup return from 0x00
0xA6E:  100  RETD     0x00        ; Table lookup return from 0x00
0xA6F:  100  RETD     0x00        ; Table lookup return from 0x00
0xA70:  100  RETD     0x00        ; Table lookup return from 0x00
0xA71:  110  RETD     0x10        ; Table lookup return from 0x10
0xA72:  132  RETD     0x32        ; Table lookup return from 0x32
0xA73:  155  RETD     0x55        ; Table lookup return from 0x55
0xA74:  126  RETD     0x26        ; Table lookup return from 0x26
0xA75:  177  RETD     0x77        ; Table lookup return from 0x77
0xA76:  198  RETD     0x98        ; Table lookup return from 0x98
0xA77:  147  RETD     0x47        ; Table lookup return from 0x47
0xA78:  126  RETD     0x26        ; Table lookup return from 0x26
0xA79:  166  RETD     0x66        ; Table lookup return from 0x66
0xA7A:  166  RETD     0x66        ; Table lookup return from 0x66
0xA7B:  100  RETD     0x00        ; Table lookup return from 0x00
0xA7C:  100  RETD     0x00        ; Table lookup return from 0x00
0xA7D:  100  RETD     0x00        ; Table lookup return from 0x00
0xA7E:  100  RETD     0x00        ; Table lookup return from 0x00
0xA7F:  100  RETD     0x00        ; Table lookup return from 0x00
0xA80:  100  RETD     0x00        ; Table lookup return from 0x00
0xA81:  110  RETD     0x10        ; Table lookup return from 0x10
0xA82:  102  RETD     0x02        ; Table lookup return from 0x02
0xA83:  133  RETD     0x33        ; Table lookup return from 0x33
0xA84:  124  RETD     0x24        ; Table lookup return from 0x24
0xA85:  176  RETD     0x76        ; Table lookup return from 0x76
0xA86:  154  RETD     0x54        ; Table lookup return from 0x54 (MEM_AGE)
0xA87:  180  RETD     0x80        ; Table lookup return from 0x80
0xA88:  194  RETD     0x94        ; Table lookup return from 0x94
0xA89:  194  RETD     0x94        ; Table lookup return from 0x94
0xA8A:  144  RETD     0x44        ; Table lookup return from 0x44
0xA8B:  100  RETD     0x00        ; Table lookup return from 0x00
0xA8C:  100  RETD     0x00        ; Table lookup return from 0x00
0xA8D:  100  RETD     0x00        ; Table lookup return from 0x00
0xA8E:  100  RETD     0x00        ; Table lookup return from 0x00
0xA8F:  100  RETD     0x00        ; Table lookup return from 0x00
0xA90:  100  RETD     0x00        ; Table lookup return from 0x00
0xA91:  121  RETD     0x21        ; Table lookup return from 0x21
0xA92:  143  RETD     0x43        ; Table lookup return from 0x43 (MEM_DISCIPLINE)
0xA93:  155  RETD     0x55        ; Table lookup return from 0x55
0xA94:  136  RETD     0x36        ; Table lookup return from 0x36
0xA95:  187  RETD     0x87        ; Table lookup return from 0x87
0xA96:  196  RETD     0x96        ; Table lookup return from 0x96
0xA97:  13A  RETD     0x3A        ; Table lookup return from 0x3A
0xA98:  1BB  RETD     0xBB        ; Table lookup return from 0xBB
0xA99:  15B  RETD     0x5B        ; Table lookup return from 0x5B
0xA9A:  1BB  RETD     0xBB        ; Table lookup return from 0xBB
0xA9B:  100  RETD     0x00        ; Table lookup return from 0x00
0xA9C:  100  RETD     0x00        ; Table lookup return from 0x00
0xA9D:  100  RETD     0x00        ; Table lookup return from 0x00
0xA9E:  100  RETD     0x00        ; Table lookup return from 0x00
0xA9F:  100  RETD     0x00        ; Table lookup return from 0x00
0xAA0:  100  RETD     0x00        ; Table lookup return from 0x00
0xAA1:  101  RETD     0x01        ; Table lookup return from 0x01
0xAA2:  112  RETD     0x12        ; Table lookup return from 0x12
0xAA3:  133  RETD     0x33        ; Table lookup return from 0x33
0xAA4:  124  RETD     0x24        ; Table lookup return from 0x24
0xAA5:  122  RETD     0x22        ; Table lookup return from 0x22
0xAA6:  154  RETD     0x54        ; Table lookup return from 0x54 (MEM_AGE)
0xAA7:  122  RETD     0x22        ; Table lookup return from 0x22
0xAA8:  164  RETD     0x64        ; Table lookup return from 0x64
0xAA9:  154  RETD     0x54        ; Table lookup return from 0x54 (MEM_AGE)
0xAAA:  144  RETD     0x44        ; Table lookup return from 0x44
0xAAB:  100  RETD     0x00        ; Table lookup return from 0x00
0xAAC:  100  RETD     0x00        ; Table lookup return from 0x00
0xAAD:  100  RETD     0x00        ; Table lookup return from 0x00
0xAAE:  100  RETD     0x00        ; Table lookup return from 0x00
0xAAF:  100  RETD     0x00        ; Table lookup return from 0x00
0xAB0:  100  RETD     0x00        ; Table lookup return from 0x00
0xAB1:  110  RETD     0x10        ; Table lookup return from 0x10
0xAB2:  102  RETD     0x02        ; Table lookup return from 0x02
0xAB3:  133  RETD     0x33        ; Table lookup return from 0x33
0xAB4:  121  RETD     0x21        ; Table lookup return from 0x21
0xAB5:  144  RETD     0x44        ; Table lookup return from 0x44
0xAB6:  155  RETD     0x55        ; Table lookup return from 0x55
0xAB7:  144  RETD     0x44        ; Table lookup return from 0x44
0xAB8:  151  RETD     0x51        ; Table lookup return from 0x51 (MEM_BEHAVIOR_MISTAKE)
0xAB9:  111  RETD     0x11        ; Table lookup return from 0x11
0xABA:  111  RETD     0x11        ; Table lookup return from 0x11
0xABB:  111  RETD     0x11        ; Table lookup return from 0x11
0xABC:  100  RETD     0x00        ; Table lookup return from 0x00
0xABD:  FE8  JPBA                 ; 
0xABE:  5EF  CALZ     0x5EF       ; Flow to 0x5EF
0xABF:  B4B  LD_X     0x4B        ; Set pointer to RAM 0x4B
0xAC0:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0xAC1:  C81  AND_R_I  A, #1       ; Register A op with immediate #1
0xAC2:  D01  XOR_R_I              ; 
0xAC3:  B78  LD_X     0x78        ; Set pointer to RAM 0x78
0xAC4:  EC8  LD_R_Q   [X], A      ; Register [X] op with A
0xAC5:  B90  LD_X     0x90        ; Set pointer to RAM 0x90
0xAC6:  E4B  PSET     #B          ; Set next Page to 11
0xAC7:  4F0  CALL     0xBF0       ; Flow to 0xBF0
0xAC8:  E1A  LD_R_I   B, #10      ; Register B op with immediate #10
0xAC9:  E4E  PSET     #E          ; Set next Page to 14
0xACA:  45A  CALL     0xE5A       ; Flow to 0xE5A
0xACB:  3CF  JP_NC    0xECF       ; Flow to 0xECF
0xACC:  E45  PSET     #5          ; Set next Page to 5
0xACD:  717  JP_NZ    0x517       ; Flow to 0x517 (MEM_BEHAVIOR_MISTAKE)
0xACE:  0D8  JP       0x5D8       ; Flow to 0x5D8 (MEM_LIFECYCLE)
0xACF:  5F2  CALZ     0x5F2       ; Flow to 0x5F2
0xAD0:  B4B  LD_X     0x4B        ; Set pointer to RAM 0x4B
0xAD1:  DC0  CP_R_I   A, #0       ; Register A op with immediate #0
0xAD2:  6D7  JP_Z     0x5D7       ; Flow to 0x5D7 (MEM_LIFECYCLE)
0xAD3:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0xAD4:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0xAD5:  E80  LD_XP_R              ; 
0xAD6:  B05  LD_X     0x05        ; Set pointer to RAM 0x05
0xAD7:  E2F  LD_R_I   [X], #15    ; Register [X] op with immediate #15
0xAD8:  E45  PSET     #5          ; Set next Page to 5
0xAD9:  01A  JP       0x51A       ; Flow to 0x51A (MEM_BEHAVIOR_MISTAKE)
0xADA:  5B3  CALZ     0x5B3       ; Flow to 0x5B3
0xADB:  7EE  JP_NZ    0x5EE       ; Flow to 0x5EE
0xADC:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0xADD:  E80  LD_XP_R              ; 
0xADE:  B09  LD_X     0x09        ; Set pointer to RAM 0x09
0xADF:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0xAE0:  6E9  JP_Z     0x5E9       ; Flow to 0x5E9
0xAE1:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0xAE2:  5EF  CALZ     0x5EF       ; Flow to 0x5EF
0xAE3:  B43  LD_X     0x43        ; Set pointer to RAM 0x43 (MEM_DISCIPLINE)
0xAE4:  C24  ADD_R_I  [X], #4     ; Register [X] op with immediate #4
0xAE5:  3E7  JP_NC    0x5E7       ; Flow to 0x5E7
0xAE6:  E2F  LD_R_I   [X], #15    ; Register [X] op with immediate #15
0xAE7:  8F0  LD_Y     0xF0        ; Set pointer to RAM 0xF0
0xAE8:  5BC  CALZ     0x5BC       ; Flow to 0x5BC
0xAE9:  E08  LD_R_I   A, #8       ; Register A op with immediate #8
0xAEA:  E15  LD_R_I   B, #5       ; Register B op with immediate #5
0xAEB:  803  LD_Y     0x03        ; Set pointer to RAM 0x03
0xAEC:  E48  PSET     #8          ; Set next Page to 8
0xAED:  4A9  CALL     0x8A9       ; Flow to 0x8A9
0xAEE:  E45  PSET     #5          ; Set next Page to 5
0xAEF:  01A  JP       0x51A       ; Flow to 0x51A (MEM_BEHAVIOR_MISTAKE)
0xAF0:  F80  LD_MN_A  0x00        ; Direct RAM access at 0x00
0xAF1:  5EF  CALZ     0x5EF       ; Flow to 0x5EF
0xAF2:  B2A  LD_X     0x2A        ; Set pointer to RAM 0x2A
0xAF3:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xAF4:  556  CALZ     0x556       ; Flow to 0x556
0xAF5:  5EF  CALZ     0x5EF       ; Flow to 0x5EF
0xAF6:  FA0  LD_A_MN  0x00        ; Direct RAM access at 0x00
0xAF7:  B2B  LD_X     0x2B        ; Set pointer to RAM 0x2B
0xAF8:  F08  CP_R_Q   [X], A      ; Register [X] op with A
0xAF9:  3FF  JP_NC    0x5FF       ; Flow to 0x5FF
0xAFA:  B2A  LD_X     0x2A        ; Set pointer to RAM 0x2A
0xAFB:  A89  ADD_R_Q  [X], B      ; Register [X] op with B
0xAFC:  EE0  INC_X                ; 
0xAFD:  C60  ADC_R_I              ; 
0xAFE:  0F4  JP       0x5F4       ; Flow to 0x5F4
0xAFF:  FDF  RET                  ; 
0xB00:  100  RETD     0x00        ; Table lookup return from 0x00
0xB01:  100  RETD     0x00        ; Table lookup return from 0x00
0xB02:  1A1  RETD     0xA1        ; Table lookup return from 0xA1
0xB03:  100  RETD     0x00        ; Table lookup return from 0x00
0xB04:  100  RETD     0x00        ; Table lookup return from 0x00
0xB05:  100  RETD     0x00        ; Table lookup return from 0x00
0xB06:  100  RETD     0x00        ; Table lookup return from 0x00
0xB07:  100  RETD     0x00        ; Table lookup return from 0x00
0xB08:  100  RETD     0x00        ; Table lookup return from 0x00
0xB09:  100  RETD     0x00        ; Table lookup return from 0x00
0xB0A:  100  RETD     0x00        ; Table lookup return from 0x00
0xB0B:  100  RETD     0x00        ; Table lookup return from 0x00
0xB0C:  100  RETD     0x00        ; Table lookup return from 0x00
0xB0D:  100  RETD     0x00        ; Table lookup return from 0x00
0xB0E:  100  RETD     0x00        ; Table lookup return from 0x00
0xB0F:  100  RETD     0x00        ; Table lookup return from 0x00
0xB10:  100  RETD     0x00        ; Table lookup return from 0x00
0xB11:  120  RETD     0x20        ; Table lookup return from 0x20
0xB12:  100  RETD     0x00        ; Table lookup return from 0x00
0xB13:  130  RETD     0x30        ; Table lookup return from 0x30
0xB14:  111  RETD     0x11        ; Table lookup return from 0x11
0xB15:  102  RETD     0x02        ; Table lookup return from 0x02
0xB16:  105  RETD     0x05        ; Table lookup return from 0x05
0xB17:  100  RETD     0x00        ; Table lookup return from 0x00
0xB18:  100  RETD     0x00        ; Table lookup return from 0x00
0xB19:  100  RETD     0x00        ; Table lookup return from 0x00
0xB1A:  100  RETD     0x00        ; Table lookup return from 0x00
0xB1B:  100  RETD     0x00        ; Table lookup return from 0x00
0xB1C:  100  RETD     0x00        ; Table lookup return from 0x00
0xB1D:  100  RETD     0x00        ; Table lookup return from 0x00
0xB1E:  100  RETD     0x00        ; Table lookup return from 0x00
0xB1F:  100  RETD     0x00        ; Table lookup return from 0x00
0xB20:  100  RETD     0x00        ; Table lookup return from 0x00
0xB21:  140  RETD     0x40        ; Table lookup return from 0x40 (MEM_HUNGER)
0xB22:  100  RETD     0x00        ; Table lookup return from 0x00
0xB23:  100  RETD     0x00        ; Table lookup return from 0x00
0xB24:  111  RETD     0x11        ; Table lookup return from 0x11
0xB25:  102  RETD     0x02        ; Table lookup return from 0x02
0xB26:  100  RETD     0x00        ; Table lookup return from 0x00
0xB27:  100  RETD     0x00        ; Table lookup return from 0x00
0xB28:  103  RETD     0x03        ; Table lookup return from 0x03
0xB29:  100  RETD     0x00        ; Table lookup return from 0x00
0xB2A:  100  RETD     0x00        ; Table lookup return from 0x00
0xB2B:  100  RETD     0x00        ; Table lookup return from 0x00
0xB2C:  100  RETD     0x00        ; Table lookup return from 0x00
0xB2D:  100  RETD     0x00        ; Table lookup return from 0x00
0xB2E:  100  RETD     0x00        ; Table lookup return from 0x00
0xB2F:  100  RETD     0x00        ; Table lookup return from 0x00
0xB30:  100  RETD     0x00        ; Table lookup return from 0x00
0xB31:  100  RETD     0x00        ; Table lookup return from 0x00
0xB32:  107  RETD     0x07        ; Table lookup return from 0x07
0xB33:  151  RETD     0x51        ; Table lookup return from 0x51 (MEM_BEHAVIOR_MISTAKE)
0xB34:  111  RETD     0x11        ; Table lookup return from 0x11
0xB35:  102  RETD     0x02        ; Table lookup return from 0x02
0xB36:  105  RETD     0x05        ; Table lookup return from 0x05
0xB37:  100  RETD     0x00        ; Table lookup return from 0x00
0xB38:  106  RETD     0x06        ; Table lookup return from 0x06
0xB39:  105  RETD     0x05        ; Table lookup return from 0x05
0xB3A:  100  RETD     0x00        ; Table lookup return from 0x00
0xB3B:  100  RETD     0x00        ; Table lookup return from 0x00
0xB3C:  100  RETD     0x00        ; Table lookup return from 0x00
0xB3D:  100  RETD     0x00        ; Table lookup return from 0x00
0xB3E:  100  RETD     0x00        ; Table lookup return from 0x00
0xB3F:  100  RETD     0x00        ; Table lookup return from 0x00
0xB40:  100  RETD     0x00        ; Table lookup return from 0x00
0xB41:  160  RETD     0x60        ; Table lookup return from 0x60
0xB42:  100  RETD     0x00        ; Table lookup return from 0x00
0xB43:  100  RETD     0x00        ; Table lookup return from 0x00
0xB44:  111  RETD     0x11        ; Table lookup return from 0x11
0xB45:  104  RETD     0x04        ; Table lookup return from 0x04
0xB46:  105  RETD     0x05        ; Table lookup return from 0x05
0xB47:  100  RETD     0x00        ; Table lookup return from 0x00
0xB48:  100  RETD     0x00        ; Table lookup return from 0x00
0xB49:  100  RETD     0x00        ; Table lookup return from 0x00
0xB4A:  100  RETD     0x00        ; Table lookup return from 0x00
0xB4B:  100  RETD     0x00        ; Table lookup return from 0x00
0xB4C:  100  RETD     0x00        ; Table lookup return from 0x00
0xB4D:  100  RETD     0x00        ; Table lookup return from 0x00
0xB4E:  100  RETD     0x00        ; Table lookup return from 0x00
0xB4F:  100  RETD     0x00        ; Table lookup return from 0x00
0xB50:  100  RETD     0x00        ; Table lookup return from 0x00
0xB51:  105  RETD     0x05        ; Table lookup return from 0x05
0xB52:  107  RETD     0x07        ; Table lookup return from 0x07
0xB53:  100  RETD     0x00        ; Table lookup return from 0x00
0xB54:  111  RETD     0x11        ; Table lookup return from 0x11
0xB55:  102  RETD     0x02        ; Table lookup return from 0x02
0xB56:  100  RETD     0x00        ; Table lookup return from 0x00
0xB57:  100  RETD     0x00        ; Table lookup return from 0x00
0xB58:  100  RETD     0x00        ; Table lookup return from 0x00
0xB59:  105  RETD     0x05        ; Table lookup return from 0x05
0xB5A:  100  RETD     0x00        ; Table lookup return from 0x00
0xB5B:  100  RETD     0x00        ; Table lookup return from 0x00
0xB5C:  100  RETD     0x00        ; Table lookup return from 0x00
0xB5D:  100  RETD     0x00        ; Table lookup return from 0x00
0xB5E:  100  RETD     0x00        ; Table lookup return from 0x00
0xB5F:  100  RETD     0x00        ; Table lookup return from 0x00
0xB60:  100  RETD     0x00        ; Table lookup return from 0x00
0xB61:  170  RETD     0x70        ; Table lookup return from 0x70
0xB62:  107  RETD     0x07        ; Table lookup return from 0x07
0xB63:  180  RETD     0x80        ; Table lookup return from 0x80
0xB64:  111  RETD     0x11        ; Table lookup return from 0x11
0xB65:  104  RETD     0x04        ; Table lookup return from 0x04
0xB66:  100  RETD     0x00        ; Table lookup return from 0x00
0xB67:  100  RETD     0x00        ; Table lookup return from 0x00
0xB68:  100  RETD     0x00        ; Table lookup return from 0x00
0xB69:  100  RETD     0x00        ; Table lookup return from 0x00
0xB6A:  100  RETD     0x00        ; Table lookup return from 0x00
0xB6B:  100  RETD     0x00        ; Table lookup return from 0x00
0xB6C:  100  RETD     0x00        ; Table lookup return from 0x00
0xB6D:  100  RETD     0x00        ; Table lookup return from 0x00
0xB6E:  100  RETD     0x00        ; Table lookup return from 0x00
0xB6F:  100  RETD     0x00        ; Table lookup return from 0x00
0xB70:  100  RETD     0x00        ; Table lookup return from 0x00
0xB71:  170  RETD     0x70        ; Table lookup return from 0x70
0xB72:  107  RETD     0x07        ; Table lookup return from 0x07
0xB73:  150  RETD     0x50        ; Table lookup return from 0x50 (MEM_CHARACTER)
0xB74:  111  RETD     0x11        ; Table lookup return from 0x11
0xB75:  104  RETD     0x04        ; Table lookup return from 0x04
0xB76:  100  RETD     0x00        ; Table lookup return from 0x00
0xB77:  100  RETD     0x00        ; Table lookup return from 0x00
0xB78:  100  RETD     0x00        ; Table lookup return from 0x00
0xB79:  105  RETD     0x05        ; Table lookup return from 0x05
0xB7A:  100  RETD     0x00        ; Table lookup return from 0x00
0xB7B:  100  RETD     0x00        ; Table lookup return from 0x00
0xB7C:  100  RETD     0x00        ; Table lookup return from 0x00
0xB7D:  100  RETD     0x00        ; Table lookup return from 0x00
0xB7E:  100  RETD     0x00        ; Table lookup return from 0x00
0xB7F:  100  RETD     0x00        ; Table lookup return from 0x00
0xB80:  100  RETD     0x00        ; Table lookup return from 0x00
0xB81:  140  RETD     0x40        ; Table lookup return from 0x40 (MEM_HUNGER)
0xB82:  107  RETD     0x07        ; Table lookup return from 0x07
0xB83:  150  RETD     0x50        ; Table lookup return from 0x50 (MEM_CHARACTER)
0xB84:  111  RETD     0x11        ; Table lookup return from 0x11
0xB85:  102  RETD     0x02        ; Table lookup return from 0x02
0xB86:  100  RETD     0x00        ; Table lookup return from 0x00
0xB87:  100  RETD     0x00        ; Table lookup return from 0x00
0xB88:  100  RETD     0x00        ; Table lookup return from 0x00
0xB89:  100  RETD     0x00        ; Table lookup return from 0x00
0xB8A:  100  RETD     0x00        ; Table lookup return from 0x00
0xB8B:  100  RETD     0x00        ; Table lookup return from 0x00
0xB8C:  100  RETD     0x00        ; Table lookup return from 0x00
0xB8D:  100  RETD     0x00        ; Table lookup return from 0x00
0xB8E:  100  RETD     0x00        ; Table lookup return from 0x00
0xB8F:  100  RETD     0x00        ; Table lookup return from 0x00
0xB90:  100  RETD     0x00        ; Table lookup return from 0x00
0xB91:  160  RETD     0x60        ; Table lookup return from 0x60
0xB92:  100  RETD     0x00        ; Table lookup return from 0x00
0xB93:  180  RETD     0x80        ; Table lookup return from 0x80
0xB94:  111  RETD     0x11        ; Table lookup return from 0x11
0xB95:  102  RETD     0x02        ; Table lookup return from 0x02
0xB96:  100  RETD     0x00        ; Table lookup return from 0x00
0xB97:  100  RETD     0x00        ; Table lookup return from 0x00
0xB98:  100  RETD     0x00        ; Table lookup return from 0x00
0xB99:  100  RETD     0x00        ; Table lookup return from 0x00
0xB9A:  100  RETD     0x00        ; Table lookup return from 0x00
0xB9B:  100  RETD     0x00        ; Table lookup return from 0x00
0xB9C:  100  RETD     0x00        ; Table lookup return from 0x00
0xB9D:  100  RETD     0x00        ; Table lookup return from 0x00
0xB9E:  100  RETD     0x00        ; Table lookup return from 0x00
0xB9F:  100  RETD     0x00        ; Table lookup return from 0x00
0xBA0:  100  RETD     0x00        ; Table lookup return from 0x00
0xBA1:  100  RETD     0x00        ; Table lookup return from 0x00
0xBA2:  107  RETD     0x07        ; Table lookup return from 0x07
0xBA3:  150  RETD     0x50        ; Table lookup return from 0x50 (MEM_CHARACTER)
0xBA4:  111  RETD     0x11        ; Table lookup return from 0x11
0xBA5:  104  RETD     0x04        ; Table lookup return from 0x04
0xBA6:  100  RETD     0x00        ; Table lookup return from 0x00
0xBA7:  105  RETD     0x05        ; Table lookup return from 0x05
0xBA8:  100  RETD     0x00        ; Table lookup return from 0x00
0xBA9:  105  RETD     0x05        ; Table lookup return from 0x05
0xBAA:  100  RETD     0x00        ; Table lookup return from 0x00
0xBAB:  100  RETD     0x00        ; Table lookup return from 0x00
0xBAC:  100  RETD     0x00        ; Table lookup return from 0x00
0xBAD:  100  RETD     0x00        ; Table lookup return from 0x00
0xBAE:  100  RETD     0x00        ; Table lookup return from 0x00
0xBAF:  100  RETD     0x00        ; Table lookup return from 0x00
0xBB0:  100  RETD     0x00        ; Table lookup return from 0x00
0xBB1:  190  RETD     0x90        ; Table lookup return from 0x90
0xBB2:  107  RETD     0x07        ; Table lookup return from 0x07
0xBB3:  150  RETD     0x50        ; Table lookup return from 0x50 (MEM_CHARACTER)
0xBB4:  111  RETD     0x11        ; Table lookup return from 0x11
0xBB5:  104  RETD     0x04        ; Table lookup return from 0x04
0xBB6:  105  RETD     0x05        ; Table lookup return from 0x05
0xBB7:  105  RETD     0x05        ; Table lookup return from 0x05
0xBB8:  100  RETD     0x00        ; Table lookup return from 0x00
0xBB9:  105  RETD     0x05        ; Table lookup return from 0x05
0xBBA:  100  RETD     0x00        ; Table lookup return from 0x00
0xBBB:  100  RETD     0x00        ; Table lookup return from 0x00
0xBBC:  100  RETD     0x00        ; Table lookup return from 0x00
0xBBD:  100  RETD     0x00        ; Table lookup return from 0x00
0xBBE:  100  RETD     0x00        ; Table lookup return from 0x00
0xBBF:  100  RETD     0x00        ; Table lookup return from 0x00
0xBC0:  1CA  RETD     0xCA        ; Table lookup return from 0xCA
0xBC1:  1CD  RETD     0xCD        ; Table lookup return from 0xCD
0xBC2:  1D0  RETD     0xD0        ; Table lookup return from 0xD0
0xBC3:  1D3  RETD     0xD3        ; Table lookup return from 0xD3
0xBC4:  1D8  RETD     0xD8        ; Table lookup return from 0xD8
0xBC5:  1DB  RETD     0xDB        ; Table lookup return from 0xDB
0xBC6:  1DE  RETD     0xDE        ; Table lookup return from 0xDE
0xBC7:  1E3  RETD     0xE3        ; Table lookup return from 0xE3
0xBC8:  1E8  RETD     0xE8        ; Table lookup return from 0xE8
0xBC9:  1E8  RETD     0xE8        ; Table lookup return from 0xE8
0xBCA:  101  RETD     0x01        ; Table lookup return from 0x01
0xBCB:  931  LBPX     #31         ; Store constant #31 into memory pointer
0xBCC:  1CA  RETD     0xCA        ; Table lookup return from 0xCA
0xBCD:  107  RETD     0x07        ; Table lookup return from 0x07
0xBCE:  937  LBPX     #37         ; Store constant #37 into memory pointer
0xBCF:  1CE  RETD     0xCE        ; Table lookup return from 0xCE
0xBD0:  100  RETD     0x00        ; Table lookup return from 0x00
0xBD1:  930  LBPX     #30         ; Store constant #30 into memory pointer
0xBD2:  1D0  RETD     0xD0        ; Table lookup return from 0xD0
0xBD3:  101  RETD     0x01        ; Table lookup return from 0x01
0xBD4:  131  RETD     0x31        ; Table lookup return from 0x31
0xBD5:  101  RETD     0x01        ; Table lookup return from 0x01
0xBD6:  9F1  LBPX     #F1         ; Store constant #F1 into memory pointer
0xBD7:  1D3  RETD     0xD3        ; Table lookup return from 0xD3
0xBD8:  100  RETD     0x00        ; Table lookup return from 0x00
0xBD9:  9F0  LBPX     #F0         ; Store constant #F0 into memory pointer
0xBDA:  1D8  RETD     0xD8        ; Table lookup return from 0xD8
0xBDB:  101  RETD     0x01        ; Table lookup return from 0x01
0xBDC:  9F1  LBPX     #F1         ; Store constant #F1 into memory pointer
0xBDD:  1DB  RETD     0xDB        ; Table lookup return from 0xDB
0xBDE:  101  RETD     0x01        ; Table lookup return from 0x01
0xBDF:  131  RETD     0x31        ; Table lookup return from 0x31
0xBE0:  101  RETD     0x01        ; Table lookup return from 0x01
0xBE1:  9B1  LBPX     #B1         ; Store constant #B1 into memory pointer
0xBE2:  1DE  RETD     0xDE        ; Table lookup return from 0xDE
0xBE3:  101  RETD     0x01        ; Table lookup return from 0x01
0xBE4:  131  RETD     0x31        ; Table lookup return from 0x31
0xBE5:  101  RETD     0x01        ; Table lookup return from 0x01
0xBE6:  931  LBPX     #31         ; Store constant #31 into memory pointer
0xBE7:  1E6  RETD     0xE6        ; Table lookup return from 0xE6
0xBE8:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0xBE9:  928  LBPX     #28         ; Store constant #28 into memory pointer
0xBEA:  929  LBPX     #29         ; Store constant #29 into memory pointer
0xBEB:  92A  LBPX     #2A         ; Store constant #2A into memory pointer
0xBEC:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0xBED:  92B  LBPX     #2B         ; Store constant #2B into memory pointer
0xBEE:  92C  LBPX     #2C         ; Store constant #2C into memory pointer
0xBEF:  12D  RETD     0x2D        ; Table lookup return from 0x2D (MEM_ATTENTION)
0xBF0:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0xBF1:  938  LBPX     #38         ; Store constant #38 into memory pointer
0xBF2:  939  LBPX     #39         ; Store constant #39 into memory pointer
0xBF3:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0xBF4:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0xBF5:  90E  LBPX     #E          ; Store constant #E into memory pointer
0xBF6:  917  LBPX     #17         ; Store constant #17 into memory pointer
0xBF7:  1FF  RETD     0xFF        ; Table lookup return from 0xFF
0xBF8:  931  LBPX     #31         ; Store constant #31 into memory pointer
0xBF9:  932  LBPX     #32         ; Store constant #32 into memory pointer
0xBFA:  933  LBPX     #33         ; Store constant #33 into memory pointer
0xBFB:  1FF  RETD     0xFF        ; Table lookup return from 0xFF
0xBFC:  FFF  NOP7                 ; 
0xBFD:  FFF  NOP7                 ; 
0xBFE:  FFF  NOP7                 ; 
0xBFF:  FFF  NOP7                 ; 
0xC00:  10C  RETD     0x0C        ; Table lookup return from 0x0C
0xC01:  111  RETD     0x11        ; Table lookup return from 0x11
0xC02:  118  RETD     0x18        ; Table lookup return from 0x18
0xC03:  124  RETD     0x24        ; Table lookup return from 0x24
0xC04:  131  RETD     0x31        ; Table lookup return from 0x31
0xC05:  13A  RETD     0x3A        ; Table lookup return from 0x3A
0xC06:  143  RETD     0x43        ; Table lookup return from 0x43 (MEM_DISCIPLINE)
0xC07:  14C  RETD     0x4C        ; Table lookup return from 0x4C
0xC08:  156  RETD     0x56        ; Table lookup return from 0x56
0xC09:  160  RETD     0x60        ; Table lookup return from 0x60
0xC0A:  16C  RETD     0x6C        ; Table lookup return from 0x6C
0xC0B:  173  RETD     0x73        ; Table lookup return from 0x73
0xC0C:  143  RETD     0x43        ; Table lookup return from 0x43 (MEM_DISCIPLINE)
0xC0D:  145  RETD     0x45        ; Table lookup return from 0x45
0xC0E:  147  RETD     0x47        ; Table lookup return from 0x47
0xC0F:  149  RETD     0x49        ; Table lookup return from 0x49 (MEM_SICK)
0xC10:  14B  RETD     0x4B        ; Table lookup return from 0x4B
0xC11:  17F  RETD     0x7F        ; Table lookup return from 0x7F
0xC12:  17F  RETD     0x7F        ; Table lookup return from 0x7F
0xC13:  17F  RETD     0x7F        ; Table lookup return from 0x7F
0xC14:  17F  RETD     0x7F        ; Table lookup return from 0x7F
0xC15:  17F  RETD     0x7F        ; Table lookup return from 0x7F
0xC16:  17F  RETD     0x7F        ; Table lookup return from 0x7F
0xC17:  17F  RETD     0x7F        ; Table lookup return from 0x7F
0xC18:  10C  RETD     0x0C        ; Table lookup return from 0x0C
0xC19:  109  RETD     0x09        ; Table lookup return from 0x09
0xC1A:  109  RETD     0x09        ; Table lookup return from 0x09
0xC1B:  10A  RETD     0x0A        ; Table lookup return from 0x0A
0xC1C:  10A  RETD     0x0A        ; Table lookup return from 0x0A
0xC1D:  107  RETD     0x07        ; Table lookup return from 0x07
0xC1E:  18C  RETD     0x8C        ; Table lookup return from 0x8C
0xC1F:  10D  RETD     0x0D        ; Table lookup return from 0x0D
0xC20:  10D  RETD     0x0D        ; Table lookup return from 0x0D
0xC21:  10F  RETD     0x0F        ; Table lookup return from 0x0F
0xC22:  18F  RETD     0x8F        ; Table lookup return from 0x8F
0xC23:  110  RETD     0x10        ; Table lookup return from 0x10
0xC24:  10C  RETD     0x0C        ; Table lookup return from 0x0C
0xC25:  109  RETD     0x09        ; Table lookup return from 0x09
0xC26:  10A  RETD     0x0A        ; Table lookup return from 0x0A
0xC27:  111  RETD     0x11        ; Table lookup return from 0x11
0xC28:  10D  RETD     0x0D        ; Table lookup return from 0x0D
0xC29:  10F  RETD     0x0F        ; Table lookup return from 0x0F
0xC2A:  110  RETD     0x10        ; Table lookup return from 0x10
0xC2B:  111  RETD     0x11        ; Table lookup return from 0x11
0xC2C:  109  RETD     0x09        ; Table lookup return from 0x09
0xC2D:  10F  RETD     0x0F        ; Table lookup return from 0x0F
0xC2E:  110  RETD     0x10        ; Table lookup return from 0x10
0xC2F:  10D  RETD     0x0D        ; Table lookup return from 0x0D
0xC30:  10A  RETD     0x0A        ; Table lookup return from 0x0A
0xC31:  117  RETD     0x17        ; Table lookup return from 0x17
0xC32:  118  RETD     0x18        ; Table lookup return from 0x18
0xC33:  118  RETD     0x18        ; Table lookup return from 0x18
0xC34:  119  RETD     0x19        ; Table lookup return from 0x19
0xC35:  119  RETD     0x19        ; Table lookup return from 0x19
0xC36:  11A  RETD     0x1A        ; Table lookup return from 0x1A
0xC37:  11A  RETD     0x1A        ; Table lookup return from 0x1A
0xC38:  19A  RETD     0x9A        ; Table lookup return from 0x9A
0xC39:  19A  RETD     0x9A        ; Table lookup return from 0x9A
0xC3A:  120  RETD     0x20        ; Table lookup return from 0x20
0xC3B:  1A2  RETD     0xA2        ; Table lookup return from 0xA2
0xC3C:  124  RETD     0x24        ; Table lookup return from 0x24
0xC3D:  1A6  RETD     0xA6        ; Table lookup return from 0xA6
0xC3E:  1A6  RETD     0xA6        ; Table lookup return from 0xA6
0xC3F:  122  RETD     0x22        ; Table lookup return from 0x22
0xC40:  1A6  RETD     0xA6        ; Table lookup return from 0xA6
0xC41:  126  RETD     0x26        ; Table lookup return from 0x26
0xC42:  124  RETD     0x24        ; Table lookup return from 0x24
0xC43:  127  RETD     0x27        ; Table lookup return from 0x27
0xC44:  128  RETD     0x28        ; Table lookup return from 0x28
0xC45:  129  RETD     0x29        ; Table lookup return from 0x29
0xC46:  12B  RETD     0x2B        ; Table lookup return from 0x2B
0xC47:  12C  RETD     0x2C        ; Table lookup return from 0x2C
0xC48:  1AC  RETD     0xAC        ; Table lookup return from 0xAC
0xC49:  12B  RETD     0x2B        ; Table lookup return from 0x2B
0xC4A:  1AC  RETD     0xAC        ; Table lookup return from 0xAC
0xC4B:  12C  RETD     0x2C        ; Table lookup return from 0x2C
0xC4C:  12D  RETD     0x2D        ; Table lookup return from 0x2D (MEM_ATTENTION)
0xC4D:  12D  RETD     0x2D        ; Table lookup return from 0x2D (MEM_ATTENTION)
0xC4E:  130  RETD     0x30        ; Table lookup return from 0x30
0xC4F:  131  RETD     0x31        ; Table lookup return from 0x31
0xC50:  130  RETD     0x30        ; Table lookup return from 0x30
0xC51:  132  RETD     0x32        ; Table lookup return from 0x32
0xC52:  132  RETD     0x32        ; Table lookup return from 0x32
0xC53:  133  RETD     0x33        ; Table lookup return from 0x33
0xC54:  134  RETD     0x34        ; Table lookup return from 0x34
0xC55:  1B4  RETD     0xB4        ; Table lookup return from 0xB4
0xC56:  117  RETD     0x17        ; Table lookup return from 0x17
0xC57:  118  RETD     0x18        ; Table lookup return from 0x18
0xC58:  119  RETD     0x19        ; Table lookup return from 0x19
0xC59:  11A  RETD     0x1A        ; Table lookup return from 0x1A
0xC5A:  19A  RETD     0x9A        ; Table lookup return from 0x9A
0xC5B:  11A  RETD     0x1A        ; Table lookup return from 0x1A
0xC5C:  1B8  RETD     0xB8        ; Table lookup return from 0xB8
0xC5D:  138  RETD     0x38        ; Table lookup return from 0x38
0xC5E:  119  RETD     0x19        ; Table lookup return from 0x19
0xC5F:  19A  RETD     0x9A        ; Table lookup return from 0x9A
0xC60:  117  RETD     0x17        ; Table lookup return from 0x17
0xC61:  117  RETD     0x17        ; Table lookup return from 0x17
0xC62:  118  RETD     0x18        ; Table lookup return from 0x18
0xC63:  119  RETD     0x19        ; Table lookup return from 0x19
0xC64:  117  RETD     0x17        ; Table lookup return from 0x17
0xC65:  11A  RETD     0x1A        ; Table lookup return from 0x1A
0xC66:  19A  RETD     0x9A        ; Table lookup return from 0x9A
0xC67:  118  RETD     0x18        ; Table lookup return from 0x18
0xC68:  198  RETD     0x98        ; Table lookup return from 0x98
0xC69:  197  RETD     0x97        ; Table lookup return from 0x97
0xC6A:  198  RETD     0x98        ; Table lookup return from 0x98
0xC6B:  19A  RETD     0x9A        ; Table lookup return from 0x9A
0xC6C:  135  RETD     0x35        ; Table lookup return from 0x35
0xC6D:  135  RETD     0x35        ; Table lookup return from 0x35
0xC6E:  136  RETD     0x36        ; Table lookup return from 0x36
0xC6F:  137  RETD     0x37        ; Table lookup return from 0x37
0xC70:  137  RETD     0x37        ; Table lookup return from 0x37
0xC71:  1B7  RETD     0xB7        ; Table lookup return from 0xB7
0xC72:  137  RETD     0x37        ; Table lookup return from 0x37
0xC73:  13C  RETD     0x3C        ; Table lookup return from 0x3C
0xC74:  13E  RETD     0x3E        ; Table lookup return from 0x3E
0xC75:  140  RETD     0x40        ; Table lookup return from 0x40 (MEM_HUNGER)
0xC76:  141  RETD     0x41        ; Table lookup return from 0x41 (MEM_HAPPY)
0xC77:  142  RETD     0x42        ; Table lookup return from 0x42 (MEM_NEGLECT)
0xC78:  141  RETD     0x41        ; Table lookup return from 0x41 (MEM_HAPPY)
0xC79:  FE8  JPBA                 ; 
0xC7A:  F5B  RST                  ; 
0xC7B:  B7C  LD_X     0x7C        ; Set pointer to RAM 0x7C
0xC7C:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0xC7D:  681  JP_Z     0x581       ; Flow to 0x581
0xC7E:  DEF  CP_R_I   [X], #15    ; Register [X] op with immediate #15
0xC7F:  682  JP_Z     0x582       ; Flow to 0x582
0xC80:  C2F  ADD_R_I  [X], #15    ; Register [X] op with immediate #15
0xC81:  FDF  RET                  ; 
0xC82:  B4A  LD_X     0x4A        ; Set pointer to RAM 0x4A (MEM_SLEEPING)
0xC83:  DA8  FAN_R_I              ; 
0xC84:  696  JP_Z     0x596       ; Flow to 0x596
0xC85:  5F8  CALZ     0x5F8       ; Flow to 0x5F8
0xC86:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0xC87:  E80  LD_XP_R              ; 
0xC88:  78E  JP_NZ    0x58E       ; Flow to 0x58E
0xC89:  B15  LD_X     0x15        ; Set pointer to RAM 0x15
0xC8A:  C2F  ADD_R_I  [X], #15    ; Register [X] op with immediate #15
0xC8B:  28D  JP_C     0x58D       ; Flow to 0x58D
0xC8C:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0xC8D:  FDF  RET                  ; 
0xC8E:  B04  LD_X     0x04        ; Set pointer to RAM 0x04
0xC8F:  C21  ADD_R_I  [X], #1     ; Register [X] op with immediate #1
0xC90:  EE0  INC_X                ; 
0xC91:  C60  ADC_R_I              ; 
0xC92:  395  JP_NC    0x595       ; Flow to 0x595
0xC93:  B04  LD_X     0x04        ; Set pointer to RAM 0x04
0xC94:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0xC95:  FDF  RET                  ; 
0xC96:  5F8  CALZ     0x5F8       ; Flow to 0x5F8
0xC97:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0xC98:  E80  LD_XP_R              ; 
0xC99:  7A1  JP_NZ    0x5A1       ; Flow to 0x5A1
0xC9A:  B16  LD_X     0x16        ; Set pointer to RAM 0x16
0xC9B:  C2F  ADD_R_I  [X], #15    ; Register [X] op with immediate #15
0xC9C:  EE0  INC_X                ; 
0xC9D:  C6F  ADC_R_I              ; 
0xC9E:  2A1  JP_C     0x5A1       ; Flow to 0x5A1
0xC9F:  B16  LD_X     0x16        ; Set pointer to RAM 0x16
0xCA0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xCA1:  B00  LD_X     0x00        ; Set pointer to RAM 0x00
0xCA2:  4D2  CALL     0x5D2       ; Flow to 0x5D2 (MEM_LIFECYCLE)
0xCA3:  B02  LD_X     0x02        ; Set pointer to RAM 0x02
0xCA4:  4D2  CALL     0x5D2       ; Flow to 0x5D2 (MEM_LIFECYCLE)
0xCA5:  B08  LD_X     0x08        ; Set pointer to RAM 0x08
0xCA6:  4D9  CALL     0x5D9       ; Flow to 0x5D9 (MEM_LIFECYCLE)
0xCA7:  B09  LD_X     0x09        ; Set pointer to RAM 0x09
0xCA8:  4D9  CALL     0x5D9       ; Flow to 0x5D9 (MEM_LIFECYCLE)
0xCA9:  B06  LD_X     0x06        ; Set pointer to RAM 0x06
0xCAA:  4D2  CALL     0x5D2       ; Flow to 0x5D2 (MEM_LIFECYCLE)
0xCAB:  5EF  CALZ     0x5EF       ; Flow to 0x5EF
0xCAC:  B40  LD_X     0x40        ; Set pointer to RAM 0x40 (MEM_HUNGER)
0xCAD:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0xCAE:  6B8  JP_Z     0x5B8       ; Flow to 0x5B8
0xCAF:  B41  LD_X     0x41        ; Set pointer to RAM 0x41 (MEM_HAPPY)
0xCB0:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0xCB1:  6B8  JP_Z     0x5B8       ; Flow to 0x5B8
0xCB2:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0xCB3:  E80  LD_XP_R              ; 
0xCB4:  B0A  LD_X     0x0A        ; Set pointer to RAM 0x0A
0xCB5:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xCB6:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0xCB7:  0BC  JP       0x5BC       ; Flow to 0x5BC
0xCB8:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0xCB9:  E80  LD_XP_R              ; 
0xCBA:  B0A  LD_X     0x0A        ; Set pointer to RAM 0x0A
0xCBB:  4DF  CALL     0x5DF       ; Flow to 0x5DF (MEM_LIFECYCLE)
0xCBC:  5FB  CALZ     0x5FB       ; Flow to 0x5FB
0xCBD:  6C3  JP_Z     0x5C3       ; Flow to 0x5C3
0xCBE:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0xCBF:  E80  LD_XP_R              ; 
0xCC0:  B0D  LD_X     0x0D        ; Set pointer to RAM 0x0D
0xCC1:  4DF  CALL     0x5DF       ; Flow to 0x5DF (MEM_LIFECYCLE)
0xCC2:  0C7  JP       0x5C7       ; Flow to 0x5C7
0xCC3:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0xCC4:  E80  LD_XP_R              ; 
0xCC5:  B0D  LD_X     0x0D        ; Set pointer to RAM 0x0D
0xCC6:  4C8  CALL     0x5C8       ; Flow to 0x5C8
0xCC7:  B10  LD_X     0x10        ; Set pointer to RAM 0x10
0xCC8:  C2F  ADD_R_I  [X], #15    ; Register [X] op with immediate #15
0xCC9:  EE0  INC_X                ; 
0xCCA:  C6F  ADC_R_I              ; 
0xCCB:  EE0  INC_X                ; 
0xCCC:  C6F  ADC_R_I              ; 
0xCCD:  2D1  JP_C     0x5D1       ; Flow to 0x5D1 (MEM_LIFECYCLE)
0xCCE:  A1E  ADC_XL               ; 
0xCCF:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xCD0:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0xCD1:  FDF  RET                  ; 
0xCD2:  C2F  ADD_R_I  [X], #15    ; Register [X] op with immediate #15
0xCD3:  EE0  INC_X                ; 
0xCD4:  C6F  ADC_R_I              ; 
0xCD5:  2D8  JP_C     0x5D8       ; Flow to 0x5D8 (MEM_LIFECYCLE)
0xCD6:  A1F  ADC_XL               ; 
0xCD7:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xCD8:  FDF  RET                  ; 
0xCD9:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0xCDA:  6DE  JP_Z     0x5DE       ; Flow to 0x5DE (MEM_LIFECYCLE)
0xCDB:  C21  ADD_R_I  [X], #1     ; Register [X] op with immediate #1
0xCDC:  3DE  JP_NC    0x5DE       ; Flow to 0x5DE (MEM_LIFECYCLE)
0xCDD:  E2F  LD_R_I   [X], #15    ; Register [X] op with immediate #15
0xCDE:  FDF  RET                  ; 
0xCDF:  C21  ADD_R_I  [X], #1     ; Register [X] op with immediate #1
0xCE0:  EE0  INC_X                ; 
0xCE1:  C60  ADC_R_I              ; 
0xCE2:  EE0  INC_X                ; 
0xCE3:  C60  ADC_R_I              ; 
0xCE4:  FDF  RET                  ; 
0xCE5:  C24  ADD_R_I  [X], #4     ; Register [X] op with immediate #4
0xCE6:  3E8  JP_NC    0x5E8       ; Flow to 0x5E8
0xCE7:  E2F  LD_R_I   [X], #15    ; Register [X] op with immediate #15
0xCE8:  B40  LD_X     0x40        ; Set pointer to RAM 0x40 (MEM_HUNGER)
0xCE9:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0xCEA:  6F4  JP_Z     0x5F4       ; Flow to 0x5F4
0xCEB:  B41  LD_X     0x41        ; Set pointer to RAM 0x41 (MEM_HAPPY)
0xCEC:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0xCED:  6F4  JP_Z     0x5F4       ; Flow to 0x5F4
0xCEE:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0xCEF:  E80  LD_XP_R              ; 
0xCF0:  B08  LD_X     0x08        ; Set pointer to RAM 0x08
0xCF1:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0xCF2:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0xCF3:  E80  LD_XP_R              ; 
0xCF4:  FDF  RET                  ; 
0xCF5:  918  LBPX     #18         ; Store constant #18 into memory pointer
0xCF6:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0xCF7:  91D  LBPX     #1D         ; Store constant #1D into memory pointer
0xCF8:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0xCF9:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xCFA:  90F  LBPX     #F          ; Store constant #F into memory pointer
0xCFB:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xCFC:  1FF  RETD     0xFF        ; Table lookup return from 0xFF
0xCFD:  FFF  NOP7                 ; 
0xCFE:  FFF  NOP7                 ; 
0xCFF:  FFF  NOP7                 ; 
0xD00:  110  RETD     0x10        ; Table lookup return from 0x10
0xD01:  115  RETD     0x15        ; Table lookup return from 0x15
0xD02:  11C  RETD     0x1C        ; Table lookup return from 0x1C
0xD03:  128  RETD     0x28        ; Table lookup return from 0x28
0xD04:  135  RETD     0x35        ; Table lookup return from 0x35
0xD05:  13E  RETD     0x3E        ; Table lookup return from 0x3E
0xD06:  147  RETD     0x47        ; Table lookup return from 0x47
0xD07:  150  RETD     0x50        ; Table lookup return from 0x50 (MEM_CHARACTER)
0xD08:  15A  RETD     0x5A        ; Table lookup return from 0x5A
0xD09:  164  RETD     0x64        ; Table lookup return from 0x64
0xD0A:  170  RETD     0x70        ; Table lookup return from 0x70
0xD0B:  177  RETD     0x77        ; Table lookup return from 0x77
0xD0C:  17D  RETD     0x7D        ; Table lookup return from 0x7D
0xD0D:  17D  RETD     0x7D        ; Table lookup return from 0x7D
0xD0E:  17D  RETD     0x7D        ; Table lookup return from 0x7D
0xD0F:  17D  RETD     0x7D        ; Table lookup return from 0x7D
0xD10:  144  RETD     0x44        ; Table lookup return from 0x44
0xD11:  146  RETD     0x46        ; Table lookup return from 0x46 (MEM_WEIGHT)
0xD12:  148  RETD     0x48        ; Table lookup return from 0x48 (MEM_SICK_LEVEL)
0xD13:  14A  RETD     0x4A        ; Table lookup return from 0x4A (MEM_SLEEPING)
0xD14:  14C  RETD     0x4C        ; Table lookup return from 0x4C
0xD15:  105  RETD     0x05        ; Table lookup return from 0x05
0xD16:  101  RETD     0x01        ; Table lookup return from 0x01
0xD17:  102  RETD     0x02        ; Table lookup return from 0x02
0xD18:  103  RETD     0x03        ; Table lookup return from 0x03
0xD19:  104  RETD     0x04        ; Table lookup return from 0x04
0xD1A:  100  RETD     0x00        ; Table lookup return from 0x00
0xD1B:  106  RETD     0x06        ; Table lookup return from 0x06
0xD1C:  108  RETD     0x08        ; Table lookup return from 0x08
0xD1D:  10B  RETD     0x0B        ; Table lookup return from 0x0B
0xD1E:  108  RETD     0x08        ; Table lookup return from 0x08
0xD1F:  108  RETD     0x08        ; Table lookup return from 0x08
0xD20:  10B  RETD     0x0B        ; Table lookup return from 0x0B
0xD21:  108  RETD     0x08        ; Table lookup return from 0x08
0xD22:  108  RETD     0x08        ; Table lookup return from 0x08
0xD23:  108  RETD     0x08        ; Table lookup return from 0x08
0xD24:  10B  RETD     0x0B        ; Table lookup return from 0x0B
0xD25:  108  RETD     0x08        ; Table lookup return from 0x08
0xD26:  108  RETD     0x08        ; Table lookup return from 0x08
0xD27:  10B  RETD     0x0B        ; Table lookup return from 0x0B
0xD28:  114  RETD     0x14        ; Table lookup return from 0x14
0xD29:  192  RETD     0x92        ; Table lookup return from 0x92
0xD2A:  113  RETD     0x13        ; Table lookup return from 0x13
0xD2B:  112  RETD     0x12        ; Table lookup return from 0x12
0xD2C:  115  RETD     0x15        ; Table lookup return from 0x15
0xD2D:  113  RETD     0x13        ; Table lookup return from 0x13
0xD2E:  112  RETD     0x12        ; Table lookup return from 0x12
0xD2F:  113  RETD     0x13        ; Table lookup return from 0x13
0xD30:  193  RETD     0x93        ; Table lookup return from 0x93
0xD31:  112  RETD     0x12        ; Table lookup return from 0x12
0xD32:  116  RETD     0x16        ; Table lookup return from 0x16
0xD33:  112  RETD     0x12        ; Table lookup return from 0x12
0xD34:  192  RETD     0x92        ; Table lookup return from 0x92
0xD35:  108  RETD     0x08        ; Table lookup return from 0x08
0xD36:  10B  RETD     0x0B        ; Table lookup return from 0x0B
0xD37:  108  RETD     0x08        ; Table lookup return from 0x08
0xD38:  108  RETD     0x08        ; Table lookup return from 0x08
0xD39:  10B  RETD     0x0B        ; Table lookup return from 0x0B
0xD3A:  108  RETD     0x08        ; Table lookup return from 0x08
0xD3B:  10B  RETD     0x0B        ; Table lookup return from 0x0B
0xD3C:  108  RETD     0x08        ; Table lookup return from 0x08
0xD3D:  10B  RETD     0x0B        ; Table lookup return from 0x0B
0xD3E:  121  RETD     0x21        ; Table lookup return from 0x21
0xD3F:  1A3  RETD     0xA3        ; Table lookup return from 0xA3
0xD40:  125  RETD     0x25        ; Table lookup return from 0x25
0xD41:  115  RETD     0x15        ; Table lookup return from 0x15
0xD42:  121  RETD     0x21        ; Table lookup return from 0x21
0xD43:  1A3  RETD     0xA3        ; Table lookup return from 0xA3
0xD44:  1A3  RETD     0xA3        ; Table lookup return from 0xA3
0xD45:  1A3  RETD     0xA3        ; Table lookup return from 0xA3
0xD46:  116  RETD     0x16        ; Table lookup return from 0x16
0xD47:  121  RETD     0x21        ; Table lookup return from 0x21
0xD48:  1A3  RETD     0xA3        ; Table lookup return from 0xA3
0xD49:  12A  RETD     0x2A        ; Table lookup return from 0x2A
0xD4A:  125  RETD     0x25        ; Table lookup return from 0x25
0xD4B:  115  RETD     0x15        ; Table lookup return from 0x15
0xD4C:  121  RETD     0x21        ; Table lookup return from 0x21
0xD4D:  116  RETD     0x16        ; Table lookup return from 0x16
0xD4E:  125  RETD     0x25        ; Table lookup return from 0x25
0xD4F:  121  RETD     0x21        ; Table lookup return from 0x21
0xD50:  12E  RETD     0x2E        ; Table lookup return from 0x2E
0xD51:  12F  RETD     0x2F        ; Table lookup return from 0x2F
0xD52:  12F  RETD     0x2F        ; Table lookup return from 0x2F
0xD53:  12E  RETD     0x2E        ; Table lookup return from 0x2E
0xD54:  1AE  RETD     0xAE        ; Table lookup return from 0xAE
0xD55:  115  RETD     0x15        ; Table lookup return from 0x15
0xD56:  12E  RETD     0x2E        ; Table lookup return from 0x2E
0xD57:  12E  RETD     0x2E        ; Table lookup return from 0x2E
0xD58:  12E  RETD     0x2E        ; Table lookup return from 0x2E
0xD59:  12E  RETD     0x2E        ; Table lookup return from 0x2E
0xD5A:  121  RETD     0x21        ; Table lookup return from 0x21
0xD5B:  125  RETD     0x25        ; Table lookup return from 0x25
0xD5C:  125  RETD     0x25        ; Table lookup return from 0x25
0xD5D:  115  RETD     0x15        ; Table lookup return from 0x15
0xD5E:  121  RETD     0x21        ; Table lookup return from 0x21
0xD5F:  121  RETD     0x21        ; Table lookup return from 0x21
0xD60:  1A3  RETD     0xA3        ; Table lookup return from 0xA3
0xD61:  123  RETD     0x23        ; Table lookup return from 0x23
0xD62:  116  RETD     0x16        ; Table lookup return from 0x16
0xD63:  125  RETD     0x25        ; Table lookup return from 0x25
0xD64:  139  RETD     0x39        ; Table lookup return from 0x39
0xD65:  13A  RETD     0x3A        ; Table lookup return from 0x3A
0xD66:  139  RETD     0x39        ; Table lookup return from 0x39
0xD67:  139  RETD     0x39        ; Table lookup return from 0x39
0xD68:  13B  RETD     0x3B        ; Table lookup return from 0x3B
0xD69:  13B  RETD     0x3B        ; Table lookup return from 0x3B
0xD6A:  13A  RETD     0x3A        ; Table lookup return from 0x3A
0xD6B:  13B  RETD     0x3B        ; Table lookup return from 0x3B
0xD6C:  13B  RETD     0x3B        ; Table lookup return from 0x3B
0xD6D:  13A  RETD     0x3A        ; Table lookup return from 0x3A
0xD6E:  1BA  RETD     0xBA        ; Table lookup return from 0xBA
0xD6F:  13B  RETD     0x3B        ; Table lookup return from 0x3B
0xD70:  1AE  RETD     0xAE        ; Table lookup return from 0xAE
0xD71:  12E  RETD     0x2E        ; Table lookup return from 0x2E
0xD72:  1AE  RETD     0xAE        ; Table lookup return from 0xAE
0xD73:  115  RETD     0x15        ; Table lookup return from 0x15
0xD74:  12E  RETD     0x2E        ; Table lookup return from 0x2E
0xD75:  12E  RETD     0x2E        ; Table lookup return from 0x2E
0xD76:  12F  RETD     0x2F        ; Table lookup return from 0x2F
0xD77:  13D  RETD     0x3D        ; Table lookup return from 0x3D
0xD78:  13F  RETD     0x3F        ; Table lookup return from 0x3F
0xD79:  12F  RETD     0x2F        ; Table lookup return from 0x2F
0xD7A:  115  RETD     0x15        ; Table lookup return from 0x15
0xD7B:  12E  RETD     0x2E        ; Table lookup return from 0x2E
0xD7C:  13D  RETD     0x3D        ; Table lookup return from 0x3D
0xD7D:  FE8  JPBA                 ; 
0xD7E:  5B3  CALZ     0x5B3       ; Flow to 0x5B3
0xD7F:  792  JP_NZ    0x592       ; Flow to 0x592
0xD80:  5F5  CALZ     0x5F5       ; Flow to 0x5F5
0xD81:  B40  LD_X     0x40        ; Set pointer to RAM 0x40 (MEM_HUNGER)
0xD82:  494  CALL     0x594       ; Flow to 0x594
0xD83:  BC0  LD_X     0xC0        ; Set pointer to RAM 0xC0
0xD84:  494  CALL     0x594       ; Flow to 0x594
0xD85:  E04  LD_R_I   A, #4       ; Register A op with immediate #4
0xD86:  E14  LD_R_I   B, #4       ; Register B op with immediate #4
0xD87:  E4A  PSET     #A          ; Set next Page to 10
0xD88:  4F0  CALL     0xAF0       ; Flow to 0xAF0
0xD89:  B4D  LD_X     0x4D        ; Set pointer to RAM 0x4D (MEM_POOP)
0xD8A:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0xD8B:  692  JP_Z     0xA92       ; Flow to 0xA92
0xD8C:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0xD8D:  E07  LD_R_I   A, #7       ; Register A op with immediate #7
0xD8E:  E15  LD_R_I   B, #5       ; Register B op with immediate #5
0xD8F:  806  LD_Y     0x06        ; Set pointer to RAM 0x06
0xD90:  E48  PSET     #8          ; Set next Page to 8
0xD91:  4A9  CALL     0x8A9       ; Flow to 0x8A9
0xD92:  E45  PSET     #5          ; Set next Page to 5
0xD93:  01A  JP       0x51A       ; Flow to 0x51A (MEM_BEHAVIOR_MISTAKE)
0xD94:  944  LBPX     #44         ; Store constant #44 into memory pointer
0xD95:  9EE  LBPX     #EE         ; Store constant #EE into memory pointer
0xD96:  9BB  LBPX     #BB         ; Store constant #BB into memory pointer
0xD97:  955  LBPX     #55         ; Store constant #55 into memory pointer
0xD98:  9AA  LBPX     #AA         ; Store constant #AA into memory pointer
0xD99:  911  LBPX     #11         ; Store constant #11 into memory pointer
0xD9A:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xD9B:  100  RETD     0x00        ; Table lookup return from 0x00
0xD9C:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xD9D:  121  RETD     0x21        ; Table lookup return from 0x21
0xD9E:  933  LBPX     #33         ; Store constant #33 into memory pointer
0xD9F:  945  LBPX     #45         ; Store constant #45 into memory pointer
0xDA0:  903  LBPX     #3          ; Store constant #3 into memory pointer
0xDA1:  944  LBPX     #44         ; Store constant #44 into memory pointer
0xDA2:  930  LBPX     #30         ; Store constant #30 into memory pointer
0xDA3:  933  LBPX     #33         ; Store constant #33 into memory pointer
0xDA4:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xDA5:  132  RETD     0x32        ; Table lookup return from 0x32
0xDA6:  943  LBPX     #43         ; Store constant #43 into memory pointer
0xDA7:  9AF  LBPX     #AF         ; Store constant #AF into memory pointer
0xDA8:  923  LBPX     #23         ; Store constant #23 into memory pointer
0xDA9:  99F  LBPX     #9F         ; Store constant #9F into memory pointer
0xDAA:  903  LBPX     #3          ; Store constant #3 into memory pointer
0xDAB:  98F  LBPX     #8F         ; Store constant #8F into memory pointer
0xDAC:  920  LBPX     #20         ; Store constant #20 into memory pointer
0xDAD:  97F  LBPX     #7F         ; Store constant #7F into memory pointer
0xDAE:  910  LBPX     #10         ; Store constant #10 into memory pointer
0xDAF:  96F  LBPX     #6F         ; Store constant #6F into memory pointer
0xDB0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xDB1:  15F  RETD     0x5F        ; Table lookup return from 0x5F
0xDB2:  984  LBPX     #84         ; Store constant #84 into memory pointer
0xDB3:  9AF  LBPX     #AF         ; Store constant #AF into memory pointer
0xDB4:  904  LBPX     #4          ; Store constant #4 into memory pointer
0xDB5:  99F  LBPX     #9F         ; Store constant #9F into memory pointer
0xDB6:  920  LBPX     #20         ; Store constant #20 into memory pointer
0xDB7:  976  LBPX     #76         ; Store constant #76 into memory pointer
0xDB8:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xDB9:  16F  RETD     0x6F        ; Table lookup return from 0x6F
0xDBA:  930  LBPX     #30         ; Store constant #30 into memory pointer
0xDBB:  9AF  LBPX     #AF         ; Store constant #AF into memory pointer
0xDBC:  920  LBPX     #20         ; Store constant #20 into memory pointer
0xDBD:  99F  LBPX     #9F         ; Store constant #9F into memory pointer
0xDBE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xDBF:  18F  RETD     0x8F        ; Table lookup return from 0x8F
0xDC0:  960  LBPX     #60         ; Store constant #60 into memory pointer
0xDC1:  9AF  LBPX     #AF         ; Store constant #AF into memory pointer
0xDC2:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xDC3:  19F  RETD     0x9F        ; Table lookup return from 0x9F
0xDC4:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xDC5:  1BF  RETD     0xBF        ; Table lookup return from 0xBF
0xDC6:  B90  LD_X     0x90        ; Set pointer to RAM 0x90
0xDC7:  E10  LD_R_I   B, #0       ; Register B op with immediate #0
0xDC8:  C0B  ADD_R_I  A, #11      ; Register A op with immediate #11
0xDC9:  C5C  ADC_R_I              ; 
0xDCA:  FE8  JPBA                 ; 
0xDCB:  09C  JP       0x59C       ; Flow to 0x59C
0xDCC:  09E  JP       0x59E       ; Flow to 0x59E
0xDCD:  0A6  JP       0x5A6       ; Flow to 0x5A6
0xDCE:  0B2  JP       0x5B2       ; Flow to 0x5B2
0xDCF:  0BA  JP       0x5BA       ; Flow to 0x5BA
0xDD0:  0C0  JP       0x5C0       ; Flow to 0x5C0
0xDD1:  0C4  JP       0x5C4       ; Flow to 0x5C4
0xDD2:  5F2  CALZ     0x5F2       ; Flow to 0x5F2
0xDD3:  E91  LD_YP_R              ; 
0xDD4:  B49  LD_X     0x49        ; Set pointer to RAM 0x49 (MEM_SICK)
0xDD5:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0xDD6:  B5D  LD_X     0x5D        ; Set pointer to RAM 0x5D (MEM_LIFECYCLE)
0xDD7:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0xDD8:  C08  ADD_R_I  A, #8       ; Register A op with immediate #8
0xDD9:  C55  ADC_R_I              ; 
0xDDA:  F80  LD_MN_A  0x00        ; Direct RAM access at 0x00
0xDDB:  F91  LD_MN_B  0x01        ; Direct RAM access at 0x01
0xDDC:  E05  LD_R_I   A, #5       ; Register A op with immediate #5
0xDDD:  F82  LD_MN_A  0x02        ; Direct RAM access at 0x02
0xDDE:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0xDDF:  E80  LD_XP_R              ; 
0xDE0:  B30  LD_X     0x30        ; Set pointer to RAM 0x30
0xDE1:  500  CALZ     0x500       ; Flow to 0x500 (MEM_CHARACTER)
0xDE2:  848  LD_Y     0x48        ; Set pointer to RAM 0x48 (MEM_SICK_LEVEL)
0xDE3:  EC3  LD_R_Q   A, [Y]      ; Register A op with [Y]
0xDE4:  E12  LD_R_I   B, #2       ; Register B op with immediate #2
0xDE5:  E91  LD_YP_R              ; 
0xDE6:  B10  LD_X     0x10        ; Set pointer to RAM 0x10
0xDE7:  840  LD_Y     0x40        ; Set pointer to RAM 0x40 (MEM_HUNGER)
0xDE8:  512  CALZ     0x512       ; Flow to 0x512 (MEM_BEHAVIOR_MISTAKE)
0xDE9:  599  CALZ     0x599       ; Flow to 0x599
0xDEA:  D88  FAN_R_I              ; 
0xDEB:  7EF  JP_NZ    0x5EF       ; Flow to 0x5EF
0xDEC:  B0D  LD_X     0x0D        ; Set pointer to RAM 0x0D
0xDED:  838  LD_Y     0x38        ; Set pointer to RAM 0x38
0xDEE:  599  CALZ     0x599       ; Flow to 0x599
0xDEF:  509  CALZ     0x509       ; Flow to 0x509 (MEM_CHARACTER)
0xDF0:  843  LD_Y     0x43        ; Set pointer to RAM 0x43 (MEM_DISCIPLINE)
0xDF1:  B13  LD_X     0x13        ; Set pointer to RAM 0x13
0xDF2:  ECB  LD_R_Q   [X], [Y]    ; Register [X] op with [Y]
0xDF3:  5EF  CALZ     0x5EF       ; Flow to 0x5EF
0xDF4:  844  LD_Y     0x44        ; Set pointer to RAM 0x44
0xDF5:  B43  LD_X     0x43        ; Set pointer to RAM 0x43 (MEM_DISCIPLINE)
0xDF6:  ECB  LD_R_Q   [X], [Y]    ; Register [X] op with [Y]
0xDF7:  B50  LD_X     0x50        ; Set pointer to RAM 0x50 (MEM_CHARACTER)
0xDF8:  DE2  CP_R_I   [X], #2     ; Register [X] op with immediate #2
0xDF9:  6FC  JP_Z     0x5FC       ; Flow to 0x5FC
0xDFA:  DE4  CP_R_I   [X], #4     ; Register [X] op with immediate #4
0xDFB:  7FE  JP_NZ    0x5FE       ; Flow to 0x5FE
0xDFC:  B43  LD_X     0x43        ; Set pointer to RAM 0x43 (MEM_DISCIPLINE)
0xDFD:  E28  LD_R_I   [X], #8     ; Register [X] op with immediate #8
0xDFE:  E46  PSET     #6          ; Set next Page to 6
0xDFF:  0E5  JP       0x6E5       ; Flow to 0x6E5
0xE00:  10E  RETD     0x0E        ; Table lookup return from 0x0E
0xE01:  111  RETD     0x11        ; Table lookup return from 0x11
0xE02:  116  RETD     0x16        ; Table lookup return from 0x16
0xE03:  11F  RETD     0x1F        ; Table lookup return from 0x1F
0xE04:  124  RETD     0x24        ; Table lookup return from 0x24
0xE05:  124  RETD     0x24        ; Table lookup return from 0x24
0xE06:  129  RETD     0x29        ; Table lookup return from 0x29
0xE07:  12E  RETD     0x2E        ; Table lookup return from 0x2E
0xE08:  131  RETD     0x31        ; Table lookup return from 0x31
0xE09:  13C  RETD     0x3C        ; Table lookup return from 0x3C
0xE0A:  145  RETD     0x45        ; Table lookup return from 0x45
0xE0B:  14E  RETD     0x4E        ; Table lookup return from 0x4E
0xE0C:  155  RETD     0x55        ; Table lookup return from 0x55
0xE0D:  FE8  JPBA                 ; 
0xE0E:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0xE0F:  950  LBPX     #50         ; Store constant #50 into memory pointer
0xE10:  10E  RETD     0x0E        ; Table lookup return from 0x0E
0xE11:  960  LBPX     #60         ; Store constant #60 into memory pointer
0xE12:  130  RETD     0x30        ; Table lookup return from 0x30
0xE13:  961  LBPX     #61         ; Store constant #61 into memory pointer
0xE14:  930  LBPX     #30         ; Store constant #30 into memory pointer
0xE15:  111  RETD     0x11        ; Table lookup return from 0x11
0xE16:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0xE17:  150  RETD     0x50        ; Table lookup return from 0x50 (MEM_CHARACTER)
0xE18:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0xE19:  150  RETD     0x50        ; Table lookup return from 0x50 (MEM_CHARACTER)
0xE1A:  95E  LBPX     #5E         ; Store constant #5E into memory pointer
0xE1B:  1A8  RETD     0xA8        ; Table lookup return from 0xA8
0xE1C:  95F  LBPX     #5F         ; Store constant #5F into memory pointer
0xE1D:  9A8  LBPX     #A8         ; Store constant #A8 into memory pointer
0xE1E:  11A  RETD     0x1A        ; Table lookup return from 0x1A
0xE1F:  965  LBPX     #65         ; Store constant #65 into memory pointer
0xE20:  130  RETD     0x30        ; Table lookup return from 0x30
0xE21:  964  LBPX     #64         ; Store constant #64 into memory pointer
0xE22:  930  LBPX     #30         ; Store constant #30 into memory pointer
0xE23:  11F  RETD     0x1F        ; Table lookup return from 0x1F
0xE24:  962  LBPX     #62         ; Store constant #62 into memory pointer
0xE25:  130  RETD     0x30        ; Table lookup return from 0x30
0xE26:  97F  LBPX     #7F         ; Store constant #7F into memory pointer
0xE27:  950  LBPX     #50         ; Store constant #50 into memory pointer
0xE28:  124  RETD     0x24        ; Table lookup return from 0x24
0xE29:  97F  LBPX     #7F         ; Store constant #7F into memory pointer
0xE2A:  150  RETD     0x50        ; Table lookup return from 0x50 (MEM_CHARACTER)
0xE2B:  963  LBPX     #63         ; Store constant #63 into memory pointer
0xE2C:  930  LBPX     #30         ; Store constant #30 into memory pointer
0xE2D:  129  RETD     0x29        ; Table lookup return from 0x29
0xE2E:  9D7  LBPX     #D7         ; Store constant #D7 into memory pointer
0xE2F:  9B0  LBPX     #B0         ; Store constant #B0 into memory pointer
0xE30:  12E  RETD     0x2E        ; Table lookup return from 0x2E
0xE31:  910  LBPX     #10         ; Store constant #10 into memory pointer
0xE32:  100  RETD     0x00        ; Table lookup return from 0x00
0xE33:  910  LBPX     #10         ; Store constant #10 into memory pointer
0xE34:  180  RETD     0x80        ; Table lookup return from 0x80
0xE35:  9D1  LBPX     #D1         ; Store constant #D1 into memory pointer
0xE36:  180  RETD     0x80        ; Table lookup return from 0x80
0xE37:  9D2  LBPX     #D2         ; Store constant #D2 into memory pointer
0xE38:  180  RETD     0x80        ; Table lookup return from 0x80
0xE39:  9D3  LBPX     #D3         ; Store constant #D3 into memory pointer
0xE3A:  980  LBPX     #80         ; Store constant #80 into memory pointer
0xE3B:  139  RETD     0x39        ; Table lookup return from 0x39
0xE3C:  910  LBPX     #10         ; Store constant #10 into memory pointer
0xE3D:  100  RETD     0x00        ; Table lookup return from 0x00
0xE3E:  910  LBPX     #10         ; Store constant #10 into memory pointer
0xE3F:  180  RETD     0x80        ; Table lookup return from 0x80
0xE40:  952  LBPX     #52         ; Store constant #52 into memory pointer
0xE41:  180  RETD     0x80        ; Table lookup return from 0x80
0xE42:  953  LBPX     #53         ; Store constant #53 into memory pointer
0xE43:  980  LBPX     #80         ; Store constant #80 into memory pointer
0xE44:  142  RETD     0x42        ; Table lookup return from 0x42 (MEM_NEGLECT)
0xE45:  914  LBPX     #14         ; Store constant #14 into memory pointer
0xE46:  100  RETD     0x00        ; Table lookup return from 0x00
0xE47:  914  LBPX     #14         ; Store constant #14 into memory pointer
0xE48:  180  RETD     0x80        ; Table lookup return from 0x80
0xE49:  9D5  LBPX     #D5         ; Store constant #D5 into memory pointer
0xE4A:  180  RETD     0x80        ; Table lookup return from 0x80
0xE4B:  9D6  LBPX     #D6         ; Store constant #D6 into memory pointer
0xE4C:  980  LBPX     #80         ; Store constant #80 into memory pointer
0xE4D:  10E  RETD     0x0E        ; Table lookup return from 0x0E
0xE4E:  914  LBPX     #14         ; Store constant #14 into memory pointer
0xE4F:  100  RETD     0x00        ; Table lookup return from 0x00
0xE50:  914  LBPX     #14         ; Store constant #14 into memory pointer
0xE51:  180  RETD     0x80        ; Table lookup return from 0x80
0xE52:  956  LBPX     #56         ; Store constant #56 into memory pointer
0xE53:  980  LBPX     #80         ; Store constant #80 into memory pointer
0xE54:  10E  RETD     0x0E        ; Table lookup return from 0x0E
0xE55:  910  LBPX     #10         ; Store constant #10 into memory pointer
0xE56:  100  RETD     0x00        ; Table lookup return from 0x00
0xE57:  9D0  LBPX     #D0         ; Store constant #D0 into memory pointer
0xE58:  980  LBPX     #80         ; Store constant #80 into memory pointer
0xE59:  157  RETD     0x57        ; Table lookup return from 0x57
0xE5A:  5EF  CALZ     0x6EF       ; Flow to 0x6EF
0xE5B:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0xE5C:  E41  PSET     #1          ; Set next Page to 1
0xE5D:  4EC  CALL     0x1EC       ; Flow to 0x1EC
0xE5E:  5CE  CALZ     0x1CE       ; Flow to 0x1CE
0xE5F:  940  LBPX     #40         ; Store constant #40 into memory pointer
0xE60:  B78  LD_X     0x78        ; Set pointer to RAM 0x78
0xE61:  EE2  LDPX_R               ; 
0xE62:  B75  LD_X     0x75        ; Set pointer to RAM 0x75
0xE63:  EE8  LDPX_R               ; 
0xE64:  E42  PSET     #2          ; Set next Page to 2
0xE65:  4C3  CALL     0x2C3       ; Flow to 0x2C3
0xE66:  279  JP_C     0x279       ; Flow to 0x279
0xE67:  679  JP_Z     0x279       ; Flow to 0x279
0xE68:  B90  LD_X     0x90        ; Set pointer to RAM 0x90
0xE69:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0xE6A:  B98  LD_X     0x98        ; Set pointer to RAM 0x98
0xE6B:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0xE6C:  B90  LD_X     0x90        ; Set pointer to RAM 0x90
0xE6D:  DC0  CP_R_I   A, #0       ; Register A op with immediate #0
0xE6E:  670  JP_Z     0x270       ; Flow to 0x270
0xE6F:  B98  LD_X     0x98        ; Set pointer to RAM 0x98
0xE70:  927  LBPX     #27         ; Store constant #27 into memory pointer
0xE71:  E47  PSET     #7          ; Set next Page to 7
0xE72:  492  CALL     0x792       ; Flow to 0x792
0xE73:  556  CALZ     0x756       ; Flow to 0x756
0xE74:  E4F  PSET     #F          ; Set next Page to 15
0xE75:  400  CALL     0xF00       ; Flow to 0xF00
0xE76:  664  JP_Z     0xF64       ; Flow to 0xF64
0xE77:  5EF  CALZ     0xFEF       ; Flow to 0xFEF
0xE78:  F41  SET                  ; 
0xE79:  B78  LD_X     0x78        ; Set pointer to RAM 0x78
0xE7A:  EE8  LDPX_R               ; 
0xE7B:  FDF  RET                  ; 
0xE7C:  FE8  JPBA                 ; 
0xE7D:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0xE7E:  908  LBPX     #8          ; Store constant #8 into memory pointer
0xE7F:  17D  RETD     0x7D        ; Table lookup return from 0x7D
0xE80:  930  LBPX     #30         ; Store constant #30 into memory pointer
0xE81:  903  LBPX     #3          ; Store constant #3 into memory pointer
0xE82:  17D  RETD     0x7D        ; Table lookup return from 0x7D
0xE83:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xE84:  107  RETD     0x07        ; Table lookup return from 0x07
0xE85:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xE86:  106  RETD     0x06        ; Table lookup return from 0x06
0xE87:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xE88:  105  RETD     0x05        ; Table lookup return from 0x05
0xE89:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xE8A:  104  RETD     0x04        ; Table lookup return from 0x04
0xE8B:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xE8C:  103  RETD     0x03        ; Table lookup return from 0x03
0xE8D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xE8E:  102  RETD     0x02        ; Table lookup return from 0x02
0xE8F:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xE90:  101  RETD     0x01        ; Table lookup return from 0x01
0xE91:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xE92:  900  LBPX     #0          ; Store constant #0 into memory pointer
0xE93:  17D  RETD     0x7D        ; Table lookup return from 0x7D
0xE94:  901  LBPX     #1          ; Store constant #1 into memory pointer
0xE95:  904  LBPX     #4          ; Store constant #4 into memory pointer
0xE96:  17D  RETD     0x7D        ; Table lookup return from 0x7D
0xE97:  901  LBPX     #1          ; Store constant #1 into memory pointer
0xE98:  105  RETD     0x05        ; Table lookup return from 0x05
0xE99:  901  LBPX     #1          ; Store constant #1 into memory pointer
0xE9A:  108  RETD     0x08        ; Table lookup return from 0x08
0xE9B:  901  LBPX     #1          ; Store constant #1 into memory pointer
0xE9C:  903  LBPX     #3          ; Store constant #3 into memory pointer
0xE9D:  17D  RETD     0x7D        ; Table lookup return from 0x7D
0xE9E:  905  LBPX     #5          ; Store constant #5 into memory pointer
0xE9F:  107  RETD     0x07        ; Table lookup return from 0x07
0xEA0:  903  LBPX     #3          ; Store constant #3 into memory pointer
0xEA1:  108  RETD     0x08        ; Table lookup return from 0x08
0xEA2:  90B  LBPX     #B          ; Store constant #B into memory pointer
0xEA3:  907  LBPX     #7          ; Store constant #7 into memory pointer
0xEA4:  17D  RETD     0x7D        ; Table lookup return from 0x7D
0xEA5:  901  LBPX     #1          ; Store constant #1 into memory pointer
0xEA6:  102  RETD     0x02        ; Table lookup return from 0x02
0xEA7:  901  LBPX     #1          ; Store constant #1 into memory pointer
0xEA8:  108  RETD     0x08        ; Table lookup return from 0x08
0xEA9:  907  LBPX     #7          ; Store constant #7 into memory pointer
0xEAA:  103  RETD     0x03        ; Table lookup return from 0x03
0xEAB:  907  LBPX     #7          ; Store constant #7 into memory pointer
0xEAC:  908  LBPX     #8          ; Store constant #8 into memory pointer
0xEAD:  1A5  RETD     0xA5        ; Table lookup return from 0xA5
0xEAE:  902  LBPX     #2          ; Store constant #2 into memory pointer
0xEAF:  101  RETD     0x01        ; Table lookup return from 0x01
0xEB0:  902  LBPX     #2          ; Store constant #2 into memory pointer
0xEB1:  104  RETD     0x04        ; Table lookup return from 0x04
0xEB2:  902  LBPX     #2          ; Store constant #2 into memory pointer
0xEB3:  102  RETD     0x02        ; Table lookup return from 0x02
0xEB4:  902  LBPX     #2          ; Store constant #2 into memory pointer
0xEB5:  105  RETD     0x05        ; Table lookup return from 0x05
0xEB6:  902  LBPX     #2          ; Store constant #2 into memory pointer
0xEB7:  103  RETD     0x03        ; Table lookup return from 0x03
0xEB8:  902  LBPX     #2          ; Store constant #2 into memory pointer
0xEB9:  106  RETD     0x06        ; Table lookup return from 0x06
0xEBA:  902  LBPX     #2          ; Store constant #2 into memory pointer
0xEBB:  104  RETD     0x04        ; Table lookup return from 0x04
0xEBC:  902  LBPX     #2          ; Store constant #2 into memory pointer
0xEBD:  907  LBPX     #7          ; Store constant #7 into memory pointer
0xEBE:  1AE  RETD     0xAE        ; Table lookup return from 0xAE
0xEBF:  912  LBPX     #12         ; Store constant #12 into memory pointer
0xEC0:  103  RETD     0x03        ; Table lookup return from 0x03
0xEC1:  919  LBPX     #19         ; Store constant #19 into memory pointer
0xEC2:  908  LBPX     #8          ; Store constant #8 into memory pointer
0xEC3:  1BF  RETD     0xBF        ; Table lookup return from 0xBF
0xEC4:  918  LBPX     #18         ; Store constant #18 into memory pointer
0xEC5:  103  RETD     0x03        ; Table lookup return from 0x03
0xEC6:  928  LBPX     #28         ; Store constant #28 into memory pointer
0xEC7:  908  LBPX     #8          ; Store constant #8 into memory pointer
0xEC8:  1C4  RETD     0xC4        ; Table lookup return from 0xC4
0xEC9:  91C  LBPX     #1C         ; Store constant #1C into memory pointer
0xECA:  103  RETD     0x03        ; Table lookup return from 0x03
0xECB:  944  LBPX     #44         ; Store constant #44 into memory pointer
0xECC:  908  LBPX     #8          ; Store constant #8 into memory pointer
0xECD:  1C9  RETD     0xC9        ; Table lookup return from 0xC9
0xECE:  950  LBPX     #50         ; Store constant #50 into memory pointer
0xECF:  903  LBPX     #3          ; Store constant #3 into memory pointer
0xED0:  17D  RETD     0x7D        ; Table lookup return from 0x7D
0xED1:  903  LBPX     #3          ; Store constant #3 into memory pointer
0xED2:  104  RETD     0x04        ; Table lookup return from 0x04
0xED3:  902  LBPX     #2          ; Store constant #2 into memory pointer
0xED4:  902  LBPX     #2          ; Store constant #2 into memory pointer
0xED5:  1D1  RETD     0xD1        ; Table lookup return from 0xD1
0xED6:  90C  LBPX     #C          ; Store constant #C into memory pointer
0xED7:  102  RETD     0x02        ; Table lookup return from 0x02
0xED8:  90C  LBPX     #C          ; Store constant #C into memory pointer
0xED9:  104  RETD     0x04        ; Table lookup return from 0x04
0xEDA:  90C  LBPX     #C          ; Store constant #C into memory pointer
0xEDB:  106  RETD     0x06        ; Table lookup return from 0x06
0xEDC:  90C  LBPX     #C          ; Store constant #C into memory pointer
0xEDD:  104  RETD     0x04        ; Table lookup return from 0x04
0xEDE:  90C  LBPX     #C          ; Store constant #C into memory pointer
0xEDF:  102  RETD     0x02        ; Table lookup return from 0x02
0xEE0:  90C  LBPX     #C          ; Store constant #C into memory pointer
0xEE1:  108  RETD     0x08        ; Table lookup return from 0x08
0xEE2:  910  LBPX     #10         ; Store constant #10 into memory pointer
0xEE3:  901  LBPX     #1          ; Store constant #1 into memory pointer
0xEE4:  17D  RETD     0x7D        ; Table lookup return from 0x7D
0xEE5:  90C  LBPX     #C          ; Store constant #C into memory pointer
0xEE6:  104  RETD     0x04        ; Table lookup return from 0x04
0xEE7:  906  LBPX     #6          ; Store constant #6 into memory pointer
0xEE8:  102  RETD     0x02        ; Table lookup return from 0x02
0xEE9:  90C  LBPX     #C          ; Store constant #C into memory pointer
0xEEA:  103  RETD     0x03        ; Table lookup return from 0x03
0xEEB:  906  LBPX     #6          ; Store constant #6 into memory pointer
0xEEC:  104  RETD     0x04        ; Table lookup return from 0x04
0xEED:  910  LBPX     #10         ; Store constant #10 into memory pointer
0xEEE:  905  LBPX     #5          ; Store constant #5 into memory pointer
0xEEF:  17D  RETD     0x7D        ; Table lookup return from 0x7D
0xEF0:  906  LBPX     #6          ; Store constant #6 into memory pointer
0xEF1:  101  RETD     0x01        ; Table lookup return from 0x01
0xEF2:  907  LBPX     #7          ; Store constant #7 into memory pointer
0xEF3:  102  RETD     0x02        ; Table lookup return from 0x02
0xEF4:  908  LBPX     #8          ; Store constant #8 into memory pointer
0xEF5:  103  RETD     0x03        ; Table lookup return from 0x03
0xEF6:  90A  LBPX     #A          ; Store constant #A into memory pointer
0xEF7:  104  RETD     0x04        ; Table lookup return from 0x04
0xEF8:  90C  LBPX     #C          ; Store constant #C into memory pointer
0xEF9:  105  RETD     0x05        ; Table lookup return from 0x05
0xEFA:  90E  LBPX     #E          ; Store constant #E into memory pointer
0xEFB:  906  LBPX     #6          ; Store constant #6 into memory pointer
0xEFC:  17D  RETD     0x7D        ; Table lookup return from 0x7D
0xEFD:  FFF  NOP7                 ; 
0xEFE:  FFF  NOP7                 ; 
0xEFF:  FFF  NOP7                 ; 
0xF00:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0xF01:  E90  LD_YP_R              ; 
0xF02:  5EF  CALZ     0xFEF       ; Flow to 0xFEF
0xF03:  B7C  LD_X     0x7C        ; Set pointer to RAM 0x7C
0xF04:  DEF  CP_R_I   [X], #15    ; Register [X] op with immediate #15
0xF05:  7D6  JP_NZ    0xFD6       ; Flow to 0xFD6
0xF06:  B5C  LD_X     0x5C        ; Set pointer to RAM 0x5C
0xF07:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0xF08:  7D6  JP_NZ    0xFD6       ; Flow to 0xFD6
0xF09:  B14  LD_X     0x14        ; Set pointer to RAM 0x14
0xF0A:  512  CALZ     0xF12       ; Flow to 0xF12
0xF0B:  EE2  LDPX_R               ; 
0xF0C:  EC6  LD_R_Q   B, [X]      ; Register B op with [X]
0xF0D:  509  CALZ     0xF09       ; Flow to 0xF09
0xF0E:  B4A  LD_X     0x4A        ; Set pointer to RAM 0x4A (MEM_SLEEPING)
0xF0F:  DA8  FAN_R_I              ; 
0xF10:  64A  JP_Z     0xF4A       ; Flow to 0xF4A
0xF11:  5F8  CALZ     0xFF8       ; Flow to 0xFF8
0xF12:  717  JP_NZ    0xF17       ; Flow to 0xF17
0xF13:  815  LD_Y     0x15        ; Set pointer to RAM 0x15
0xF14:  DF0  CP_R_I   [Y], #0     ; Register [Y] op with immediate #0
0xF15:  61D  JP_Z     0xF1D       ; Flow to 0xF1D
0xF16:  0D6  JP       0xFD6       ; Flow to 0xFD6
0xF17:  831  LD_Y     0x31        ; Set pointer to RAM 0x31
0xF18:  4D9  CALL     0xFD9       ; Flow to 0xFD9
0xF19:  235  JP_C     0xF35       ; Flow to 0xF35 (MEM_SICK_SEVERITY)
0xF1A:  833  LD_Y     0x33        ; Set pointer to RAM 0x33
0xF1B:  4D9  CALL     0xFD9       ; Flow to 0xFD9
0xF1C:  335  JP_NC    0xF35       ; Flow to 0xF35 (MEM_SICK_SEVERITY)
0xF1D:  B4B  LD_X     0x4B        ; Set pointer to RAM 0x4B
0xF1E:  E2F  LD_R_I   [X], #15    ; Register [X] op with immediate #15
0xF1F:  B4A  LD_X     0x4A        ; Set pointer to RAM 0x4A (MEM_SLEEPING)
0xF20:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0xF21:  F44  SET                  ; 
0xF22:  B54  LD_X     0x54        ; Set pointer to RAM 0x54 (MEM_AGE)
0xF23:  C21  ADD_R_I  [X], #1     ; Register [X] op with immediate #1
0xF24:  EE0  INC_X                ; 
0xF25:  C60  ADC_R_I              ; 
0xF26:  F5B  RST                  ; 
0xF27:  32A  JP_NC    0xF2A       ; Flow to 0xF2A
0xF28:  B54  LD_X     0x54        ; Set pointer to RAM 0x54 (MEM_AGE)
0xF29:  999  LBPX     #99         ; Store constant #99 into memory pointer
0xF2A:  B50  LD_X     0x50        ; Set pointer to RAM 0x50 (MEM_CHARACTER)
0xF2B:  DEF  CP_R_I   [X], #15    ; Register [X] op with immediate #15
0xF2C:  7D6  JP_NZ    0xFD6       ; Flow to 0xFD6
0xF2D:  810  LD_Y     0x10        ; Set pointer to RAM 0x10
0xF2E:  5D7  CALZ     0xFD7       ; Flow to 0xFD7
0xF2F:  7D6  JP_NZ    0xFD6       ; Flow to 0xFD6
0xF30:  834  LD_Y     0x34        ; Set pointer to RAM 0x34
0xF31:  43D  CALL     0xF3D       ; Flow to 0xF3D (MEM_SICK_SEVERITY)
0xF32:  836  LD_Y     0x36        ; Set pointer to RAM 0x36
0xF33:  43D  CALL     0xF3D       ; Flow to 0xF3D (MEM_SICK_SEVERITY)
0xF34:  0D6  JP       0xFD6       ; Flow to 0xFD6
0xF35:  805  LD_Y     0x05        ; Set pointer to RAM 0x05
0xF36:  DFF  CP_R_I   [Y], #15    ; Register [Y] op with immediate #15
0xF37:  63C  JP_Z     0xF3C       ; Flow to 0xF3C (MEM_SICK_SEVERITY)
0xF38:  DF4  CP_R_I   [Y], #4     ; Register [Y] op with immediate #4
0xF39:  23C  JP_C     0xF3C       ; Flow to 0xF3C (MEM_SICK_SEVERITY)
0xF3A:  E3F  LD_R_I   [Y], #15    ; Register [Y] op with immediate #15
0xF3B:  4DF  CALL     0xFDF       ; Flow to 0xFDF (INC_NEGLECT)
0xF3C:  0D6  JP       0xFD6       ; Flow to 0xFD6
0xF3D:  EF3  LDPY_R               ; 
0xF3E:  EC7  LD_R_Q   B, [Y]      ; Register B op with [Y]
0xF3F:  E8D  RRC                  ; 
0xF40:  E8C  RRC                  ; 
0xF41:  E8D  RRC                  ; 
0xF42:  E8C  RRC                  ; 
0xF43:  C93  AND_R_I  B, #3       ; Register B op with immediate #3
0xF44:  F5E  RST                  ; 
0xF45:  A3F  ADC_YL               ; 
0xF46:  AAC  SUB      [Y], A      ; Register [Y] op with A
0xF47:  EF0  INC_Y                ; 
0xF48:  ABD  SBC_R_Q              ; 
0xF49:  FDF  RET                  ; 
0xF4A:  5F8  CALZ     0xFF8       ; Flow to 0xFF8
0xF4B:  753  JP_NZ    0xF53       ; Flow to 0xF53
0xF4C:  815  LD_Y     0x15        ; Set pointer to RAM 0x15
0xF4D:  DF0  CP_R_I   [Y], #0     ; Register [Y] op with immediate #0
0xF4E:  65B  JP_Z     0xF5B       ; Flow to 0xF5B
0xF4F:  816  LD_Y     0x16        ; Set pointer to RAM 0x16
0xF50:  5D4  CALZ     0xFD4       ; Flow to 0xFD4
0xF51:  75B  JP_NZ    0xF5B       ; Flow to 0xF5B
0xF52:  059  JP       0xF59       ; Flow to 0xF59
0xF53:  833  LD_Y     0x33        ; Set pointer to RAM 0x33
0xF54:  4D9  CALL     0xFD9       ; Flow to 0xFD9
0xF55:  359  JP_NC    0xF59       ; Flow to 0xF59
0xF56:  831  LD_Y     0x31        ; Set pointer to RAM 0x31
0xF57:  4D9  CALL     0xFD9       ; Flow to 0xFD9
0xF58:  35B  JP_NC    0xF5B       ; Flow to 0xF5B
0xF59:  E01  LD_R_I   A, #1       ; Register A op with immediate #1
0xF5A:  0D4  JP       0xFD4       ; Flow to 0xFD4
0xF5B:  B49  LD_X     0x49        ; Set pointer to RAM 0x49 (MEM_SICK)
0xF5C:  DE3  CP_R_I   [X], #3     ; Register [X] op with immediate #3
0xF5D:  374  JP_NC    0xF74       ; Flow to 0xF74
0xF5E:  5F8  CALZ     0xFF8       ; Flow to 0xFF8
0xF5F:  763  JP_NZ    0xF63       ; Flow to 0xF63
0xF60:  5FD  CALZ     0xFFD       ; Flow to 0xFFD
0xF61:  671  JP_Z     0xF71       ; Flow to 0xF71
0xF62:  071  JP       0xF71       ; Flow to 0xF71
0xF63:  80C  LD_Y     0x0C        ; Set pointer to RAM 0x0C
0xF64:  DF2  CP_R_I   [Y], #2     ; Register [Y] op with immediate #2
0xF65:  269  JP_C     0xF69       ; Flow to 0xF69
0xF66:  80B  LD_Y     0x0B        ; Set pointer to RAM 0x0B
0xF67:  DFD  CP_R_I   [Y], #13    ; Register [Y] op with immediate #13
0xF68:  374  JP_NC    0xF74       ; Flow to 0xF74
0xF69:  5FD  CALZ     0xFFD       ; Flow to 0xFFD
0xF6A:  671  JP_Z     0xF71       ; Flow to 0xF71
0xF6B:  80F  LD_Y     0x0F        ; Set pointer to RAM 0x0F
0xF6C:  DF1  CP_R_I   [Y], #1     ; Register [Y] op with immediate #1
0xF6D:  271  JP_C     0xF71       ; Flow to 0xF71
0xF6E:  80E  LD_Y     0x0E        ; Set pointer to RAM 0x0E
0xF6F:  DF6  CP_R_I   [Y], #6     ; Register [Y] op with immediate #6
0xF70:  374  JP_NC    0xF74       ; Flow to 0xF74
0xF71:  B4F  LD_X     0x4F        ; Set pointer to RAM 0x4F
0xF72:  DE5  CP_R_I   [X], #5     ; Register [X] op with immediate #5
0xF73:  276  JP_C     0xF76       ; Flow to 0xF76
0xF74:  E06  LD_R_I   A, #6       ; Register A op with immediate #6
0xF75:  0D4  JP       0xFD4       ; Flow to 0xFD4
0xF76:  810  LD_Y     0x10        ; Set pointer to RAM 0x10
0xF77:  5D7  CALZ     0xFD7       ; Flow to 0xFD7
0xF78:  780  JP_NZ    0xF80       ; Flow to 0xF80
0xF79:  B50  LD_X     0x50        ; Set pointer to RAM 0x50 (MEM_CHARACTER)
0xF7A:  DEF  CP_R_I   [X], #15    ; Register [X] op with immediate #15
0xF7B:  37E  JP_NC    0xF7E       ; Flow to 0xF7E
0xF7C:  E05  LD_R_I   A, #5       ; Register A op with immediate #5
0xF7D:  0D4  JP       0xFD4       ; Flow to 0xFD4
0xF7E:  B4E  LD_X     0x4E        ; Set pointer to RAM 0x4E
0xF7F:  E2F  LD_R_I   [X], #15    ; Register [X] op with immediate #15
0xF80:  806  LD_Y     0x06        ; Set pointer to RAM 0x06
0xF81:  5D4  CALZ     0xFD4       ; Flow to 0xFD4
0xF82:  785  JP_NZ    0xF85       ; Flow to 0xF85
0xF83:  E04  LD_R_I   A, #4       ; Register A op with immediate #4
0xF84:  0D4  JP       0xFD4       ; Flow to 0xFD4
0xF85:  5FD  CALZ     0xFFD       ; Flow to 0xFFD
0xF86:  78D  JP_NZ    0xF8D       ; Flow to 0xF8D
0xF87:  80D  LD_Y     0x0D        ; Set pointer to RAM 0x0D
0xF88:  5D7  CALZ     0xFD7       ; Flow to 0xFD7
0xF89:  78D  JP_NZ    0xF8D       ; Flow to 0xF8D
0xF8A:  E2F  LD_R_I   [X], #15    ; Register [X] op with immediate #15
0xF8B:  B49  LD_X     0x49        ; Set pointer to RAM 0x49 (MEM_SICK)
0xF8C:  C21  ADD_R_I  [X], #1     ; Register [X] op with immediate #1
0xF8D:  800  LD_Y     0x00        ; Set pointer to RAM 0x00
0xF8E:  5D4  CALZ     0xFD4       ; Flow to 0xFD4
0xF8F:  7A2  JP_NZ    0xFA2       ; Flow to 0xFA2
0xF90:  834  LD_Y     0x34        ; Set pointer to RAM 0x34
0xF91:  EF3  LDPY_R               ; 
0xF92:  EC7  LD_R_Q   B, [Y]      ; Register B op with [Y]
0xF93:  800  LD_Y     0x00        ; Set pointer to RAM 0x00
0xF94:  512  CALZ     0xF12       ; Flow to 0xF12
0xF95:  EFC  LDPY_R               ; 
0xF96:  ECD  LD_R_Q   [Y], B      ; Register [Y] op with B
0xF97:  509  CALZ     0xF09       ; Flow to 0xF09
0xF98:  B40  LD_X     0x40        ; Set pointer to RAM 0x40 (MEM_HUNGER)
0xF99:  C2C  ADD_R_I  [X], #12    ; Register [X] op with immediate #12
0xF9A:  29E  JP_C     0xF9E       ; Flow to 0xF9E
0xF9B:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0xF9C:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0xF9D:  0D4  JP       0xFD4       ; Flow to 0xFD4
0xF9E:  813  LD_Y     0x13        ; Set pointer to RAM 0x13
0xF9F:  C3F  ADD_R_I  [Y], #15    ; Register [Y] op with immediate #15
0xFA0:  2A2  JP_C     0xFA2       ; Flow to 0xFA2
0xFA1:  E30  LD_R_I   [Y], #0     ; Register [Y] op with immediate #0
0xFA2:  802  LD_Y     0x02        ; Set pointer to RAM 0x02
0xFA3:  5D4  CALZ     0xFD4       ; Flow to 0xFD4
0xFA4:  7B7  JP_NZ    0xFB7       ; Flow to 0xFB7
0xFA5:  836  LD_Y     0x36        ; Set pointer to RAM 0x36
0xFA6:  EF3  LDPY_R               ; 
0xFA7:  EC7  LD_R_Q   B, [Y]      ; Register B op with [Y]
0xFA8:  802  LD_Y     0x02        ; Set pointer to RAM 0x02
0xFA9:  512  CALZ     0xF12       ; Flow to 0xF12
0xFAA:  EFC  LDPY_R               ; 
0xFAB:  ECD  LD_R_Q   [Y], B      ; Register [Y] op with B
0xFAC:  509  CALZ     0xF09       ; Flow to 0xF09
0xFAD:  B41  LD_X     0x41        ; Set pointer to RAM 0x41 (MEM_HAPPY)
0xFAE:  C2C  ADD_R_I  [X], #12    ; Register [X] op with immediate #12
0xFAF:  2B3  JP_C     0xFB3       ; Flow to 0xFB3
0xFB0:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0xFB1:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0xFB2:  0D4  JP       0xFD4       ; Flow to 0xFD4
0xFB3:  813  LD_Y     0x13        ; Set pointer to RAM 0x13
0xFB4:  C3F  ADD_R_I  [Y], #15    ; Register [Y] op with immediate #15
0xFB5:  2B7  JP_C     0xFB7       ; Flow to 0xFB7
0xFB6:  E30  LD_R_I   [Y], #0     ; Register [Y] op with immediate #0
0xFB7:  843  LD_Y     0x43        ; Set pointer to RAM 0x43 (MEM_DISCIPLINE)
0xFB8:  EC3  LD_R_Q   A, [Y]      ; Register A op with [Y]
0xFB9:  813  LD_Y     0x13        ; Set pointer to RAM 0x13
0xFBA:  DF0  CP_R_I   [Y], #0     ; Register [Y] op with immediate #0
0xFBB:  7C6  JP_NZ    0xFC6       ; Flow to 0xFC6
0xFBC:  ECC  LD_R_Q   [Y], A      ; Register [Y] op with A
0xFBD:  814  LD_Y     0x14        ; Set pointer to RAM 0x14
0xFBE:  B43  LD_X     0x43        ; Set pointer to RAM 0x43 (MEM_DISCIPLINE)
0xFBF:  F41  SET                  ; 
0xFC0:  A9E  ADC_R_Q  [Y], [X]    ; Register [Y] op with [X]
0xFC1:  2C6  JP_C     0xFC6       ; Flow to 0xFC6
0xFC2:  5F8  CALZ     0xFF8       ; Flow to 0xFF8
0xFC3:  6C6  JP_Z     0xFC6       ; Flow to 0xFC6
0xFC4:  E03  LD_R_I   A, #3       ; Register A op with immediate #3
0xFC5:  0D4  JP       0xFD4       ; Flow to 0xFD4
0xFC6:  808  LD_Y     0x08        ; Set pointer to RAM 0x08
0xFC7:  DFF  CP_R_I   [Y], #15    ; Register [Y] op with immediate #15
0xFC8:  7CD  JP_NZ    0xFCD       ; Flow to 0xFCD
0xFC9:  E30  LD_R_I   [Y], #0     ; Register [Y] op with immediate #0
0xFCA:  5F8  CALZ     0xFF8       ; Flow to 0xFF8
0xFCB:  6CD  JP_Z     0xFCD       ; Flow to 0xFCD
0xFCC:  4DF  CALL     0xFDF       ; Flow to 0xFDF (INC_NEGLECT)
0xFCD:  809  LD_Y     0x09        ; Set pointer to RAM 0x09
0xFCE:  DFF  CP_R_I   [Y], #15    ; Register [Y] op with immediate #15
0xFCF:  7D3  JP_NZ    0xFD3       ; Flow to 0xFD3
0xFD0:  E30  LD_R_I   [Y], #0     ; Register [Y] op with immediate #0

; =========================================================
; ROUTINE: INC_BEHAVIOR_MISTAKE
; Location: 0xFD1 (Page 15, Step D1)
; Trigger:  Discipline call timed out or was ignored
; Logic:    Increments [0x51] using saturated logic (max 15)
; =========================================================

0xFD1:  B51  LD_X     0x51        ; Set pointer to RAM 0x51 (MEM_BEHAVIOR_MISTAKE)
0xFD2:  4E8  CALL     0xFE8       ; Flow to 0xFE8 (SATURATED_INC_ROUTINE)
0xFD3:  0D6  JP       0xFD6       ; Flow to 0xFD6
0xFD4:  B5C  LD_X     0x5C        ; Set pointer to RAM 0x5C
0xFD5:  EC8  LD_R_Q   [X], A      ; Register [X] op with A
0xFD6:  B5C  LD_X     0x5C        ; Set pointer to RAM 0x5C
0xFD7:  DE0  CP_R_I   [X], #0     ; Register [X] op with immediate #0
0xFD8:  FDF  RET                  ; 
0xFD9:  F07  CP_R_Q   B, [Y]      ; Register B op with [Y]
0xFDA:  7DE  JP_NZ    0xFDE       ; Flow to 0xFDE
0xFDB:  A3F  ADC_YL               ; 
0xFDC:  A2F  ADC_YH               ; 
0xFDD:  F03  CP_R_Q   A, [Y]      ; Register A op with [Y]
0xFDE:  FDF  RET                  ; 

; =========================================================
; ROUTINE: INC_NEGLECT
; Location: 0xFDF (Page 15, Step DF)
; Trigger:  Attention call (Hunger/Happy=0) timed out
; Logic:    Increments [0x42] using saturated logic (max 15)
; =========================================================

0xFDF:  B42  LD_X     0x42        ; Set pointer to RAM 0x42 (MEM_NEGLECT)
0xFE0:  4E8  CALL     0xFE8       ; Flow to 0xFE8 (SATURATED_INC_ROUTINE)
0xFE1:  B50  LD_X     0x50        ; Set pointer to RAM 0x50 (MEM_CHARACTER)
0xFE2:  DEF  CP_R_I   [X], #15    ; Register [X] op with immediate #15
0xFE3:  7EB  JP_NZ    0xFEB       ; Flow to 0xFEB
0xFE4:  810  LD_Y     0x10        ; Set pointer to RAM 0x10
0xFE5:  5D7  CALZ     0xFD7       ; Flow to 0xFD7
0xFE6:  7EB  JP_NZ    0xFEB       ; Flow to 0xFEB
0xFE7:  B4F  LD_X     0x4F        ; Set pointer to RAM 0x4F

; =========================================================
; ROUTINE: SATURATED_INC_ROUTINE
; Location: 0xFE8 (Page 15, Step E8)
; Trigger:  Internal sub-call
; Logic:    [X] = Min([X] + 1, 15). Prevents overflow wrap-around.
; =========================================================

0xFE8:  C21  ADD_R_I  [X], #1     ; Register [X] op with immediate #1
0xFE9:  3EB  JP_NC    0xFEB       ; Flow to 0xFEB
0xFEA:  E2F  LD_R_I   [X], #15    ; Register [X] op with immediate #15
0xFEB:  FDF  RET                  ; 
0xFEC:  5EF  CALZ     0xFEF       ; Flow to 0xFEF
0xFED:  B7C  LD_X     0x7C        ; Set pointer to RAM 0x7C
0xFEE:  E2F  LD_R_I   [X], #15    ; Register [X] op with immediate #15
0xFEF:  E06  LD_R_I   A, #6       ; Register A op with immediate #6
0xFF0:  8D1  LD_Y     0xD1        ; Set pointer to RAM 0xD1
0xFF1:  5B7  CALZ     0xFB7       ; Flow to 0xFB7
0xFF2:  E02  LD_R_I   A, #2       ; Register A op with immediate #2
0xFF3:  E14  LD_R_I   B, #4       ; Register B op with immediate #4
0xFF4:  E48  PSET     #8          ; Set next Page to 8
0xFF5:  4A8  CALL     0x8A8       ; Flow to 0x8A8
0xFF6:  5EF  CALZ     0x8EF       ; Flow to 0x8EF
0xFF7:  B74  LD_X     0x74        ; Set pointer to RAM 0x74
0xFF8:  E6F  LDPX_MX  #F          ; Store constant #F into memory pointer
0xFF9:  B5D  LD_X     0x5D        ; Set pointer to RAM 0x5D (MEM_LIFECYCLE)
0xFFA:  911  LBPX     #11         ; Store constant #11 into memory pointer
0xFFB:  E44  PSET     #4          ; Set next Page to 4
0xFFC:  465  CALL     0x465       ; Flow to 0x465 (MEM_WEIGHT)
0xFFD:  E4D  PSET     #D          ; Set next Page to 13
0xFFE:  0D2  JP       0xDD2       ; Flow to 0xDD2
0xFFF:  FFF  NOP7                 ; 
0x1000:  FA0  LD_A_MN  0x00        ; Direct RAM access at 0x00
0x1001:  FB1  LD_B_MN  0x01        ; Direct RAM access at 0x01
0x1002:  E50  PSET     #10         ; Set next Page to 16
0x1003:  FE8  JPBA                 ; 
0x1004:  FA0  LD_A_MN  0x00        ; Direct RAM access at 0x00
0x1005:  FB1  LD_B_MN  0x01        ; Direct RAM access at 0x01
0x1006:  E51  PSET     #11         ; Set next Page to 17
0x1007:  FE8  JPBA                 ; 
0x1008:  FA0  LD_A_MN  0x00        ; Direct RAM access at 0x00
0x1009:  FB1  LD_B_MN  0x01        ; Direct RAM access at 0x01
0x100A:  E52  PSET     #12         ; Set next Page to 18
0x100B:  FE8  JPBA                 ; 
0x100C:  FA0  LD_A_MN  0x00        ; Direct RAM access at 0x00
0x100D:  FB1  LD_B_MN  0x01        ; Direct RAM access at 0x01
0x100E:  E53  PSET     #13         ; Set next Page to 19
0x100F:  FE8  JPBA                 ; 
0x1010:  FA0  LD_A_MN  0x00        ; Direct RAM access at 0x00
0x1011:  FB1  LD_B_MN  0x01        ; Direct RAM access at 0x01
0x1012:  E54  PSET     #14         ; Set next Page to 20
0x1013:  FE8  JPBA                 ; 
0x1014:  FA0  LD_A_MN  0x00        ; Direct RAM access at 0x00
0x1015:  FB1  LD_B_MN  0x01        ; Direct RAM access at 0x01
0x1016:  E55  PSET     #15         ; Set next Page to 21
0x1017:  FE8  JPBA                 ; 
0x1018:  FA0  LD_A_MN  0x00        ; Direct RAM access at 0x00
0x1019:  FB1  LD_B_MN  0x01        ; Direct RAM access at 0x01
0x101A:  E56  PSET     #16         ; Set next Page to 22
0x101B:  FE8  JPBA                 ; 
0x101C:  FA0  LD_A_MN  0x00        ; Direct RAM access at 0x00
0x101D:  FB1  LD_B_MN  0x01        ; Direct RAM access at 0x01
0x101E:  E57  PSET     #17         ; Set next Page to 23
0x101F:  FE8  JPBA                 ; 
0x1020:  423  CALL     0x1723      ; Flow to 0x1723
0x1021:  E40  PSET     #0          ; Set next Page to 0
0x1022:  009  JP       0x009       ; Flow to 0x009
0x1023:  FE8  JPBA                 ; 
0x1024:  FFF  NOP7                 ; 
0x1025:  FFF  NOP7                 ; 
0x1026:  FFF  NOP7                 ; 
0x1027:  FFF  NOP7                 ; 
0x1028:  FFF  NOP7                 ; 
0x1029:  FFF  NOP7                 ; 
0x102A:  FFF  NOP7                 ; 
0x102B:  FFF  NOP7                 ; 
0x102C:  FFF  NOP7                 ; 
0x102D:  FFF  NOP7                 ; 
0x102E:  FFF  NOP7                 ; 
0x102F:  FFF  NOP7                 ; 
0x1030:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1031:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1032:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1033:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1034:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1035:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x1036:  97A  LBPX     #7A         ; Store constant #7A into memory pointer
0x1037:  96E  LBPX     #6E         ; Store constant #6E into memory pointer
0x1038:  96E  LBPX     #6E         ; Store constant #6E into memory pointer
0x1039:  97A  LBPX     #7A         ; Store constant #7A into memory pointer
0x103A:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x103B:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x103C:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x103D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x103E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x103F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1040:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1041:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1042:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1043:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1044:  980  LBPX     #80         ; Store constant #80 into memory pointer
0x1045:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x1046:  9A0  LBPX     #A0         ; Store constant #A0 into memory pointer
0x1047:  9E0  LBPX     #E0         ; Store constant #E0 into memory pointer
0x1048:  9E0  LBPX     #E0         ; Store constant #E0 into memory pointer
0x1049:  9A0  LBPX     #A0         ; Store constant #A0 into memory pointer
0x104A:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x104B:  980  LBPX     #80         ; Store constant #80 into memory pointer
0x104C:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x104D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x104E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x104F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1050:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1051:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1052:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1053:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1054:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1055:  940  LBPX     #40         ; Store constant #40 into memory pointer
0x1056:  943  LBPX     #43         ; Store constant #43 into memory pointer
0x1057:  967  LBPX     #67         ; Store constant #67 into memory pointer
0x1058:  97E  LBPX     #7E         ; Store constant #7E into memory pointer
0x1059:  96E  LBPX     #6E         ; Store constant #6E into memory pointer
0x105A:  938  LBPX     #38         ; Store constant #38 into memory pointer
0x105B:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x105C:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x105D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x105E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x105F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1060:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1061:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1062:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1063:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1064:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x1065:  9A0  LBPX     #A0         ; Store constant #A0 into memory pointer
0x1066:  9A0  LBPX     #A0         ; Store constant #A0 into memory pointer
0x1067:  9E0  LBPX     #E0         ; Store constant #E0 into memory pointer
0x1068:  9E0  LBPX     #E0         ; Store constant #E0 into memory pointer
0x1069:  9A0  LBPX     #A0         ; Store constant #A0 into memory pointer
0x106A:  9A0  LBPX     #A0         ; Store constant #A0 into memory pointer
0x106B:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x106C:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x106D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x106E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x106F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1070:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1071:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1072:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1073:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1074:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1075:  91E  LBPX     #1E         ; Store constant #1E into memory pointer
0x1076:  93D  LBPX     #3D         ; Store constant #3D into memory pointer
0x1077:  927  LBPX     #27         ; Store constant #27 into memory pointer
0x1078:  927  LBPX     #27         ; Store constant #27 into memory pointer
0x1079:  93D  LBPX     #3D         ; Store constant #3D into memory pointer
0x107A:  91E  LBPX     #1E         ; Store constant #1E into memory pointer
0x107B:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x107C:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x107D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x107E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x107F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1080:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1081:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1082:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1083:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1084:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1085:  92C  LBPX     #2C         ; Store constant #2C into memory pointer
0x1086:  96E  LBPX     #6E         ; Store constant #6E into memory pointer
0x1087:  97A  LBPX     #7A         ; Store constant #7A into memory pointer
0x1088:  97A  LBPX     #7A         ; Store constant #7A into memory pointer
0x1089:  97E  LBPX     #7E         ; Store constant #7E into memory pointer
0x108A:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x108B:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x108C:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x108D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x108E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x108F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1090:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1091:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1092:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1093:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1094:  90E  LBPX     #E          ; Store constant #E into memory pointer
0x1095:  93D  LBPX     #3D         ; Store constant #3D into memory pointer
0x1096:  97B  LBPX     #7B         ; Store constant #7B into memory pointer
0x1097:  94F  LBPX     #4F         ; Store constant #4F into memory pointer
0x1098:  94F  LBPX     #4F         ; Store constant #4F into memory pointer
0x1099:  97B  LBPX     #7B         ; Store constant #7B into memory pointer
0x109A:  93D  LBPX     #3D         ; Store constant #3D into memory pointer
0x109B:  90E  LBPX     #E          ; Store constant #E into memory pointer
0x109C:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x109D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x109E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x109F:  100  RETD     0x00        ; Table lookup return from 0x00
0x10A0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10A1:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10A2:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10A3:  9E0  LBPX     #E0         ; Store constant #E0 into memory pointer
0x10A4:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x10A5:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x10A6:  928  LBPX     #28         ; Store constant #28 into memory pointer
0x10A7:  988  LBPX     #88         ; Store constant #88 into memory pointer
0x10A8:  988  LBPX     #88         ; Store constant #88 into memory pointer
0x10A9:  928  LBPX     #28         ; Store constant #28 into memory pointer
0x10AA:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x10AB:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x10AC:  9E0  LBPX     #E0         ; Store constant #E0 into memory pointer
0x10AD:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10AE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10AF:  100  RETD     0x00        ; Table lookup return from 0x00
0x10B0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10B1:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10B2:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10B3:  903  LBPX     #3          ; Store constant #3 into memory pointer
0x10B4:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x10B5:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x10B6:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x10B7:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x10B8:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x10B9:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x10BA:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x10BB:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x10BC:  903  LBPX     #3          ; Store constant #3 into memory pointer
0x10BD:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10BE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10BF:  100  RETD     0x00        ; Table lookup return from 0x00
0x10C0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10C1:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10C2:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10C3:  9E0  LBPX     #E0         ; Store constant #E0 into memory pointer
0x10C4:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x10C5:  928  LBPX     #28         ; Store constant #28 into memory pointer
0x10C6:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x10C7:  9C8  LBPX     #C8         ; Store constant #C8 into memory pointer
0x10C8:  9C8  LBPX     #C8         ; Store constant #C8 into memory pointer
0x10C9:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x10CA:  928  LBPX     #28         ; Store constant #28 into memory pointer
0x10CB:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x10CC:  9E0  LBPX     #E0         ; Store constant #E0 into memory pointer
0x10CD:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10CE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10CF:  100  RETD     0x00        ; Table lookup return from 0x00
0x10D0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10D1:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10D2:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10D3:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x10D4:  986  LBPX     #86         ; Store constant #86 into memory pointer
0x10D5:  9CD  LBPX     #CD         ; Store constant #CD into memory pointer
0x10D6:  999  LBPX     #99         ; Store constant #99 into memory pointer
0x10D7:  9F1  LBPX     #F1         ; Store constant #F1 into memory pointer
0x10D8:  901  LBPX     #1          ; Store constant #1 into memory pointer
0x10D9:  911  LBPX     #11         ; Store constant #11 into memory pointer
0x10DA:  912  LBPX     #12         ; Store constant #12 into memory pointer
0x10DB:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x10DC:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x10DD:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10DE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10DF:  100  RETD     0x00        ; Table lookup return from 0x00
0x10E0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10E1:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10E2:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10E3:  901  LBPX     #1          ; Store constant #1 into memory pointer
0x10E4:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x10E5:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x10E6:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x10E7:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x10E8:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x10E9:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x10EA:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x10EB:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x10EC:  901  LBPX     #1          ; Store constant #1 into memory pointer
0x10ED:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10EE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10EF:  100  RETD     0x00        ; Table lookup return from 0x00
0x10F0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10F1:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10F2:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10F3:  9E0  LBPX     #E0         ; Store constant #E0 into memory pointer
0x10F4:  990  LBPX     #90         ; Store constant #90 into memory pointer
0x10F5:  988  LBPX     #88         ; Store constant #88 into memory pointer
0x10F6:  988  LBPX     #88         ; Store constant #88 into memory pointer
0x10F7:  928  LBPX     #28         ; Store constant #28 into memory pointer
0x10F8:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x10F9:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x10FA:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x10FB:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x10FC:  9E0  LBPX     #E0         ; Store constant #E0 into memory pointer
0x10FD:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10FE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x10FF:  100  RETD     0x00        ; Table lookup return from 0x00
0x1100:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1101:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1102:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1103:  9E0  LBPX     #E0         ; Store constant #E0 into memory pointer
0x1104:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x1105:  928  LBPX     #28         ; Store constant #28 into memory pointer
0x1106:  928  LBPX     #28         ; Store constant #28 into memory pointer
0x1107:  988  LBPX     #88         ; Store constant #88 into memory pointer
0x1108:  988  LBPX     #88         ; Store constant #88 into memory pointer
0x1109:  928  LBPX     #28         ; Store constant #28 into memory pointer
0x110A:  928  LBPX     #28         ; Store constant #28 into memory pointer
0x110B:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x110C:  9E0  LBPX     #E0         ; Store constant #E0 into memory pointer
0x110D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x110E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x110F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1110:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x1111:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x1112:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x1113:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x1114:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x1115:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x1116:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x1117:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x1118:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x1119:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x111A:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x111B:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x111C:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x111D:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x111E:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x111F:  1FF  RETD     0xFF        ; Table lookup return from 0xFF
0x1120:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1121:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1122:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1123:  9E0  LBPX     #E0         ; Store constant #E0 into memory pointer
0x1124:  990  LBPX     #90         ; Store constant #90 into memory pointer
0x1125:  988  LBPX     #88         ; Store constant #88 into memory pointer
0x1126:  988  LBPX     #88         ; Store constant #88 into memory pointer
0x1127:  928  LBPX     #28         ; Store constant #28 into memory pointer
0x1128:  928  LBPX     #28         ; Store constant #28 into memory pointer
0x1129:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x112A:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x112B:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x112C:  9E0  LBPX     #E0         ; Store constant #E0 into memory pointer
0x112D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x112E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x112F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1130:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1131:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1132:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1133:  9FC  LBPX     #FC         ; Store constant #FC into memory pointer
0x1134:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x1135:  979  LBPX     #79         ; Store constant #79 into memory pointer
0x1136:  9F3  LBPX     #F3         ; Store constant #F3 into memory pointer
0x1137:  9F1  LBPX     #F1         ; Store constant #F1 into memory pointer
0x1138:  9F1  LBPX     #F1         ; Store constant #F1 into memory pointer
0x1139:  9F3  LBPX     #F3         ; Store constant #F3 into memory pointer
0x113A:  979  LBPX     #79         ; Store constant #79 into memory pointer
0x113B:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x113C:  9FC  LBPX     #FC         ; Store constant #FC into memory pointer
0x113D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x113E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x113F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1140:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1141:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1142:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1143:  9E0  LBPX     #E0         ; Store constant #E0 into memory pointer
0x1144:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x1145:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x1146:  928  LBPX     #28         ; Store constant #28 into memory pointer
0x1147:  988  LBPX     #88         ; Store constant #88 into memory pointer
0x1148:  988  LBPX     #88         ; Store constant #88 into memory pointer
0x1149:  928  LBPX     #28         ; Store constant #28 into memory pointer
0x114A:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x114B:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x114C:  9E0  LBPX     #E0         ; Store constant #E0 into memory pointer
0x114D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x114E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x114F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1150:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1151:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1152:  901  LBPX     #1          ; Store constant #1 into memory pointer
0x1153:  907  LBPX     #7          ; Store constant #7 into memory pointer
0x1154:  918  LBPX     #18         ; Store constant #18 into memory pointer
0x1155:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x1156:  918  LBPX     #18         ; Store constant #18 into memory pointer
0x1157:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x1158:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x1159:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x115A:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x115B:  909  LBPX     #9          ; Store constant #9 into memory pointer
0x115C:  907  LBPX     #7          ; Store constant #7 into memory pointer
0x115D:  901  LBPX     #1          ; Store constant #1 into memory pointer
0x115E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x115F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1160:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1161:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1162:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1163:  903  LBPX     #3          ; Store constant #3 into memory pointer
0x1164:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x1165:  918  LBPX     #18         ; Store constant #18 into memory pointer
0x1166:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x1167:  918  LBPX     #18         ; Store constant #18 into memory pointer
0x1168:  918  LBPX     #18         ; Store constant #18 into memory pointer
0x1169:  928  LBPX     #28         ; Store constant #28 into memory pointer
0x116A:  918  LBPX     #18         ; Store constant #18 into memory pointer
0x116B:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x116C:  903  LBPX     #3          ; Store constant #3 into memory pointer
0x116D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x116E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x116F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1170:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1171:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1172:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1173:  903  LBPX     #3          ; Store constant #3 into memory pointer
0x1174:  91C  LBPX     #1C         ; Store constant #1C into memory pointer
0x1175:  928  LBPX     #28         ; Store constant #28 into memory pointer
0x1176:  918  LBPX     #18         ; Store constant #18 into memory pointer
0x1177:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x1178:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x1179:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x117A:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x117B:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x117C:  903  LBPX     #3          ; Store constant #3 into memory pointer
0x117D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x117E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x117F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1180:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1181:  97E  LBPX     #7E         ; Store constant #7E into memory pointer
0x1182:  981  LBPX     #81         ; Store constant #81 into memory pointer
0x1183:  999  LBPX     #99         ; Store constant #99 into memory pointer
0x1184:  9AF  LBPX     #AF         ; Store constant #AF into memory pointer
0x1185:  9B5  LBPX     #B5         ; Store constant #B5 into memory pointer
0x1186:  9AD  LBPX     #AD         ; Store constant #AD into memory pointer
0x1187:  9B5  LBPX     #B5         ; Store constant #B5 into memory pointer
0x1188:  9AD  LBPX     #AD         ; Store constant #AD into memory pointer
0x1189:  9B5  LBPX     #B5         ; Store constant #B5 into memory pointer
0x118A:  9AD  LBPX     #AD         ; Store constant #AD into memory pointer
0x118B:  9B5  LBPX     #B5         ; Store constant #B5 into memory pointer
0x118C:  9AF  LBPX     #AF         ; Store constant #AF into memory pointer
0x118D:  999  LBPX     #99         ; Store constant #99 into memory pointer
0x118E:  981  LBPX     #81         ; Store constant #81 into memory pointer
0x118F:  17E  RETD     0x7E        ; Table lookup return from 0x7E
0x1190:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1191:  903  LBPX     #3          ; Store constant #3 into memory pointer
0x1192:  905  LBPX     #5          ; Store constant #5 into memory pointer
0x1193:  90C  LBPX     #C          ; Store constant #C into memory pointer
0x1194:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x1195:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x1196:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x1197:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x1198:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x1199:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x119A:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x119B:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x119C:  90C  LBPX     #C          ; Store constant #C into memory pointer
0x119D:  905  LBPX     #5          ; Store constant #5 into memory pointer
0x119E:  903  LBPX     #3          ; Store constant #3 into memory pointer
0x119F:  100  RETD     0x00        ; Table lookup return from 0x00
0x11A0:  950  LBPX     #50         ; Store constant #50 into memory pointer
0x11A1:  9A8  LBPX     #A8         ; Store constant #A8 into memory pointer
0x11A2:  9A8  LBPX     #A8         ; Store constant #A8 into memory pointer
0x11A3:  9A8  LBPX     #A8         ; Store constant #A8 into memory pointer
0x11A4:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x11A5:  90A  LBPX     #A          ; Store constant #A into memory pointer
0x11A6:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x11A7:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x11A8:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x11A9:  90A  LBPX     #A          ; Store constant #A into memory pointer
0x11AA:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x11AB:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x11AC:  9F0  LBPX     #F0         ; Store constant #F0 into memory pointer
0x11AD:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x11AE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x11AF:  100  RETD     0x00        ; Table lookup return from 0x00
0x11B0:  96C  LBPX     #6C         ; Store constant #6C into memory pointer
0x11B1:  992  LBPX     #92         ; Store constant #92 into memory pointer
0x11B2:  954  LBPX     #54         ; Store constant #54 into memory pointer
0x11B3:  9D4  LBPX     #D4         ; Store constant #D4 into memory pointer
0x11B4:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x11B5:  906  LBPX     #6          ; Store constant #6 into memory pointer
0x11B6:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x11B7:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x11B8:  90A  LBPX     #A          ; Store constant #A into memory pointer
0x11B9:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x11BA:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x11BB:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x11BC:  9F0  LBPX     #F0         ; Store constant #F0 into memory pointer
0x11BD:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x11BE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x11BF:  100  RETD     0x00        ; Table lookup return from 0x00
0x11C0:  944  LBPX     #44         ; Store constant #44 into memory pointer
0x11C1:  9AA  LBPX     #AA         ; Store constant #AA into memory pointer
0x11C2:  9AA  LBPX     #AA         ; Store constant #AA into memory pointer
0x11C3:  9BA  LBPX     #BA         ; Store constant #BA into memory pointer
0x11C4:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x11C5:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x11C6:  906  LBPX     #6          ; Store constant #6 into memory pointer
0x11C7:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x11C8:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x11C9:  922  LBPX     #22         ; Store constant #22 into memory pointer
0x11CA:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x11CB:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x11CC:  9F0  LBPX     #F0         ; Store constant #F0 into memory pointer
0x11CD:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x11CE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x11CF:  100  RETD     0x00        ; Table lookup return from 0x00
0x11D0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x11D1:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x11D2:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x11D3:  9F0  LBPX     #F0         ; Store constant #F0 into memory pointer
0x11D4:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x11D5:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x11D6:  90A  LBPX     #A          ; Store constant #A into memory pointer
0x11D7:  90A  LBPX     #A          ; Store constant #A into memory pointer
0x11D8:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x11D9:  90A  LBPX     #A          ; Store constant #A into memory pointer
0x11DA:  90A  LBPX     #A          ; Store constant #A into memory pointer
0x11DB:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x11DC:  9A8  LBPX     #A8         ; Store constant #A8 into memory pointer
0x11DD:  9A8  LBPX     #A8         ; Store constant #A8 into memory pointer
0x11DE:  9A8  LBPX     #A8         ; Store constant #A8 into memory pointer
0x11DF:  150  RETD     0x50        ; Table lookup return from 0x50 (MEM_CHARACTER)
0x11E0:  E0F  LD_R_I   A, #15      ; Register A op with immediate #15
0x11E1:  E80  LD_XP_R              ; 
0x11E2:  B10  LD_X     0x10        ; Set pointer to RAM 0x10
0x11E3:  E68  LDPX_MX  #8          ; Store constant #8 into memory pointer
0x11E4:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x11E5:  E61  LDPX_MX  #1          ; Store constant #1 into memory pointer
0x11E6:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x11E7:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x11E8:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x11E9:  B26  LD_X     0x26        ; Set pointer to RAM 0x26
0x11EA:  907  LBPX     #7          ; Store constant #7 into memory pointer
0x11EB:  B54  LD_X     0x54        ; Set pointer to RAM 0x54 (MEM_AGE)
0x11EC:  E6F  LDPX_MX  #F          ; Store constant #F into memory pointer
0x11ED:  B71  LD_X     0x71        ; Set pointer to RAM 0x71
0x11EE:  E68  LDPX_MX  #8          ; Store constant #8 into memory pointer
0x11EF:  E68  LDPX_MX  #8          ; Store constant #8 into memory pointer
0x11F0:  B76  LD_X     0x76        ; Set pointer to RAM 0x76
0x11F1:  E63  LDPX_MX  #3          ; Store constant #3 into memory pointer
0x11F2:  E62  LDPX_MX  #2          ; Store constant #2 into memory pointer
0x11F3:  E62  LDPX_MX  #2          ; Store constant #2 into memory pointer
0x11F4:  E62  LDPX_MX  #2          ; Store constant #2 into memory pointer
0x11F5:  E42  PSET     #2          ; Set next Page to 2
0x11F6:  044  JP       0x244       ; Flow to 0x244
0x11F7:  FFF  NOP7                 ; 
0x11F8:  FFF  NOP7                 ; 
0x11F9:  FFF  NOP7                 ; 
0x11FA:  FFF  NOP7                 ; 
0x11FB:  FFF  NOP7                 ; 
0x11FC:  FFF  NOP7                 ; 
0x11FD:  FFF  NOP7                 ; 
0x11FE:  FFF  NOP7                 ; 
0x11FF:  FFF  NOP7                 ; 
0x1200:  E00  LD_R_I   A, #0       ; Register A op with immediate #0
0x1201:  E80  LD_XP_R              ; 
0x1202:  B24  LD_X     0x24        ; Set pointer to RAM 0x24
0x1203:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1204:  B14  LD_X     0x14        ; Set pointer to RAM 0x14
0x1205:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x1206:  B32  LD_X     0x32        ; Set pointer to RAM 0x32
0x1207:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1208:  B36  LD_X     0x36        ; Set pointer to RAM 0x36
0x1209:  97D  LBPX     #7D         ; Store constant #7D into memory pointer
0x120A:  B58  LD_X     0x58        ; Set pointer to RAM 0x58
0x120B:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x120C:  B7B  LD_X     0x7B        ; Set pointer to RAM 0x7B
0x120D:  E6F  LDPX_MX  #F          ; Store constant #F into memory pointer
0x120E:  B7D  LD_X     0x7D        ; Set pointer to RAM 0x7D
0x120F:  E2F  LD_R_I   [X], #15    ; Register [X] op with immediate #15
0x1210:  B3C  LD_X     0x3C        ; Set pointer to RAM 0x3C
0x1211:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0x1212:  B74  LD_X     0x74        ; Set pointer to RAM 0x74
0x1213:  E60  LDPX_MX  #0          ; Store constant #0 into memory pointer
0x1214:  B7C  LD_X     0x7C        ; Set pointer to RAM 0x7C
0x1215:  E25  LD_R_I   [X], #5     ; Register [X] op with immediate #5
0x1216:  E0F  LD_R_I   A, #15      ; Register A op with immediate #15
0x1217:  E80  LD_XP_R              ; 
0x1218:  B71  LD_X     0x71        ; Set pointer to RAM 0x71
0x1219:  E20  LD_R_I   [X], #0     ; Register [X] op with immediate #0
0x121A:  B78  LD_X     0x78        ; Set pointer to RAM 0x78
0x121B:  E21  LD_R_I   [X], #1     ; Register [X] op with immediate #1
0x121C:  B00  LD_X     0x00        ; Set pointer to RAM 0x00
0x121D:  EE2  LDPX_R               ; 
0x121E:  EE2  LDPX_R               ; 
0x121F:  EC2  LD_R_Q   A, [X]      ; Register A op with [X]
0x1220:  E42  PSET     #2          ; Set next Page to 2
0x1221:  055  JP       0x255       ; Flow to 0x255
0x1222:  EEE  LDPX_R               ; 
0x1223:  EF0  INC_Y                ; 
0x1224:  EEE  LDPX_R               ; 
0x1225:  EF0  INC_Y                ; 
0x1226:  EEE  LDPX_R               ; 
0x1227:  EF0  INC_Y                ; 
0x1228:  EEE  LDPX_R               ; 
0x1229:  EF0  INC_Y                ; 
0x122A:  EEE  LDPX_R               ; 
0x122B:  EF0  INC_Y                ; 
0x122C:  EEE  LDPX_R               ; 
0x122D:  E42  PSET     #2          ; Set next Page to 2
0x122E:  029  JP       0x229       ; Flow to 0x229
0x122F:  FFF  NOP7                 ; 
0x1230:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1231:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1232:  960  LBPX     #60         ; Store constant #60 into memory pointer
0x1233:  990  LBPX     #90         ; Store constant #90 into memory pointer
0x1234:  90E  LBPX     #E          ; Store constant #E into memory pointer
0x1235:  957  LBPX     #57         ; Store constant #57 into memory pointer
0x1236:  946  LBPX     #46         ; Store constant #46 into memory pointer
0x1237:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x1238:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x1239:  914  LBPX     #14         ; Store constant #14 into memory pointer
0x123A:  906  LBPX     #6          ; Store constant #6 into memory pointer
0x123B:  90F  LBPX     #F          ; Store constant #F into memory pointer
0x123C:  91E  LBPX     #1E         ; Store constant #1E into memory pointer
0x123D:  9F0  LBPX     #F0         ; Store constant #F0 into memory pointer
0x123E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x123F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1240:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1241:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1242:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1243:  907  LBPX     #7          ; Store constant #7 into memory pointer
0x1244:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x1245:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x1246:  940  LBPX     #40         ; Store constant #40 into memory pointer
0x1247:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x1248:  913  LBPX     #13         ; Store constant #13 into memory pointer
0x1249:  934  LBPX     #34         ; Store constant #34 into memory pointer
0x124A:  943  LBPX     #43         ; Store constant #43 into memory pointer
0x124B:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x124C:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x124D:  907  LBPX     #7          ; Store constant #7 into memory pointer
0x124E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x124F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1250:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1251:  960  LBPX     #60         ; Store constant #60 into memory pointer
0x1252:  99E  LBPX     #9E         ; Store constant #9E into memory pointer
0x1253:  907  LBPX     #7          ; Store constant #7 into memory pointer
0x1254:  907  LBPX     #7          ; Store constant #7 into memory pointer
0x1255:  916  LBPX     #16         ; Store constant #16 into memory pointer
0x1256:  944  LBPX     #44         ; Store constant #44 into memory pointer
0x1257:  944  LBPX     #44         ; Store constant #44 into memory pointer
0x1258:  944  LBPX     #44         ; Store constant #44 into memory pointer
0x1259:  916  LBPX     #16         ; Store constant #16 into memory pointer
0x125A:  907  LBPX     #7          ; Store constant #7 into memory pointer
0x125B:  907  LBPX     #7          ; Store constant #7 into memory pointer
0x125C:  99E  LBPX     #9E         ; Store constant #9E into memory pointer
0x125D:  960  LBPX     #60         ; Store constant #60 into memory pointer
0x125E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x125F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1260:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1261:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1262:  907  LBPX     #7          ; Store constant #7 into memory pointer
0x1263:  90A  LBPX     #A          ; Store constant #A into memory pointer
0x1264:  913  LBPX     #13         ; Store constant #13 into memory pointer
0x1265:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x1266:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x1267:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x1268:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x1269:  940  LBPX     #40         ; Store constant #40 into memory pointer
0x126A:  931  LBPX     #31         ; Store constant #31 into memory pointer
0x126B:  90A  LBPX     #A          ; Store constant #A into memory pointer
0x126C:  906  LBPX     #6          ; Store constant #6 into memory pointer
0x126D:  901  LBPX     #1          ; Store constant #1 into memory pointer
0x126E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x126F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1270:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1271:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1272:  970  LBPX     #70         ; Store constant #70 into memory pointer
0x1273:  988  LBPX     #88         ; Store constant #88 into memory pointer
0x1274:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x1275:  974  LBPX     #74         ; Store constant #74 into memory pointer
0x1276:  972  LBPX     #72         ; Store constant #72 into memory pointer
0x1277:  973  LBPX     #73         ; Store constant #73 into memory pointer
0x1278:  977  LBPX     #77         ; Store constant #77 into memory pointer
0x1279:  906  LBPX     #6          ; Store constant #6 into memory pointer
0x127A:  90C  LBPX     #C          ; Store constant #C into memory pointer
0x127B:  92C  LBPX     #2C         ; Store constant #2C into memory pointer
0x127C:  91C  LBPX     #1C         ; Store constant #1C into memory pointer
0x127D:  9FC  LBPX     #FC         ; Store constant #FC into memory pointer
0x127E:  918  LBPX     #18         ; Store constant #18 into memory pointer
0x127F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1280:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1281:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1282:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1283:  90F  LBPX     #F          ; Store constant #F into memory pointer
0x1284:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x1285:  940  LBPX     #40         ; Store constant #40 into memory pointer
0x1286:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x1287:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x1288:  941  LBPX     #41         ; Store constant #41 into memory pointer
0x1289:  932  LBPX     #32         ; Store constant #32 into memory pointer
0x128A:  911  LBPX     #11         ; Store constant #11 into memory pointer
0x128B:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x128C:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x128D:  907  LBPX     #7          ; Store constant #7 into memory pointer
0x128E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x128F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1290:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1291:  960  LBPX     #60         ; Store constant #60 into memory pointer
0x1292:  99E  LBPX     #9E         ; Store constant #9E into memory pointer
0x1293:  90F  LBPX     #F          ; Store constant #F into memory pointer
0x1294:  917  LBPX     #17         ; Store constant #17 into memory pointer
0x1295:  916  LBPX     #16         ; Store constant #16 into memory pointer
0x1296:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x1297:  944  LBPX     #44         ; Store constant #44 into memory pointer
0x1298:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x1299:  916  LBPX     #16         ; Store constant #16 into memory pointer
0x129A:  917  LBPX     #17         ; Store constant #17 into memory pointer
0x129B:  90F  LBPX     #F          ; Store constant #F into memory pointer
0x129C:  99E  LBPX     #9E         ; Store constant #9E into memory pointer
0x129D:  960  LBPX     #60         ; Store constant #60 into memory pointer
0x129E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x129F:  100  RETD     0x00        ; Table lookup return from 0x00
0x12A0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x12A1:  960  LBPX     #60         ; Store constant #60 into memory pointer
0x12A2:  9D0  LBPX     #D0         ; Store constant #D0 into memory pointer
0x12A3:  958  LBPX     #58         ; Store constant #58 into memory pointer
0x12A4:  944  LBPX     #44         ; Store constant #44 into memory pointer
0x12A5:  94A  LBPX     #4A         ; Store constant #4A into memory pointer
0x12A6:  942  LBPX     #42         ; Store constant #42 into memory pointer
0x12A7:  946  LBPX     #46         ; Store constant #46 into memory pointer
0x12A8:  942  LBPX     #42         ; Store constant #42 into memory pointer
0x12A9:  92A  LBPX     #2A         ; Store constant #2A into memory pointer
0x12AA:  906  LBPX     #6          ; Store constant #6 into memory pointer
0x12AB:  91C  LBPX     #1C         ; Store constant #1C into memory pointer
0x12AC:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x12AD:  9F0  LBPX     #F0         ; Store constant #F0 into memory pointer
0x12AE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x12AF:  100  RETD     0x00        ; Table lookup return from 0x00
0x12B0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x12B1:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x12B2:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x12B3:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x12B4:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x12B5:  92A  LBPX     #2A         ; Store constant #2A into memory pointer
0x12B6:  942  LBPX     #42         ; Store constant #42 into memory pointer
0x12B7:  946  LBPX     #46         ; Store constant #46 into memory pointer
0x12B8:  946  LBPX     #46         ; Store constant #46 into memory pointer
0x12B9:  946  LBPX     #46         ; Store constant #46 into memory pointer
0x12BA:  942  LBPX     #42         ; Store constant #42 into memory pointer
0x12BB:  92A  LBPX     #2A         ; Store constant #2A into memory pointer
0x12BC:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x12BD:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x12BE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x12BF:  100  RETD     0x00        ; Table lookup return from 0x00
0x12C0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x12C1:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x12C2:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x12C3:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x12C4:  90E  LBPX     #E          ; Store constant #E into memory pointer
0x12C5:  91E  LBPX     #1E         ; Store constant #1E into memory pointer
0x12C6:  93E  LBPX     #3E         ; Store constant #3E into memory pointer
0x12C7:  97E  LBPX     #7E         ; Store constant #7E into memory pointer
0x12C8:  97E  LBPX     #7E         ; Store constant #7E into memory pointer
0x12C9:  93E  LBPX     #3E         ; Store constant #3E into memory pointer
0x12CA:  91E  LBPX     #1E         ; Store constant #1E into memory pointer
0x12CB:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x12CC:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x12CD:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x12CE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x12CF:  100  RETD     0x00        ; Table lookup return from 0x00
0x12D0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x12D1:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x12D2:  907  LBPX     #7          ; Store constant #7 into memory pointer
0x12D3:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x12D4:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x12D5:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x12D6:  916  LBPX     #16         ; Store constant #16 into memory pointer
0x12D7:  914  LBPX     #14         ; Store constant #14 into memory pointer
0x12D8:  934  LBPX     #34         ; Store constant #34 into memory pointer
0x12D9:  942  LBPX     #42         ; Store constant #42 into memory pointer
0x12DA:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x12DB:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x12DC:  906  LBPX     #6          ; Store constant #6 into memory pointer
0x12DD:  901  LBPX     #1          ; Store constant #1 into memory pointer
0x12DE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x12DF:  100  RETD     0x00        ; Table lookup return from 0x00
0x12E0:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x12E1:  928  LBPX     #28         ; Store constant #28 into memory pointer
0x12E2:  9A8  LBPX     #A8         ; Store constant #A8 into memory pointer
0x12E3:  9A8  LBPX     #A8         ; Store constant #A8 into memory pointer
0x12E4:  9A4  LBPX     #A4         ; Store constant #A4 into memory pointer
0x12E5:  9A4  LBPX     #A4         ; Store constant #A4 into memory pointer
0x12E6:  96C  LBPX     #6C         ; Store constant #6C into memory pointer
0x12E7:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x12E8:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x12E9:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x12EA:  92C  LBPX     #2C         ; Store constant #2C into memory pointer
0x12EB:  91C  LBPX     #1C         ; Store constant #1C into memory pointer
0x12EC:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x12ED:  9F0  LBPX     #F0         ; Store constant #F0 into memory pointer
0x12EE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x12EF:  100  RETD     0x00        ; Table lookup return from 0x00
0x12F0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x12F1:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x12F2:  9F0  LBPX     #F0         ; Store constant #F0 into memory pointer
0x12F3:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x12F4:  91C  LBPX     #1C         ; Store constant #1C into memory pointer
0x12F5:  90E  LBPX     #E          ; Store constant #E into memory pointer
0x12F6:  90A  LBPX     #A          ; Store constant #A into memory pointer
0x12F7:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x12F8:  946  LBPX     #46         ; Store constant #46 into memory pointer
0x12F9:  942  LBPX     #42         ; Store constant #42 into memory pointer
0x12FA:  94A  LBPX     #4A         ; Store constant #4A into memory pointer
0x12FB:  94C  LBPX     #4C         ; Store constant #4C into memory pointer
0x12FC:  958  LBPX     #58         ; Store constant #58 into memory pointer
0x12FD:  9D0  LBPX     #D0         ; Store constant #D0 into memory pointer
0x12FE:  960  LBPX     #60         ; Store constant #60 into memory pointer
0x12FF:  100  RETD     0x00        ; Table lookup return from 0x00
0x1300:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1301:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x1302:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x1303:  9AC  LBPX     #AC         ; Store constant #AC into memory pointer
0x1304:  98E  LBPX     #8E         ; Store constant #8E into memory pointer
0x1305:  97E  LBPX     #7E         ; Store constant #7E into memory pointer
0x1306:  91E  LBPX     #1E         ; Store constant #1E into memory pointer
0x1307:  91E  LBPX     #1E         ; Store constant #1E into memory pointer
0x1308:  91F  LBPX     #1F         ; Store constant #1F into memory pointer
0x1309:  93F  LBPX     #3F         ; Store constant #3F into memory pointer
0x130A:  93F  LBPX     #3F         ; Store constant #3F into memory pointer
0x130B:  93F  LBPX     #3F         ; Store constant #3F into memory pointer
0x130C:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x130D:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x130E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x130F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1310:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1311:  940  LBPX     #40         ; Store constant #40 into memory pointer
0x1312:  960  LBPX     #60         ; Store constant #60 into memory pointer
0x1313:  953  LBPX     #53         ; Store constant #53 into memory pointer
0x1314:  914  LBPX     #14         ; Store constant #14 into memory pointer
0x1315:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x1316:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x1317:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x1318:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x1319:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x131A:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x131B:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x131C:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x131D:  944  LBPX     #44         ; Store constant #44 into memory pointer
0x131E:  96B  LBPX     #6B         ; Store constant #6B into memory pointer
0x131F:  158  RETD     0x58        ; Table lookup return from 0x58
0x1320:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1321:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1322:  90D  LBPX     #D          ; Store constant #D into memory pointer
0x1323:  952  LBPX     #52         ; Store constant #52 into memory pointer
0x1324:  962  LBPX     #62         ; Store constant #62 into memory pointer
0x1325:  944  LBPX     #44         ; Store constant #44 into memory pointer
0x1326:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x1327:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x1328:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x1329:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x132A:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x132B:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x132C:  94E  LBPX     #4E         ; Store constant #4E into memory pointer
0x132D:  971  LBPX     #71         ; Store constant #71 into memory pointer
0x132E:  940  LBPX     #40         ; Store constant #40 into memory pointer
0x132F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1330:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1331:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1332:  9FC  LBPX     #FC         ; Store constant #FC into memory pointer
0x1333:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x1334:  979  LBPX     #79         ; Store constant #79 into memory pointer
0x1335:  9B5  LBPX     #B5         ; Store constant #B5 into memory pointer
0x1336:  9FD  LBPX     #FD         ; Store constant #FD into memory pointer
0x1337:  9B5  LBPX     #B5         ; Store constant #B5 into memory pointer
0x1338:  9B5  LBPX     #B5         ; Store constant #B5 into memory pointer
0x1339:  9FD  LBPX     #FD         ; Store constant #FD into memory pointer
0x133A:  9B5  LBPX     #B5         ; Store constant #B5 into memory pointer
0x133B:  979  LBPX     #79         ; Store constant #79 into memory pointer
0x133C:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x133D:  9FC  LBPX     #FC         ; Store constant #FC into memory pointer
0x133E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x133F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1340:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1341:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1342:  9FC  LBPX     #FC         ; Store constant #FC into memory pointer
0x1343:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x1344:  911  LBPX     #11         ; Store constant #11 into memory pointer
0x1345:  911  LBPX     #11         ; Store constant #11 into memory pointer
0x1346:  911  LBPX     #11         ; Store constant #11 into memory pointer
0x1347:  911  LBPX     #11         ; Store constant #11 into memory pointer
0x1348:  911  LBPX     #11         ; Store constant #11 into memory pointer
0x1349:  911  LBPX     #11         ; Store constant #11 into memory pointer
0x134A:  911  LBPX     #11         ; Store constant #11 into memory pointer
0x134B:  911  LBPX     #11         ; Store constant #11 into memory pointer
0x134C:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x134D:  9FC  LBPX     #FC         ; Store constant #FC into memory pointer
0x134E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x134F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1350:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1351:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1352:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x1353:  91C  LBPX     #1C         ; Store constant #1C into memory pointer
0x1354:  97F  LBPX     #7F         ; Store constant #7F into memory pointer
0x1355:  9DF  LBPX     #DF         ; Store constant #DF into memory pointer
0x1356:  9DE  LBPX     #DE         ; Store constant #DE into memory pointer
0x1357:  9FE  LBPX     #FE         ; Store constant #FE into memory pointer
0x1358:  9FE  LBPX     #FE         ; Store constant #FE into memory pointer
0x1359:  9DE  LBPX     #DE         ; Store constant #DE into memory pointer
0x135A:  9DF  LBPX     #DF         ; Store constant #DF into memory pointer
0x135B:  97F  LBPX     #7F         ; Store constant #7F into memory pointer
0x135C:  91C  LBPX     #1C         ; Store constant #1C into memory pointer
0x135D:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x135E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x135F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1360:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1361:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1362:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x1363:  91C  LBPX     #1C         ; Store constant #1C into memory pointer
0x1364:  97F  LBPX     #7F         ; Store constant #7F into memory pointer
0x1365:  98F  LBPX     #8F         ; Store constant #8F into memory pointer
0x1366:  9AE  LBPX     #AE         ; Store constant #AE into memory pointer
0x1367:  9FE  LBPX     #FE         ; Store constant #FE into memory pointer
0x1368:  9FE  LBPX     #FE         ; Store constant #FE into memory pointer
0x1369:  98E  LBPX     #8E         ; Store constant #8E into memory pointer
0x136A:  9AF  LBPX     #AF         ; Store constant #AF into memory pointer
0x136B:  97F  LBPX     #7F         ; Store constant #7F into memory pointer
0x136C:  91C  LBPX     #1C         ; Store constant #1C into memory pointer
0x136D:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x136E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x136F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1370:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1371:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x1372:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x1373:  9DC  LBPX     #DC         ; Store constant #DC into memory pointer
0x1374:  9DE  LBPX     #DE         ; Store constant #DE into memory pointer
0x1375:  97E  LBPX     #7E         ; Store constant #7E into memory pointer
0x1376:  91E  LBPX     #1E         ; Store constant #1E into memory pointer
0x1377:  91E  LBPX     #1E         ; Store constant #1E into memory pointer
0x1378:  91F  LBPX     #1F         ; Store constant #1F into memory pointer
0x1379:  93F  LBPX     #3F         ; Store constant #3F into memory pointer
0x137A:  93F  LBPX     #3F         ; Store constant #3F into memory pointer
0x137B:  93F  LBPX     #3F         ; Store constant #3F into memory pointer
0x137C:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x137D:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x137E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x137F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1380:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1381:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x1382:  9A8  LBPX     #A8         ; Store constant #A8 into memory pointer
0x1383:  9AC  LBPX     #AC         ; Store constant #AC into memory pointer
0x1384:  9AA  LBPX     #AA         ; Store constant #AA into memory pointer
0x1385:  9A9  LBPX     #A9         ; Store constant #A9 into memory pointer
0x1386:  9ED  LBPX     #ED         ; Store constant #ED into memory pointer
0x1387:  939  LBPX     #39         ; Store constant #39 into memory pointer
0x1388:  901  LBPX     #1          ; Store constant #1 into memory pointer
0x1389:  905  LBPX     #5          ; Store constant #5 into memory pointer
0x138A:  903  LBPX     #3          ; Store constant #3 into memory pointer
0x138B:  907  LBPX     #7          ; Store constant #7 into memory pointer
0x138C:  90E  LBPX     #E          ; Store constant #E into memory pointer
0x138D:  9FC  LBPX     #FC         ; Store constant #FC into memory pointer
0x138E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x138F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1390:  9E7  LBPX     #E7         ; Store constant #E7 into memory pointer
0x1391:  9A5  LBPX     #A5         ; Store constant #A5 into memory pointer
0x1392:  9BD  LBPX     #BD         ; Store constant #BD into memory pointer
0x1393:  9BD  LBPX     #BD         ; Store constant #BD into memory pointer
0x1394:  9BD  LBPX     #BD         ; Store constant #BD into memory pointer
0x1395:  9FD  LBPX     #FD         ; Store constant #FD into memory pointer
0x1396:  907  LBPX     #7          ; Store constant #7 into memory pointer
0x1397:  901  LBPX     #1          ; Store constant #1 into memory pointer
0x1398:  911  LBPX     #11         ; Store constant #11 into memory pointer
0x1399:  909  LBPX     #9          ; Store constant #9 into memory pointer
0x139A:  911  LBPX     #11         ; Store constant #11 into memory pointer
0x139B:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x139C:  9FC  LBPX     #FC         ; Store constant #FC into memory pointer
0x139D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x139E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x139F:  100  RETD     0x00        ; Table lookup return from 0x00
0x13A0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x13A1:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x13A2:  9A8  LBPX     #A8         ; Store constant #A8 into memory pointer
0x13A3:  9AC  LBPX     #AC         ; Store constant #AC into memory pointer
0x13A4:  9AA  LBPX     #AA         ; Store constant #AA into memory pointer
0x13A5:  9AD  LBPX     #AD         ; Store constant #AD into memory pointer
0x13A6:  9ED  LBPX     #ED         ; Store constant #ED into memory pointer
0x13A7:  939  LBPX     #39         ; Store constant #39 into memory pointer
0x13A8:  901  LBPX     #1          ; Store constant #1 into memory pointer
0x13A9:  909  LBPX     #9          ; Store constant #9 into memory pointer
0x13AA:  90B  LBPX     #B          ; Store constant #B into memory pointer
0x13AB:  907  LBPX     #7          ; Store constant #7 into memory pointer
0x13AC:  90E  LBPX     #E          ; Store constant #E into memory pointer
0x13AD:  9FC  LBPX     #FC         ; Store constant #FC into memory pointer
0x13AE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x13AF:  100  RETD     0x00        ; Table lookup return from 0x00
0x13B0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x13B1:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x13B2:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x13B3:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x13B4:  90A  LBPX     #A          ; Store constant #A into memory pointer
0x13B5:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x13B6:  9A2  LBPX     #A2         ; Store constant #A2 into memory pointer
0x13B7:  9A2  LBPX     #A2         ; Store constant #A2 into memory pointer
0x13B8:  9A2  LBPX     #A2         ; Store constant #A2 into memory pointer
0x13B9:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x13BA:  90A  LBPX     #A          ; Store constant #A into memory pointer
0x13BB:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x13BC:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x13BD:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x13BE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x13BF:  100  RETD     0x00        ; Table lookup return from 0x00
0x13C0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x13C1:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x13C2:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x13C3:  901  LBPX     #1          ; Store constant #1 into memory pointer
0x13C4:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x13C5:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x13C6:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x13C7:  91C  LBPX     #1C         ; Store constant #1C into memory pointer
0x13C8:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x13C9:  964  LBPX     #64         ; Store constant #64 into memory pointer
0x13CA:  944  LBPX     #44         ; Store constant #44 into memory pointer
0x13CB:  962  LBPX     #62         ; Store constant #62 into memory pointer
0x13CC:  911  LBPX     #11         ; Store constant #11 into memory pointer
0x13CD:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x13CE:  940  LBPX     #40         ; Store constant #40 into memory pointer
0x13CF:  120  RETD     0x20        ; Table lookup return from 0x20
0x13D0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x13D1:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x13D2:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x13D3:  901  LBPX     #1          ; Store constant #1 into memory pointer
0x13D4:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x13D5:  924  LBPX     #24         ; Store constant #24 into memory pointer
0x13D6:  974  LBPX     #74         ; Store constant #74 into memory pointer
0x13D7:  95C  LBPX     #5C         ; Store constant #5C into memory pointer
0x13D8:  94C  LBPX     #4C         ; Store constant #4C into memory pointer
0x13D9:  924  LBPX     #24         ; Store constant #24 into memory pointer
0x13DA:  924  LBPX     #24         ; Store constant #24 into memory pointer
0x13DB:  942  LBPX     #42         ; Store constant #42 into memory pointer
0x13DC:  941  LBPX     #41         ; Store constant #41 into memory pointer
0x13DD:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x13DE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x13DF:  100  RETD     0x00        ; Table lookup return from 0x00
0x13E0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x13E1:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x13E2:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x13E3:  901  LBPX     #1          ; Store constant #1 into memory pointer
0x13E4:  942  LBPX     #42         ; Store constant #42 into memory pointer
0x13E5:  964  LBPX     #64         ; Store constant #64 into memory pointer
0x13E6:  954  LBPX     #54         ; Store constant #54 into memory pointer
0x13E7:  96C  LBPX     #6C         ; Store constant #6C into memory pointer
0x13E8:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x13E9:  974  LBPX     #74         ; Store constant #74 into memory pointer
0x13EA:  964  LBPX     #64         ; Store constant #64 into memory pointer
0x13EB:  942  LBPX     #42         ; Store constant #42 into memory pointer
0x13EC:  949  LBPX     #49         ; Store constant #49 into memory pointer
0x13ED:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x13EE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x13EF:  100  RETD     0x00        ; Table lookup return from 0x00
0x13F0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x13F1:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x13F2:  9A6  LBPX     #A6         ; Store constant #A6 into memory pointer
0x13F3:  9B9  LBPX     #B9         ; Store constant #B9 into memory pointer
0x13F4:  9A5  LBPX     #A5         ; Store constant #A5 into memory pointer
0x13F5:  935  LBPX     #35         ; Store constant #35 into memory pointer
0x13F6:  925  LBPX     #25         ; Store constant #25 into memory pointer
0x13F7:  905  LBPX     #5          ; Store constant #5 into memory pointer
0x13F8:  905  LBPX     #5          ; Store constant #5 into memory pointer
0x13F9:  925  LBPX     #25         ; Store constant #25 into memory pointer
0x13FA:  905  LBPX     #5          ; Store constant #5 into memory pointer
0x13FB:  919  LBPX     #19         ; Store constant #19 into memory pointer
0x13FC:  912  LBPX     #12         ; Store constant #12 into memory pointer
0x13FD:  992  LBPX     #92         ; Store constant #92 into memory pointer
0x13FE:  96C  LBPX     #6C         ; Store constant #6C into memory pointer
0x13FF:  100  RETD     0x00        ; Table lookup return from 0x00
0x1400:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1401:  950  LBPX     #50         ; Store constant #50 into memory pointer
0x1402:  96B  LBPX     #6B         ; Store constant #6B into memory pointer
0x1403:  944  LBPX     #44         ; Store constant #44 into memory pointer
0x1404:  90E  LBPX     #E          ; Store constant #E into memory pointer
0x1405:  912  LBPX     #12         ; Store constant #12 into memory pointer
0x1406:  91A  LBPX     #1A         ; Store constant #1A into memory pointer
0x1407:  912  LBPX     #12         ; Store constant #12 into memory pointer
0x1408:  912  LBPX     #12         ; Store constant #12 into memory pointer
0x1409:  912  LBPX     #12         ; Store constant #12 into memory pointer
0x140A:  918  LBPX     #18         ; Store constant #18 into memory pointer
0x140B:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x140C:  944  LBPX     #44         ; Store constant #44 into memory pointer
0x140D:  96B  LBPX     #6B         ; Store constant #6B into memory pointer
0x140E:  950  LBPX     #50         ; Store constant #50 into memory pointer
0x140F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1410:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1411:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1412:  99C  LBPX     #9C         ; Store constant #9C into memory pointer
0x1413:  9E2  LBPX     #E2         ; Store constant #E2 into memory pointer
0x1414:  992  LBPX     #92         ; Store constant #92 into memory pointer
0x1415:  98A  LBPX     #8A         ; Store constant #8A into memory pointer
0x1416:  98A  LBPX     #8A         ; Store constant #8A into memory pointer
0x1417:  91A  LBPX     #1A         ; Store constant #1A into memory pointer
0x1418:  92A  LBPX     #2A         ; Store constant #2A into memory pointer
0x1419:  9AA  LBPX     #AA         ; Store constant #AA into memory pointer
0x141A:  9AA  LBPX     #AA         ; Store constant #AA into memory pointer
0x141B:  912  LBPX     #12         ; Store constant #12 into memory pointer
0x141C:  924  LBPX     #24         ; Store constant #24 into memory pointer
0x141D:  924  LBPX     #24         ; Store constant #24 into memory pointer
0x141E:  9D8  LBPX     #D8         ; Store constant #D8 into memory pointer
0x141F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1420:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1421:  953  LBPX     #53         ; Store constant #53 into memory pointer
0x1422:  96E  LBPX     #6E         ; Store constant #6E into memory pointer
0x1423:  952  LBPX     #52         ; Store constant #52 into memory pointer
0x1424:  97A  LBPX     #7A         ; Store constant #7A into memory pointer
0x1425:  948  LBPX     #48         ; Store constant #48 into memory pointer
0x1426:  968  LBPX     #68         ; Store constant #68 into memory pointer
0x1427:  948  LBPX     #48         ; Store constant #48 into memory pointer
0x1428:  948  LBPX     #48         ; Store constant #48 into memory pointer
0x1429:  950  LBPX     #50         ; Store constant #50 into memory pointer
0x142A:  960  LBPX     #60         ; Store constant #60 into memory pointer
0x142B:  960  LBPX     #60         ; Store constant #60 into memory pointer
0x142C:  950  LBPX     #50         ; Store constant #50 into memory pointer
0x142D:  96F  LBPX     #6F         ; Store constant #6F into memory pointer
0x142E:  950  LBPX     #50         ; Store constant #50 into memory pointer
0x142F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1430:  940  LBPX     #40         ; Store constant #40 into memory pointer
0x1431:  9A0  LBPX     #A0         ; Store constant #A0 into memory pointer
0x1432:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x1433:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x1434:  97A  LBPX     #7A         ; Store constant #7A into memory pointer
0x1435:  9EA  LBPX     #EA         ; Store constant #EA into memory pointer
0x1436:  9BF  LBPX     #BF         ; Store constant #BF into memory pointer
0x1437:  9E9  LBPX     #E9         ; Store constant #E9 into memory pointer
0x1438:  9BD  LBPX     #BD         ; Store constant #BD into memory pointer
0x1439:  9EA  LBPX     #EA         ; Store constant #EA into memory pointer
0x143A:  97A  LBPX     #7A         ; Store constant #7A into memory pointer
0x143B:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x143C:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x143D:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x143E:  9A0  LBPX     #A0         ; Store constant #A0 into memory pointer
0x143F:  140  RETD     0x40        ; Table lookup return from 0x40 (MEM_HUNGER)
0x1440:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1441:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x1442:  9A6  LBPX     #A6         ; Store constant #A6 into memory pointer
0x1443:  9B9  LBPX     #B9         ; Store constant #B9 into memory pointer
0x1444:  9A5  LBPX     #A5         ; Store constant #A5 into memory pointer
0x1445:  925  LBPX     #25         ; Store constant #25 into memory pointer
0x1446:  925  LBPX     #25         ; Store constant #25 into memory pointer
0x1447:  905  LBPX     #5          ; Store constant #5 into memory pointer
0x1448:  915  LBPX     #15         ; Store constant #15 into memory pointer
0x1449:  925  LBPX     #25         ; Store constant #25 into memory pointer
0x144A:  925  LBPX     #25         ; Store constant #25 into memory pointer
0x144B:  909  LBPX     #9          ; Store constant #9 into memory pointer
0x144C:  912  LBPX     #12         ; Store constant #12 into memory pointer
0x144D:  992  LBPX     #92         ; Store constant #92 into memory pointer
0x144E:  96C  LBPX     #6C         ; Store constant #6C into memory pointer
0x144F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1450:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1451:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1452:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1453:  9FC  LBPX     #FC         ; Store constant #FC into memory pointer
0x1454:  942  LBPX     #42         ; Store constant #42 into memory pointer
0x1455:  981  LBPX     #81         ; Store constant #81 into memory pointer
0x1456:  981  LBPX     #81         ; Store constant #81 into memory pointer
0x1457:  981  LBPX     #81         ; Store constant #81 into memory pointer
0x1458:  982  LBPX     #82         ; Store constant #82 into memory pointer
0x1459:  981  LBPX     #81         ; Store constant #81 into memory pointer
0x145A:  981  LBPX     #81         ; Store constant #81 into memory pointer
0x145B:  981  LBPX     #81         ; Store constant #81 into memory pointer
0x145C:  981  LBPX     #81         ; Store constant #81 into memory pointer
0x145D:  942  LBPX     #42         ; Store constant #42 into memory pointer
0x145E:  9FC  LBPX     #FC         ; Store constant #FC into memory pointer
0x145F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1460:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1461:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1462:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1463:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x1464:  9F0  LBPX     #F0         ; Store constant #F0 into memory pointer
0x1465:  9C8  LBPX     #C8         ; Store constant #C8 into memory pointer
0x1466:  9E4  LBPX     #E4         ; Store constant #E4 into memory pointer
0x1467:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x1468:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x1469:  9CC  LBPX     #CC         ; Store constant #CC into memory pointer
0x146A:  9D8  LBPX     #D8         ; Store constant #D8 into memory pointer
0x146B:  9F0  LBPX     #F0         ; Store constant #F0 into memory pointer
0x146C:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x146D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x146E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x146F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1470:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1471:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1472:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1473:  903  LBPX     #3          ; Store constant #3 into memory pointer
0x1474:  915  LBPX     #15         ; Store constant #15 into memory pointer
0x1475:  919  LBPX     #19         ; Store constant #19 into memory pointer
0x1476:  91B  LBPX     #1B         ; Store constant #1B into memory pointer
0x1477:  91E  LBPX     #1E         ; Store constant #1E into memory pointer
0x1478:  916  LBPX     #16         ; Store constant #16 into memory pointer
0x1479:  917  LBPX     #17         ; Store constant #17 into memory pointer
0x147A:  91C  LBPX     #1C         ; Store constant #1C into memory pointer
0x147B:  916  LBPX     #16         ; Store constant #16 into memory pointer
0x147C:  903  LBPX     #3          ; Store constant #3 into memory pointer
0x147D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x147E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x147F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1480:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1481:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1482:  980  LBPX     #80         ; Store constant #80 into memory pointer
0x1483:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x1484:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x1485:  990  LBPX     #90         ; Store constant #90 into memory pointer
0x1486:  9F0  LBPX     #F0         ; Store constant #F0 into memory pointer
0x1487:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x1488:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x1489:  9F0  LBPX     #F0         ; Store constant #F0 into memory pointer
0x148A:  990  LBPX     #90         ; Store constant #90 into memory pointer
0x148B:  9A0  LBPX     #A0         ; Store constant #A0 into memory pointer
0x148C:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x148D:  980  LBPX     #80         ; Store constant #80 into memory pointer
0x148E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x148F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1490:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1491:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1492:  903  LBPX     #3          ; Store constant #3 into memory pointer
0x1493:  915  LBPX     #15         ; Store constant #15 into memory pointer
0x1494:  919  LBPX     #19         ; Store constant #19 into memory pointer
0x1495:  91B  LBPX     #1B         ; Store constant #1B into memory pointer
0x1496:  91F  LBPX     #1F         ; Store constant #1F into memory pointer
0x1497:  91C  LBPX     #1C         ; Store constant #1C into memory pointer
0x1498:  91C  LBPX     #1C         ; Store constant #1C into memory pointer
0x1499:  91F  LBPX     #1F         ; Store constant #1F into memory pointer
0x149A:  913  LBPX     #13         ; Store constant #13 into memory pointer
0x149B:  91B  LBPX     #1B         ; Store constant #1B into memory pointer
0x149C:  917  LBPX     #17         ; Store constant #17 into memory pointer
0x149D:  903  LBPX     #3          ; Store constant #3 into memory pointer
0x149E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x149F:  100  RETD     0x00        ; Table lookup return from 0x00
0x14A0:  938  LBPX     #38         ; Store constant #38 into memory pointer
0x14A1:  9A6  LBPX     #A6         ; Store constant #A6 into memory pointer
0x14A2:  913  LBPX     #13         ; Store constant #13 into memory pointer
0x14A3:  90F  LBPX     #F          ; Store constant #F into memory pointer
0x14A4:  903  LBPX     #3          ; Store constant #3 into memory pointer
0x14A5:  9E0  LBPX     #E0         ; Store constant #E0 into memory pointer
0x14A6:  9D0  LBPX     #D0         ; Store constant #D0 into memory pointer
0x14A7:  931  LBPX     #31         ; Store constant #31 into memory pointer
0x14A8:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x14A9:  9D0  LBPX     #D0         ; Store constant #D0 into memory pointer
0x14AA:  9E2  LBPX     #E2         ; Store constant #E2 into memory pointer
0x14AB:  90F  LBPX     #F          ; Store constant #F into memory pointer
0x14AC:  913  LBPX     #13         ; Store constant #13 into memory pointer
0x14AD:  916  LBPX     #16         ; Store constant #16 into memory pointer
0x14AE:  948  LBPX     #48         ; Store constant #48 into memory pointer
0x14AF:  101  RETD     0x01        ; Table lookup return from 0x01
0x14B0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x14B1:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x14B2:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x14B3:  903  LBPX     #3          ; Store constant #3 into memory pointer
0x14B4:  915  LBPX     #15         ; Store constant #15 into memory pointer
0x14B5:  919  LBPX     #19         ; Store constant #19 into memory pointer
0x14B6:  91B  LBPX     #1B         ; Store constant #1B into memory pointer
0x14B7:  91F  LBPX     #1F         ; Store constant #1F into memory pointer
0x14B8:  917  LBPX     #17         ; Store constant #17 into memory pointer
0x14B9:  917  LBPX     #17         ; Store constant #17 into memory pointer
0x14BA:  91D  LBPX     #1D         ; Store constant #1D into memory pointer
0x14BB:  916  LBPX     #16         ; Store constant #16 into memory pointer
0x14BC:  903  LBPX     #3          ; Store constant #3 into memory pointer
0x14BD:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x14BE:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x14BF:  100  RETD     0x00        ; Table lookup return from 0x00
0x14C0:  941  LBPX     #41         ; Store constant #41 into memory pointer
0x14C1:  92A  LBPX     #2A         ; Store constant #2A into memory pointer
0x14C2:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x14C3:  936  LBPX     #36         ; Store constant #36 into memory pointer
0x14C4:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x14C5:  92A  LBPX     #2A         ; Store constant #2A into memory pointer
0x14C6:  941  LBPX     #41         ; Store constant #41 into memory pointer
0x14C7:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x14C8:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x14C9:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x14CA:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x14CB:  914  LBPX     #14         ; Store constant #14 into memory pointer
0x14CC:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x14CD:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x14CE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x14CF:  100  RETD     0x00        ; Table lookup return from 0x00
0x14D0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x14D1:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x14D2:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x14D3:  950  LBPX     #50         ; Store constant #50 into memory pointer
0x14D4:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x14D5:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x14D6:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x14D7:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x14D8:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x14D9:  922  LBPX     #22         ; Store constant #22 into memory pointer
0x14DA:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x14DB:  914  LBPX     #14         ; Store constant #14 into memory pointer
0x14DC:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x14DD:  922  LBPX     #22         ; Store constant #22 into memory pointer
0x14DE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x14DF:  100  RETD     0x00        ; Table lookup return from 0x00
0x14E0:  980  LBPX     #80         ; Store constant #80 into memory pointer
0x14E1:  940  LBPX     #40         ; Store constant #40 into memory pointer
0x14E2:  9F0  LBPX     #F0         ; Store constant #F0 into memory pointer
0x14E3:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x14E4:  924  LBPX     #24         ; Store constant #24 into memory pointer
0x14E5:  98E  LBPX     #8E         ; Store constant #8E into memory pointer
0x14E6:  996  LBPX     #96         ; Store constant #96 into memory pointer
0x14E7:  906  LBPX     #6          ; Store constant #6 into memory pointer
0x14E8:  924  LBPX     #24         ; Store constant #24 into memory pointer
0x14E9:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x14EA:  9F0  LBPX     #F0         ; Store constant #F0 into memory pointer
0x14EB:  940  LBPX     #40         ; Store constant #40 into memory pointer
0x14EC:  940  LBPX     #40         ; Store constant #40 into memory pointer
0x14ED:  980  LBPX     #80         ; Store constant #80 into memory pointer
0x14EE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x14EF:  100  RETD     0x00        ; Table lookup return from 0x00
0x14F0:  907  LBPX     #7          ; Store constant #7 into memory pointer
0x14F1:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x14F2:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x14F3:  905  LBPX     #5          ; Store constant #5 into memory pointer
0x14F4:  90E  LBPX     #E          ; Store constant #E into memory pointer
0x14F5:  912  LBPX     #12         ; Store constant #12 into memory pointer
0x14F6:  922  LBPX     #22         ; Store constant #22 into memory pointer
0x14F7:  922  LBPX     #22         ; Store constant #22 into memory pointer
0x14F8:  962  LBPX     #62         ; Store constant #62 into memory pointer
0x14F9:  915  LBPX     #15         ; Store constant #15 into memory pointer
0x14FA:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x14FB:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x14FC:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x14FD:  907  LBPX     #7          ; Store constant #7 into memory pointer
0x14FE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x14FF:  100  RETD     0x00        ; Table lookup return from 0x00
0x1500:  93E  LBPX     #3E         ; Store constant #3E into memory pointer
0x1501:  941  LBPX     #41         ; Store constant #41 into memory pointer
0x1502:  941  LBPX     #41         ; Store constant #41 into memory pointer
0x1503:  13E  RETD     0x3E        ; Table lookup return from 0x3E
0x1504:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1505:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1506:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x1507:  17F  RETD     0x7F        ; Table lookup return from 0x7F
0x1508:  962  LBPX     #62         ; Store constant #62 into memory pointer
0x1509:  951  LBPX     #51         ; Store constant #51 into memory pointer
0x150A:  949  LBPX     #49         ; Store constant #49 into memory pointer
0x150B:  146  RETD     0x46        ; Table lookup return from 0x46 (MEM_WEIGHT)
0x150C:  941  LBPX     #41         ; Store constant #41 into memory pointer
0x150D:  949  LBPX     #49         ; Store constant #49 into memory pointer
0x150E:  949  LBPX     #49         ; Store constant #49 into memory pointer
0x150F:  136  RETD     0x36        ; Table lookup return from 0x36
0x1510:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x1511:  922  LBPX     #22         ; Store constant #22 into memory pointer
0x1512:  97F  LBPX     #7F         ; Store constant #7F into memory pointer
0x1513:  120  RETD     0x20        ; Table lookup return from 0x20
0x1514:  94F  LBPX     #4F         ; Store constant #4F into memory pointer
0x1515:  949  LBPX     #49         ; Store constant #49 into memory pointer
0x1516:  949  LBPX     #49         ; Store constant #49 into memory pointer
0x1517:  131  RETD     0x31        ; Table lookup return from 0x31
0x1518:  93E  LBPX     #3E         ; Store constant #3E into memory pointer
0x1519:  949  LBPX     #49         ; Store constant #49 into memory pointer
0x151A:  949  LBPX     #49         ; Store constant #49 into memory pointer
0x151B:  132  RETD     0x32        ; Table lookup return from 0x32
0x151C:  907  LBPX     #7          ; Store constant #7 into memory pointer
0x151D:  901  LBPX     #1          ; Store constant #1 into memory pointer
0x151E:  971  LBPX     #71         ; Store constant #71 into memory pointer
0x151F:  10F  RETD     0x0F        ; Table lookup return from 0x0F
0x1520:  936  LBPX     #36         ; Store constant #36 into memory pointer
0x1521:  949  LBPX     #49         ; Store constant #49 into memory pointer
0x1522:  949  LBPX     #49         ; Store constant #49 into memory pointer
0x1523:  136  RETD     0x36        ; Table lookup return from 0x36
0x1524:  906  LBPX     #6          ; Store constant #6 into memory pointer
0x1525:  949  LBPX     #49         ; Store constant #49 into memory pointer
0x1526:  949  LBPX     #49         ; Store constant #49 into memory pointer
0x1527:  13E  RETD     0x3E        ; Table lookup return from 0x3E
0x1528:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x1529:  944  LBPX     #44         ; Store constant #44 into memory pointer
0x152A:  17C  RETD     0x7C        ; Table lookup return from 0x7C
0x152B:  100  RETD     0x00        ; Table lookup return from 0x00
0x152C:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x152D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x152E:  17C  RETD     0x7C        ; Table lookup return from 0x7C
0x152F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1530:  974  LBPX     #74         ; Store constant #74 into memory pointer
0x1531:  954  LBPX     #54         ; Store constant #54 into memory pointer
0x1532:  15C  RETD     0x5C        ; Table lookup return from 0x5C
0x1533:  100  RETD     0x00        ; Table lookup return from 0x00
0x1534:  954  LBPX     #54         ; Store constant #54 into memory pointer
0x1535:  954  LBPX     #54         ; Store constant #54 into memory pointer
0x1536:  17C  RETD     0x7C        ; Table lookup return from 0x7C
0x1537:  100  RETD     0x00        ; Table lookup return from 0x00
0x1538:  91C  LBPX     #1C         ; Store constant #1C into memory pointer
0x1539:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x153A:  17C  RETD     0x7C        ; Table lookup return from 0x7C
0x153B:  100  RETD     0x00        ; Table lookup return from 0x00
0x153C:  95C  LBPX     #5C         ; Store constant #5C into memory pointer
0x153D:  954  LBPX     #54         ; Store constant #54 into memory pointer
0x153E:  174  RETD     0x74        ; Table lookup return from 0x74
0x153F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1540:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x1541:  954  LBPX     #54         ; Store constant #54 into memory pointer
0x1542:  174  RETD     0x74        ; Table lookup return from 0x74
0x1543:  100  RETD     0x00        ; Table lookup return from 0x00
0x1544:  90C  LBPX     #C          ; Store constant #C into memory pointer
0x1545:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x1546:  17C  RETD     0x7C        ; Table lookup return from 0x7C
0x1547:  100  RETD     0x00        ; Table lookup return from 0x00
0x1548:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x1549:  954  LBPX     #54         ; Store constant #54 into memory pointer
0x154A:  17C  RETD     0x7C        ; Table lookup return from 0x7C
0x154B:  100  RETD     0x00        ; Table lookup return from 0x00
0x154C:  95C  LBPX     #5C         ; Store constant #5C into memory pointer
0x154D:  954  LBPX     #54         ; Store constant #54 into memory pointer
0x154E:  17C  RETD     0x7C        ; Table lookup return from 0x7C
0x154F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1550:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x1551:  938  LBPX     #38         ; Store constant #38 into memory pointer
0x1552:  110  RETD     0x10        ; Table lookup return from 0x10
0x1553:  100  RETD     0x00        ; Table lookup return from 0x00
0x1554:  944  LBPX     #44         ; Store constant #44 into memory pointer
0x1555:  928  LBPX     #28         ; Store constant #28 into memory pointer
0x1556:  110  RETD     0x10        ; Table lookup return from 0x10
0x1557:  100  RETD     0x00        ; Table lookup return from 0x00
0x1558:  064  JP       0x264       ; Flow to 0x264
0x1559:  064  JP       0x264       ; Flow to 0x264
0x155A:  071  JP       0x271       ; Flow to 0x271
0x155B:  07E  JP       0x27E       ; Flow to 0x27E
0x155C:  08B  JP       0x28B       ; Flow to 0x28B
0x155D:  098  JP       0x298       ; Flow to 0x298
0x155E:  0A5  JP       0x2A5       ; Flow to 0x2A5
0x155F:  0B2  JP       0x2B2       ; Flow to 0x2B2
0x1560:  0BF  JP       0x2BF       ; Flow to 0x2BF
0x1561:  0CC  JP       0x2CC       ; Flow to 0x2CC
0x1562:  0D9  JP       0x2D9       ; Flow to 0x2D9 (MEM_ATTENTION)
0x1563:  098  JP       0x298       ; Flow to 0x298
0x1564:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x1565:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x1566:  903  LBPX     #3          ; Store constant #3 into memory pointer
0x1567:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x1568:  92D  LBPX     #2D         ; Store constant #2D into memory pointer
0x1569:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x156A:  905  LBPX     #5          ; Store constant #5 into memory pointer
0x156B:  905  LBPX     #5          ; Store constant #5 into memory pointer
0x156C:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x156D:  9F0  LBPX     #F0         ; Store constant #F0 into memory pointer
0x156E:  980  LBPX     #80         ; Store constant #80 into memory pointer
0x156F:  911  LBPX     #11         ; Store constant #11 into memory pointer
0x1570:  100  RETD     0x00        ; Table lookup return from 0x00
0x1571:  909  LBPX     #9          ; Store constant #9 into memory pointer
0x1572:  914  LBPX     #14         ; Store constant #14 into memory pointer
0x1573:  932  LBPX     #32         ; Store constant #32 into memory pointer
0x1574:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x1575:  9DE  LBPX     #DE         ; Store constant #DE into memory pointer
0x1576:  9C3  LBPX     #C3         ; Store constant #C3 into memory pointer
0x1577:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x1578:  999  LBPX     #99         ; Store constant #99 into memory pointer
0x1579:  964  LBPX     #64         ; Store constant #64 into memory pointer
0x157A:  965  LBPX     #65         ; Store constant #65 into memory pointer
0x157B:  980  LBPX     #80         ; Store constant #80 into memory pointer
0x157C:  911  LBPX     #11         ; Store constant #11 into memory pointer
0x157D:  100  RETD     0x00        ; Table lookup return from 0x00
0x157E:  909  LBPX     #9          ; Store constant #9 into memory pointer
0x157F:  915  LBPX     #15         ; Store constant #15 into memory pointer
0x1580:  94B  LBPX     #4B         ; Store constant #4B into memory pointer
0x1581:  955  LBPX     #55         ; Store constant #55 into memory pointer
0x1582:  978  LBPX     #78         ; Store constant #78 into memory pointer
0x1583:  9C6  LBPX     #C6         ; Store constant #C6 into memory pointer
0x1584:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x1585:  999  LBPX     #99         ; Store constant #99 into memory pointer
0x1586:  9AC  LBPX     #AC         ; Store constant #AC into memory pointer
0x1587:  968  LBPX     #68         ; Store constant #68 into memory pointer
0x1588:  980  LBPX     #80         ; Store constant #80 into memory pointer
0x1589:  911  LBPX     #11         ; Store constant #11 into memory pointer
0x158A:  101  RETD     0x01        ; Table lookup return from 0x01
0x158B:  909  LBPX     #9          ; Store constant #9 into memory pointer
0x158C:  915  LBPX     #15         ; Store constant #15 into memory pointer
0x158D:  94B  LBPX     #4B         ; Store constant #4B into memory pointer
0x158E:  955  LBPX     #55         ; Store constant #55 into memory pointer
0x158F:  994  LBPX     #94         ; Store constant #94 into memory pointer
0x1590:  9C2  LBPX     #C2         ; Store constant #C2 into memory pointer
0x1591:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x1592:  999  LBPX     #99         ; Store constant #99 into memory pointer
0x1593:  964  LBPX     #64         ; Store constant #64 into memory pointer
0x1594:  965  LBPX     #65         ; Store constant #65 into memory pointer
0x1595:  980  LBPX     #80         ; Store constant #80 into memory pointer
0x1596:  911  LBPX     #11         ; Store constant #11 into memory pointer
0x1597:  100  RETD     0x00        ; Table lookup return from 0x00
0x1598:  909  LBPX     #9          ; Store constant #9 into memory pointer
0x1599:  916  LBPX     #16         ; Store constant #16 into memory pointer
0x159A:  951  LBPX     #51         ; Store constant #51 into memory pointer
0x159B:  95B  LBPX     #5B         ; Store constant #5B into memory pointer
0x159C:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x159D:  98F  LBPX     #8F         ; Store constant #8F into memory pointer
0x159E:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x159F:  999  LBPX     #99         ; Store constant #99 into memory pointer
0x15A0:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x15A1:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x15A2:  98F  LBPX     #8F         ; Store constant #8F into memory pointer
0x15A3:  911  LBPX     #11         ; Store constant #11 into memory pointer
0x15A4:  101  RETD     0x01        ; Table lookup return from 0x01
0x15A5:  909  LBPX     #9          ; Store constant #9 into memory pointer
0x15A6:  916  LBPX     #16         ; Store constant #16 into memory pointer
0x15A7:  951  LBPX     #51         ; Store constant #51 into memory pointer
0x15A8:  95B  LBPX     #5B         ; Store constant #5B into memory pointer
0x15A9:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x15AA:  98A  LBPX     #8A         ; Store constant #8A into memory pointer
0x15AB:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x15AC:  999  LBPX     #99         ; Store constant #99 into memory pointer
0x15AD:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x15AE:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x15AF:  988  LBPX     #88         ; Store constant #88 into memory pointer
0x15B0:  911  LBPX     #11         ; Store constant #11 into memory pointer
0x15B1:  101  RETD     0x01        ; Table lookup return from 0x01
0x15B2:  90B  LBPX     #B          ; Store constant #B into memory pointer
0x15B3:  917  LBPX     #17         ; Store constant #17 into memory pointer
0x15B4:  937  LBPX     #37         ; Store constant #37 into memory pointer
0x15B5:  941  LBPX     #41         ; Store constant #41 into memory pointer
0x15B6:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x15B7:  98A  LBPX     #8A         ; Store constant #8A into memory pointer
0x15B8:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x15B9:  999  LBPX     #99         ; Store constant #99 into memory pointer
0x15BA:  940  LBPX     #40         ; Store constant #40 into memory pointer
0x15BB:  97B  LBPX     #7B         ; Store constant #7B into memory pointer
0x15BC:  9B0  LBPX     #B0         ; Store constant #B0 into memory pointer
0x15BD:  923  LBPX     #23         ; Store constant #23 into memory pointer
0x15BE:  101  RETD     0x01        ; Table lookup return from 0x01
0x15BF:  909  LBPX     #9          ; Store constant #9 into memory pointer
0x15C0:  916  LBPX     #16         ; Store constant #16 into memory pointer
0x15C1:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x15C2:  946  LBPX     #46         ; Store constant #46 into memory pointer
0x15C3:  992  LBPX     #92         ; Store constant #92 into memory pointer
0x15C4:  9C4  LBPX     #C4         ; Store constant #C4 into memory pointer
0x15C5:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x15C6:  999  LBPX     #99         ; Store constant #99 into memory pointer
0x15C7:  918  LBPX     #18         ; Store constant #18 into memory pointer
0x15C8:  9F6  LBPX     #F6         ; Store constant #F6 into memory pointer
0x15C9:  95F  LBPX     #5F         ; Store constant #5F into memory pointer
0x15CA:  943  LBPX     #43         ; Store constant #43 into memory pointer
0x15CB:  101  RETD     0x01        ; Table lookup return from 0x01
0x15CC:  909  LBPX     #9          ; Store constant #9 into memory pointer
0x15CD:  916  LBPX     #16         ; Store constant #16 into memory pointer
0x15CE:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x15CF:  946  LBPX     #46         ; Store constant #46 into memory pointer
0x15D0:  968  LBPX     #68         ; Store constant #68 into memory pointer
0x15D1:  9D1  LBPX     #D1         ; Store constant #D1 into memory pointer
0x15D2:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x15D3:  999  LBPX     #99         ; Store constant #99 into memory pointer
0x15D4:  90C  LBPX     #C          ; Store constant #C into memory pointer
0x15D5:  973  LBPX     #73         ; Store constant #73 into memory pointer
0x15D6:  988  LBPX     #88         ; Store constant #88 into memory pointer
0x15D7:  911  LBPX     #11         ; Store constant #11 into memory pointer
0x15D8:  100  RETD     0x00        ; Table lookup return from 0x00
0x15D9:  90A  LBPX     #A          ; Store constant #A into memory pointer
0x15DA:  916  LBPX     #16         ; Store constant #16 into memory pointer
0x15DB:  92D  LBPX     #2D         ; Store constant #2D into memory pointer
0x15DC:  932  LBPX     #32         ; Store constant #32 into memory pointer
0x15DD:  994  LBPX     #94         ; Store constant #94 into memory pointer
0x15DE:  9C2  LBPX     #C2         ; Store constant #C2 into memory pointer
0x15DF:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x15E0:  999  LBPX     #99         ; Store constant #99 into memory pointer
0x15E1:  9A0  LBPX     #A0         ; Store constant #A0 into memory pointer
0x15E2:  975  LBPX     #75         ; Store constant #75 into memory pointer
0x15E3:  980  LBPX     #80         ; Store constant #80 into memory pointer
0x15E4:  911  LBPX     #11         ; Store constant #11 into memory pointer
0x15E5:  101  RETD     0x01        ; Table lookup return from 0x01
0x15E6:  112  RETD     0x12        ; Table lookup return from 0x12
0x15E7:  101  RETD     0x01        ; Table lookup return from 0x01
0x15E8:  102  RETD     0x02        ; Table lookup return from 0x02
0x15E9:  103  RETD     0x03        ; Table lookup return from 0x03
0x15EA:  104  RETD     0x04        ; Table lookup return from 0x04
0x15EB:  105  RETD     0x05        ; Table lookup return from 0x05
0x15EC:  106  RETD     0x06        ; Table lookup return from 0x06
0x15ED:  107  RETD     0x07        ; Table lookup return from 0x07
0x15EE:  108  RETD     0x08        ; Table lookup return from 0x08
0x15EF:  109  RETD     0x09        ; Table lookup return from 0x09
0x15F0:  110  RETD     0x10        ; Table lookup return from 0x10
0x15F1:  111  RETD     0x11        ; Table lookup return from 0x11
0x15F2:  192  RETD     0x92        ; Table lookup return from 0x92
0x15F3:  181  RETD     0x81        ; Table lookup return from 0x81
0x15F4:  182  RETD     0x82        ; Table lookup return from 0x82
0x15F5:  183  RETD     0x83        ; Table lookup return from 0x83
0x15F6:  184  RETD     0x84        ; Table lookup return from 0x84
0x15F7:  185  RETD     0x85        ; Table lookup return from 0x85
0x15F8:  186  RETD     0x86        ; Table lookup return from 0x86
0x15F9:  187  RETD     0x87        ; Table lookup return from 0x87
0x15FA:  188  RETD     0x88        ; Table lookup return from 0x88
0x15FB:  189  RETD     0x89        ; Table lookup return from 0x89
0x15FC:  190  RETD     0x90        ; Table lookup return from 0x90
0x15FD:  191  RETD     0x91        ; Table lookup return from 0x91
0x15FE:  FFF  NOP7                 ; 
0x15FF:  FFF  NOP7                 ; 
0x1600:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1601:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1602:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x1603:  982  LBPX     #82         ; Store constant #82 into memory pointer
0x1604:  982  LBPX     #82         ; Store constant #82 into memory pointer
0x1605:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x1606:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1607:  100  RETD     0x00        ; Table lookup return from 0x00
0x1608:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1609:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x160A:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x160B:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x160C:  9FE  LBPX     #FE         ; Store constant #FE into memory pointer
0x160D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x160E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x160F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1610:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1611:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1612:  9CC  LBPX     #CC         ; Store constant #CC into memory pointer
0x1613:  9A2  LBPX     #A2         ; Store constant #A2 into memory pointer
0x1614:  992  LBPX     #92         ; Store constant #92 into memory pointer
0x1615:  98C  LBPX     #8C         ; Store constant #8C into memory pointer
0x1616:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1617:  100  RETD     0x00        ; Table lookup return from 0x00
0x1618:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1619:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x161A:  944  LBPX     #44         ; Store constant #44 into memory pointer
0x161B:  982  LBPX     #82         ; Store constant #82 into memory pointer
0x161C:  992  LBPX     #92         ; Store constant #92 into memory pointer
0x161D:  96C  LBPX     #6C         ; Store constant #6C into memory pointer
0x161E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x161F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1620:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1621:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1622:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x1623:  922  LBPX     #22         ; Store constant #22 into memory pointer
0x1624:  9FE  LBPX     #FE         ; Store constant #FE into memory pointer
0x1625:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x1626:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1627:  100  RETD     0x00        ; Table lookup return from 0x00
0x1628:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1629:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x162A:  99E  LBPX     #9E         ; Store constant #9E into memory pointer
0x162B:  992  LBPX     #92         ; Store constant #92 into memory pointer
0x162C:  992  LBPX     #92         ; Store constant #92 into memory pointer
0x162D:  962  LBPX     #62         ; Store constant #62 into memory pointer
0x162E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x162F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1630:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1631:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1632:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x1633:  992  LBPX     #92         ; Store constant #92 into memory pointer
0x1634:  992  LBPX     #92         ; Store constant #92 into memory pointer
0x1635:  964  LBPX     #64         ; Store constant #64 into memory pointer
0x1636:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1637:  100  RETD     0x00        ; Table lookup return from 0x00
0x1638:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1639:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x163A:  906  LBPX     #6          ; Store constant #6 into memory pointer
0x163B:  9E2  LBPX     #E2         ; Store constant #E2 into memory pointer
0x163C:  912  LBPX     #12         ; Store constant #12 into memory pointer
0x163D:  90E  LBPX     #E          ; Store constant #E into memory pointer
0x163E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x163F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1640:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1641:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1642:  96C  LBPX     #6C         ; Store constant #6C into memory pointer
0x1643:  992  LBPX     #92         ; Store constant #92 into memory pointer
0x1644:  992  LBPX     #92         ; Store constant #92 into memory pointer
0x1645:  96C  LBPX     #6C         ; Store constant #6C into memory pointer
0x1646:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1647:  100  RETD     0x00        ; Table lookup return from 0x00
0x1648:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1649:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x164A:  94C  LBPX     #4C         ; Store constant #4C into memory pointer
0x164B:  992  LBPX     #92         ; Store constant #92 into memory pointer
0x164C:  992  LBPX     #92         ; Store constant #92 into memory pointer
0x164D:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x164E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x164F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1650:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1651:  9EE  LBPX     #EE         ; Store constant #EE into memory pointer
0x1652:  925  LBPX     #25         ; Store constant #25 into memory pointer
0x1653:  9C5  LBPX     #C5         ; Store constant #C5 into memory pointer
0x1654:  925  LBPX     #25         ; Store constant #25 into memory pointer
0x1655:  9EF  LBPX     #EF         ; Store constant #EF into memory pointer
0x1656:  9EE  LBPX     #EE         ; Store constant #EE into memory pointer
0x1657:  100  RETD     0x00        ; Table lookup return from 0x00
0x1658:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1659:  9EF  LBPX     #EF         ; Store constant #EF into memory pointer
0x165A:  92F  LBPX     #2F         ; Store constant #2F into memory pointer
0x165B:  9C5  LBPX     #C5         ; Store constant #C5 into memory pointer
0x165C:  925  LBPX     #25         ; Store constant #25 into memory pointer
0x165D:  9E5  LBPX     #E5         ; Store constant #E5 into memory pointer
0x165E:  9E2  LBPX     #E2         ; Store constant #E2 into memory pointer
0x165F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1660:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1661:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1662:  94C  LBPX     #4C         ; Store constant #4C into memory pointer
0x1663:  992  LBPX     #92         ; Store constant #92 into memory pointer
0x1664:  992  LBPX     #92         ; Store constant #92 into memory pointer
0x1665:  964  LBPX     #64         ; Store constant #64 into memory pointer
0x1666:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1667:  1FE  RETD     0xFE        ; Table lookup return from 0xFE
0x1668:  992  LBPX     #92         ; Store constant #92 into memory pointer
0x1669:  992  LBPX     #92         ; Store constant #92 into memory pointer
0x166A:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x166B:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x166C:  9FE  LBPX     #FE         ; Store constant #FE into memory pointer
0x166D:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x166E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x166F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1670:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1671:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x1672:  942  LBPX     #42         ; Store constant #42 into memory pointer
0x1673:  942  LBPX     #42         ; Store constant #42 into memory pointer
0x1674:  942  LBPX     #42         ; Store constant #42 into memory pointer
0x1675:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x1676:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1677:  17E  RETD     0x7E        ; Table lookup return from 0x7E
0x1678:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1679:  93E  LBPX     #3E         ; Store constant #3E into memory pointer
0x167A:  9C0  LBPX     #C0         ; Store constant #C0 into memory pointer
0x167B:  93E  LBPX     #3E         ; Store constant #3E into memory pointer
0x167C:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x167D:  9CE  LBPX     #CE         ; Store constant #CE into memory pointer
0x167E:  992  LBPX     #92         ; Store constant #92 into memory pointer
0x167F:  1E6  RETD     0xE6        ; Table lookup return from 0xE6
0x1680:  90C  LBPX     #C          ; Store constant #C into memory pointer
0x1681:  9F2  LBPX     #F2         ; Store constant #F2 into memory pointer
0x1682:  982  LBPX     #82         ; Store constant #82 into memory pointer
0x1683:  982  LBPX     #82         ; Store constant #82 into memory pointer
0x1684:  9F2  LBPX     #F2         ; Store constant #F2 into memory pointer
0x1685:  98E  LBPX     #8E         ; Store constant #8E into memory pointer
0x1686:  9F2  LBPX     #F2         ; Store constant #F2 into memory pointer
0x1687:  10C  RETD     0x0C        ; Table lookup return from 0x0C
0x1688:  90C  LBPX     #C          ; Store constant #C into memory pointer
0x1689:  9F2  LBPX     #F2         ; Store constant #F2 into memory pointer
0x168A:  984  LBPX     #84         ; Store constant #84 into memory pointer
0x168B:  988  LBPX     #88         ; Store constant #88 into memory pointer
0x168C:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x168D:  988  LBPX     #88         ; Store constant #88 into memory pointer
0x168E:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x168F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1690:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1691:  9F0  LBPX     #F0         ; Store constant #F0 into memory pointer
0x1692:  990  LBPX     #90         ; Store constant #90 into memory pointer
0x1693:  9A0  LBPX     #A0         ; Store constant #A0 into memory pointer
0x1694:  9E0  LBPX     #E0         ; Store constant #E0 into memory pointer
0x1695:  9A0  LBPX     #A0         ; Store constant #A0 into memory pointer
0x1696:  9E0  LBPX     #E0         ; Store constant #E0 into memory pointer
0x1697:  100  RETD     0x00        ; Table lookup return from 0x00
0x1698:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1699:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x169A:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x169B:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x169C:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x169D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x169E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x169F:  100  RETD     0x00        ; Table lookup return from 0x00
0x16A0:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x16A1:  906  LBPX     #6          ; Store constant #6 into memory pointer
0x16A2:  93F  LBPX     #3F         ; Store constant #3F into memory pointer
0x16A3:  934  LBPX     #34         ; Store constant #34 into memory pointer
0x16A4:  92C  LBPX     #2C         ; Store constant #2C into memory pointer
0x16A5:  9FC  LBPX     #FC         ; Store constant #FC into memory pointer
0x16A6:  960  LBPX     #60         ; Store constant #60 into memory pointer
0x16A7:  120  RETD     0x20        ; Table lookup return from 0x20
0x16A8:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x16A9:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x16AA:  938  LBPX     #38         ; Store constant #38 into memory pointer
0x16AB:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x16AC:  928  LBPX     #28         ; Store constant #28 into memory pointer
0x16AD:  9FC  LBPX     #FC         ; Store constant #FC into memory pointer
0x16AE:  960  LBPX     #60         ; Store constant #60 into memory pointer
0x16AF:  120  RETD     0x20        ; Table lookup return from 0x20
0x16B0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x16B1:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x16B2:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x16B3:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x16B4:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x16B5:  9F0  LBPX     #F0         ; Store constant #F0 into memory pointer
0x16B6:  960  LBPX     #60         ; Store constant #60 into memory pointer
0x16B7:  120  RETD     0x20        ; Table lookup return from 0x20
0x16B8:  90A  LBPX     #A          ; Store constant #A into memory pointer
0x16B9:  90A  LBPX     #A          ; Store constant #A into memory pointer
0x16BA:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x16BB:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x16BC:  97E  LBPX     #7E         ; Store constant #7E into memory pointer
0x16BD:  90A  LBPX     #A          ; Store constant #A into memory pointer
0x16BE:  90A  LBPX     #A          ; Store constant #A into memory pointer
0x16BF:  102  RETD     0x02        ; Table lookup return from 0x02
0x16C0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x16C1:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x16C2:  97A  LBPX     #7A         ; Store constant #7A into memory pointer
0x16C3:  96E  LBPX     #6E         ; Store constant #6E into memory pointer
0x16C4:  96E  LBPX     #6E         ; Store constant #6E into memory pointer
0x16C5:  97A  LBPX     #7A         ; Store constant #7A into memory pointer
0x16C6:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x16C7:  100  RETD     0x00        ; Table lookup return from 0x00
0x16C8:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x16C9:  99C  LBPX     #9C         ; Store constant #9C into memory pointer
0x16CA:  9A0  LBPX     #A0         ; Store constant #A0 into memory pointer
0x16CB:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x16CC:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x16CD:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x16CE:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x16CF:  104  RETD     0x04        ; Table lookup return from 0x04
0x16D0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x16D1:  986  LBPX     #86         ; Store constant #86 into memory pointer
0x16D2:  9F4  LBPX     #F4         ; Store constant #F4 into memory pointer
0x16D3:  994  LBPX     #94         ; Store constant #94 into memory pointer
0x16D4:  9DC  LBPX     #DC         ; Store constant #DC into memory pointer
0x16D5:  994  LBPX     #94         ; Store constant #94 into memory pointer
0x16D6:  9F4  LBPX     #F4         ; Store constant #F4 into memory pointer
0x16D7:  186  RETD     0x86        ; Table lookup return from 0x86
0x16D8:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x16D9:  9FC  LBPX     #FC         ; Store constant #FC into memory pointer
0x16DA:  984  LBPX     #84         ; Store constant #84 into memory pointer
0x16DB:  9FC  LBPX     #FC         ; Store constant #FC into memory pointer
0x16DC:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x16DD:  9C4  LBPX     #C4         ; Store constant #C4 into memory pointer
0x16DE:  9B4  LBPX     #B4         ; Store constant #B4 into memory pointer
0x16DF:  18C  RETD     0x8C        ; Table lookup return from 0x8C
0x16E0:  91C  LBPX     #1C         ; Store constant #1C into memory pointer
0x16E1:  932  LBPX     #32         ; Store constant #32 into memory pointer
0x16E2:  97E  LBPX     #7E         ; Store constant #7E into memory pointer
0x16E3:  9FC  LBPX     #FC         ; Store constant #FC into memory pointer
0x16E4:  97E  LBPX     #7E         ; Store constant #7E into memory pointer
0x16E5:  93E  LBPX     #3E         ; Store constant #3E into memory pointer
0x16E6:  91C  LBPX     #1C         ; Store constant #1C into memory pointer
0x16E7:  100  RETD     0x00        ; Table lookup return from 0x00
0x16E8:  91C  LBPX     #1C         ; Store constant #1C into memory pointer
0x16E9:  922  LBPX     #22         ; Store constant #22 into memory pointer
0x16EA:  942  LBPX     #42         ; Store constant #42 into memory pointer
0x16EB:  984  LBPX     #84         ; Store constant #84 into memory pointer
0x16EC:  942  LBPX     #42         ; Store constant #42 into memory pointer
0x16ED:  922  LBPX     #22         ; Store constant #22 into memory pointer
0x16EE:  91C  LBPX     #1C         ; Store constant #1C into memory pointer
0x16EF:  100  RETD     0x00        ; Table lookup return from 0x00
0x16F0:  905  LBPX     #5          ; Store constant #5 into memory pointer
0x16F1:  9C2  LBPX     #C2         ; Store constant #C2 into memory pointer
0x16F2:  9A0  LBPX     #A0         ; Store constant #A0 into memory pointer
0x16F3:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x16F4:  9D0  LBPX     #D0         ; Store constant #D0 into memory pointer
0x16F5:  9E0  LBPX     #E0         ; Store constant #E0 into memory pointer
0x16F6:  9CA  LBPX     #CA         ; Store constant #CA into memory pointer
0x16F7:  104  RETD     0x04        ; Table lookup return from 0x04
0x16F8:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x16F9:  9CA  LBPX     #CA         ; Store constant #CA into memory pointer
0x16FA:  9E0  LBPX     #E0         ; Store constant #E0 into memory pointer
0x16FB:  9F8  LBPX     #F8         ; Store constant #F8 into memory pointer
0x16FC:  9D0  LBPX     #D0         ; Store constant #D0 into memory pointer
0x16FD:  9A0  LBPX     #A0         ; Store constant #A0 into memory pointer
0x16FE:  9C2  LBPX     #C2         ; Store constant #C2 into memory pointer
0x16FF:  105  RETD     0x05        ; Table lookup return from 0x05
0x1700:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x1701:  93B  LBPX     #3B         ; Store constant #3B into memory pointer
0x1702:  95B  LBPX     #5B         ; Store constant #5B into memory pointer
0x1703:  96B  LBPX     #6B         ; Store constant #6B into memory pointer
0x1704:  973  LBPX     #73         ; Store constant #73 into memory pointer
0x1705:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x1706:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x1707:  1FF  RETD     0xFF        ; Table lookup return from 0xFF
0x1708:  9DF  LBPX     #DF         ; Store constant #DF into memory pointer
0x1709:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x170A:  9EF  LBPX     #EF         ; Store constant #EF into memory pointer
0x170B:  9FF  LBPX     #FF         ; Store constant #FF into memory pointer
0x170C:  9E6  LBPX     #E6         ; Store constant #E6 into memory pointer
0x170D:  9EA  LBPX     #EA         ; Store constant #EA into memory pointer
0x170E:  9EC  LBPX     #EC         ; Store constant #EC into memory pointer
0x170F:  1FF  RETD     0xFF        ; Table lookup return from 0xFF
0x1710:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1711:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x1712:  9F6  LBPX     #F6         ; Store constant #F6 into memory pointer
0x1713:  976  LBPX     #76         ; Store constant #76 into memory pointer
0x1714:  9DE  LBPX     #DE         ; Store constant #DE into memory pointer
0x1715:  976  LBPX     #76         ; Store constant #76 into memory pointer
0x1716:  9F6  LBPX     #F6         ; Store constant #F6 into memory pointer
0x1717:  13C  RETD     0x3C        ; Table lookup return from 0x3C
0x1718:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x1719:  942  LBPX     #42         ; Store constant #42 into memory pointer
0x171A:  918  LBPX     #18         ; Store constant #18 into memory pointer
0x171B:  925  LBPX     #25         ; Store constant #25 into memory pointer
0x171C:  9A4  LBPX     #A4         ; Store constant #A4 into memory pointer
0x171D:  918  LBPX     #18         ; Store constant #18 into memory pointer
0x171E:  942  LBPX     #42         ; Store constant #42 into memory pointer
0x171F:  110  RETD     0x10        ; Table lookup return from 0x10
0x1720:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1721:  940  LBPX     #40         ; Store constant #40 into memory pointer
0x1722:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1723:  90C  LBPX     #C          ; Store constant #C into memory pointer
0x1724:  90F  LBPX     #F          ; Store constant #F into memory pointer
0x1725:  91F  LBPX     #1F         ; Store constant #1F into memory pointer
0x1726:  91E  LBPX     #1E         ; Store constant #1E into memory pointer
0x1727:  106  RETD     0x06        ; Table lookup return from 0x06
0x1728:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1729:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x172A:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x172B:  918  LBPX     #18         ; Store constant #18 into memory pointer
0x172C:  918  LBPX     #18         ; Store constant #18 into memory pointer
0x172D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x172E:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x172F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1730:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1731:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x1732:  938  LBPX     #38         ; Store constant #38 into memory pointer
0x1733:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x1734:  9FE  LBPX     #FE         ; Store constant #FE into memory pointer
0x1735:  938  LBPX     #38         ; Store constant #38 into memory pointer
0x1736:  938  LBPX     #38         ; Store constant #38 into memory pointer
0x1737:  100  RETD     0x00        ; Table lookup return from 0x00
0x1738:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1739:  938  LBPX     #38         ; Store constant #38 into memory pointer
0x173A:  938  LBPX     #38         ; Store constant #38 into memory pointer
0x173B:  9FE  LBPX     #FE         ; Store constant #FE into memory pointer
0x173C:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x173D:  938  LBPX     #38         ; Store constant #38 into memory pointer
0x173E:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x173F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1740:  97E  LBPX     #7E         ; Store constant #7E into memory pointer
0x1741:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x1742:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x1743:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x1744:  97E  LBPX     #7E         ; Store constant #7E into memory pointer
0x1745:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1746:  938  LBPX     #38         ; Store constant #38 into memory pointer
0x1747:  154  RETD     0x54        ; Table lookup return from 0x54 (MEM_AGE)
0x1748:  954  LBPX     #54         ; Store constant #54 into memory pointer
0x1749:  958  LBPX     #58         ; Store constant #58 into memory pointer
0x174A:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x174B:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x174C:  954  LBPX     #54         ; Store constant #54 into memory pointer
0x174D:  954  LBPX     #54         ; Store constant #54 into memory pointer
0x174E:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x174F:  140  RETD     0x40        ; Table lookup return from 0x40 (MEM_HUNGER)
0x1750:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1751:  97E  LBPX     #7E         ; Store constant #7E into memory pointer
0x1752:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1753:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1754:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1755:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1756:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1757:  100  RETD     0x00        ; Table lookup return from 0x00
0x1758:  926  LBPX     #26         ; Store constant #26 into memory pointer
0x1759:  949  LBPX     #49         ; Store constant #49 into memory pointer
0x175A:  949  LBPX     #49         ; Store constant #49 into memory pointer
0x175B:  932  LBPX     #32         ; Store constant #32 into memory pointer
0x175C:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x175D:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x175E:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x175F:  104  RETD     0x04        ; Table lookup return from 0x04
0x1760:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x1761:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1762:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x1763:  954  LBPX     #54         ; Store constant #54 into memory pointer
0x1764:  954  LBPX     #54         ; Store constant #54 into memory pointer
0x1765:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x1766:  940  LBPX     #40         ; Store constant #40 into memory pointer
0x1767:  138  RETD     0x38        ; Table lookup return from 0x38
0x1768:  944  LBPX     #44         ; Store constant #44 into memory pointer
0x1769:  944  LBPX     #44         ; Store constant #44 into memory pointer
0x176A:  928  LBPX     #28         ; Store constant #28 into memory pointer
0x176B:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x176C:  97F  LBPX     #7F         ; Store constant #7F into memory pointer
0x176D:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x176E:  968  LBPX     #68         ; Store constant #68 into memory pointer
0x176F:  100  RETD     0x00        ; Table lookup return from 0x00
0x1770:  97F  LBPX     #7F         ; Store constant #7F into memory pointer
0x1771:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x1772:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x1773:  97F  LBPX     #7F         ; Store constant #7F into memory pointer
0x1774:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1775:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x1776:  940  LBPX     #40         ; Store constant #40 into memory pointer
0x1777:  17C  RETD     0x7C        ; Table lookup return from 0x7C
0x1778:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1779:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x177A:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x177B:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x177C:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x177D:  9BC  LBPX     #BC         ; Store constant #BC into memory pointer
0x177E:  9A4  LBPX     #A4         ; Store constant #A4 into memory pointer
0x177F:  1FC  RETD     0xFC        ; Table lookup return from 0xFC
0x1780:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1781:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x1782:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x1783:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x1784:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1785:  99C  LBPX     #9C         ; Store constant #9C into memory pointer
0x1786:  9A0  LBPX     #A0         ; Store constant #A0 into memory pointer
0x1787:  17C  RETD     0x7C        ; Table lookup return from 0x7C
0x1788:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1789:  97F  LBPX     #7F         ; Store constant #7F into memory pointer
0x178A:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x178B:  908  LBPX     #8          ; Store constant #8 into memory pointer
0x178C:  97F  LBPX     #7F         ; Store constant #7F into memory pointer
0x178D:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x178E:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x178F:  154  RETD     0x54        ; Table lookup return from 0x54 (MEM_AGE)
0x1790:  954  LBPX     #54         ; Store constant #54 into memory pointer
0x1791:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x1792:  940  LBPX     #40         ; Store constant #40 into memory pointer
0x1793:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x1794:  9FC  LBPX     #FC         ; Store constant #FC into memory pointer
0x1795:  924  LBPX     #24         ; Store constant #24 into memory pointer
0x1796:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x1797:  100  RETD     0x00        ; Table lookup return from 0x00
0x1798:  9FC  LBPX     #FC         ; Store constant #FC into memory pointer
0x1799:  924  LBPX     #24         ; Store constant #24 into memory pointer
0x179A:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x179B:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x179C:  99C  LBPX     #9C         ; Store constant #9C into memory pointer
0x179D:  9A0  LBPX     #A0         ; Store constant #A0 into memory pointer
0x179E:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x179F:  100  RETD     0x00        ; Table lookup return from 0x00
0x17A0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17A1:  97F  LBPX     #7F         ; Store constant #7F into memory pointer
0x17A2:  941  LBPX     #41         ; Store constant #41 into memory pointer
0x17A3:  941  LBPX     #41         ; Store constant #41 into memory pointer
0x17A4:  93E  LBPX     #3E         ; Store constant #3E into memory pointer
0x17A5:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17A6:  974  LBPX     #74         ; Store constant #74 into memory pointer
0x17A7:  100  RETD     0x00        ; Table lookup return from 0x00
0x17A8:  95C  LBPX     #5C         ; Store constant #5C into memory pointer
0x17A9:  974  LBPX     #74         ; Store constant #74 into memory pointer
0x17AA:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17AB:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x17AC:  944  LBPX     #44         ; Store constant #44 into memory pointer
0x17AD:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17AE:  974  LBPX     #74         ; Store constant #74 into memory pointer
0x17AF:  100  RETD     0x00        ; Table lookup return from 0x00
0x17B0:  9FC  LBPX     #FC         ; Store constant #FC into memory pointer
0x17B1:  924  LBPX     #24         ; Store constant #24 into memory pointer
0x17B2:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x17B3:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17B4:  97F  LBPX     #7F         ; Store constant #7F into memory pointer
0x17B5:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17B6:  974  LBPX     #74         ; Store constant #74 into memory pointer
0x17B7:  100  RETD     0x00        ; Table lookup return from 0x00
0x17B8:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x17B9:  904  LBPX     #4          ; Store constant #4 into memory pointer
0x17BA:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x17BB:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17BC:  97C  LBPX     #7C         ; Store constant #7C into memory pointer
0x17BD:  954  LBPX     #54         ; Store constant #54 into memory pointer
0x17BE:  95C  LBPX     #5C         ; Store constant #5C into memory pointer
0x17BF:  100  RETD     0x00        ; Table lookup return from 0x00
0x17C0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17C1:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x17C2:  942  LBPX     #42         ; Store constant #42 into memory pointer
0x17C3:  942  LBPX     #42         ; Store constant #42 into memory pointer
0x17C4:  942  LBPX     #42         ; Store constant #42 into memory pointer
0x17C5:  93C  LBPX     #3C         ; Store constant #3C into memory pointer
0x17C6:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17C7:  100  RETD     0x00        ; Table lookup return from 0x00
0x17C8:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17C9:  97E  LBPX     #7E         ; Store constant #7E into memory pointer
0x17CA:  902  LBPX     #2          ; Store constant #2 into memory pointer
0x17CB:  90C  LBPX     #C          ; Store constant #C into memory pointer
0x17CC:  930  LBPX     #30         ; Store constant #30 into memory pointer
0x17CD:  940  LBPX     #40         ; Store constant #40 into memory pointer
0x17CE:  97E  LBPX     #7E         ; Store constant #7E into memory pointer
0x17CF:  100  RETD     0x00        ; Table lookup return from 0x00
0x17D0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17D1:  9C4  LBPX     #C4         ; Store constant #C4 into memory pointer
0x17D2:  9A4  LBPX     #A4         ; Store constant #A4 into memory pointer
0x17D3:  994  LBPX     #94         ; Store constant #94 into memory pointer
0x17D4:  98C  LBPX     #8C         ; Store constant #8C into memory pointer
0x17D5:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17D6:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17D7:  100  RETD     0x00        ; Table lookup return from 0x00
0x17D8:  920  LBPX     #20         ; Store constant #20 into memory pointer
0x17D9:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17DA:  910  LBPX     #10         ; Store constant #10 into memory pointer
0x17DB:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17DC:  919  LBPX     #19         ; Store constant #19 into memory pointer
0x17DD:  915  LBPX     #15         ; Store constant #15 into memory pointer
0x17DE:  913  LBPX     #13         ; Store constant #13 into memory pointer
0x17DF:  100  RETD     0x00        ; Table lookup return from 0x00
0x17E0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17E1:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17E2:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17E3:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17E4:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17E5:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17E6:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17E7:  100  RETD     0x00        ; Table lookup return from 0x00
0x17E8:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17E9:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17EA:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17EB:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17EC:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17ED:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17EE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17EF:  100  RETD     0x00        ; Table lookup return from 0x00
0x17F0:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17F1:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17F2:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17F3:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17F4:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17F5:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17F6:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17F7:  100  RETD     0x00        ; Table lookup return from 0x00
0x17F8:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17F9:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17FA:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17FB:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17FC:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17FD:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17FE:  900  LBPX     #0          ; Store constant #0 into memory pointer
0x17FF:  100  RETD     0x00        ; Table lookup return from 0x00