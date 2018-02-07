Authors:
Dileep Gudena
Gokul Surendra
Date: 11/14/2017

**ReadMe**

import the Main.py file to the python environment.
Run the program by giving the comand line arguments as <number of samples> <Evidence> <Query>

suppose if we want to find out JohnCalls given Alarm is true and burglary is false for 1000 samples.
We give the argument in the following format

1000 A,t|B,f J

The evidence is seperated by | and it's value is seperated by ,

Similarly we give the following command line arguments for our table formulations for the given queries.

Table-1
10 A,f B
50 A,f B
100 A,f B
200 A,f B
500 A,f B
1000 A,f B
5000 A,f B
10000 A,f B

Table-2
10 A,f J
50 A,f J
100 A,f J
200 A,f J
500 A,f J
1000 A,f J
5000 A,f J
10000 A,f J

Table-3
10 J,t|E,f B
50 J,t|E,f B
100 J,t|E,f B
200 J,t|E,f B
500 J,t|E,f B
1000 J,t|E,f B
5000 J,t|E,f B
10000 J,t|E,f B

Table-4
10 J,t|E,f M
50 J,t|E,f M
100 J,t|E,f M
200 J,t|E,f M
500 J,t|E,f M
1000 J,t|E,f M
5000 J,t|E,f M
10000 J,t|E,f M

Table-5
10 M,t|J,f B
50 M,t|J,f B
100 M,t|J,f B
200 M,t|J,f B
500 M,t|J,f B
1000 M,t|J,f B
5000 M,t|J,f B
10000 M,t|J,f B

Table-6
10 M,t|J,f E
50 M,t|J,f E
100 M,t|J,f E
200 M,t|J,f E
500 M,t|J,f E
1000 M,t|J,f E
5000 M,t|J,f E
10000 M,t|J,f E