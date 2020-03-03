for i in `cat a1.log`;
do
export VAR=$i
sed -i "s#{{ .Chart.Name }}#$VAR#g"   $i/deployment.yaml;
done 


