# Automated Vivado Workflow #

This repository provides the basic structures for a non-project based Vivado
work flow. The project is set up for the use of Git and GNU Make.

Vivado version: 2017.1

## Directories: ##
   * doc: documentation
   * ip_repo: folder for project-external IPs used in the project
   * scripts: scripts that build the design
   * src: Sources of the design in different sub-folders
     + bd: Block diagrams added to the design
     + constraints: Files containing the design constraints
     + ip: IP blocks generated in Vivado
     + rtl: RTL code that is contained in the project
   * tb: testbenches to test single modules or the whole project
   * output: output data generated by Vivado runs (automatically generated)
