Filemanager
===========

Filemanager provides complete suite for storage management in [OpenDomo OS 2.0](https://github.com/opalenzuela/opendomo). 

Features
========

1. Detection of new **local** media connected (SD card, USB hard drive, etc). Check [Netdrives Plugin](https://github.com/jmirasb/opendomo-netdrives) for network drives
2. Indexing of files stored
3. Import of files from media to permanent storage
4. Deletion of files from the media attached if configured (e.g empty the digital camera for further use)
5. Replication of important files among separate permanent storage
6. Friendly browsing of files from OpenDomoOS' interface, both mobile and desktop
7. Empty space management: control how much space is available, request and preconfigure new drives when required.

New features will be discussed in the [Issues section](https://github.com/jmirasb/opendomo-filemanager/issues) of this project.


How to test it?
===============

This plugin is not yet in a stable version, so it's required to be installed via oddevel package. To do so, install oddevel to your OpenDomoOS2 system, and execute the following lines as "admin", from the command line:

    $ plugin_add_from_gh.sh jmirasb opendomo-filemanager
    
After a few seconds the plugin will be ready in your system. 
