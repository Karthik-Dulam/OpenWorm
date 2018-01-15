#The [OpenWorm Simulation Stack](http://github.com/openworm/openworm) embedded in the [jupyter datascience-notebook environment](https://github.com/jupyter/docker-stacks/tree/master/datascience-notebook)

What has been modified from the original OpenWorm simulation stack
------------------------------------------------------------------
Pros:
* Can use many open source tools to build Jupyter notebooks based on OpenWorm simulations
* python defaults to version 3, can access version 2 with python2 executable

Cons: 
* Does not have the UI installed for NEURON
* Is 3.5 GB larger
* Has the overhead of the installation of the Jupyter environment installed on it, therefore other installations may be more difficult than with the default Ubuntu 16.04 used in the regular OpenWorm simulation stack
