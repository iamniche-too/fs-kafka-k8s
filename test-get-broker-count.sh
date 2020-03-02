jq '.items[].metadata.name | select (. | startswith("kafka"))' actual_out.json | wc -w
