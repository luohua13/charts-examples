
for i in `cat a1.log`;
do 
helm inspect $i | grep -v ^#  | grep -v '^[[:space:]].*#' > $i.yaml ;
done
