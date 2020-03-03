for i in `cat a1.log`;
do
sed -i "s#Values.image.pullPolicy#Values.global.image.pullPolicy#g"   $i/deployment.yaml;
done 
