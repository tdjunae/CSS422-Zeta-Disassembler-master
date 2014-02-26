*-----------------------------------------------------------
* Title      :Brandon's Mini Disassembler
* Written by :Brandon Roth
* Date       :2/23/2014
* Description:Disassembles and stuff!
*-----------------------------------------------------------
START   ORG     $1000

        LEA     MESSAGE,A1      Loads MESSAGE into address register A1
        MOVE.B  #14,D0          Moves the number 14 into data register D0
        TRAP    #15             Displays Message
        
*-----------------------------------------------------------        
* Start of Mini Disassembler
*-----------------------------------------------------------        

START2  EQU $00007FC0
NOPOP   EQU $04   *Store as byte, but I really only care about first 4 bits
*MOVEOP  EQU %00 *First two bits of move are always 00
        
        *Load starting location of test input file into A0
        MOVEA.L #START2,A0  
        *Move byte data at (A0) into D0. D0 is now the first 8 bits of the first
        *OP instruction from the test input file
        MOVE.B  (A0),D0
        *Clear the first 4 bits from 8 bit value in D0. I am doing this so we retain
        *just the last 4 bits. These LAST 4 bits are FIRST 4 bits the of the first OP
        *CODE. By using only the first 4 bits of an instruction, we can begin to
        *narrow down which particular OP code the instruction actually is!
        BCLR.L  #$00,D0 
        BCLR.L  #$01,D0
        BCLR.L  #$02,D0
        BCLR.L  #$03,D0
        *Now I need to shift these 4 bit values right by 4 bits, so that these 4 bits
        *are in the LSB position. Then I can begin to compare this value with others 
        *and start decoding this OP CODE.
        LSR.W   #$04,D0
        *Now I know the order in which the opcodes will appear, but later I will
        *need to keep loading opcode data into some register and testing until we
        *find a hit with the first four bits. then JSR into some subroutine.   

*Decode a NOP OP--------------------------------------------
        MOVE.B  #NOPOP,D1  *Load the first 4 bits (really a byte) of NOP into D1
        *Compare the first 4 bits of the first OP CODE with first 4 of NOP. 
        *If equal we have a NOP instruction.Branch to 'ISNOP' and decode the rest
        CMP.B   D0,D1
        BEQ     ISNOP
        
*Decode a MOVE OP-------------------------------------------
        *MOVE.B  (A0),D0     *Move the byte data at A0 into D0 (**i really want only 4 bits...)
        
*Branch to correct OP-------------------------------------------        
ISNOP   
NOPBODY EQU $0E71   *The rest of the NOP instruction equals this hex value
        MOVE.W  (A0),D0 *Move the WHOLE instruction into D0
        *need to clear the first 4 MSB bits again, so I can compare just the last
        *12 bits to the last 12 bits of the NOP instruction...
        MOVE.W  #NOPBODY,D1 *Move the 'rest' of the instruction binary code into D1
        *Compare D0 to D1, I could just compare the whole word value in memory
        *to the whole word value of a NOP instruction (since NOP is constant),
        *but I won't since it would be too easy :)
        *
        *Output some message, hey we found a NOP or something...
        *
        
*ISMOVE  *is a move instruction, try to decode rest. need a jsr or something to get here?
        
*-----------------------------------------------------------        
* End of Mini Disassembler
*-----------------------------------------------------------    
        
THEEND  MOVE.B  #9,D0
        TRAP    #15             Halt Simulator        
        
CR      EQU     $0D             ASCII code for Carriage Return
LF      EQU     $0A             ASCII code for Line Feed
MESSAGE DC.B    'Hey, going to try to disassemble MOVE.B',CR,LF,0
        END     START
        
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
