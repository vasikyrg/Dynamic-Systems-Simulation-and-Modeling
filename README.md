# Dynamic Systems Simulation and Modeling

Linear Configuration, Estimation of Unknown Parameters, Minimum Squares Method

The mass-spring-damper system shown in the following figure is given:

![image](https://user-images.githubusercontent.com/95449708/150970466-2a00e22c-21bc-4025-986a-82c97e1696f0.png)

Where b is the damping constant, k is the spring constant, u is an external force and y (t) is the displacement of the mass m due to the momentum applied to it. Simulate the algorithm you designed in the previous step assuming m = 15kg, b = 0.2kg / sec, k = 2kg / sec2 and u = 5 sin (2t) + 10.5N. Use samples every 0.1sec for 10sec assuming zero initial conditions for system states.


The circuit of the following figure is given:

![image](https://user-images.githubusercontent.com/95449708/150970767-476b9ca6-b520-4f75-946a-4d63aebd2d27.png)

where u1 (t) = 2 sin (t) V and u2 (t) = 1 V. In addition, we can only measure the voltages VR, VC at the ends of the resistor and the capacitor respectively.
(a) Estimate with the method of least squares the transfer table of the above circuit. The VR, VC voltages are generated from the v.p file by calling the function as follows:

Vout = v (t);

E.g.

t = 1.5;

Vout = v (t);

The variable Vout contains the voltages VR, VC at time t = 1.5.

VR = Vout (1), VC = Vout (2)

Note: The simulations should be done with Matlab functions that you choose based on the quality of the results they give.

(b) Assume that the VR, VC measurements are taken incorrectly (eg generate the VR, VC signals as before and add in 3 random times some random numbers much larger in size than the normal values). Notice what impact this error has on the parameter estimates using the least squares method.
