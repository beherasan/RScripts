#!/usr/bin/perl


@dirs =("7181","7240","7377","7443","7481","7606");

open(IN,"Toxoplasma_Unassigned_6frame_search_02_PSMs.txt") or die "Could not open the file:$!\n";
while(<IN>)
{
	chomp;
	$_=~s/\r//g;
	unless(/^Checked/)
	{
		($anno,$master,$charge,$fscan,$file)=(split /\t/)[4,8,11,26,27];
		#print "$anno\t$master\t$charge\t$fscan\t$file\n";
		$k=$anno."_".$master."_".$fscan;
		unless (exists $hash{$k})
		{
			$hash{$k}="";
			foreach $k1 (@dirs)
			{
				#$sfile=$file;
				#$file=~s/$\.mgf//;
				$infile="Toxoplasma_Unassigned_6frame_search.dta/".$k1."/Toxoplasma_Unassigned_6frame_search.".$fscan.".".$fscan.".".$charge.".dta";
				if(-e $infile)
				{	
					#$lineC=0;
					open(IN2,"$infile") or die "Could not open the file:$!\n";
					while(<IN2>)
					{
						chomp;
						$_=~s/\r//g;
						($mz,$inten)=(split /\s/)[0,1];
						if($mz >= 126.128 && $mz <=126.129)
						{
							$line=$anno."|".$master."|".$charge."|".$fscan."|".$file;
							$hash2{$line}{"TMT126"}="$inten";
						}
						if($mz >= 127.125 && $mz <=127.126)
						{
							$line=$anno."|".$master."|".$charge."|".$fscan."|".$file;
							$hash2{$line}{"TMT127N"}="$inten";
						}
						if($mz >= 127.131 && $mz <=127.132)
						{
							$line=$anno."|".$master."|".$charge."|".$fscan."|".$file;
							$hash2{$line}{"TMT127C"}="$inten";
						}
						if($mz >= 128.128 && $mz <=128.129)
						{
							$line=$anno."|".$master."|".$charge."|".$fscan."|".$file;
							$hash2{$line}{"TMT128N"}="$inten";
						}
						if($mz >= 128.134 && $mz <=128.135)
						{
							$line=$anno."|".$master."|".$charge."|".$fscan."|".$file;
							$hash2{$line}{"TMT128C"}="$inten";
						}
						if($mz >= 129.131 && $mz <=129.133)
						{
							$line=$anno."|".$master."|".$charge."|".$fscan."|".$file;
							$hash2{$line}{"TMT129N"}="$inten";
						}
						if($mz >= 129.137 && $mz <=129.138)
						{
							$line=$anno."|".$master."|".$charge."|".$fscan."|".$file;
							$hash2{$line}{"TMT129C"}="$inten";
						}
						if($mz >= 130.135 && $mz <=130.136)
						{
							$line=$anno."|".$master."|".$charge."|".$fscan."|".$file;
							$hash2{$line}{"TMT130N"}="$inten";
						}
						if($mz >= 130.141 && $mz <=130.142)
						{
							$line=$anno."|".$master."|".$charge."|".$fscan."|".$file;
							$hash2{$line}{"TMT130C"}="$inten";
						}
						if($mz >= 131.138 && $mz <=131.139)
						{
							$line=$anno."|".$master."|".$charge."|".$fscan."|".$file;
							$hash2{$line}{"TMT131"}="$inten";
						}						
					}
					close IN2;
					#print "$infile\n";
				}	
			}
		}
			
	}
}

@TMT=("TMT126","TMT127N","TMT127C","TMT128N","TMT128C","TMT129N","TMT129C","TMT130N","TMT130C","TMT131");

open(OUT,">TMT_information.txt") or die "Could not open the file:$!\n";
print OUT "Annotated Sequence\tMaster protein accession\tFirst scan";
foreach (@TMT)
{
	print OUT "\t$_";
}
print OUT "\tCharge\tFileName\n";

foreach $k1 (keys %hash2)
{
	@d=(split /\|/,$k1);
	print OUT "$d[0]\t$d[1]\t$d[3]";	#$k1=$anno."|".$master."|".$charge."|".$fscan."|".$file;
	foreach $k2 (@TMT)
	{
		if(exists $hash2{$k1}{$k2})
		{
			print OUT "\t$hash2{$k1}{$k2}";
		}
		else
		{
			print OUT "\t0";
		}
	}
	print OUT "\t$d[2]\t$d[4]";
	print OUT "\n";
}
close OUT;