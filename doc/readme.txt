===============================================================================
Ext3Undel                       (c) 2008 by Itzchak Rehberg (devel@izzysoft.de)
-------------------------------------------------------------------------------
$Id$
-------------------------------------------------------------------------------
Script to help you undelete (accidentally) deleted files from ext2/ext3 disk
partitions - by automating the necessary steps of running different utilities
===============================================================================

Contents
--------

1) Copyright and warranty
2) Requirements
3) Limitations
4) What is ext3undel, and what does it do?
5) Installation
6) Usage
7) Additional information

===============================================================================

1) Copyright and Warranty
-------------------------

This little program is (c)opyrighted by Andreas Itzchak Rehberg
(devel AT izzysoft DOT de) and protected by the GNU Public License Version 2
(GPL). For details on the License see the file LICENSE in this directory. The
contents of this archive may only be distributed all together.

===============================================================================

2) Requirements
---------------

Dependencies are slightly different for the contained script. So for R.A.L.F.
you will need PhotoRec (or foremost) only, while R.O.L.F. additionally requires
some executables from the Sleuthkit (namely fls, fsstat and dls). All other
requirements are essentially and should be available on all systems: Bash, Awk,
and things like that.

===============================================================================

3) Limitations
---------------

No warranties at all :) For more, see also the other documentation files and man
pages. If you think there's something missing here, don't hesitate to notify the
author (me) about it - chances are quite good it will be added if possible.

===============================================================================

4) What is ext3undel, and what does it do?
------------------------------------------

The short description above already said it: It's two scripts to help you
recovering files you (accidentally) deleted from some ext2/ext3 formatted
drive.

Though most pages in the InterNet state it is impossible to delete such files,
this is simply wrong. Just think of all the forensic people - it is their
daily work. Correct is: It is not that easy as to simply take them out of some
trash folder. The ext2/ext3 file system stores the MetaData (i.e. the file name,
its size, creation/modification date, etc.) in its "iNodes" - together with the
information in which file system blocks the real data is stored. When you delete
a file, this connection is broken - and both, iNode and data blocks, are marked
as free; but the information stays there until it is overwritten.

Due to this fact, tools like PhotoRec or foremost can scan the "free" blocks for
"signatures", and restore the files data (there are "significant bits" for most
file types - just open some in an ASCII viewer, and you will note the "JFIF" in
the beginning of JPG files, "FLV" for Flash Videos, "PK" in ZIP files, and so
on). But since the connection to the iNode is lost, they cannot tell the real
name of that file - and thus cannot restore a "certain file" - it's either all
or nothing, and for a large disk there may be many files restored (which would
take you hours to sort out).

However, iNodes are organized in groups, and each of these groups have a known
group of data blocks they keep the information for. So if we could figure out
the iNode our file occupied once, we can restrict our restore process to that
group of blocks - that is what R.O.L.F. does with the help of Sleuthkit: The
'fls' executable lists up all iNodes together with the MetaData (which we grep
for the file name, so we get the iNode number). 'fsstat' lists up all iNode
groups together with their associated data blocks (which we grep for the iNode
number retrieved with 'fls'). 'dls' extracts the specified data blocks from the
file system, and stores them to an image. Now we can tell PhotoRec (or foremost)
to scan that image (instead of the complete file system), and our result is
much closer to what we seek.

Opposite to R.O.L.F., R.A.L.F. is designed to get all files from a given disk
(partition). You might not need R.A.L.F, but could use PhotoRec or foremost
directly instead - all R.A.L.F. does is to save you from selecting the command
line switches/options, and ensuring that you recover to a disk/partition other
than the original data are on, to avoid more destruction before the recovery
has been done.

===============================================================================

5) Installation and configuration
---------------------------------

Unpack the tarball (you probably already did so when you're reading this).
Check the path specifications at the top of the Makefile (they should be fine
for Ubuntu and most likely other Debian derivates), and finally simply run
"sudo make install" (see doc/install.txt for more details on this way of
[un]installation).

Alternatively, put the executables somewhere in your path, and optionally
put the man pages to their locations, and you are done with the installation.

Finally you may want to review/edit the settings at the top of the scripts, to
see if they fit your requirements. This step is usually not necessary - but
you may do so if you want to.

===============================================================================

6) Usage
--------

Calling either script with the parameter "--help" will reveal this information.

After successfully installing the package, more information can also be found
calling "man rolf" and "man ralf".

===============================================================================

7) Additional Information
-------------------------

For information on the development as well as availability of new versions, you
may want to visit the project site, i.e.
  http://projects.izzysoft.de/trac/ext3undel
or the authors website, more precisely:
  http://www.izzysoft.de/?topic=software
or the project page on Freshmeat:
  http://freshmeat.net/projects/ext3undel
On the second mentioned page, you will also find more information about other
programs written by the author - as you will on Freshmeat when visiting
  http://freshmeat.net/~izzysoft/

To file a bug report, feature request or simply have a look at the current
development, please visit http://projects.izzysoft.de/trac/ext3undel
