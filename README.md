# rust-silabs processor support

A helper repository containing svd2rust generated processor support files for Silicon Labs microcontrollers.

SVD files from [kiel.com](http://www.keil.com/dd2/).

The plan is that [src/hal](src/hal) will contain a generic HAL for silabs devices (based on [emlib](https://github.com/ryankurte/efm32-base/tree/master/emlib), and [src/devices] will contain the device specific files generated from SVDs.

That said, I am not totally sure how to achieve it at the moment.


## Status

[![GitHub tag](https://img.shields.io/github/tag/ryankurte/rust-silabs.svg)](https://github.com/ryankurte/rust-silabs)
[![Build Status](https://travis-ci.org/ryankurte/rust-slabs.svg?branch=master)](https://travis-ci.org/ryankurte/rust-slabs)
[![Documentation](https://docs.rs/silabs/badge.svg))](https://docs.rs/silabs/badge.svg))


## Usage

TODO


## Licensing

Rust components are MIT licensed. SVD files are Kiel/ARM licensed.

---

If you have any questions, comments, or suggestions, feel free to open an issue or a pull request.


