for i in `cat a1.log`;
do
cat  $i/deployment.yaml | grep -v  "{{ include" > $i/deployment.yaml.bak1 
cat $i/deployment.yaml.bak1  > $i/deployment.yaml ;
done   
