# showcal
Showcal is a calendar/task/appointment manager ("bash script").  It is simple -- VERY simple -- and portable. 

Dependencies: bash, Perl, awk, ncal , cal (in Cygwin).

## Parameters

./showcal.sh  => If no parameter is given, showcal presents a list of months.

./showcal.sh 1 => Presents the months with even weeks on the left and odd weeks on the right.

./showcal.sh 2 => Same as giving no parameter. This will probably change.

./showcal.sh 3 => Prints the content of the file "cal.conf" located in the same directory as showcal.sh . 


