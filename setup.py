#!/usr/bin/env python
# coding: utf-8

from setuptools import setup
from Cython.Distutils import build_ext
from distutils.extension import Extension

setup(
    name="eventsocket",
    version="0.1.4",
    description="Twisted protocol for the FreeSWITCH's Event Socket",
    author="Alexandre Fiori",
    url="http://github.com/fiorix/eventsocket",
    py_modules=["eventsocket"],
    cmdclass = {'build_ext': build_ext},
    ext_modules = [Extension("_eventsocket_accell", ["_eventsocket_accell.pyx"])],
    #install_requires=["twisted"],
)
