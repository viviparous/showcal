#! /usr/bin/env bash

function repeat(){
	for i in {1..40}; do echo -n "$1"; done
	echo ""
}

function prcygw() {

  cal -m -w -n 6 | sed 's/ /-/g' | perl -Mfeature=say -ne 'BEGIN { %d01=(); @a01=(); $iR=0; $iC=0; } { chomp($_);  push @a01, $_; } END { for $LL (@a01){  $iR++ if $LL =~ /\d\d\d\d/; $pos=0; for $ii (1..3){  $ss=substr($LL,$pos,25); $pos+=25;  push @{$d01{$iR.".".$iC}},$ss; $iC++; $iC=0 if $iC>2 ;} }  for $k ( sort {$a<=>$b} keys %d01) { say "\n". join("\n", @{$d01{$k}}); } }'

}



mode=0
argcount=$#
if [[ $argcount -eq 1 && $1 -eq 1 ]]; then
 mode=1
elif [[ $argcount -eq 1 && $1 -eq 3 ]]; then
 mode=3

fi

echo "mode is $mode"

#external file
calconf="cal.conf"

YY=$(date +"%Y")
MM=$(date +"%-m") 
WW=$(date +"%-W")
DD=$(date +"%d")

LIM=3
FINM=$(($MM + $LIM))

#examples
#ncal -b -w -M | awk -v ww="$WW" '{if(match($1,"^" ww) ){print ">>> "$0" <<<<<<" } else { print $0} }'
#ncal -b -w -M | awk -v ww=$(date +"%W") '{if(match($1,"^" ww) ){print ">>> "$0" <<<<<<" } else { print $0} }'


# if read $calconf
if [ $mode -eq 3 ]; then
  currdir=$(dirname $0)
  if [ -e "$currdir/$calconf" ]; then
    cat $currdir/$calconf
  elif [ -e "$calconf" ]; then
    cat $calconf
  else
    echo "No file $calconf found!"	
  fi
 exit 0
fi



# cygwin handler
osvar=$(uname -a)

if [[ "$osvar" =~ "CYGWIN" ]]; then
 echo "OS = cygwin"
 #if($^O eq "cygwin"){ #expect cal, not ncal

 if [ $mode -eq 0 ]; then
  cal -m -w -n 6 | sed 's/ /-/g' | perl -Mfeature=say -ne 'BEGIN { %d01=(); @a01=(); $iR=0; $iC=0; } { chomp($_);  push @a01, $_; } END { for $LL (@a01){  $iR++ if $LL =~ /\d\d\d\d/; $pos=0; for $ii (1..3){  $ss=substr($LL,$pos,25); $pos+=25;  push @{$d01{$iR.".".$iC}},$ss; $iC++; $iC=0 if $iC>2 ;} }  for $k ( sort {$a<=>$b} keys %d01) { say "\n". join("\n", @{$d01{$k}}); } }'
 
 else
  cal -m -w -n 6 | sed 's/ /-/g' | perl -Mfeature=say -ne 'BEGIN { %d01=(); @a01=(); $iR=0; $iC=0; } { chomp($_);  push @a01, $_; } END { for $LL (@a01){  $iR++ if $LL =~ /\d\d\d\d/; $pos=0; for $ii (1..3){  $ss=substr($LL,$pos,25); $pos+=25;  push @{$d01{$iR.".".$iC}},$ss; $iC++; $iC=0 if $iC>2 ;} }  for $k ( sort {$a<=>$b} keys %d01) { say "\n". join("\n", @{$d01{$k}}); } }' | awk -F'-' 'function isnum(x){return(x==x+0)} { if(isnum($1) && $1%2!=0){ for(c=0;c<50;c++) printf "-"; print $0} else{print $0}}'

 fi

 repeat 'x'
 cal -m -w 
 echo "[ $DD ] in w $WW"

exit 0
fi



#for INC in $(eval echo {$MM..$FINM})
for (( INC=$MM; INC<=$FINM; INC++ ))
do
 mVal=$INC
 if [ $mVal -gt 12 ];
 then
  YY=$(($YY + 1))
  mVal=1
 fi

 if [ $mode -eq 0 ]; then
  ncal -b -w -M -h -d "$YY-$mVal" | awk -v ww="$WW" -v dd="$DD" '{if(match($1,"^" ww) ){print $0" <<<<<<<<<<<<<<<< ["dd"]" }else { print $0}  }'

 else
  ncal -b -w -M -h -d "$YY-$mVal" | awk -F'|' 'function isnum(x){return(x==x+0)} { if(isnum($1) && $1%2!=0){ for(c=0;c<50;c++) printf "-"; print $0} else{print $0}}'

 fi

done
