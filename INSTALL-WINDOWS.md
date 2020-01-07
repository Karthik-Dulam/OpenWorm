
Windows Installation
--------------------
The easiest set up is in linux or mac, but these instructions can be used to install on Windows.

To install on Windows, unless you definitely have Windows 10 *Pro* do NOT install the product named "Docker for Windows", which looks like the default option when you go to Docker.com.

Instead, you want to install [Docker Toolbox on Windows](https://docs.docker.com/toolbox/toolbox_install_windows/).

Upon installation, you may need to say yes to installing Oracle's Virtual Box.

In addition, in order to run the environment correctly, you may run into an error that asks you to go into your BIOS and to enable some options.  This means restarting your computer, holding down the F2 or Del keys, and then finding an option to "enable virtualization" on your machine, enabling it, saving the BIOS, and restarting again.

After this is done, please run *"Docker Quickstart terminal"*, which should have been installed.  If everything is working properly you will be given a terminal interface that has a whale ascii art and then an interactive shell with a dollar sign ($).

In the shell you are given, run the following commands:

```
git clone http://github.com/openworm/openworm
cd openworm
./run-shell-only.sh
```

This will give you a new shell.  Inside that:

```
DISPLAY=:44 python master_openworm.py
```

1. About 5-10 minutes of output will display on the screen as the steps run.
2. The simulation will end.  Exit the container with `exit` and run `stop.sh` on your system to clean up the running container.
3. Inspect the output in the `output` directory.

Troubleshooting
---------------

1. If you have an error "This computer doesn't have VT-X/AMD-v enabled.  Enabling it in the BIOS is mandatory" and you are running windows directly on hardware (i.e. not inside another virtual environment), you will need to enable virtualization in your BIOS, which means restarting your computer, holding down F2 or Del and finding the option for virtualization; enabling it, saving and restarting your machine.

2. When in doubt, try to run a different image.  Open Kitematic and Click "Create" next to "hello-world-nginx".  If you get "Voila! Your nginx container is running!", then at least your Docker environment is working OK.  If not, try reinstalling Docker Toolbox.
