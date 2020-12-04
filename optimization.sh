#!/bin/bash
rm graph.txt
touch graph.txt 
for i in `seq 0 3`
do
if [[ $i -eq 2 ]] || [[ $i -eq 3 ]]
then
	start=`date +%s%N`
	g++ "-O$i" -march=native $1 -o fact2
	end=`date +%s%N`
	echo "Time of compile:" `expr $end - $start`  "nanoseconds" -e\n >>graph.txt
	echo `time ./fact2`
	echo "The -O$i -march=native optimization"
	FILENAME=~/lab4/fact2
	FILESIZE=$(stat -c%s "$FILENAME")
	echo "Size of $FILENAME = $FILESIZE byte"
	start=`date +%s%N`
	g++ "-O$i" -march=native -funroll-loops $1 -o fact2
	end=`date +%s%N`
	echo `time ./fact2`
	echo "Time of compile:" `expr $end - $start`  "nanoseconds" -e\n >>graph.txt
	echo "The -O$i -march=native -funroll-loops optimization"
	FILENAME=~/lab4/fact2
	FILESIZE=$(stat -c%s "$FILENAME")
	echo "Size of $FILENAME = $FILESIZE byte"
else
start=`date +%s%N`
g++ "-O$i" $1 -o fact2
end=`date +%s%N`
echo `time ./fact2`
echo "Time of compile:" `expr $end - $start`  "nanoseconds" -e\n >>graph.txt
echo "The -O$i optimization"
FILENAME=~/lab4/fact2
FILESIZE=$(stat -c%s "$FILENAME")
echo "Size of $FILENAME = $FILESIZE byte"
fi
done
start=`date +%s%N`
g++ -Os $1 -o fact2
end=`date +%s%N`
echo `time ./fact2`
echo "Time of compile:" `expr $end - $start`  "nanoseconds" -e\n >>graph.txt
echo "The -Os optimization"
FILENAME=~/lab4/fact2
FILESIZE=$(stat -c%s "$FILENAME")
echo "Size of $FILENAME = $FILESIZE byte"

start=`date +%s%N`
g++ -O2 -march=native $1 -o fact2
end=`date +%s%N`
echo "Time of compile:" `expr $end - $start` "nanoseconds" >> graph.txt
time ./fact2
echo "Optional $2"
du -bh ./fact2

start=`date +%s%N`
g++ -O2 -march=native -fipa-matrix-reorg $1 -o fact2
end=`date +%s%N`
echo "Time of compile:" `expr $end - $start` "nanoseconds" >> graph.txt
time ./fact2
echo "Option -fipa-matrix-reorg"
du -bh ./fact2

start=`date +%s%N`
g++ -O2 -flto $1 -o fact2
end=`date +%s%N`
echo "Time of compile:" `expr $end - $start` "nanoseconds" >> graph.txt
time ./fact2
echo "Option -flto"
du -bh ./fact2

start=`date +%s%N`
g++ -O2 -fprofile-generate -fdump-tree-optimized $1 -o fact2
end=`date +%s%N`
echo "Time of compile:" `expr $end - $start` "nanoseconds" >> graph.txt
time ./fact2
echo "Option -fprofile-generate"
du -bh ./fact2

start=`date +%s%N`
g++ -O2 -fprofile-use -fdump-tree-optimized $1 -o fact2
end=`date +%s%N`
echo "Time of compile:" `expr $end - $start` "nanoseconds" >> graph.txt
time ./fact2
echo "Option -fprofile-use"
du -bh ./fact2
