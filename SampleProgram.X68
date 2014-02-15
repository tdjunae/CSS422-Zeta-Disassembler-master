*-----------------------------------------------------------
* Title      :Does this work?
* Written by :Brandon Roth
* Date       :1/30/2100
* Description:Small Program that will print 'Hello World'
*-----------------------------------------------------------
START   ORG     $1000


*-------Code for output------
        LEA     MESSAGE,A1      Loads MESSAGE into address register A1
        MOVE.B  #14,D0          Moves the number 14 into data register D0
        TRAP    #15             Displays Message
        
        MOVE.B  #9,D0
        TRAP    #15             Halt Simulator
        
        
CR      EQU     $0D             ASCII code for Carriage Return
LF      EQU     $0A             ASCII code for Line Feed
MESSAGE DC.B    'Hello, My name is Brandon Roth',CR,LF
        DC.B    'This class is a lot of fun. I am enjoying the material.',CR,LF
        DC.B    'I hope to learn more about hardware after using this simulator.',CR,LF
        DC.B    '',CR,LF
        DC.B    'Thank you for listening',0

        END     START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
