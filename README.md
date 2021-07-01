# echo

[![Linux tests](https://github.com/memowe/echo-server/actions/workflows/linux-tests.yml/badge.svg)](https://github.com/memowe/echo-server/actions/workflows/linux-tests.yml)
[![Mac OS tests](https://github.com/memowe/echo-server/actions/workflows/mac-tests.yml/badge.svg)](https://github.com/memowe/echo-server/actions/workflows/mac-tests.yml)
[![Windows tests](https://github.com/memowe/echo-server/actions/workflows/windows-tests.yml/badge.svg)](https://github.com/memowe/echo-server/actions/workflows/windows-tests.yml)

With the form provided by this web app, users can create simple web pages using [Markdown][markdown]. These web pages are self-contained, fully encoded in their own URL. Because of this, it is easy to send huge amounts of text by passing a simple link, possibly shortened by a URL shortener service. It is also possible to generate a QR code for the page's URL to pass around. Because [URLs can be quite long][urls-long] and this app uses gzip for compression (which works extremely well for text), the amount of encoded content can be surprisingly big (see an example below).

A running echo instance can be found here: [tinyurl.com/memowecho][memowecho].

## EXAMPLES

- [Has the world ended yet?][end-of-the-world] - the obvious answer.
- [A huge amount of text][long-example] encoded in a not-so-long URL.
- [Velociraptor-free workplace][velociraptor-free] - a complex website using basic markdown with inline SVG graphics and javascript date calculation.

## DID YOU KNOW ...?

The echo web app has a very short and well-documented [source code][echo-source] and comes with a [test suite][echo-test]. It is still shorter than this README file, even without the two extra-long URLs.

[markdown]: https://daringfireball.net/projects/markdown/
[urls-long]: http://stackoverflow.com/a/417184/1184510
[long-example]: http://euve75060.serverprofi24.de:4000/H4sIAAAAAAAAA+2Xy2okNxRA9wPzDxeyM8b/YJJlyCbkA9RVcluZek1J8mT89bmq7o6NCSEEgq7Q%0A2czY7u6S7tGxxflBHmVal7Ns7uw/f/r86e7u53X3s4Qt5vnuTsZ1WneJIYmbfbqXYV2iTz5l/aEb%0A9V1D0E/7KaT9XqIfZQxulmVd8vxdfNjndZTk500fEpaXMOYlSU4yuZMuIz5dFvAyu/PixE3ha/6u%0AD/C7S++e97JOeUvZPZQtPiZ58fsqfo3lAW4YciwfSfJ7jmmVMa/Xpx6veye7P+X5QX7VfcugW3Xy%0AxcVRzvnk9/Pul3vdsC7mJLkvYXb6enTLkLJ+PiZ5B+QDjod/eK06KoFTe5x+yiGKyzqe7mkSr28J%0Ae8g6zeWdYZFnv4y73/Uj+s1LnracXPLl7fojH6MOvk66TvAXsl9zmbs8LUzTbUnllOXJ53NwSZY8%0ATU6e3BCmEMv6NyD7G5FZJyhfhwPJOgZlEs5LiDHM8jUHOU1uGXUH2+589HokBa9LuuDr6x4mGf3k%0AlzJnPmedpsx53YluvuzEhY87+RfaDMUbv0vxJryJ89EbFWcJp2cdOsRDn7AM78TRVf5Wm6s1hytp%0Ac3o+vyX5pjsTHWXWRWUO5YsX/dbN94VD1AVj2vMo/g+/D0EVSGFdpAw2D+u+6WZj1p1uOsi0qrKp%0AfCbEqWzlWDVs+tmi2bDOutn17Rjx44Mfv+gJTUF/625/EHQjEstpOT2Hkz5DnxqelIis23EOOnJ5%0A/hKedc0w63GM4Tj7ubgTRt2r+jG7V932NrnhOP+n8r9s6zGMi7H88qOmQTVt/THn0vufOT2+bfyv%0AiY85L/9ciNymKBNdQR5DH2R0livjwugKuMyb3jBfgFxJvxtfR9Wv381/8LgcgKK48rpBKGSONW50%0A8vUE3s6kEZ8e5EfktXYocGqDEyAQBk6kdfV0ol8M9oshP0hr1CStW7/0SGvSuj954dQjJ0AgDJxI%0A6+rpRL8Y7BdDfpDWqElat37pkdakdX/ywqlHToBAGDiR1tXTiX4x2C+G/CCtUZO0bv3SI61J6/7k%0AhVOPnACBMHAiraunE/1isF8M+UFaoyZp3fqlR1qT1v3JC6ceOQECYeBEWldPJ/rFYL8Y8oO0Rk3S%0AuvVLj7QmrfuTF049cgIEwsCJtK6eTvSLwX4x5AdpjZqkdeuXHmlNWvcnL5x65AQIhIETaV09negX%0Ag/1iyA/SGjVJ69YvPdKatO5PXjj1yAkQCAMn0rp6OtEvBvvFkB+kNWqS1q1feqQ1ad2fvHDqkRMg%0AEAZOpHX1dKJfDPaLIT9Ia9QkrVu/9Ehr0ro/eeHUIydAIAycSOvq6US/GOwXQ36Q1qhJWrd+6ZHW%0ApHV/8sKpR06AQBg4kdbV04l+MdgvhvwgrVGTtG790iOtSev+5IVTj5wAgTBwIq2rpxP9YrBfDPlB%0AWqMmad36pUdak9b9yQunHjkBAmHgRFpXTyf6xWC/GPKDtEZN0rr1S4+0Jq37kxdOPXICBMLAibSu%0Ank70i8F+MeQHaY2apHXrlx5pTVr3Jy+ceuQECISBE2ldPZ3oF4P9YsgP0ho1SevWLz3SmrTuT144%0A9cgJEAgDJ9K6ejrRLwb7xZAfpDVqktatX3qkNWndn7xw6pETIBAGTqR19XSiXwz2iyE/SGvUJK1b%0Av/RIa9K6P3nh1CMnQCAMnEjr6ulEvxjsF0N+kNaoSVq3fumR1qR1f/LCqUdOgEAYOJHW1dOJfjHY%0AL4b8IK1Rk7Ru/dIjrUnr/uSFU4+cAIEwcCKtq6cT/WKwXwz5QVqjJmnd+qVHWpPW/ckLpx45AQJh%0A4ERaV08n+sVgvxjyg7RGTdK69UuPtCat+5MXTj1yAgTCwIm0rp5O9IvBfjHkB2mNmqR165ceaU1a%0A/1d5H/4ESuGNLJReAQA=?md=1
[memowecho]: http://tinyurl.com/memowecho
[end-of-the-world]: http://euve75060.serverprofi24.de:4000/H4sIAAAAAAAAA/PL1wMAfwP2uwMAAAA=
[velociraptor-free]: http://euve75060.serverprofi24.de:4000/H4sIAAAAAAAAA5VWXW8bNxB8N+D/sLg8xGpJit9311oCnMRFjDhw4BrtY6FQZ+taWTKki2X312eW%0AJ1kq0gaoIJB3K+7ucGaX1Cu6eX/xK+F7Rr+dX169vbg++3RzdU2/XJ+f0+9X1x8+XZ69PT8+Oj46%0AXT/e0aaddrNREbQuaNa0d7NuVLiAl6f7+WI9KmZd9/DTcLjZbNTGqeXqbmi11kO4FvTYNps3y6dR%0AoUlT5TyF2hTj4yM6veMRE7XTUYG1f4Rsh+lh0s1erKYgPN3HyisvaqtCkq4SmqQrhSlJ+krYmKQx%0AoianRR3IWGGMh6kSpsY6K6SxJMuIGd7eC+kIDkF4+FvjRUCAukYA+NRY5WEOlUCMWAtTkay9AHRZ%0AR+EiI7ACQMhxRI2Hmh/4h6iFjAAAHGRiEDYkH4SBSXvhNRlTC+8TpybnhSGvhbEpAjByO2EBzFZI%0AAvTwY5hwqBmOiAxHGOyvFDHyWJqkBd61sDxUeIvEayKBgiqBGbIWKxwiJzCEfSOQrPsReLVg+NIg%0AFWYQWsFYwcNjh+Sx+VRiawgnkQIBYgI/nrOxwQmdHCe3ouQh7kOym8uxA9POpFXsI6ER05+nl+Uc%0A2mO2nALWPj7esskfINV9NDBit5xDXIbIOvs87sNKC7SOA+d8vszLGRkFOPlAEcpFl1ADkJ7w4iNo%0AkAEQmKdsdxkWKipT4SNUJVSd88nmkimFLTMeWyUJ1bJJ1ttpD4ZVxqwz2dDcUs26Y9CHvPX75D0x%0A2pBJM3lv5nBvMbuxvtndRPSEyxJ7jFWmEDhz+QKhzS3CBDloxeNerFIwo9wHMAEA11Ye5AEw1+eD%0AijkfgOkepttOezHBQQ6InbF0zGFW2GQ+A0oGJcRtGTSXpgx1z3ZuzdJu55hYsqxJlQsuWA7ls2ZG%0AUwlt0V8oQmn6CjIalcoFgtrnNi5zYzqk1ViEpmJlyWWp8/gCmUuzn9xuv1VfXtgcktqsRWR3VE1O%0AL0vuocSFZXKb4qcAJv8uaN2tln81cntswnVnGhWvdP4UdNvO5/vX4eHJ983a3VFo+6PQO62QzluF%0AEyEoPs4U5ALVYjuhh/ho4ImrUHH7OsUVVCvuO6v4gFEVlycoq5RhEQ4fyx0NyIJDT3MgtA8qyCqX%0AuFdxbilLDr96RKKonPBOVckqVBvwWHZEHTjKAHj1v1OzZeI2f7ZMnA6/uR2M2V0PqyZ11K0mi/Xt%0AcnU/KlbLbtI1JwCpcWQ5cGMjpB3Qnrlqf3FFsLi70Gqkfx4V1pUMBJeUqaPy30f5D73+A4qMWvHx%0AWTKWEhfXIZb6+1hAYo8Fd+j/wLJlrJ9O+e4d8/190dFssqaH1fLLdP5Mn5tmQcTXOqIuenKnk+d1%0AMb5dLuGVrePTzys4s53W7SI11M0amk/WHeGtnTaLTvX/DdKqfcD+nx9QrV3z1A3/nDxOemsxpuky%0AfbnnxXdNdz5v+PHN88X05DVHfj1Q7WLRrN7ffLykEQrPxNJXpQmRfqSPaAOVmnZ+crJoNvSOOR1w%0AmJv2Hk8k6cVc2KHD3w1TFgcLBjSkEwNyfoj5a/1g8HOmJWMbfwXPtEwEAQkAAA==?md=1
[echo-source]: https://github.com/memowe/echo/blob/master/echo.pl
[echo-test]: https://github.com/memowe/echo/blob/master/t/1_webapp.t

## LICENSE

Copyright (c) 2012-2021 [Mirko Westermeier][mirko], ([\@memowe][mgh], [mirko@westermeier.de][mmail])

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[mirko]: http://mirko.westermeier.de
[mgh]: https://github.com/memowe
[mmail]: mailto:mirko@westermeier.de
