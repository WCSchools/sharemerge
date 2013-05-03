      __      _____ ___     _             _    
  	  \ \    / / __/ __| __| |_  ___  ___| |___
  	   \ \/\/ / (__\__ \/ _| ' \/ _ \/ _ \ (_-<
  	    \_/\_/ \___|___/\__|_||_\___/\___/_/__/

I found myself with a directory of files in Sharepoint that needed to be moved to a public FTP server. This perl script merges file descriptions from the origin Sharepoint with URLs from the FTP server (file list copied from Interarchy). See the sample files for details.

The manual labor on the front end comes from copying the directory information from Sharepoint and FTP, and saving that to two files to be acted on by `sharemerge.pl`.

What does it do again?
----------------------

The script is clearly commented so I can remember what I did (and hope it helps you). It basically automates five incredibly tedious steps.

1. Converts ftp URLs to http URLs in `url.txt`
2. Strips out every fifth line from `sharepoint.txt` (which happens to be the description field I need to make sensible links)
3. Merges the two files into one
4. Places the description inside the `<a>`tags
5. Formats the whole thing as an unordered list ready for publication

Achtung!
--------

Use caution! I still need to improve the script to prevent clobbering.

Usage
-----

You could make this executable and drop it in your $PATH. Since this is designed for a specific task, I simply run it from the directory that holds the files (which is why I need to prevent clobbering).

		perl supermerge.pl 'Interarchy file' 'Sharepoint file'
    
To clarify using the included sample files.

		perl supermerge.pl urls.txt sharepoint.txt
