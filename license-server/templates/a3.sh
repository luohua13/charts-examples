for i in `cat a1.log`;
do
sed -i "s#replicaCount#global.replicaCount#g"   $i/deployment.yaml;
done 

