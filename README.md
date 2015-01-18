I wrote ***ext3undel*** several years ago after finding myself in a situation
where I needed such a tool. But since its last release back in 2008, I've
stopped working on it. No longer really „maintaining“ the code, I decided to
upload it to Github, so anyone interested can easily fork it.

## What is ext3undel, and what does it do?
Basically, it's two scripts to help you recovering files you (accidentally)
deleted from some ext2/ext3 formatted drive.

Though most pages in the InterNet state it is impossible to undelete such files,
this is simply wrong. Just think of all the forensic people – it is their
daily work. Correct is: It is not that easy as to simply take them out of some
trash folder. The ext2/ext3 file system stores the MetaData (i.e. the file name,
its size, creation/modification date, etc.) in its "iNodes" – together with the
information in which file system blocks the real data is stored. When you delete
a file, this connection is broken – and both, iNode and data blocks, are marked
as free; but the information stays there until it is overwritten.

Due to this fact, tools like [PhotoRec] or [foremost] can scan the "free" blocks
for "signatures", and restore the files data (there are "significant bits" for
most file types - just open some in an ASCII viewer, and you will note the "JFIF"
in the beginning of JPG files, "FLV" for Flash Videos, "PK" in ZIP files, and so
on). But since the connection to the iNode is lost, they cannot tell the real
name of that file - and thus cannot restore a "certain file" – it's either all
or nothing, and for a large disk there may be many files restored (which would
take you hours to sort out).

However, iNodes are organized in groups, and each of these groups have a known
group of data blocks they keep the information for. So if we could figure out
the iNode our file occupied once, we can restrict our restore process to that
group of blocks – that is what „R.A.L.F.“ (Recover A Lost File) does with the
help of [Sleuthkit]: The `fls` executable lists up all iNodes together with the
MetaData (which we grep for the file name, so we get the iNode number). `fsstat`
lists up all iNode groups together with their associated data blocks (which we
grep for the iNode number retrieved with `fls`). `dls` extracts the specified
data blocks from the file system, and stores them to an image. Now we can tell
[PhotoRec] (or [foremost]) to scan that image (instead of the complete file
system), and our result is much closer to what we seek.

Opposite to „R.A.L.F.“, „G.A.B.I.“ (Get All Back Immediately) is designed to get
all files from a given disk (partition). You might not need „G.A.B.I.“, but
could use [PhotoRec] or [foremost] directly instead - all „G.A.B.I.“ does is to
save you from selecting the command line switches/options, and ensuring that you
recover to a disk/partition other than the original data are on, to avoid more
destruction before the recovery has been done.

## Where to find more details?
Check the `doc/` sub-directory of this project for the original documentation,
and also take a look at the man pages stored in `man/`.


[PhotoRec]: http://www.cgsecurity.org/wiki/PhotoRec "PhotoRec at CGSecurity"
[foremost]: http://en.wikipedia.org/wiki/Foremost_%28software%29 "Wikipedia: Foremost (software)"
[Sleuthkit]: http://www.sleuthkit.org/ "The Sleuth Kit"
