from setuptools import setup

setup(
    name='uploader_menu',
    version='1.0.0',
    description='uploader menu',
    author='MrReval',
    author_email='azadit441@gmail.com',
    url='https://github.com/MrReval/uploader',
    setup_requires=['wheel'],
    install_requires=[
        'colored~=1.4.4',
        'pyfiglet~=0.8.post1',
        'prettytable~=3.5.0'
    ],
    py_modules=['udp_submenu', 'network_submenu', 'monitor', 'main_menu', 'display']
)
