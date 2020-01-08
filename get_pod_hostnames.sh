for i in 0 1 2; do kubectl -n kafka exec kafka-$i -- sh -c 'hostname'; done
