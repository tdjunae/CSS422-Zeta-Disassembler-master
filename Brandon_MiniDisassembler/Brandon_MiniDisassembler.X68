*-----------------------------------------------------------
* Title      :Brandon's Mini Disassembler
* Written by :Brandon Roth
* Date       :2/23/2014
* Description:***
*-----------------------------------------------------------
START   ORG     $1000

        LEA     MESSAGE,A1      Loads MESSAGE into address register A1
        MOVE.B  #14,D0          Moves the number 14 into data register D0
        TRAP    #15             Displays Message
        
*-----------------------------------------------------------        
* Start of Mini Disassembler
*-----------------------------------------------------------        

START2  EQU $00007FC0
MOVEOP  EQU %00 *First two bits of move are always 00
        
        MOVEA.L #START2,A0  *Load starting location of test input file into A0
        MOVE.B  (A0),D0     *Move the byte data at A0 into D0 (**i really want only 4 bits...)
        
        
ISMOVE  *is a move instruction, try to decode rest
        
*-----------------------------------------------------------        
* End of Mini Disassembler
*-----------------------------------------------------------    
        
NOTMOVE MOVE.B  #9,D0
        TRAP    #15             Halt Simulator        
        
CR      EQU     $0D             ASCII code for Carriage Return
LF      EQU     $0A             ASCII code for Line Feed
MESSAGE DC.B    'Hey, going to try to disassemble MOVE.B',0
        END     START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
