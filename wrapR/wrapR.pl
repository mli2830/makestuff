### Takes a bunch of filenames, usually generated by make
### Generates an R wrapper that:
### ** loads all .RData files (and .RData files corresponding to .Rout files)
### ** Does something tricky with environment files
### ** Puts unrecognized file names into a variable called input_files
### ** sources all .R files (verbosely)
### ** saves image to a .RData file

### Make should pipe output to a .Rout file,
### and provide its name as first argument.

use strict;
use 5.10.0;

my @env;
my @envir;
my @R;
my @input;

my $target = shift(@ARGV);
die "ERROR -- wrapR.pl: Illegal target $target (does not end with .Rout) \n" unless $target =~ s/.Rout$/.RData/;
die "ERROR -- wrapR.pl: No input files received, nothing to do.  A rule, script or dependency is probably missing from the project directory \n" unless @ARGV>0;

my $rtarget = $target;
$rtarget =~ s/\.RData//;

say "# This file was generated automatically by wrapR.pl";
say "# You probably don't want to edit it";

my $savetext = "save.image(file=\"$target\")";
my $save = $savetext;

foreach(@ARGV){
	s/Rout$/RData/;
	if ((/\.RData$/) or (/\.rda$/) or (/.R.env$/) or (/.Rdata/)){
		push @env, $_;
	} elsif (/\.R$/){
		push @R, $_;
	} elsif (/\.envir$/){
		s/.envir//;
		s/Rout$/RData/;
		push @envir, "\"$_\"";
	} else {
		push @input, "\"$_\"";
	}
}

foreach(@env){
	say "load('$_')";
}
say;

if (@input){
	print "\ninput_files <- c(";
	print join ", ", @input;
	print ")\n";
}

say "rtargetname <- \"$rtarget\"";
say "pdfname <- \"$rtarget.Rout.pdf\"";
say "csvname <- \"$rtarget.Rout.csv\"";

if (@envir){
	print "\nenvir_list <- list(); ";
	print "for (f in  c(";
	print join ", ", @envir;
	say ")){envir_list[[f]] <- new.env(); load(f, envir=envir_list[[f]])}";
}

say "pdf(pdfname)";

say "# End RR preface\n";

say "# Generated using wrapR file $rtarget.wrapR.r";

foreach my $f (@R){
	say "source('$f', echo=TRUE)";
	my $text;
	open (INF, $f);
	while(<INF>){
		if (/rdsave/){
			$save = $_;
			$save =~ s/^# *//;
			if ($save =~/^#/) {$save=$savetext} else{
				$save =~ s/rdsave\s*\(/save(file="$target", / or die("Problem with special statement $save");
			}
		}

		if (/rdnosave/){
			$save = "";
		}
	}
}

say "# Wrapped output file $rtarget.wrapR.rout";

say "# Begin RR postscript";

say "\n# If you see this in your terminal, the R script $rtarget.wrapR.r (or something it called) did not close properly";
say "warnings()";
say "$save\n";

