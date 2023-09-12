# Computer vision

[TOC]



# 23-09-07

### Physics of color 



The white light is composed of almost equal energy in all wavelengths of the visible spectrum. Actually, *the white is a combination of red, blue and green*. When the light passes through the triangular prism, you see a rainbow. This is because the prism separates the colors by a different angle (by varying [refractive index](https://www.britannica.com/science/refractive-index)). 

[Prism experiments](https://www.youtube.com/watch?v=uucYGK_Ymp0)

In simple words, **color** is the result of the interaction between physical light and our visual system. Sientifically (and broader), reflected color is the result of interaction of light source spectrum with surface reflectance. Spectral radiometry is a field of science that deals with the measurement and analysis of light or electromagnetic radiation. 







### Human eye

Cones and rods are the two types of light-sensitive receptors (dwell in the retina). 

**Cones** are cone-shaped, responsible for color vision and provide high-resolution, detailed images. Cones are less sensitive to light, meaning they require more light to become activated.

There are three types of cones: short-wavelength cones (blue), medium-wavelength cones (green), and long-wavelength cones (red). The brain combines the signals from these cones to create our perception of a wide range of colors.

 **Rods** are rod-shaped and highly sensitive to light. They are responsible for the gray-scale (black & white) vision. Rods are bad at detecting colors. They are more suited for detecting motion and shapes under low-light conditions.

<img src="./pics for conspects/CV/23-09-07 1.jpg" alt="23-09-07 1" style="zoom:65%;" />







### Color spaces

#### Linear color space

Linear color space is defined by three primaries. The coordinates of a color are given by the weights of the primaries used to match it.

One of the most well-known examples of a linear color space is CIELAB:





#### Absolute color space

<img src="./pics for conspects/CV/23-09-07 3.png" alt="23-09-07 3" style="zoom:80%;" />

The chromaticity diagram is a color space on the XY-plane. 

Every color can be represented as a set of coordinates on the chromaticity diagram. It is a two-dimensional simplification of an RGB space, which is three-dimensional. 

The chromaticity diagram is an absolute color space, since it is defined in terms of physical phenomena: it represents colors in terms of the wavelengths of light and how they mix.

You can play with the chromaticity diagram [here](https://company235.com/tools/colour/cie.html).





#### RGB color space

<img src="./pics for conspects/CV/23-09-07 2.png" alt="23-09-07 2" style="zoom:80%;" />

RGB space describes how to express every color as a combination of red, green and blue. Primaries used in RGB space are monochromatic lights (consist of a single wavelength).

To define an RGB color space, we draw a triangle, with four main points: red, green, blue and white. Depending on the triangle location, the same color can be represented with different coordinates. 

The GRB system depends on three primary colors. We need to define primaries in absolute terms, so that there is no ambiguity (e.g. colors do not change depending on the monitor). Here is where [the absolute color space](####Absolute color space) is used. 







**HSV color space** is a nonlinear collor space. HSV stands for:

- Hue
- Saturation
- Value



HSV space can be converted into RGB space. 







### White balancing

White balance is the process of removing unnatural color casts.

**The von Kries adaptation** hypothesis suggests that the human visual system adapts to changes in illumination by adjusting its sensitivity to different wavelengths of light. Cones in the retina adapt to changes by multiplying their responses to incoming light by a scaling factor. The factor depends on the spectral composition of the ambient light.





















