.equ INPUT, 0
.equ OUTPUT, 1
.equ LOW, 0
.equ HIGH, 1
.equ BUTTON, 8 // (physical 3)
.equ RED_LED, 16 // (physical 10)
.equ YELLOW_LED, 15 // (physical 8)
.equ GREEN_LED, 7 // (physical 7)
.equ STOP_LED, 25 // (physical 37)
.equ GO_LED, 24 // (physical 35)

.section .rodata
out_msg1: .asciz "YOU MAY CROSS NOW.\n"
out_msg2: .asciz "DO NOT CROSS. TRAFFIC IS ONGOING.\n"
start_msg: .asciz "PRESS BUTTON TO START SIMULATION.\n"
success_msg: .asciz "Street-Crossing Program is successfully running.\n"
cross_end: .asciz "LIGHTS ARE FLASHING. PREPARE FOR ONCOMING TRAFFIC.\n"
prepare: .asciz "PREPARE TO CROSS.\n"

.text
.global main
main:
    push {lr}
    // Initialize the wiringPi library
    bl wiringPiSetup 

    // Initializing PINS for button and LEDs.
    mov r0, #BUTTON 
    mov r1, #INPUT
    bl pinMode

    mov r0, #RED_LED
    mov r1, #OUTPUT
    bl pinMode

    mov r0, #YELLOW_LED
    mov r1, #OUTPUT
    bl pinMode

    mov r0, #GREEN_LED
    mov r1, #OUTPUT
    bl pinMode

    mov r0, #STOP_LED
    mov r1, #OUTPUT
    bl pinMode

    mov r0, #GO_LED
    mov r1, #OUTPUT
    bl pinMode

    // r4 is the state of the LED
    // r5 is the state of the button
    mov r4, #0 // zero = off
    mov r5, #0 // zero = button is not pressed

    // Let user now program is running
    ldr r0, =success_msg
    bl printf

    // Prompt user to start simulation
    ldr r0, =start_msg
    bl printf

do_while:
    // ----------------------------------------------
    // INITIAL STATE OF THE TRAFFIC LIGHTS:
    // TRAFFIC LIGHTS: ON (ONCOMING TRAFFIC = TRUE)
    // PEDESTRIAN LIGHTS: OFF (PEDESTRIANS CANNOT CROSS)
    // ----------------------------------------------

    // read the button state
    mov r0, #BUTTON
    bl digitalRead
    
    // Check if button is pressed
    cmp r0, #HIGH // is r0 == HIGH (1)?
    beq button_pressed // yes, button is pressed

    // this code compares the current state of the button with the previous state
    // continue_while code creates a delay between button presses.
    cmp r5, #0 // is r5 == 0 (button was not pressed before)?
    beq continue_while // yes, continue while loop

    // comparing the LED states. If the LED is on, branch to turn_off_traffic_light.
    cmp r4, #1 // is r4 == 1 (led is on)?
    beq turn_off_traffic_light // yes, turn off led

    // ----------------------------------------------
    // INITIAL STATE OF THE TRAFFIC LIGHTS:
    mov r0, #RED_LED 
    mov r1, #LOW
    bl digitalWrite

    mov r0, #YELLOW_LED 
    mov r1, #LOW
    bl digitalWrite

    mov r0, #GREEN_LED 
    mov r1, #HIGH
    bl digitalWrite

    mov r0, #STOP_LED 
    mov r1, #HIGH
    bl digitalWrite

    mov r0, #GO_LED 
    mov r1, #LOW
    bl digitalWrite
    // ----------------------------------------------

    mov r4, #1 // set led state variable to on
    ldr r0, =out_msg2 
    bl printf

    mov r5, #0 // reset button state to not pressed
    b do_while

button_pressed:
    mov r5, #1 // set button state to pressed
    b continue_while

turn_off_traffic_light:
    // ----------------------------------------------
    // Flash from Green -> Yellow -> Red
    // ----------------------------------------------
    // 3 second delay to flash down.
    ldr r0, =prepare
    bl printf

    ldr r0, =#3000
    bl delay

    mov r0, #RED_LED // digitalWrite(16, LOW);
    mov r1, #LOW
    bl digitalWrite

    mov r0, #YELLOW_LED // digitalWrite(15, LOW);
    mov r1, #LOW
    bl digitalWrite

    mov r0, #GREEN_LED // digitalWrite(7, LOW);
    mov r1, #HIGH
    bl digitalWrite

    ldr r0, =#1000
    bl delay

    mov r0, #RED_LED // digitalWrite(16, LOW);
    mov r1, #LOW
    bl digitalWrite

    mov r0, #YELLOW_LED // digitalWrite(15, LOW);
    mov r1, #HIGH
    bl digitalWrite

    mov r0, #GREEN_LED // digitalWrite(7, LOW);
    mov r1, #LOW
    bl digitalWrite

    ldr r0, =#1000
    bl delay

    mov r0, #RED_LED // digitalWrite(16, LOW);
    mov r1, #HIGH
    bl digitalWrite

    mov r0, #YELLOW_LED // digitalWrite(15, LOW);
    mov r1, #LOW
    bl digitalWrite

    mov r0, #GREEN_LED // digitalWrite(7, LOW);
    mov r1, #LOW
    bl digitalWrite

    ldr r0, =#1000
    bl delay
    // ----------------------------------------------
    mov r0, #STOP_LED // digitalWrite(10, LOW);
    mov r1, #LOW
    bl digitalWrite

    mov r0, #GO_LED // digitalWrite(11, LOW);
    mov r1, #HIGH
    bl digitalWrite

    mov r4, #0 // set led state to off
    ldr r0, =out_msg1 
    bl printf

    // WRITE DELAY FUNCTIONALITY HERE
    ldr r0, =#10000
    bl delay

    // BRANCH TO FLASH
    ldr r0, =cross_end
    bl printf
    // print out msg to warn pedestrians of cross ending
    b flash

