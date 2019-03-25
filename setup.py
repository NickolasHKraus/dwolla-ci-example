#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""The setup script."""

from setuptools import setup, find_packages

def read(filename):
    """Read file contents."""
    path = os.path.realpath(os.path.join(os.path.dirname(__file__), filename))
    with open(path, 'rb') as f:
        return f.read().decode('utf-8')

requirements = read('requirements.txt').split()

readme = read('README.md')

setup_requirements = []

test_requirements = []

setup(
    author='Nickolas Kraus',
    author_email='NickHKraus@gmail.com',
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: MIT License',
        'Natural Language :: English',
        'Programming Language :: Python :: 2',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.4',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
    ],
    description='An example Python package built and deployed via Dwolla CI',
    entry_points={
        'console_scripts': [
            'dwolla_ci_example=dwolla_ci_example.cli:main',
        ],
    },
    install_requires=requirements,
    license='MIT license',
    long_description=readme,
    include_package_data=True,
    keywords='dwolla_ci_example',
    name='dwolla_ci_example',
    packages=find_packages(include=['dwolla_ci_example']),
    setup_requires=setup_requirements,
    test_suite='tests',
    tests_require=test_requirements,
    url='https://github.com/NickolasHKraus/dwolla_ci_example',
    version='0.1.0',
    zip_safe=False,
)
