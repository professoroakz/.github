"""Setup script for professoroakz-github package."""

from setuptools import setup

# Read version from VERSION file
with open("VERSION", "r") as f:
    version = f.read().strip()

setup(
    name="professoroakz-github",
    version=version,
    description="GitHub configuration repository",
    long_description=open("README.md").read(),
    long_description_content_type="text/markdown",
    author="professoroakz",
    url="https://github.com/professoroakz/.github",
    license="MIT",
    python_requires=">=3.9",
)
