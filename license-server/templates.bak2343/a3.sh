for i in `cat a1.log`;
do
rm  -rf  $i/Chart.yaml  $i/values.yaml  $i/templates/tests/    $i/templates/_helpers.tpl  $i/templates/NOTES.txt  $i/templates/service.yaml ;
done
