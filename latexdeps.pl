use strict;
use 5.10.0;

undef $/;

my $basename = $ARGV[0];
$basename =~ s/\.tex$//;

my $f = <>;

while ($f =~ s/\\input\s*{(.*?)}//){
	say "$basename.tex: $1 .deps/$1.d";
}

while ($f =~ s/\\includegraphics\s*{(.*?)}//){
	say "$basename.tex: $1";
}

while ($f =~ s/\\includegraphics\s*\[[^\]]*]\s*{(.*?)}//){
	say "$basename.tex: $1";
}

while ($f =~ s/\\bibliography\s*{(.*?)}//){
	say "$basename.pdf: $basename.bbl";
	my @biblist = split /,\s*/, $1;
	@biblist= map {s/\.bib$//; $_} @biblist;
	@biblist= map {s/$/.bib/; $_} @biblist;
	say "$basename.bbl: " . join " ", @biblist;
}
