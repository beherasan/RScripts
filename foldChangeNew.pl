#!/usr/bin/perl

open(IN,"iBAQ_010919_removingAll0.txt") or die "Could not open the file:$!\n";

while(<IN>)
{
	chomp;
		@all=(split /\t/);
		$sum1=$sum2=$count1=$count2=0;
		for($i=1;$i<scalar(@all);$i++)
		{
			$v=$all[$i];
			if($i >= 3 && $i<= 4)
			{
				$sum1+=$v;
				unless($v == 0)
				{
					$count1++;
				}	
			}
			# control
			elsif($i >= 1 and $i <= 2)
			{
				$sum2+=$v;
				unless($v == 0)
				{
					$count2++;
				}
			}
		}
		unless($count1 == 0)
		{
			$av1=$sum1/$count1;
		}
		else
		{
			$av1=0;
		}
		unless($count2 == 0)
		{
			$av2=$sum2/$count2;
		}
		else
		{
			$av2=0;
		}
		if($av1 !=0 && $av2 !=0)
		{
			$fc=$av1/$av2;
		}
		elsif($av1 == 0 && $av2 == 0)
		{
			$fc= 0; 
		}
		elsif($av1 == 0)
		{
			$fc= 1/$av2;
		}
		else
		{
			$fc = $av1;
		} 		
		if($all[0] eq "Accession")
		{
			print "$all[0]\tfc\n";
		}
		else
		{
			print "$all[0]\t$fc\n";
		}
}