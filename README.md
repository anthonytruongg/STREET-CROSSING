# INTRODUCTION

For the Final Project, I decided to do the Street Crossing project.
This project stood out to me because as a Computer Engineering major,
have yet to be able to gain experience in hardware side of things. Up until now, I have been coding with hardly any experience in the latter. Reading this project prompt got me excited to figure out the bridge between the two.

# PROMPT

Street Crossing - This consists of a street light (red,yellow,green row of LEDs), and a separate red and green led (walk/dont walk) and a button. When the button is pressed, the red lights light up and the green indicator for walk lights up. Eventually the green and yellow will flash saying time to walk is over, then the red for dont walk lights up, and green for traffic lights up.

# DOCUMENTATION

I was not sure of where to start so I started off by googling everything online. This was not easy, because there is very limited information around how to work with Assembly + Raspberry pi 4. Eventually, I looked into the textbook but that looked extremely difficult as well, as they were not using any packages to help. The GPIO memory registers needed to be hard coded and that looked extremely time consuming and difficult. I thought there had to be an easier way to approach this (without using Python, C++) and so I looked into Professor Conrad's GitHub and was able to find sample repos pertaining to this project.

The sample repo's utilized wiringPi package. Had I not even looked through his repo, I would have never found this package that allowed ease into coding the connection of the GPIO pins. I started off with the redLed project, to test the connections and everything went smooth. I then looked through the push button repos to figure out how to get the wiring and coding to work together. After figuring out the proper wiring and realizing the code was working, this is when the project officially started.

## MY THOUGHT PROCESS

Looking at this project at first, it was very overwhelming. I broke down the project into bits and pieces that were manageable, and here is how I did that.

1. Firstly, I had to figure out how to get power to the LED. I wired a red LED with a 220 ohm resistor and ran the code to get it to light up.
2. Now, I wanted to figure out how to get the button to working. Sifting through the available lab repos, I found code to toggle the push button state. I learned here, that when the button is pushed down, it gets "grounded" meaning the voltage is zero.
3. Now, knowing how to power an LED and toggle a button, I combined both bits of code to power the LED with a button. This was challenging, but was manageable through keeping track of the state of the LED and button. Since the button cannot stay "pressed", this is why a state variable was declared to track this.
4. Now that I was able to get one LED powering on and off through a button press, I had to figure out how to wire the remaining 4 LEDs. This was simple, as I just copied the initial LED circuit and replicated it. During this process, I realized that the green LED was dimly lit. This is because the voltage drop between the green LED is much greater compared to the red and yellow LEDs. To counteract this dim LED, I ran no resistor through this LED while the red and yellow LEDs had a 220 ohm resistor running through it.
5. Now that I had all the LEDs running and powering on with a toggle of a button, I had to first figure out how to toggle the lights. For traffic lights, GREEN is on, YELLOW is off, RED is off. For Pedestrian lights, RED is on, and GREEN is off. I initialized the state of these LEDs.
6. After initial state, I had to run a flash function to get the lights to flash. I added a delay in between flashes to give ample time for the lights to flash. The pedestrian lights will stay on for ~18s.
7. And that's it!

## POST-THOUGHTS

This project was really fun and I enjoyed coding the logic for the hardware. This project made me realize how much I love the major that I chose (computer engineering) because I get a good dosage of coding and working with electrical components.

# FULL PROJECT DOCUMENTATION LINK

https://drive.google.com/drive/folders/1tRWq2ty44gfzDVTsBHXGuH1jMdWoXVG1?usp=share_link
