#!/usr/bin/perl
# urlMdescriptions.pl

use warnings;
use strict;

#==============================================================
#  	          __      _____ ___     _             _    
#		  \ \    / / __/ __| __| |_  ___  ___| |___
#		   \ \/\/ / (__\__ \/ _| ' \/ _ \/ _ \ (_-<
#		    \_/\_/ \___|___/\__|_||_\___/\___/_/__/
#
#					www.whitfield.k12.ga.us
#
#	This perl script merges file descriptions from Sharepoint 
#	with URLs from Interarchy. 
#
# 	USAGE:  
#
# 	perl supermerge.pl 'Interarchy file' 'Sharepoint file'
# 	    ---or more clearly---
# 	perl supermerge.pl urls.txt sharepoint.txt
#
# =============================================================

# -------------------------------------------------------------
# Grab CLI arguments
my $ftpsource = shift @ARGV;
my $descsource = shift @ARGV;

# -------------------------------------------------------------
# Improve file literacy! Open files for reading and writing
open (FTPIN, $ftpsource) or die "Can't read source file $ftpsource: $!\n";
open (HTTPOUT, ">", 'ftptmp.txt') or die "Can't write on file ftptmp.txt: $!\n";
open (DESCIN, $descsource) or die "Can't read source file $descsource: $!\n";
open (DESCOUT, ">", 'desctmp.txt') or die "Can't write on file desctmp.txt: $!\n";

# -------------------------------------------------------------
# Convert ftp-style addresses to web-friendly http addresses
while (<FTPIN>) {
	s/ftp:\/\/eric_beavers\@/http:\/\//;
	s/(.+)/\<a href="$1"\>ZZZZ\<\/a>/;
	print HTTPOUT $_;
}

# -------------------------------------------------------------
# save every fifth line to a new file
while (<DESCIN>) {
	print DESCOUT unless (0 != $. % 5);
	};

# -------------------------------------------------------------
# Define variables
my $urls = 'ftptmp.txt';
my $desc = 'desctmp.txt';

# -------------------------------------------------------------
# Improve file literacy! Open new files for reading and writing.
open (URLS, $urls) or die "Can't read source file $urls: $!\n";
open (DESC, $desc) or die "Can't read source file $desc: $!\n";

# -------------------------------------------------------------
# Show that we're getting some work done around here
`paste $urls $desc > tmp.txt`;
print "Merging files\n";

# -------------------------------------------------------------
# Define variables and open tmp.txt for reading and writing.
my $merged = 'tmp.txt';
open (TMP, 'tmp.txt') or die "Can't read source file tmp.txt: $!\n";
open (OUT, ">", 'evidence.html') or die "Can't write to file evidence.html: $!\n";

# -------------------------------------------------------------
# Move descriptions inside <a> tags
while (<TMP>) {
	s/ZZZZ(\<\/a\>)\t(.+)\n/$2$1\n/;
	s/(.+)/\<li\>$1\<\/li\>/;
	print OUT $_;
}
print "DING! File evidence.html ready for publishing.\n";
# -------------------------------------------------------------
# Close up shop. We're finished here.
close (OUT);
close (TMP);
close (DESC);
close (URLS);
close (DESCOUT);
close (DESCIN);
close (HTTPOUT);
close (FTPIN);
