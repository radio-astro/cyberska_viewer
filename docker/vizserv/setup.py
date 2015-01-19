from distutils.core import setup
from vizserv import __version__
from vizserv import __author__
from vizserv import __author_email__


setup(
    name='vizserv',
    version=__version__,
    author=__author__,
    author_email=__author_email__,
    packages=['vizserv', 'vizserv.test'],
    scripts=[],
    url='',
    license='LICENSE.txt',
    description='Image Visualization Service for CANARIE',
    long_description=open('README.txt').read(),
    install_requires=[
        "Flask >= 0.10.1",
        "Flask-SQLAlchemy >= 0.16",
        "Requests >= 1.2.3"
        ],
)