continue_while:
    mov r0, #500
    bl delay
    b do_while

flash:
    mov r0, #GREEN_LED // digitalWrite(7, LOW);
    mov r1, #LOW
    bl digitalWrite

    mov r0, #YELLOW_LED // digitalWrite(15, LOW);
    mov r1, #LOW
    bl digitalWrite

    ldr r0, =#750
    bl delay

    mov r0, #GREEN_LED // digitalWrite(7, HIGH);
    mov r1, #HIGH
    bl digitalWrite

    mov r0, #YELLOW_LED // digitalWrite(15, HIGH);
    mov r1, #HIGH
    bl digitalWrite

    ldr r0, =#750
    bl delay

    mov r0, #GREEN_LED // digitalWrite(7, LOW);
    mov r1, #LOW
    bl digitalWrite

    mov r0, #YELLOW_LED // digitalWrite(15, LOW);
    mov r1, #LOW
    bl digitalWrite

    ldr r0, =#750
    bl delay

    mov r0, #GREEN_LED // digitalWrite(7, HIGH);
    mov r1, #HIGH
    bl digitalWrite

    mov r0, #YELLOW_LED // digitalWrite(15, HIGH);
    mov r1, #HIGH
    bl digitalWrite

    ldr r0, =#750
    bl delay

    mov r0, #GREEN_LED // digitalWrite(7, LOW);
    mov r1, #LOW
    bl digitalWrite

    mov r0, #YELLOW_LED // digitalWrite(15, LOW);
    mov r1, #LOW
    bl digitalWrite

    ldr r0, =#750
    bl delay

    mov r0, #GREEN_LED // digitalWrite(7, HIGH);
    mov r1, #HIGH
    bl digitalWrite

    mov r0, #YELLOW_LED // digitalWrite(15, HIGH);
    mov r1, #HIGH
    bl digitalWrite

    ldr r0, =#750
    bl delay

    mov r0, #GREEN_LED // digitalWrite(7, LOW);
    mov r1, #LOW
    bl digitalWrite

    mov r0, #YELLOW_LED // digitalWrite(15, LOW);
    mov r1, #LOW
    bl digitalWrite

    ldr r0, =#750
    bl delay

    mov r0, #GREEN_LED // digitalWrite(7, HIGH);
    mov r1, #HIGH
    bl digitalWrite

    mov r0, #YELLOW_LED // digitalWrite(15, HIGH);
    mov r1, #HIGH
    bl digitalWrite

    ldr r0, =#750
    bl delay

    mov r0, #GREEN_LED // digitalWrite(7, LOW);
    mov r1, #LOW
    bl digitalWrite

    mov r0, #YELLOW_LED // digitalWrite(15, LOW);
    mov r1, #LOW
    bl digitalWrite

    ldr r0, =#750
    bl delay

    mov r0, #GREEN_LED // digitalWrite(7, HIGH);
    mov r1, #HIGH
    bl digitalWrite

    mov r0, #YELLOW_LED // digitalWrite(15, HIGH);
    mov r1, #HIGH
    bl digitalWrite

    ldr r0, =#750
    bl delay

    mov r0, #GREEN_LED // digitalWrite(7, LOW);
    mov r1, #HIGH
    bl digitalWrite

    mov r0, #YELLOW_LED // digitalWrite(15, LOW);
    mov r1, #LOW
    bl digitalWrite

    mov r0, #RED_LED // digitalWrite(16, HIGH);
    mov r1, #LOW
    bl digitalWrite

    mov r0, #STOP_LED // digitalWrite(10, HIGH);
    mov r1, #HIGH
    bl digitalWrite

    mov r0, #GO_LED // digitalWrite(11, HIGH);
    mov r1, #LOW
    bl digitalWrite

    ldr r0, =cross_end
    bl printf

    mov r5, #0 // reset button state to not pressed
    mov r4, #0 // reset led state to off
    b do_while

end_do_while:
    mov r0, #0 //return 0;
    pop {pc} //} 