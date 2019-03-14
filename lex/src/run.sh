if [ -z "$1" ]; then
	files="$(ls *.l)"
	for file in ${files}
	do
		./run.sh ${file%%.*}
	done
else
	if [ -z "$2" ]; then data="$1"; else data="$2"; fi
	make file=$1 >/dev/null && ./$1.o <$data.in |& tee $data.out
fi
