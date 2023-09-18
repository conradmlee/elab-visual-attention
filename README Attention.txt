Saliency-based Visual Attention Matlab Code

by Conrad Lee (with much help from Polina Akselrod and Eugenio Culurciello through Yale ELAB)


INTRODUCTION

This is a basic Matlab implementation of the model described in "A Model of Saliency-Based Visual Attention for Rapid Scene Analysis" by Laurent Itti, Christof Koch, and Ernst Niebur.


RUNNING THE PROGRAM

(1) If you don't have Matlab, download the latest version and install it

(2) Make sure you have all the Matlab attention files, as well as the included image folder

(3) Once you are in the command window for Matlab, type this in and press enter:

addpath(genpath(['wherever YOUR folder is located']))

Sample path: addpath(genpath('C:\Users\Lee\Desktop\ELAB\Attention'))

Note that if this is your sample path, your image folder should at:
C:\Users\Lee\Desktop\ELAB\Attention\img

(4) Now just type in "attention" and press enter

(5) The program takes about 25 seconds to run (feel free to try and streamline this if you can)

(6) If you have done all this correctly and your image file is in the right place, you should see five images displayed.

In order they are:
1. The intensity saliency map
2. The color saliency map
3. The orientation saliency map
4. The master saliency map (combined I, C, and O)
5. The input image with the first focal attention point

(7) Now just press enter to move to the next attention point. You can do this ten times. (or you can change the parameters in the find_max.m file to add more)

(8) To close all the windows, just type "close all" in the command window and press enter.

(9) To input a different image, just open the "attention.m" file in the matlab editor and change the input where it says INPUT IMAGE. Note that the image must be a 512 x 512 PNG format file.


ADDITIONAL NOTES

(1) Most parameters can be changed between the attention.m and find_max.m files

(2) If you want to stop display of individual saliency maps (C, I, or O), go to "intensity_saliency.m" (or color/orientation) and comment out the "display image" section, which includes "figure" and "imshow"

(3) To make the program continue displaying more focal points go to "find_max.m" and change i=1:10 to a larger number (like 20, or 30). After this you should also change the EdgeColor fraction that multiplies i (initially set to 0.1, for i=1:10) in order to gradually decrement the color from red to yellow.


NEEDS DEBUGGING

(1) The image seems to be drifting towards the bottom right (due to decimation/normalization?), see Dirk Walther or the "Salient Green" blog online for help

(2) Do I need a DoG filter: difference of gaussians.

(3) Runs extremely slowly. Too many for loops. Either put them in a MEX file or find some other way to cut down.