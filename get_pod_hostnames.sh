for i in 0 1 2; do kubectl exec kafka-$i -- sh -c 'hostname'; done
