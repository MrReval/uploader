from setuptools import setup

setup(
    name='uploader_core',
    version='1.3.8',
    description='uploader main functions',
    author='MrReval',
    author_email=M'azadit441@gmail.com',
    url='https://github.com/MrReval/uploader',
    setup_requires=['wheel'],
    install_requires=[
        'psutil==5.9.4',
        'redis==4.3.5',
        'pytz==2022.6'
    ],
    py_modules=['time', 'network', 'udp', 'database', 'log', 'ip']
)
