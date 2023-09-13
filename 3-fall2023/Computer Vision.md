# Computer vision

[TOC]



# 23-09-07

### Physics of color 

The white light is composed of almost equal energy in all wavelengths of the visible spectrum. Actually, *the white is a combination of red, blue and green*. When the light passes through the triangular prism, you see a rainbow. This is because the prism separates the colors by a different angle (by varying [refractive index](https://www.britannica.com/science/refractive-index)). 

[Prism experiments](https://www.youtube.com/watch?v=uucYGK_Ymp0)

In simple words, **color** is the result of the interaction between physical light and our visual system. Sientifically (and broader), reflected color is the result of interaction of light source spectrum with surface reflectance. Spectral radiometry is a field of science that deals with the measurement and analysis of light or electromagnetic radiation. 

[Amaizing math behind colors](https://www.youtube.com/watch?v=gnUYoQ1pwes)







### Human eye

Cones and rods are the two types of light-sensitive receptors (dwell in the retina). 

<img src="./pics for conspects/CV/23-09-07 1.jpg" alt="23-09-07 1" style="zoom:65%;" />

 **Rods** are rod-shaped and highly sensitive to light. They are responsible for the gray-scale (black & white) vision. Rods are bad at detecting colors. They are more suited for detecting motion and shapes under low-light conditions.

**Cones** are cone-shaped, responsible for color vision and provide high-resolution, detailed images. Cones are less sensitive to light, meaning they require more light to become activated.

There are three types of cones: short-wavelength cones (blue), medium-wavelength cones (green), and long-wavelength cones (red). Each type detects the light of definite wavelength (the range can be found in the pic below). Depending on the wavelength, different amounts of cone types are activated. The brain combines the signals from the cones to create our perception of colors.

<img src="./pics for conspects/CV/23-09-07 5.png" alt="23-09-07 5" style="zoom:80%;" />

You can also notice that cones of different types have different responsivity. If we add three functions together, it gives us a function of a total responsivity. Its maximum is in the range of green and yellow wavelengths. It explains why we see colors around yellow as a lot brighter than others. 







### Color spaces

#### Linear color space

Linear color space is defined by three primaries. The coordinates of a color are given by the weights of the primaries used to match it.

One of the most well-known examples of a linear color space is CIELAB.





#### Chromaticity diagram

<img src="./pics for conspects/CV/23-09-07 3.png" alt="23-09-07 3" style="zoom:80%;" />

The chromaticity diagram is a color space on the XY-plane. 

Every color can be represented as a set of coordinates on the chromaticity diagram. It is a two-dimensional simplification of an RGB space, which is three-dimensional. 

You can play with the chromaticity diagram [here](https://company235.com/tools/colour/cie.html). 





#### RGB space

<img src="./pics for conspects/CV/23-09-07 4.png" alt="23-09-07 4" style="zoom:80%;" />

RGB space describes how to express every color as a combination of red, green and blue. Primaries used in RGB space are monochromatic lights (consist of a single wavelength).





#### HSV space \todo

HSV color space is a nonlinear collor space. HSV stands for:

- Hue
- Saturation
- Value



HSV space can be converted into RGB space. 







### White balancing

White balance is the process of removing unnatural color casts.

**The von Kries adaptation** hypothesis suggests that the human eye adapts to changes in illumination by adjusting its sensitivity to different wavelengths of light. Cones adapt to changes by multiplying their responses to incoming light by a scaling factor. 

So, the idea of von Kries adaptation is to multiply each channel by a gain factor. One way to find the factor is to use the "gray card" method:

- take a picture of a neutral object (white or gray)
- deduce the weight of each channel. If the neutral object is recorded as $r_w, g_w, b_w$, then weights for custom white balance settings will be $\frac{1}{r_w}, \frac{1}{g_w}, \frac{1}{b_w}$. 





















