CC=g++
CFLAGS=-g
LDFLAGS=-lwiringPi

all: street-crossing

street-crossing: street-crossing.s
        $(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

clean:
        rm -f street-crossing






